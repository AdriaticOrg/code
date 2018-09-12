report 13062602 "Export VIES"
{
    UsageCategory = Administration;
    RDLCLayout = './src/reportlayout/Rep13062602.ExportVIES.rdlc';
    Caption = 'Export VIES';

    dataset
    {
        dataitem("VIES Report Header"; "VIES Report Header")
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
            column(PrepairedByName; PrepairedByUser."Reporting_SI Name-Adl") { }
            column(ResponsibleName; ResponsibleUser."Reporting_SI Name-Adl") { }

            dataitem("VIES Report Line"; "VIES Report Line")
            {
                column("Type"; FORMAT(Type, 0, '<Number>')) { }
                column(PeriodID; "Period Round") { }
                column(VATRegistrationNo; "VAT Registration No.")
                {
                    IncludeCaption = true;
                }
                column(CountryCode; "Country/Region Code") { }
                column(GoodsAmount; SalesGoods) { }
                column(ServicesAmount; SalesSvcs) { }
                column(EU3PartyTrade; Sales3Pty) { }
                column(EUCustomsProcedure; SalesCustoms) { }

                trigger OnAfterGetRecord()
                begin
                    Clear(SalesGoods);
                    Clear(SalesSvcs);
                    Clear(Sales3Pty);
                    clear(SalesCustoms);

                    if ("EU Sales Type" = "EU Sales Type"::Goods) and
                    (not "EU 3-Party Trade") and (not "EU Customs Procedure")
                    then
                        SalesGoods := Amount;

                    if ("EU Sales Type" = "EU Sales Type"::Services) and
                    (not "EU 3-Party Trade") and (not "EU Customs Procedure")
                    then
                        SalesSvcs := Amount;

                    if "EU Customs Procedure" then
                        SalesCustoms := Amount;

                    if "EU 3-Party Trade" then
                        Sales3Pty := Amount;
                end;
            }

            trigger OnPostDataItem()
            begin
                if ExpFile then begin
                    ExportVIES("VIES Report Header");
                    "VIES Report Header".ReleaseReopen(0);
                end;
            end;

            trigger OnAfterGetRecord()
            begin
                PrepairedByUser.get("Prep. By User ID");
                PrepairedByUser.testfield("Reporting_SI Name-Adl");
                ResponsibleUser.get("Resp. User ID");
                ResponsibleUser.TestField("Reporting_SI Name-Adl");
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
        LblReportTitle = 'VIES Report';
        LblPage = 'Page';
        LblResponsiblePerson = 'Responsible Person';
        LblReportPrepairedBy = 'Report Prepaired By';
        LblNew = 'New';
        LblCorrection = 'Correction';
        LblCountryCode = 'Country Code';
        LblGoodsAmount = 'Goods Amount';
        LblServicesAmount = 'Services Amount';
        LblEU3PartyTrade = 'EU-3 Party Trade';
        LblEUCustomsProcedure = 'EU Customs Procedure';
        LblTotal = 'Total';
        LblPeriod = 'Period';

    }
    var
        PrepairedByUser: Record "User Setup";
        ResponsibleUser: Record "User Setup";
        ExpFile: Boolean;
        IsTotaling: Boolean;
        IsBold: Boolean;
        HideZeros: Boolean;
        SalesGoods: Decimal;
        SalesSvcs: Decimal;
        Sales3Pty: Decimal;
        SalesCustoms: Decimal;
        ExportDoneMsg: Label 'Export to %1 done OK.';

    local procedure ExportVIES(VIESRepHead: Record "VIES Report Header")
    var
        VIESRepLine: Record "VIES Report Line";
        VIESRepLineSum: Record "VIES Report Line";
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
        TotSalesGoods: Decimal;
        TotSalesSvcs: Decimal;
        TotSales3Pty: Decimal;
        TotSalesCustoms: Decimal;
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

        VIESRepHead.TestField("Period Start Date");

        RepSIMgt.GetUser(RespUser, VIESRepHead."Resp. User ID");
        RepSIMgt.GetUser(MakerUser, VIESRepHead."Prep. By User ID");

        StatMonth := DATE2DMY(VIESRepHead."Period Start Date", 2);
        StatYear := DATE2DMY(VIESRepHead."Period Start Date", 3);

        xmlns := 'http://edavki.durs.si/Documents/Schemas/VIES_KP_5.xs';

        VIESRepLineSum.Reset();
        VIESRepLineSum.SetRange("Document No.", VIESRepHead."No.");
        VIESRepLineSum.SetRange(Type, VIESRepLine.type::New);
        VIESRepLineSum.SetRange("EU Sales Type", VIESRepLineSum."EU Sales Type"::Goods);
        VIESRepLineSum.SetRange("EU 3-Party Trade", false);
        VIESRepLineSum.SetRange("EU Customs Procedure", false);
        VIESRepLineSum.CalcSums(Amount);
        TotSalesGoods := VIESRepLineSum.Amount;

        VIESRepLineSum.SetRange("EU Sales Type", VIESRepLineSum."EU Sales Type"::Services);
        VIESRepLineSum.CalcSums(Amount);
        TotSalesSvcs := VIESRepLineSum.Amount;

        VIESRepLineSum.SetRange("EU Sales Type");
        VIESRepLineSum.SetRange("EU 3-Party Trade", true);
        VIESRepLineSum.CalcSums(Amount);
        TotSales3Pty := VIESRepLineSum.Amount;

        VIESRepLineSum.SetRange("EU 3-Party Trade");
        VIESRepLineSum.SetRange("EU Customs Procedure", true);
        VIESRepLineSum.CalcSums(Amount);
        TotSalesCustoms := VIESRepLineSum.Amount;

        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create('Envelope', xmlns);
        XmlDoc.Add(xmlElem[1]);

        XmlElem[2] := XmlElement.Create('Header', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('taxpayer', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('vatNumber', xmlns);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."VAT Registration No."));
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

        XmlElem[3] := XmlElement.Create('VIES_KP', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[3] := XmlElement.Create('General', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('H1_Year', xmlns);
        XmlElem[4].Add(XmlText.Create(format(StatYear)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('H1_Month', xmlns);
        XmlElem[4].Add(XmlText.Create(format(StatMonth)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('A13_CurrentTotal', xmlns);
        XmlElem[4].Add(XmlText.Create(format(TotSalesGoods, 0, PrecisionTok)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('A14_Current4263Total', xmlns);
        XmlElem[4].Add(XmlText.Create(format(TotSalesCustoms, 0, PrecisionTok)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('A15_CurrentThreePartyTotal', xmlns);
        XmlElem[4].Add(XmlText.Create(format(TotSales3Pty, 0, PrecisionTok)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('A16_CurrentServiceTotal', xmlns);
        XmlElem[4].Add(XmlText.Create(format(TotSalesSvcs, 0, PrecisionTok)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('F17_ResponsiblePerson', xmlns);
        XmlElem[4].Add(XmlText.Create(RespUser."Reporting_SI Name-Adl"));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('F17_TaxNumber', xmlns); //todo
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('F18_ContactPerson', xmlns);
        XmlElem[4].Add(XmlText.Create(PrepairedByUser."Reporting_SI Name-Adl"));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('F18_ContactPerson', xmlns);
        XmlElem[4].Add(XmlText.Create(PrepairedByUser."Reporting_SI Phone-Adl"));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('F13_RepresentativeTaxNumber', xmlns);  //todo
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[3] := XmlElement.Create('A_Current', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        VIESRepLine.Reset();
        VIESRepLine.SetRange("Document No.", VIESRepHead."No.");
        VIESRepLine.SetRange(Type, VIESRepLine.type::New);
        if VIESRepLine.FindSet() then
            repeat
                XmlElem[4] := XmlElement.Create('A', xmlns);
                XmlElem[3].Add(xmlElem[4]);

                XmlElem[5] := XmlElement.Create('A1_C', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(VIESRepLine."Country/Region Code"));

                XmlElem[5] := XmlElement.Create('A2_N', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(VIESRepLine."VAT Registration No."));

                if (VIESRepLine."EU Sales Type" = VIESRepLine."EU Sales Type"::Goods) and
                   (not VIESRepLine."EU 3-Party Trade") and (not VIESRepLine."EU Customs Procedure")
                then begin
                    XmlElem[5] := XmlElement.Create('A3_T', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

                if (VIESRepLine."EU Sales Type" = VIESRepLine."EU Sales Type"::Services) and
                   (not VIESRepLine."EU 3-Party Trade") and (not VIESRepLine."EU Customs Procedure")
                then begin
                    XmlElem[5] := XmlElement.Create('A6_S', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

                if VIESRepLine."EU Customs Procedure" then begin
                    XmlElem[5] := XmlElement.Create('A4_C4263', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

                if VIESRepLine."EU 3-Party Trade" then begin
                    XmlElem[5] := XmlElement.Create('A5_T3', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

            until VIESRepLine.Next() = 0;

        XmlElem[3] := XmlElement.Create('B_PastCorrections', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        VIESRepLine.SetRange(Type, VIESRepLine.type::Correction);
        if VIESRepLine.FindSet() then
            repeat
                XmlElem[4] := XmlElement.Create('B', xmlns);
                XmlElem[3].Add(xmlElem[4]);

                XmlElem[5] := XmlElement.Create('B0_Y', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(format(VIESRepLine."Period Year")));

                XmlElem[5] := XmlElement.Create('B0_M', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(format(VIESRepLine."Period Round")));

                XmlElem[5] := XmlElement.Create('B1_C', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(VIESRepLine."Country/Region Code"));

                XmlElem[5] := XmlElement.Create('B2_N', xmlns);
                XmlElem[4].Add(xmlElem[5]);
                XmlElem[5].Add(XmlText.Create(VIESRepLine."VAT Registration No."));

                if (VIESRepLine."EU Sales Type" = VIESRepLine."EU Sales Type"::Goods) and
                   (not VIESRepLine."EU 3-Party Trade") and (not VIESRepLine."EU Customs Procedure")
                then begin
                    XmlElem[5] := XmlElement.Create('B3_T', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

                if (VIESRepLine."EU Sales Type" = VIESRepLine."EU Sales Type"::Services) and
                   (not VIESRepLine."EU 3-Party Trade") and (not VIESRepLine."EU Customs Procedure")
                then begin
                    XmlElem[5] := XmlElement.Create('B6_S', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

                if VIESRepLine."EU Customs Procedure" then begin
                    XmlElem[5] := XmlElement.Create('B4_C4263', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;

                if VIESRepLine."EU 3-Party Trade" then begin
                    XmlElem[5] := XmlElement.Create('B5_T3', xmlns);
                    XmlElem[4].Add(xmlElem[5]);
                    XmlElem[5].Add(XmlText.Create(format(VIESRepLine.Amount, 0, PrecisionTok)));
                end;
            until VIESRepLine.Next() = 0;

        //export stream file part
        TmpBlob.Blob.CreateOutStream(OutStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(OutStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);

        FileName := 'VIES_' + format(VIESRepHead."No.") + '.xml';
        ExpOk := File.DownloadFromStream(InStr, 'Save To File', '', 'All Files (*.*)|*.*', FileName);

        Message(ExportDoneMsg, FileName);

    end;
}