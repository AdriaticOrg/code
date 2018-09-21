report 13062602 "Export VIES-Adl"
{
    UsageCategory = Administration;
    RDLCLayout = './src/reportlayout/Rep13062602.ExportVIESAdl.rdlc';
    Caption = 'Export VIES';

    dataset
    {
        dataitem("VIES Report Header"; "VIES Report Header-Adl")
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

            dataitem("VIES Report Line"; "VIES Report Line-Adl")
            {
                DataItemLink = "Document No." = field ("No.");

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

            trigger OnAfterGetRecord()
            begin
                PrepairedByUser.get("Prep. By User ID");
                PrepairedByUser.testfield("Reporting Name-Adl");
                ResponsibleUser.get("Resp. User ID");
                ResponsibleUser.TestField("Reporting Name-Adl");

                if ExpFile then begin
                    case "VIES Report Header"."VIES Country" of
                        "VIES Report Header"."VIES Country"::Slovenia:
                            ExportVIESSI("VIES Report Header");
                        "VIES Report Header"."VIES Country"::Croatia:
                            ExportVIESHR("VIES Report Header");
                    end;

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
                    field(ExpFile; ExpFile)
                    {
                        Caption = 'Export File';
                        ApplicationArea = All;
                        Visible = true;
                        ToolTip = 'TODO: Tooltip - Reporting';
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
        SalesGoods: Decimal;
        SalesSvcs: Decimal;
        Sales3Pty: Decimal;
        SalesCustoms: Decimal;
        ExportDoneMsg: Label 'Export to %1 done OK.';

    local procedure ExportVIESSI(VIESRepHead: Record "VIES Report Header-Adl")
    var
        VIESRepLine: Record "VIES Report Line-Adl";
        ViesRepBuff: Record "VIES Report Buffer-Adl" temporary;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        RespUser: Record "User Setup";
        MakerUser: Record "User Setup";
        TmpBlob: Record TempBlob temporary;
        RepSIMgt: Codeunit "Reporting SI Mgt.-Adl";
        XmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;
        XmlElem: array[10] of XmlElement;
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
        ExpOk: Boolean;
        xmlns: Text;
        nsEDP: Text;
        StatMonth: Integer;
        StatYear: Integer;
        TotSalesGoods: Decimal;
        TotSalesSvcs: Decimal;
        TotSales3Pty: Decimal;
        TotSalesCustoms: Decimal;
        PrecisionTok: Label '<Precision,0:0><Standard Format,9>';
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

        xmlns := 'http://edavki.durs.si/Documents/Schemas/VIES_KP_5.xsd';
        nsEDP := 'http://edavki.durs.si/Documents/Schemas/EDP-Common-1.xsd';

        FillRepBuffer(VIESRepHead, ViesRepBuff);
        ViesRepBuff.reset();

        ViesRepBuff.SetRange(Type, ViesRepBuff.Type::New);
        ViesRepBuff.CalcSums("EU 3-Party Amt.", "EU Customs Proc. Amt", "EU Sales Goods Amt.", "EU Sales Srvc. Amt.");
        TotSalesGoods := ViesRepBuff."EU Sales Goods Amt.";
        TotSalesSvcs := ViesRepBuff."EU Sales Srvc. Amt.";
        TotSales3Pty := ViesRepBuff."EU 3-Party Amt.";
        TotSalesCustoms := ViesRepBuff."EU Customs Proc. Amt";

        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create('Envelope', xmlns);
        XmlElem[1].Add(XmlAttribute.CreateNamespaceDeclaration('edp', nsEDP));
        XmlDoc.Add(xmlElem[1]);

        XmlElem[2] := XmlElement.Create('Header', nsEDP);
        XmlElem[2].Add(XmlAttribute.CreateNamespaceDeclaration('edp', nsEDP));
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('taxpayer', nsEDP);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('vatNumber', nsEDP);
        XmlElem[4].Add(XmlText.Create(CompanyInfo."VAT Registration No."));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('taxpayerType', nsEDP);
        XmlElem[4].Add(XmlText.Create('PO'));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('name', nsEDP);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Name));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('address1', nsEDP);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.Address));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[4] := XmlElement.Create('City', nsEDP);
        XmlElem[4].Add(XmlText.Create(CompanyInfo.City));
        XmlElem[3].Add(XmlElem[4]);

        XmlElem[2] := XmlElement.Create('Signatures', nsEDP);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[2] := XmlElement.Create('body', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('bodyContent', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[3] := XmlElement.Create('VIES_KP', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('General', xmlns);
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[5] := XmlElement.Create('H1_Year', xmlns);
        XmlElem[5].Add(XmlText.Create(format(StatYear)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('H1_Month', xmlns);
        XmlElem[5].Add(XmlText.Create(format(StatMonth)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('A13_CurrentTotal', xmlns);
        XmlElem[5].Add(XmlText.Create(format(TotSalesGoods, 0, PrecisionTok)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('A14_Current4263Total', xmlns);
        XmlElem[5].Add(XmlText.Create(format(TotSalesCustoms, 0, PrecisionTok)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('A15_CurrentThreePartyTotal', xmlns);
        XmlElem[5].Add(XmlText.Create(format(TotSales3Pty, 0, PrecisionTok)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('A16_CurrentServiceTotal', xmlns);
        XmlElem[5].Add(XmlText.Create(format(TotSalesSvcs, 0, PrecisionTok)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('F17_ResponsiblePerson', xmlns);
        XmlElem[5].Add(XmlText.Create(RespUser."Reporting Name-Adl"));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('F17_TaxNumber', xmlns); //todo
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('F18_ContactPerson', xmlns);
        XmlElem[5].Add(XmlText.Create(PrepairedByUser."Reporting Name-Adl"));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('F18_ContactPerson', xmlns);
        XmlElem[5].Add(XmlText.Create(PrepairedByUser."Reporting Phone-Adl"));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('F13_RepresentativeTaxNumber', xmlns);  //todo
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[4] := XmlElement.Create('A_Current', xmlns);
        XmlElem[2].Add(xmlElem[4]);

        with ViesRepBuff do begin
            if FindSet() then
                repeat
                    XmlElem[5] := XmlElement.Create('A', xmlns);
                    XmlElem[4].Add(xmlElem[5]);

                    XmlElem[6] := XmlElement.Create('A1_C', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create("Country/Region Code"));

                    XmlElem[6] := XmlElement.Create('A2_N', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(RepSIMgt.GetNumsFromStr("VAT Registration No.")));

                    XmlElem[6] := XmlElement.Create('A3_T', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU Sales Goods Amt.", 0, PrecisionTok)));

                    XmlElem[6] := XmlElement.Create('A4_C4263', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU Customs Proc. Amt", 0, PrecisionTok)));

                    XmlElem[6] := XmlElement.Create('A5_T3', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU 3-Party Amt.", 0, PrecisionTok)));

                    XmlElem[6] := XmlElement.Create('A6_S', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU Sales Srvc. Amt.", 0, PrecisionTok)));

                until Next() = 0;

            ViesRepBuff.SetRange(Type, ViesRepBuff.Type::Correction);
            if FindSet() then begin
                XmlElem[4] := XmlElement.Create('B_PastCorrections', xmlns);
                XmlElem[2].Add(xmlElem[4]);

                repeat
                    XmlElem[5] := XmlElement.Create('B', xmlns);
                    XmlElem[4].Add(xmlElem[5]);

                    XmlElem[6] := XmlElement.Create('B0_Y', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format(VIESRepLine."Period Year")));  //fix it

                    XmlElem[6] := XmlElement.Create('B0_M', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format(VIESRepLine."Period Round")));  //fix it

                    XmlElem[6] := XmlElement.Create('B1_C', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create("Country/Region Code"));

                    XmlElem[6] := XmlElement.Create('B2_N', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(RepSIMgt.GetNumsFromStr("VAT Registration No.")));

                    XmlElem[6] := XmlElement.Create('B3_T', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU Sales Goods Amt.", 0, PrecisionTok)));

                    XmlElem[6] := XmlElement.Create('B4_C4263', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU Customs Proc. Amt", 0, PrecisionTok)));

                    XmlElem[6] := XmlElement.Create('B5_T3', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU 3-Party Amt.", 0, PrecisionTok)));

                    XmlElem[6] := XmlElement.Create('B6_S', xmlns);
                    XmlElem[5].Add(xmlElem[6]);
                    XmlElem[6].Add(XmlText.Create(format("EU Sales Srvc. Amt.", 0, PrecisionTok)));

                until Next() = 0;
            end;
        end;

        //export stream file part
        TmpBlob.Blob.CreateOutStream(OutStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(OutStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);

        FileName := 'VIES_' + format(VIESRepHead."No.") + '.xml';
        ExpOk := File.DownloadFromStream(InStr, 'Save To File', '', 'All Files (*.*)|*.*', FileName);

        Message(ExportDoneMsg, FileName);

    end;

    local procedure ExportVIESHR(VIESRepHead: Record "VIES Report Header-Adl")
    var
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        ViesRepBuff: Record "VIES Report Buffer-Adl" temporary;
        RespUser: Record "User Setup";
        MakerUser: Record "User Setup";
        VIESSetup: Record "VIES Setup-Adl";
        TmpBlob: Record TempBlob temporary;
        RepSIMgt: Codeunit "Reporting SI Mgt.-Adl";
        XmlDoc: XmlDocument;
        XmlDec: XmlDeclaration;
        XmlAttr: XmlAttribute;
        XmlElem: array[10] of XmlElement;
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
        ExpOk: Boolean;
        xmlns: Text;
        xmlnsmeta: Text;
        LineCntr: Integer;
        HeadTagName: Text;
        StatMonth: Integer;
        StatYear: Integer;
        TotSalesGoods: Decimal;
        TotSalesSvcs: Decimal;
        TotSales3Pty: Decimal;
        TotSalesCustoms: Decimal;
        ConformsTo: Text;
        Street: Text[200];
        HouseNo: Text[100];
        MakerName: Text[200];
        MakerSurname: Text[200];
        PrecisionTok: Label '<Precision,2:2><Standard Format,9>';
        HeadTxt: Label 'Zbirna prijava za isporuke dobara i usluga u druge države članice Europske unije';
        HeadAttrPrefixTok: Label 'http://purl.org/dc/elements/1.1/';
        FormLbl: Label 'Elektronički obrazac';
        AddressantLbl: Label 'Ministarstvo Financija, Porezna uprava, Zagreb';
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

        VIESSetup.Get();
        VIESSetup.TestField("VIES Company Branch Code");

        VIESRepHead.TestField("Period Start Date");

        RepSIMgt.SplitAddress(CompanyInfo.Address + CompanyInfo."Address 2", Street, HouseNo);

        RepSIMgt.GetUser(RespUser, VIESRepHead."Resp. User ID");
        RepSIMgt.GetUser(MakerUser, VIESRepHead."Prep. By User ID");
        RepSIMgt.SplitUserName(MakerUser."Reporting Name-Adl", MakerName, MakerSurname);

        StatMonth := DATE2DMY(VIESRepHead."Period Start Date", 2);
        StatYear := DATE2DMY(VIESRepHead."Period Start Date", 3);

        xmlnsmeta := 'http://e-porezna.porezna-uprava.hr/sheme/Metapodaci/v2-0';
        case VIESRepHead."VIES Type" of
            VIESRepHead."VIES Type"::ZP:
                begin
                    xmlns := 'http://e-porezna.porezna-uprava.hr/sheme/zahtjevi/ObrazacZP/v1-0';
                    HeadTagName := 'ObrazacZP';
                    ConformsTo := 'ObrazacZP-v1-0';
                end;
            VIESRepHead."VIES Type"::"PDV-S":
                begin
                    xmlns := 'http://e-porezna.porezna-uprava.hr/sheme/zahtjevi/ObrazacPDVS/v1-0';
                    HeadTagName := 'ObrazacPDVS';
                    ConformsTo := 'ObrazacPDVS-v1-0';
                end;
        end;

        FillRepBuffer(VIESRepHead, ViesRepBuff);
        ViesRepBuff.reset();

        ViesRepBuff.CalcSums("EU 3-Party Amt.", "EU Customs Proc. Amt", "EU Sales Goods Amt.", "EU Sales Srvc. Amt.");
        TotSalesGoods := ViesRepBuff."EU Sales Goods Amt.";
        TotSalesSvcs := ViesRepBuff."EU Sales Srvc. Amt.";
        TotSales3Pty := ViesRepBuff."EU 3-Party Amt.";
        TotSalesCustoms := ViesRepBuff."EU Customs Proc. Amt";

        XmlDoc := xmlDocument.Create();
        XmlDec := xmlDeclaration.Create('1.0', 'UTF-8', '');
        XmlDoc.SetDeclaration(XmlDec);

        XmlElem[1] := xmlElement.Create(HeadTagName, xmlns);
        XmlAttr := XmlAttribute.Create('verzijaSheme', '1.0');
        XmlElem[1].Add(XmlAttr);
        XmlDoc.Add(xmlElem[1]);

        XmlElem[2] := XmlElement.Create('Metapodaci', xmlnsmeta);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('Naslov', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(HeadTxt));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'title');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Autor', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(MakerUser."Reporting Name-Adl"));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'creator');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Datum', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(FORMAT(WORKDATE(), 0, '<Year4>-<Month,2>-<Day,2>') + 'T' +
         FORMAT(TIME(), 0, '<Hours24,2><Filler Character,0>:<Minutes,2>:<Seconds,2>')));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'date');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Format', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create('text/xml'));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'format');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Jezik', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create('hr-HR'));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'language');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Identifikator', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(LOWERCASE((DELCHR(CREATEGUID(), '<>', '{}')))));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'identifier');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Uskladjenost', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(ConformsTo));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'conformsTo');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Tip', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(FormLbl));
        XmlAttr := XmlAttribute.Create('dc', HeadAttrPrefixTok + 'type');
        XmlElem[3].Add(XmlAttr);

        XmlElem[3] := XmlElement.Create('Adresant', xmlnsmeta);
        XmlElem[2].Add(xmlElem[3]);
        XmlElem[3].Add(XmlText.Create(AddressantLbl));

        XmlElem[2] := XmlElement.Create('Zaglavlje', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('Razdoblje', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('DatumOd', xmlns);
        XmlElem[4].Add((XmlText.Create(FORMAT(VIESRepHead."Period Start Date", 0, '<Year4>-<Month,2>-<Day,2>'))));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('DatumOd', xmlns);
        XmlElem[4].Add((XmlText.Create(FORMAT(VIESRepHead."Period End Date", 0, '<Year4>-<Month,2>-<Day,2>'))));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[3] := XmlElement.Create('Obveznik', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('Naziv', xmlns);
        XmlElem[4].Add((XmlText.Create(CompanyInfo.Name)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('OIB', xmlns);
        XmlElem[4].Add((XmlText.Create(CompanyInfo."VAT Registration No."))); //to do
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('Adresa', xmlns);
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[5] := XmlElement.Create('Mjesto', xmlns);
        XmlElem[5].Add((XmlText.Create(CompanyInfo.City)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('Ulica', xmlns);
        XmlElem[5].Add((XmlText.Create(Street)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[5] := XmlElement.Create('Broj', xmlns);
        XmlElem[5].Add((XmlText.Create(HouseNo)));
        XmlElem[4].Add(xmlElem[5]);

        XmlElem[3] := XmlElement.Create('ObracunSastavio', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[4] := XmlElement.Create('Ime', xmlns);
        XmlElem[4].Add((XmlText.Create(MakerName)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('Prezime', xmlns);
        XmlElem[4].Add((XmlText.Create(MakerSurname)));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('Telefon', xmlns);
        XmlElem[4].Add((XmlText.Create(MakerUser."Reporting Phone-Adl")));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[4] := XmlElement.Create('Email', xmlns);
        XmlElem[4].Add((XmlText.Create(MakerUser."Reporting Email-Adl")));
        XmlElem[3].Add(xmlElem[4]);

        XmlElem[3] := XmlElement.Create('Ispostava', xmlns);
        XmlElem[3].Add((XmlText.Create(VIESSetup."VIES Company Branch Code")));
        XmlElem[2].Add(xmlElem[3]);

        XmlElem[2] := XmlElement.Create('Tijelo', xmlns);
        XmlElem[1].Add(xmlElem[2]);

        XmlElem[3] := XmlElement.Create('Isporuke', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        with ViesRepBuff do
            if FindSet() then
                repeat
                    LineCntr += 1;

                    XmlElem[4] := XmlElement.Create('Isporuka', xmlns);
                    XmlElem[3].Add(xmlElem[4]);

                    XmlElem[5] := XmlElement.Create('RedBr', xmlns);
                    XmlElem[5].Add((XmlText.Create(format(LineCntr))));
                    XmlElem[4].Add(xmlElem[5]);

                    XmlElem[5] := XmlElement.Create('KodDrzave', xmlns);
                    XmlElem[5].Add((XmlText.Create("Country/Region Code")));
                    XmlElem[4].Add(xmlElem[5]);

                    XmlElem[5] := XmlElement.Create('PDVID', xmlns);
                    XmlElem[5].Add((XmlText.Create("VAT Registration No.")));
                    XmlElem[4].Add(xmlElem[5]);

                    case VIESRepHead."VIES Type" of
                        VIESRepHead."VIES Type"::ZP:
                            begin
                                XmlElem[5] := XmlElement.Create('I1', xmlns);
                                XmlElem[5].Add(XmlText.Create(format("EU Sales Goods Amt.", 0, PrecisionTok)));
                                XmlElem[4].Add(xmlElem[5]);

                                XmlElem[5] := XmlElement.Create('I2', xmlns);
                                XmlElem[5].Add(XmlText.Create(format("EU Customs Proc. Amt", 0, PrecisionTok)));
                                XmlElem[4].Add(xmlElem[5]);

                                XmlElem[5] := XmlElement.Create('I4', xmlns);
                                XmlElem[5].Add(XmlText.Create(format("EU 3-Party Amt.", 0, PrecisionTok)));
                                XmlElem[4].Add(xmlElem[5]);

                                XmlElem[5] := XmlElement.Create('I5', xmlns);
                                XmlElem[5].Add(XmlText.Create(format("EU Sales Srvc. Amt.", 0, PrecisionTok)));
                                XmlElem[4].Add(xmlElem[5]);
                            end;

                        VIESRepHead."VIES Type"::"PDV-S":
                            begin
                                XmlElem[5] := XmlElement.Create('I1', xmlns);
                                XmlElem[5].Add((XmlText.Create(format("EU Sales Goods Amt.", 0, PrecisionTok))));
                                XmlElem[4].Add(xmlElem[5]);

                                XmlElem[5] := XmlElement.Create('I2', xmlns);
                                XmlElem[4].Add(xmlElem[5]);
                                XmlElem[5].Add(XmlText.Create(format("EU Sales Srvc. Amt.", 0, PrecisionTok)));
                            end;
                    end;
                until Next() = 0;

        XmlElem[3] := XmlElement.Create('IsporukeUkupno', xmlns);
        XmlElem[2].Add(xmlElem[3]);

        case VIESRepHead."VIES Type" of
            VIESRepHead."VIES Type"::ZP:
                begin
                    XmlElem[4] := XmlElement.Create('I1', xmlns);
                    XmlElem[3].Add(xmlElem[4]);
                    XmlElem[4].Add((XmlText.Create(format(TotSalesGoods, 0, PrecisionTok))));

                    XmlElem[4] := XmlElement.Create('I2', xmlns);
                    XmlElem[3].Add(xmlElem[4]);
                    XmlElem[4].Add((XmlText.Create(format(TotSalesCustoms, 0, PrecisionTok))));

                    XmlElem[4] := XmlElement.Create('I3', xmlns);
                    XmlElem[3].Add(xmlElem[4]);
                    XmlElem[4].Add((XmlText.Create(format(TotSales3Pty, 0, PrecisionTok))));

                    XmlElem[4] := XmlElement.Create('I4', xmlns);
                    XmlElem[3].Add(xmlElem[4]);
                    XmlElem[4].Add((XmlText.Create(format(TotSalesSvcs, 0, PrecisionTok))));
                end;
            VIESRepHead."VIES Type"::"PDV-S":
                begin
                    XmlElem[4] := XmlElement.Create('I1', xmlns);
                    XmlElem[3].Add(xmlElem[4]);
                    XmlElem[4].Add((XmlText.Create(format(TotSalesGoods, 0, PrecisionTok))));

                    XmlElem[4] := XmlElement.Create('I2', xmlns);
                    XmlElem[3].Add(xmlElem[4]);
                    XmlElem[4].Add((XmlText.Create(format(TotSalesSvcs, 0, PrecisionTok))));
                end;
        end;

        //export stream file part
        TmpBlob.Blob.CreateOutStream(OutStr, TextEncoding::UTF8);
        xmlDoc.WriteTo(OutStr);
        TmpBlob.Blob.CreateInStream(inStr, TextEncoding::UTF8);

        FileName := 'VIES_' + format(VIESRepHead."No.") + '.xml';
        ExpOk := File.DownloadFromStream(InStr, 'Save To File', '', 'All Files (*.*)|*.*', FileName);

        Message(ExportDoneMsg, FileName);

    end;

    local procedure FillRepBuffer(ViesRepHead: Record "VIES Report Header-Adl"; var ViesRepBuff: Record "VIES Report Buffer-Adl" temporary)
    var
        ViesRepLine2: Record "VIES Report Line-Adl";
        Cntr: Integer;
        RoundPrec: Integer;
    begin
        RoundPrec := 1;
        if ViesRepHead."VIES Country" = ViesRepHead."VIES Country"::Croatia then
            RoundPrec := 0.01;

        ViesRepLine2.reset();
        ViesRepLine2.SetRange("Document No.", ViesRepHead."No.");
        if ViesRepLine2.FindSet() then
            repeat
                with ViesRepBuff do begin
                    SetRange(Type, ViesRepLine2.Type);
                    SetRange("Country/Region Code", ViesRepLine2."Country/Region Code");
                    SetRange("VAT Registration No.", ViesRepLine2."VAT Registration No.");
                    SetRange("Period Year", ViesRepLine2."Period Year");
                    SetRange("Period Round", ViesRepLine2."Period Round");
                    if not FindSet() then begin
                        Cntr += 1;
                        init();
                        "Entry No." := Cntr;
                        Type := ViesRepLine2.Type;
                        "Country/Region Code" := ViesRepLine2."Country/Region Code";
                        "VAT Registration No." := ViesRepLine2."VAT Registration No.";
                        "Period Year" := ViesRepLine2."Period Year";
                        "Period Round" := ViesRepLine2."Period Round";
                        insert();
                    end;

                    case true of
                        ViesRepLine2."EU 3-Party Trade":
                            "EU 3-Party Amt." += round(ViesRepLine2.Amount, RoundPrec, '=');
                        ViesRepLine2."EU Customs Procedure":
                            "EU Customs Proc. Amt" += round(ViesRepLine2.Amount, RoundPrec, '=');
                        ViesRepLine2."EU Sales Type" = ViesRepLine2."EU Sales Type"::Goods:
                            "EU Sales Goods Amt." += round(ViesRepLine2.Amount, RoundPrec, '=');
                        ViesRepLine2."EU Sales Type" = ViesRepLine2."EU Sales Type"::Services:
                            "EU Sales Srvc. Amt." += round(ViesRepLine2.Amount, RoundPrec, '=');
                    end;
                    Modify();
                end;
            until ViesRepLine2.Next() = 0;
    end;
}