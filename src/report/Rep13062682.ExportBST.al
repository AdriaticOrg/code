report 13062682 "Export BST"
{
    UsageCategory = Administration;
    RDLCLayout = './src/reportlayout/Rep13062682.ExportBST.rdlc';
    Caption = 'Export BST';

    dataset
    {
        dataitem("BST Report Header"; "BST Report Header")
        {
            RequestFilterFields = "No.";

            column(CompanyName; CompanyName) { }
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
            column(PrepairedByName; PrepairedByUser."Reporting_SI Name") { }
            column(ResponsibleName; ResponsibleUser."Reporting_SI Name") { }

            dataitem("BST Code"; "BST Code")
            {
                column(SerialNumber; "Serial Num.")
                {
                    IncludeCaption = true;
                }
                column(Description; Description)
                {
                    IncludeCaption = true;
                }
                column(BSTCode; Code)
                {
                    IncludeCaption = true;
                }
                column(IsTotaling; IsTotaling) { }
                column(IsBold; IsBold) { }
                column(IncomeAmount; BstReportLine."Income Amount") { }
                column(ExpenseAmount; BstReportLine."Expense Amount") { }

                trigger OnAfterGetRecord()
                begin
                    IsTotaling := "Type" = "Type"::Total;
                    IsBold := StrLen("Code") = 1;

                    IF "Code" = '' THEN CurrReport.SKIP;

                    BstReportLine.RESET;
                    BstReportLine.SETRANGE("Document No.", "BST Report Header"."No.");
                    IF Totaling <> '' THEN
                        BstReportLine.SETFILTER("BST Code", Totaling)
                    ELSE
                        BstReportLine.SETRANGE("BST Code", Code);

                    BstReportLine.CALCSUMS("Income Amount", "Expense Amount");

                    IF HideZeros AND (BstReportLine."Income Amount" = 0) AND (BstReportLine."Expense Amount" = 0) THEN CurrReport.SKIP;
                end;

            }

            trigger OnPostDataItem()
            begin
                if ExpFile then begin
                    ExportBST("BST Report Header");
                    "BST Report Header".ReleaseReopen(0);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                PrepairedByUser.get("Prep. By User ID");
                PrepairedByUser.testfield("Reporting_SI Name");
                ResponsibleUser.get("Resp. User ID");
                ResponsibleUser.TestField("Reporting_SI Name");
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
                    field(HideZeros; HideZeros)
                    {
                        Caption = 'Hide zeros';
                        ApplicationArea = All;
                        Visible = true;
                    }
                    field(ExpFile; ExpFile)
                    {
                        Caption = 'Export File';
                        ApplicationArea = All;
                        Visible = true;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    labels
    {
        LblReportTitle = 'BST Report';
        LblPage = 'Page';
        LblResponsiblePerson = 'Responsible Person';
        LblReportPrepairedBy = 'Report Prepaired By';
        LblIncomeAmount = 'Income Amount';
        LblExpenseAmount = 'Expense Amount';
    }
    var
        ExpFile: Boolean;
        IsTotaling: Boolean;
        IsBold: Boolean;
        HideZeros: Boolean;
        PrepairedByUser: Record "User Setup";
        ResponsibleUser: Record "User Setup";
        BSTReportLine: Record "BST Report Line";
        Msg001: Label 'Export to %1 done OK.';

    local procedure ExportBST(BSTRepHead: Record "BST Report Header")
    var
        RepSIMgt: Codeunit "Reporting SI Mgt.";
        BSTRepLine: Record "BST Report Line";
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        RespUser: Record "User Setup";
        MakerUser: Record "User Setup";
        XmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: array[10] of XmlElement;
        XmlAttr: XmlAttribute;
        OutStr: OutStream;
        InStr: InStream;
        TmpBlob: Record TempBlob temporary;
        FileName: Text;
        ExpOk: Boolean;
        xbsrns: Text;
        CurrDT: DateTime;
        MsgId: Text;
        SysVersion: Text[20];
        Street: Text[200];
        HouseNo: Text[100];
        StatMonth: Integer;
        StatYear: Integer;
        LineCntr: Integer;
        ClaimLiabStr: Text[10];
        TxtPrec: Label '<Precision,2:2><Standard Format,9>';
    begin
        CompanyInfo.get();
        CompanyInfo.TestField("Registration No.");
        CompanyInfo.TestField("VAT Registration No.");
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField(Address);
        CompanyInfo.TestField("Post Code");
        CompanyInfo.TestField(City);

        GLSetup.get();
        GLSetup.TestField("LCY Code");

        BSTRepHead.TestField("Period Start Date");

        RepSIMgt.GetUser(RespUser, BSTRepHead."Resp. User ID");
        RepSIMgt.GetUser(MakerUser, BSTRepHead."Prep. By User ID");

        RepSIMgt.SplitAddress(CompanyInfo.Address + CompanyInfo."Address 2", Street, HouseNo);

        StatMonth := DATE2DMY(BSTRepHead."Period Start Date", 2);
        StatYear := DATE2DMY(BSTRepHead."Period Start Date", 3);

        CurrDT := CREATEDATETIME(TODAY, TIME);
        MsgId := CompanyInfo."VAT Registration No." + FORMAT(CurrDT, 0, '<Year4><Month,2><Day,2><Hours24,2><Filler Character,0><Minutes,2><Seconds,2><Second dec>');

        xbsrns := 'http://www.bsi.si/2014/07/BSReport';
        SysVersion := '2.0.18.0';

        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create('BS_Report', xbsrns);
        XmlDoc.Add(xmlElem[1]);

        XmlElem[2] := XmlElement.Create('Header', xbsrns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('SenderMessageId', xbsrns);
        XmlElem[3].Add(XmlText.Create(MsgId));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('SendingDateTime', xbsrns);
        XmlElem[3].Add(XmlText.Create(FORMAT(CurrDT, 0, '<Year4>-<Month,2>-<Day,2>T<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('SystemVersion', xbsrns);
        XmlElem[3].Add(XmlText.Create(SysVersion));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('ApplicationType', xbsrns);
        XmlElem[3].Add(XmlText.Create('P'));
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[3] := XmlElement.Create('Sender', xbsrns);
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[4] := XmlElement.Create('CodeAJPES', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Registration No."));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('TaxCode', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."VAT Registration No."));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('CompanyName', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Name));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('Street', xbsrns);
        XmlElem[4].Add(XmlText.Create(Street));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('HouseNo', xbsrns);
        XmlElem[4].Add(XmlText.Create(HouseNo));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('PostCode', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Post Code"));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('City', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.City));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[3] := XmlElement.Create('Reporter', xbsrns);
        XmlElem[2].Add(XmlElem[3]);

        XmlElem[4] := XmlElement.Create('CodeAJPES', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Registration No."));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('TaxCode', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."VAT Registration No."));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('CompanyName', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Name));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('Street', xbsrns);
        XmlElem[4].Add(XmlText.Create(Street));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('HouseNo', xbsrns);
        XmlElem[4].Add(XmlText.Create(HouseNo));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('PostCode', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."Post Code"));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('City', xbsrns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.City));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('Telephone', xbsrns);
        XmlElem[4].Add(XmlText.Create(PrepairedByUser."Reporting_SI Phone"));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[2] := XmlElement.Create('SMO', xbsrns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('BST_Report', xbsrns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('ReportHeader', xbsrns);
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[5] := XmlElement.Create('Period', xbsrns);
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[6] := XmlElement.Create('Year', xbsrns);
        XmlElem[6].Add(XmlText.Create(format(StatYear)));
        XmlElem[5].Add(xmlElem[6]);

        XmlElem[6] := XmlElement.Create('Month', xbsrns);
        XmlElem[6].Add(XmlText.Create(format(StatMonth)));
        XmlElem[5].Add(xmlElem[6]);

        XmlElem[5] := XmlElement.Create('ResponsiblePerson', xbsrns);
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[6] := XmlElement.Create('PersonalData', xbsrns);
        XmlElem[5].Add(xmlElem[6]);

        XmlElem[7] := XmlElement.Create('Name', xbsrns);
        XmlElem[6].Add(xmlElem[7]);
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Name"));

        XmlElem[7] := XmlElement.Create('Email', xbsrns);
        XmlElem[6].Add(xmlElem[7]);
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Email"));

        XmlElem[7] := XmlElement.Create('Telephon', xbsrns);
        XmlElem[6].Add(xmlElem[7]);
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Phone"));

        XmlElem[7] := XmlElement.Create('Position', xbsrns);
        XmlElem[6].Add(xmlElem[7]);
        XmlElem[7].Add(XmlText.Create(RespUser."Reporting_SI Position"));

        XmlElem[5] := XmlElement.Create('ReportMaker', xbsrns);
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[6] := XmlElement.Create('Name', xbsrns);
        XmlElem[5].Add(xmlElem[6]);
        XmlElem[6].Add(XmlText.Create(RespUser."Reporting_SI Name"));

        XmlElem[6] := XmlElement.Create('Email', xbsrns);
        XmlElem[5].Add(xmlElem[6]);
        XmlElem[6].Add(XmlText.Create(RespUser."Reporting_SI Email"));

        XmlElem[6] := XmlElement.Create('Telephon', xbsrns);
        XmlElem[5].Add(xmlElem[6]);
        XmlElem[6].Add(XmlText.Create(RespUser."Reporting_SI Phone"));

        XmlElem[6] := XmlElement.Create('Currency', xbsrns);
        XmlElem[5].Add(xmlElem[6]);
        XmlElem[6].Add(XmlText.Create(GLSetup."LCY Code"));

        XmlElem[4] := XmlElement.Create('ReportSpecifications', xbsrns);
        XmlElem[3].Add(xmlElem[4]);

        BSTReportLine.Reset();
        BSTReportLine.SetRange("Document No.", BSTRepHead."No.");
        if BSTReportLine.FindSet() then begin
            repeat
                LineCntr += 1;

                XmlElem[5] := XmlElement.Create('Specification', xbsrns);
                XmlElem[4].Add(xmlElem[5]);

                XmlElem[6] := XmlElement.Create('SerialNo', xbsrns);
                XmlElem[5].Add(xmlElem[6]);
                XmlElem[6].Add(XmlText.Create(Format(LineCntr)));

                XmlElem[6] := XmlElement.Create('Code', xbsrns);
                XmlElem[5].Add(xmlElem[6]);
                XmlElem[6].Add(XmlText.Create(BSTReportLine."BST Code"));

                XmlElem[6] := XmlElement.Create('Country', xbsrns);
                XmlElem[5].Add(xmlElem[6]);
                XmlElem[6].Add(XmlText.Create(format(BSTReportLine."Country/Region No.")));

                XmlElem[6] := XmlElement.Create('Income', xbsrns);
                XmlElem[5].Add(xmlElem[6]);
                XmlElem[6].Add(XmlText.Create(Format(BSTReportLine."Income Amount", 0, TxtPrec)));

                XmlElem[6] := XmlElement.Create('Expenditure', xbsrns);
                XmlElem[5].Add(xmlElem[6]);
                XmlElem[6].Add(XmlText.Create(Format(BSTReportLine."Expense Amount", 0, TxtPrec)));

                XmlElem[6] := XmlElement.Create('SpecificationEntryType', xbsrns);
                XmlElem[5].Add(xmlElem[6]);
                XmlElem[6].Add(XmlText.Create('L'));

            until BSTReportLine.Next() = 0;
        end;

        //export stream file part
        TmpBlob.Blob.CreateOutStream(outStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(outStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);

        FileName := 'bst_' + format(BSTRepHead."No.") + '.xml';
        ExpOk := File.DownloadFromStream(InStr, 'Save To File', '', 'All Files (*.*)|*.*', FileName);

        Message(Msg001, FileName);

    end;
}