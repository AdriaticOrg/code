report 13062622 "Export PDO"
{
    UsageCategory = Administration;
    RDLCLayout = './src/reportlayout/Rep13062622.ExportPDO.rdlc';
    Caption = 'Export PDO';

    dataset
    {
        dataitem("PDO Report Header"; "PDO Report Header")
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
            column(PrepairedByName; PrepairedByUser."Reporting_SI Name") { }
            column(ResponsibleName; ResponsibleUser."Reporting_SI Name") { }

            dataitem("PDO Report Line"; "PDO Report Line")
            {
                column("Type"; FORMAT(Type, 0, '<Number>')) { }
                column(PeriodID; "Period Round") { }
                column(VATRegistrationNo; "VAT Registration No.")
                {
                    IncludeCaption = true;
                }
                column(CountryCode; "Country/Region Code") { }
                column(AmountLCY; "Amount (LCY)")
                {
                    IncludeCaption = true;
                }

                trigger OnAfterGetRecord()
                begin
                end;
            }

            trigger OnPostDataItem()
            begin
                if ExpFile then begin
                    ExportPDO("PDO Report Header");
                    "PDO Report Header".ReleaseReopen(0);
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
                    field(ExpFile; ExpFile)
                    {
                        Caption = 'Export File';
                        ApplicationArea = All;
                        Visible = true;
                    }
                }
            }
        }
    }
    labels
    {
        LblReportTitle = 'PDO Report';
        LblPage = 'Page';
        LblResponsiblePerson = 'Responsible Person';
        LblReportPrepairedBy = 'Report Prepaired By';
        LblNew = 'New';
        LblCorrection = 'Correction';
        LblCountryCode = 'Country Code';
        LblTotal = 'Total';
        LblPeriod = 'Period';

    }
    var
        PrepairedByUser: Record "User Setup";
        ResponsibleUser: Record "User Setup";
        ExpFile: Boolean;
        ExportDoneMsg: Label 'Export to %1 done OK.';

    local procedure ExportPDO(PDORepHead: Record "PDO Report Header")
    var
        PDORepLine: Record "PDO Report Line";
        PDORepLineSum: Record "PDO Report Line";
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        RespUser: Record "User Setup";
        MakerUser: Record "User Setup";
        TmpBlob: Record TempBlob temporary;
        RepSIMgt: Codeunit "Reporting SI Mgt.";
        XmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: array[10] of XmlElement;
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
        ExpOk: Boolean;
        xmlns: Text;
        StatMonth: Integer;
        StatYear: Integer;
        TotSales: Decimal;
        TotPrevSales: Decimal;
        PrecisionTok: Label '<Precision,2:2><Standard Format,9>';
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

        PDORepHead.TestField("Period Start Date");

        RepSIMgt.GetUser(RespUser, PDORepHead."Resp. User ID");
        RepSIMgt.GetUser(MakerUser, PDORepHead."Prep. By User ID");

        StatMonth := DATE2DMY(PDORepHead."Period Start Date", 2);
        StatYear := DATE2DMY(PDORepHead."Period Start Date", 3);

        xmlns := 'http://edavki.durs.si/Documents/Schemas/PD_O_2.xsd';

        PDORepLineSum.Reset();
        PDORepLineSum.SetRange("Document No.", PDORepHead."No.");
        PDORepLineSum.SetRange(Type, PDORepLineSum.type::New);
        PDORepLineSum.CalcSums("Amount (LCY)");
        TotSales := PDORepLineSum."Amount (LCY)";

        PDORepLineSum.SetRange(Type, PDORepLineSum.Type::Correction);
        PDORepLineSum.CalcSums("Amount (LCY)");
        TotPrevSales := PDORepLineSum."Amount (LCY)";

        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create('Envelope', xmlns);
        XmlDoc.Add(xmlElem[1]);

        XmlElem[2] := XmlElement.Create('Header', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('taxpayer', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('taxNumber', xmlns);
        XmlElem[4].Add(XmlText.Create(RepSIMgt.GetNumsFromStr(CompanyInfo."VAT Registration No.")));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('taxpayerType', xmlns);
        XmlElem[4].Add(XmlText.Create('PO'));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('name', xmlns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Name));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('address1', xmlns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Address));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('City', xmlns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.City));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[2] := XmlElement.Create('Signatures', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[2] := XmlElement.Create('body', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('bodyContent', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[3] := XmlElement.Create('PD_O', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('PeriodYear', xmlns);
        XmlElem[4].Add(XmlText.Create(format(StatYear)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('PeriodMonth', xmlns);
        XmlElem[4].Add(XmlText.Create(format(StatMonth)));
        XmlElem[3].Add(xmlElem[4]);

        PDORepLine.Reset();
        PDORepLine.SetRange("Document No.", PDORepHead."No.");
        PDORepLine.SetRange(Type, PDORepLine.type::New);
        if PDORepLine.FindSet() then
            repeat
                XmlElem[4] := XmlElement.Create('A', xmlns);
                XmlElem[3].Add(xmlElem[4]);

                XmlElem[5] := XmlElement.Create('A2', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(PDORepLine."VAT Registration No."));

                XmlElem[5] := XmlElement.Create('A3', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(format(PDORepLine."Amount (LCY)", 0, PrecisionTok)));

            until PDORepLine.Next() = 0;

        XmlElem[3] := XmlElement.Create('B_PastCorrections', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[3] := XmlElement.Create('A4', xmlns);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(format(TotPrevSales, 0, PrecisionTok)));

        PDORepLine.SetRange(Type, PDORepLine.type::Correction);
        if PDORepLine.FindSet() then
            repeat
                XmlElem[3] := XmlElement.Create('B', xmlns);
                XmlElem[2].Add(xmlElem[3]);

                XmlElem[4] := XmlElement.Create('B1_Year', xmlns);
                XmlElem[3].Add(xmlElem[4]);
                XmlElem[4].Add(XmlText.Create(format(PDORepLine."Period Year")));

                XmlElem[4] := XmlElement.Create('B1_Month', xmlns);
                XmlElem[3].Add(xmlElem[4]);
                XmlElem[4].Add(XmlText.Create(format(PDORepLine."Period Round")));

                XmlElem[4] := XmlElement.Create('B2', xmlns);
                XmlElem[3].Add(xmlElem[4]);
                XmlElem[4].Add(XmlText.Create(PDORepLine."VAT Registration No."));

                XmlElem[4] := XmlElement.Create('B3', xmlns);
                XmlElem[3].Add(xmlElem[4]);
                XmlElem[4].Add(XmlText.Create(format(PDORepLine."Amount (LCY)", 0, PrecisionTok)));

            until PDORepLine.Next() = 0;

        //export stream file part
        TmpBlob.Blob.CreateOutStream(OutStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(OutStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);

        FileName := 'PDO_' + format(PDORepHead."No.") + '.xml';
        ExpOk := File.DownloadFromStream(InStr, 'Save To File', '', 'All Files (*.*)|*.*', FileName);

        Message(ExportDoneMsg, FileName);

    end;
}