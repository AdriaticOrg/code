report 13062642 "Export FAS-Adl"
{
    UsageCategory = Administration;
    Caption = 'Export FAS';
    RDLCLayout = './src/reportlayout/Rep13062642.ExportFASAdl.rdlc';

    dataset
    {
        dataitem("FAS Report Header"; "FAS Report Header-Adl")
        {
            RequestFilterFields = "No.";

            column(CompanyName; CompanyName()) { }
            column(DocumentNo; "No.")
            {
                IncludeCaption = true;
            }
            column(PeriodStart; "Period Start Date")
            {
                IncludeCaption = true;
            }
            column(PeriodEnd; "Period End Date")
            {
                IncludeCaption = true;
            }
            column(PrepairedByName; PrepairedByUser."Reporting Name-Adl") { }
            column(ResponsibleName; ResponsibleUser."Reporting Name-Adl") { }
            column(ShadowBackgroundOnPosting; ShadowBackgroundOnPosting) { }

            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING (Number);

                dataitem("FAS Instrument"; "FAS Instrument-Adl")
                {
                    DataItemTableView = SORTING (Code);

                    dataitem("FAS Sector"; "FAS Sector-Adl")
                    {
                        DataItemTableView = SORTING (Code);

                        column(FasType; FasType) { }
                        column(InstrumentCode; "FAS Instrument".Code) { }
                        column(InstrumentIsTotal; "FAS Instrument".Type = "FAS Instrument".Type::Total) { }
                        column(SectorCode; "FAS Sector".Code) { }
                        column(SectorIsTotal; "FAS Sector".Type = "FAS Sector".Type::Total) { }
                        column(TransactionsInPeriod; FASReportLine."Transactions Amt. in Period") { }
                        column(ChangesInPeriod; FASReportLine."Changes Amt. in Period") { }
                        column(ClosingBalance; FASReportLine."Period Closing Balance") { }

                        trigger OnAfterGetRecord()
                        begin
                            IF Code = '' THEN CurrReport.SKIP();

                            IF Type = Type::Total THEN
                                FasReportLine.SETFILTER("Sector Code", Totaling)
                            ELSE
                                FasReportLine.SETRANGE("Sector Code", Code);

                            FasReportLine.CALCSUMS("Period Closing Balance", "Transactions Amt. in Period", "Changes Amt. in Period");

                            if (FasReportLine."Period Closing Balance" = 0) and (FasReportLine."Transactions Amt. in Period" = 0) and
                             (FasReportLine."Changes Amt. in Period" = 0)
                            then
                                CurrReport.Skip();
                        end;
                    }
                    trigger OnAfterGetRecord()
                    begin
                        IF Code = '' THEN CurrReport.SKIP();

                        IF Type = Type::Total THEN
                            FasReportLine.SETFILTER("Instrument Code", Totaling)
                        ELSE
                            FasReportLine.SETRANGE("Instrument Code", Code);
                    end;
                }
                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, 2);
                end;

                trigger OnAfterGetRecord()
                begin
                    FasType := SELECTSTR(Number + 1, FasTypeTok);

                    FasReportLine.RESET();
                    FasReportLine.SETCURRENTKEY("Document No.", "FAS Type", "Sector Code", "Instrument Code");
                    FasReportLine.SETRANGE("Document No.", "FAS Report Header"."No.");
                    FasReportLine.SETRANGE("FAS Type", Number);
                end;
            }

            trigger OnPostDataItem()
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                PrepairedByUser.get("Prep. By User ID");
                PrepairedByUser.testfield("Reporting Name-Adl");
                ResponsibleUser.get("Resp. User ID");
                ResponsibleUser.TestField("Reporting Name-Adl");

                if ExpFile then begin
                    ExportFAS("FAS Report Header");
                    "Last Export on Date" := Today();
                    "Last Export at Time" := Time();
                    Modify();
                    ReleaseReopen(0);
                end;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(ShadowBackgroundOnPosting; ShadowBackgroundOnPosting)
                    {
                        Caption = 'Shadow Background On Posting';
                        ApplicationArea = All;
                        Visible = true;
                        ToolTip = 'Shows background shadow on posting value cells';
                    }
                    field(ExpFile; ExpFile)
                    {
                        Caption = 'Export File';
                        ApplicationArea = All;
                        Visible = true;
                        ToolTip = 'Exports data to xml file';
                    }
                }
            }
        }
    }

    labels
    {
        LblReportTitle = 'FAS Report';
        LblPage = 'Page';
        LblResponsiblePerson = 'Responsible Person';
        LblReportPrepairedBy = 'Report Prepaired By';
        LblTransactions = 'Transactions';
        LblChanges = 'Changes';
        LblBalance = 'Balance';
    }


    var
        FASSetup: Record "FAS Setup-Adl";
        CompanyInfo: Record "Company Information";
        PrepairedByUser: Record "User Setup";
        ResponsibleUser: Record "User Setup";
        MngUserSetup: Record "User Setup";
        FasReportLine: Record "FAS Report Line-Adl";
        ExpFile: Boolean;
        ShadowBackgroundOnPosting: Boolean;
        FasType: Text;
        FasTypeTok: Label 'Undefined,Assets,Liabilities';
        ExportDoneMsg: Label 'Export to %1 done OK.';
        AmountMiustBePositiveMsg: Label 'Sheet 1 and 2 must have positive amounts. FAS Reporting Line sum for AOP %1 (%2) is %3. Filters:\\%4';


    local procedure ExportFAS(FASRepHead: Record "FAS Report Header-Adl")
    var
        FinSect: Record "FAS Sector-Adl";
        FinInst: Record "FAS Instrument-Adl";
        FASRepLine: Record "FAS Report Line-Adl";
        TmpBlob: Codeunit "Temp Blob";
        RepSIMgt: Codeunit "Reporting SI Mgt.-Adl";
        XmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: array[10] of XmlElement;
        XmlAttr: XmlAttribute;
        OutStr: OutStream;
        InStr: InStream;
        xmlns: Text;
        FileName: Text;
        ExpOk: Boolean;
        i: Integer;
        j: Integer;
        k: Integer;
        aop: Integer;
        curraop: Integer;
        FormNum: Integer;
        StatId: text[10];
        Values: array[700, 23] of decimal;
        WarningStr: Text;
        FASTypeNum: Integer;
        Amt: Decimal;
        HaveValue: Boolean;
        TmpValue: Decimal;

    begin
        FASRepHead.TestField("Period Year");
        FASRepHead.TestField("Period Round");

        ResponsibleUser.Get(FASRepHead."Resp. User ID");
        ResponsibleUser.TestField("Reporting Name-Adl");
        ResponsibleUser.TestField("Reporting Email-Adl");
        ResponsibleUser.TestField("Reporting Phone-Adl");

        FASSetup.Get();
        FASSetup.TestField("Budget User Code");
        FASSetup.TestField("Company Sector Code");

        MngUserSetup.get(FASSetup."FAS Director User ID");
        MngUserSetup.TestField("Reporting Name-Adl");

        CompanyInfo.Get();
        CompanyInfo.TestField("Registration No.");
        CompanyInfo.TestField("VAT Registration No.");
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField(Address);
        CompanyInfo.TestField(City);

        FASRepLine.SetRange("Document No.", FASRepHead."No.");
        for FormNum := 1 to 6 do begin
            FinInst.Reset();
            FinInst.SetFilter("AOP Code", '<>%1', '');
            if FinInst.FindSet() then
                repeat
                    EVALUATE(curraop, FinInst."AOP Code");
                    IF (curraop < 100) OR (curraop > 127) THEN
                        FinInst.FieldError("AOP Code");
                    curraop += (FormNum - 1) * 100;

                    FinSect.Reset();
                    FinSect.SetFilter("Index Code", '<>%1', '');
                    if FinSect.FindSet() then
                        repeat
                            EVALUATE(i, FinSect."Index Code");
                            IF (i > 23) OR (i < 1) THEN
                                FinSect.FIELDERROR("Index Code");

                            if FormNum mod 2 = 0 then
                                FASTypeNum := 2
                            else
                                FASTypeNum := 1;

                            FasReportLine.SetRange("FAS Type", FASTypeNum);

                            IF FinInst.Type = FinInst.Type::Posting THEN
                                FASRepLine.SETRANGE("Instrument Code", FinInst.Code)
                            ELSE
                                FASRepLine.SETFILTER("Instrument Code", FinInst.Totaling);

                            IF FinSect.Type = FinSect.Type::Posting THEN
                                FASRepLine.SETRANGE("Sector Code", FinSect.Code)
                            ELSE
                                FASRepLine.SETFILTER("Sector Code", FinSect.Totaling);

                            if FormNum mod 2 = 0 then
                                FASRepLine.SetRange("FAS Type", FASRepLine."FAS Type"::Liabilities)
                            else
                                FASRepLine.SetRange("FAS Type", FASRepLine."FAS Type"::Assets);

                            FASRepLine.CalcSums("Period Closing Balance", "Transactions Amt. in Period", "Changes Amt. in Period");

                            case FormNum of
                                1, 2:
                                    Amt := FASRepLine."Period Closing Balance";
                                3, 4:
                                    Amt := FASRepLine."Transactions Amt. in Period";
                                5, 6:
                                    Amt := FASRepLine."Changes Amt. in Period";
                            end;

                            Values[currAOP] [i] += Amt;

                            HaveValue := false;
                            if Amt <> 0 then
                                HaveValue := true;

                            IF (curraop >= 100) AND (curraop < 299) AND (FASRepLine.Amount < 0) THEN
                                WarningStr += StrSubstNo(AmountMiustBePositiveMsg, currAOP, i, FASRepLine.Amount, FASRepLine.GETFILTERS());

                        until FinSect.Next() = 0;

                until FinInst.Next() = 0;
        end;

        if WarningStr <> '' then
            Message(WarningStr);

        xmlns := 'http://www.w3.org/2001/XMLSchema-instance';

        XmlDoc := xmlDocument.Create();
        //XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDec := XmlDeclaration.Create('1.0', 'WINDOWS-1250', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlAttr := XmlAttribute.CreateNamespaceDeclaration('xsi', xmlns);
        XmlElem[1] := xmlElement.Create('AjpesDokument', XmlAttr);
        XmlDoc.Add(xmlElem[1]);

        XmlElem[2] := XmlElement.Create('Ident');
        XmlElem[1].Add(xmlElem[2]);
        XmlAttr := XmlAttribute.Create('krog', format(FASRepHead."Period Round"));
        XmlElem[2].Add(XmlAttr);
        XmlAttr := XmlAttribute.Create('Vrsta', 'sfr_' + FORMAT(DATE2DMY(FASRepHead."Period End Date", 3)));
        XmlElem[2].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Datum');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].Add(xmlText.Create(FORMAT(WORKDATE(), 0, 9)));

        XmlElem[3] := XmlElement.Create('Ura');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(FORMAT(TIME(), 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')));

        XmlElem[2] := XmlElement.Create('OsnovniPodatki');
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('SifUpor');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(FASSetup."Budget User Code"));

        XmlElem[3] := XmlElement.Create('MaticnaStevilka10');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(PADSTR(CompanyInfo."Registration No.", 10, '0')));

        XmlElem[3] := XmlElement.Create('DavcnaStevilka');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(RepSIMgt.GetNumsFromStr(CompanyInfo."VAT Registration No.")));

        XmlElem[3] := XmlElement.Create('Sektor');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(RepSIMgt.GetNumsFromStr(FASSetup."Company Sector Code")));

        XmlElem[3] := XmlElement.Create('Ime');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(CompanyInfo.Name));

        XmlElem[3] := XmlElement.Create('Sedez');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(STRSUBSTNO('%1 %2 %3', CompanyInfo.Address, CompanyInfo."Address 2", CompanyInfo.City)));

        XmlElem[3] := XmlElement.Create('OdgovornaOseba');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(ResponsibleUser."Reporting Name-Adl"));

        XmlElem[3] := XmlElement.Create('TelefonskaStevilka');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(ResponsibleUser."Reporting Phone-Adl"));

        XmlElem[3] := XmlElement.Create('Email');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(ResponsibleUser."Reporting Email-Adl"));

        XmlElem[3] := XmlElement.Create('VodjaPodjetja');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(MngUserSetup."Reporting Name-Adl"));

        XmlElem[3] := XmlElement.Create('Datum');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(FORMAT(WORKDATE(), 0, 9)));

        XmlElem[3] := XmlElement.Create('Kraj');
        XmlElem[2].Add(XmlElem[3]);
        XmlElem[3].add(XmlText.Create(CompanyInfo.City));

        XmlElem[2] := XmlElement.Create('Obrazci');
        XmlElem[1].Add(xmlElem[2]);

        for i := 1 to 6 do begin
            XmlElem[3] := XmlElement.Create('Obrazec');
            XmlElem[2].Add(XmlElem[3]);
            XmlAttr := XmlAttribute.Create('krog', format(FASRepHead."Period Round"));
            XmlElem[3].Add(XmlAttr);

            case i of
                1:
                    StatId := 'sfr';
                2:
                    StatId := 'sob';
                3:
                    StatId := 'trs';
                4:
                    StatId := 'tob';
                5:
                    StatId := 'vsfr';
                6:
                    StatId := 'vsob';
            END;
            XmlAttr := XmlAttribute.Create('id', StatId);
            XmlElem[3].Add(XmlAttr);

            for j := 0 to 27 do begin
                aop := i * 100 + j;
                XmlElem[4] := XmlElement.Create('Aop');
                XmlElem[3].Add(XmlElem[4]);
                XmlAttr := XmlAttribute.Create('id', Format(aop));
                XmlElem[4].Add(XmlAttr);

                for k := 1 to 22 do begin
                    HaveValue := false;
                    TmpValue := Values[aop] [k];
                    if TmpValue <> 0 then
                        HaveValue := true;

                    XmlElem[5] := XmlElement.Create('P');
                    XmlElem[5].Add((XmlText.Create(FORMAT(Values[aop] [k], 0, '<Precision,2:2><Standard Format,9>'))));
                    XmlElem[4].Add(XmlElem[5]);
                    XmlAttr := XmlAttribute.Create('s', Format(k));
                    XmlElem[5].Add(XmlAttr);
                end;
            end;
        end;

        // Create an out stream from the blob, notice the encoding.
        TmpBlob.CreateOutStream(OutStr, TextEncoding::UTF8);
        // Write the contents of the doc to the stream
        xmlDoc.WriteTo(outStr);
        // From the same blob, that now contains the xml document, create an instr
        TmpBlob.CreateInStream(InStr, TextEncoding::UTF8);

        // Save the data of the InStream as a file.
        //ExpOk :=File.DownloadFromStream(InStr, 'Export To File', '', '*.xml|*.XML', FileName);  
        FileName := 'fas_' + format(FASRepHead."Period Year") + '_' + format(FASRepHead."Period Round") + '.xml';
        ExpOk := File.DownloadFromStream(InStr, 'Save To File', '', 'All Files (*.*)|*.*', FileName);

        Message(ExportDoneMsg, FileName);

        /*TempFile.CREATETEMPFILE();  
        TempFile.WRITE('abc');  
        TempFile.CREATEINSTREAM(NewStream);  
        ToFileName := 'SampleFile.txt';  
        DOWNLOADFROMSTREAM(NewStream,'Export','','All Files (*.*)|*.*',ToFileName) 
        */
    end;

}