codeunit 13062610 "Fisc. Management-ADL"
{
    TableNo = "Sales Invoice Header";
    Permissions = TableData "Sales Invoice Header"=rimd,TableData "Sales Cr.Memo Header"=rimd;
    trigger OnRun()
    var
        FiscSetup : Record "Fiscalization Setup-ADL";
        tmpSalesInvoice : Record "Sales Invoice Header";
        Text065 : TextConst ENU='There must be a value in field %1 on document no. %2';
        txtTerminalCode : Text[30];
    begin
        IF NOT (FiscSetup.IsActive) THEN
        EXIT;

        FiscSetup.GET;

        IF NOT FiscSetup.CountryCodeRS THEN
        IF NOT (FiscSetup.SendDataAutomatically) THEN
            EXIT;

        tmpSalesInvoice := Rec;

        tmpSalesInvoice.CALCFIELDS("Amount Including VAT");

        //GetFiscSubjectFromPostedDocumentPaymentMethodsSales(0,Rec."No.");

        //FiscPostedSalesDocAdd.GET(tmpSalesInvoice."Fisc. Entry No.");

        IF tmpSalesInvoice."Fisc. Subject" = FALSE THEN
        EXIT;

        IF tmpSalesInvoice."Fisc. Terminal" = '' THEN
        ERROR(Text065,tmpSalesInvoice.FIELDCAPTION("Fisc. Terminal"),"No.");

        //FiscPostedSalesDocAdd.TESTFIELD("Fisc. Terminal");
        txtTerminalCode:=FORMAT(tmpSalesInvoice."Fisc. Terminal");

        //IF tmpSalesInvoice."Posting TimeStamp" = 0DT THEN
        //ERROR(Text065,tmpSalesInvoice.FIELDCAPTION("Posting TimeStamp"),"No.");
        IF tmpSalesInvoice."Fisc. Location Code" = '' THEN
        ERROR(Text065,tmpSalesInvoice.FIELDCAPTION("Fisc. Location Code"),"No.");
        
        //tmpSalesInvoice.TESTFIELD("Posting TimeStamp");
        //tmpSalesInvoice.TESTFIELD("Fisc. Location Code");
        

        IF FiscSetup.CountryCodeRS THEN BEGIN
            CreateInitalLogEntry(2,Rec);

        //FiskDataMgt.SubmitFiscDocumentRS(2,FiscPostedSalesDocAdd."Entry No.",tmpSalesInvoice."No.",
        //    tmpSalesInvoice."Bill-to Customer No.",FiscPostedSalesDocAdd."Late Delivery");
        END ELSE BEGIN
        tmpSalesInvoice.TESTFIELD("Amount Including VAT");

        // log
        IF Rec."Prepayment Invoice" THEN
            CreateInitalLogEntry(8,Rec)
        ELSE
            CreateInitalLogEntry(2,Rec);

        //FiscSetup.TESTFIELD("Certificate Thumbprint");

        //FiscPostedSalesDocAdd."Issuer Protection Code" := FiskDataMgt.ZKI(
        //FiscSetup."Certificate Thumbprint",
        //GetCompanyOIB(TRUE),
        //FormatDateTime(FiscPostedSalesDocAdd."Posting TimeStamp"),
        //tmpSalesInvoice."No.",
        //FiscPostedSalesDocAdd."Fisc. Location Code",
        //txtTerminalCode,
        //FormatDecimal(tmpSalesInvoice."Amount Including VAT")
        //);
        //FiscPostedSalesDocAdd.MODIFY;
        COMMIT;


        //ltxtFileName:=CreateSalesInvoiceXMLFile(tmpSalesInvoice,FiscPostedSalesDocAdd."Late Delivery");

        //OutString := SB.ToString();

        //ltxtCISResponse := FiskDataMgt.SubmitFiscDocument(OutString,InString,FiscSetup."Certificate Thumbprint",FiscSetup."Web Service URL");

        //IF "Prepayment Invoice" THEN
            //ltxtCISResponse := FiskDataMgt.SubmitFiscDocument(OutString,InString,FiscSetup."Certificate Thumbprint",FiscSetup."Web Service URL",'Invoice',8,
            //FiscPostedSalesDocAdd."Entry No.",tmpSalesInvoice."No.",tmpSalesInvoice."Bill-to Customer No.",FiscPostedSalesDocAdd."Late Delivery")
        //ELSE
            //ltxtCISResponse := FiskDataMgt.SubmitFiscDocument(OutString,InString,FiscSetup."Certificate Thumbprint",FiscSetup."Web Service URL",'Invoice',2,
            //FiscPostedSalesDocAdd."Entry No.",tmpSalesInvoice."No.",tmpSalesInvoice."Bill-to Customer No.",FiscPostedSalesDocAdd."Late Delivery");

        //IF FiscSetup."Show Web Service Messages" THEN
            //MESSAGE(ltxtCISResponse);

        //IF (STRPOS(ltxtCISResponse,'<jir>')=1) THEN BEGIN
            //FiscPostedSalesDocAdd."Tax Authority Doc. No.":=COPYSTR(ltxtCISResponse,6,36);
            //FiscPostedSalesDocAdd."Fisc. Registered" := TRUE;
            //FiscPostedSalesDocAdd.MODIFY;
            //COMMIT;
        //END ELSE ERROR(ltxtCISResponse);
        END;
    end;
    
    var
        xmlFile : File;
        FileName : Text;
    procedure FiscSetupExists() : Boolean
    var
      FiscalizationSetup : Record "Fiscalization Setup-ADL";
    begin
        EXIT(FiscalizationSetup.GET);
    end;
    procedure GetFiscSubject(FiscPaymentMethodCode : Code[20]) : Boolean
    var 
        FiscPaymentMethod : Record "Fisc. Payment Method-ADL";
    begin
    IF ((FiscPaymentMethodCode<>'') AND (FiscPaymentMethod.GET(FiscPaymentMethodCode))) THEN
      EXIT(FiscPaymentMethod."Subject to Fiscalization")
    ELSE
      EXIT(FALSE);
    end;

    procedure GetFiscLocationCodeMapping(prmLocationCode : Code[10]) : Code[10]
    var Location : Record Location;
        FiscLocation : Code[10]; 
        LocMap : Record "Fiscalization Loc. Mapping-ADL";
    
    begin
        IF Location.GET(prmLocationCode) THEN BEGIN
        LocMap.SETRANGE("Location Code",Location.Code);
        IF ((LocMap.COUNT=1) AND (LocMap.FINDFIRST)) THEN
            FiscLocation := LocMap."Fisc. Location Code";
        END;

        EXIT(FiscLocation);
    end;


    procedure GetFiscWholesaleTerminalLoc(PrmFiscLocCode : Code[20]) : Text
    var TerminalCode : Text;
        WholesaleTerminal : Record "Fiscalization Terminal-ADL";

    begin
        // Rewrite as needed, ie. add more filters
        TerminalCode := '';

        WholesaleTerminal.SETRANGE("Fisc. Location Code",PrmFiscLocCode);
        WholesaleTerminal.SETRANGE("User ID",USERID);
        IF (WholesaleTerminal.FINDFIRST AND (WholesaleTerminal.COUNT=1)) THEN
        TerminalCode := WholesaleTerminal."Fisc. Terminal Code";

        // Only one terminal per location must be fund, if multiple terminals per location user must select terminal manualy.

        EXIT(TerminalCode);
    end;

    procedure GetFiscNoSeriesMapp(VAR Rec : Record "Sales Header") : Code[10]
    var NoSeriesCode : Code[10];
        FiscLocation : Record "Fiscalization Location-ADL";
        FiscTerminal : Record "Fiscalization Terminal-ADL";
        FiscSetup : Record "Fiscalization Setup-ADL";
    begin
        FiscSetup.GET();
        FiscSetup.TESTFIELD("Source of No. Series");

        NoSeriesCode := '';

        IF (FiscSetup."Source of No. Series" =FiscSetup."Source of No. Series"::"Fiscalization Location") THEN
        BEGIN
        IF FiscLocation.GET(Rec."Fisc. Location Code") THEN BEGIN
            FiscLocation.TESTFIELD("Fisc. No. Series");
            NoSeriesCode := FiscLocation."Fisc. No. Series";
        END;
        END;

        IF (FiscSetup."Source of No. Series" =FiscSetup."Source of No. Series"::"Fiscalization Terminal") THEN
        BEGIN
        //  IF FiscTerminal.GET(prmSalesHeader."Fisc. Terminal") THEN BEGIN
        //IF FiscTerminal.GET(prmSalesHeader."Fisc. Terminal",prmSalesHeader."Fisc. Location Code") THEN BEGIN
            IF Rec."Fisc. Terminal" <> '' THEN BEGIN
            FiscTerminal.GET(Rec."Fisc. Terminal", Rec."Fisc. Location Code",USERID);

            FiscTerminal.TESTFIELD("Fisc. No. Series");
            NoSeriesCode := FiscTerminal."Fisc. No. Series";
            END;
        //  END;
        END;
        EXIT(NoSeriesCode);
    end;
    procedure FinalizeFiscalization(DocumentType : Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"
     ;PostingDate : Date;FiscSubject : Boolean
     ;FiscSalesInvHeader : Record "Sales Invoice Header"
     ;FiscSalesCrMemoHeader : Record "Sales Cr.Memo Header";PreviewMode : Boolean; IsNestedRun : Boolean)
    var
       FiscalizationSetup : Record "Fiscalization Setup-ADL"; 
       FiscOK : Boolean;
       FinalizeFiscalizationSI : Codeunit "Finalize Fiscalization SI-ADL";
    begin
        // <VAT.1132>
        IF PreviewMode THEN
            EXIT;
        IF NOT FiscalizationSetup.IsActive THEN
            EXIT;
        IF IsNestedRun THEN
            EXIT;

        COMMIT;
        FiscalizationSetup.GET;
        IF PostingDate >= FiscalizationSetup."Start Date" THEN BEGIN
        // HR
        IF FiscSubject AND FiscalizationSetup.CountryCodeHR THEN BEGIN
            CASE TRUE OF
            (DocumentType IN [DocumentType::Order,DocumentType::Invoice]) :
                BEGIN
                    FiscOK := CODEUNIT.RUN(CODEUNIT::"Fisc. Management-ADL",FiscSalesInvHeader);
                END;
            (DocumentType IN [DocumentType::"Return Order",DocumentType::"Credit Memo"]) :
                BEGIN
                    FiscOK := CODEUNIT.RUN(CODEUNIT::"Fisc.-Cr.Memo-ADL",FiscSalesCrMemoHeader);
                END;
            END;
        END;

        // SI
        IF  FiscalizationSetup.CountryCodeSI THEN BEGIN
            FinalizeFiscalizationSI.SetProperties(DocumentType,FiscSubject,FiscSalesInvHeader,FiscSalesCrMemoHeader);
            FiscOK := FinalizeFiscalizationSI.RUN;
        END;

        // RS
        IF FiscSubject AND FiscalizationSetup.CountryCodeRS THEN BEGIN
            IF DocumentType IN [DocumentType::Order,DocumentType::Invoice] THEN
            FiscOK := CODEUNIT.RUN(CODEUNIT::"Fisc. Management-ADL",FiscSalesInvHeader);
        END;
        COMMIT;
        END;
        // </VAT.1132>
    end;
    procedure CreateInitalLogEntry(DocumentType : Option;SalesInvHdr : Record "Sales Invoice Header")
        var FiscalizationSetup : Record "Fiscalization Setup-ADL";
    begin
        //FiscLog.SETRANGE("Document Type",DocumentType);
        //FiscLog.SETRANGE("Document No.",SalesInvHdr."No.");
        //FiscLog.SETRANGE("Entry Type",FiscLog."Entry Type"::Initial);
        //IF NOT FiscPostedSalesDocAdd.GET(SalesInvHdr."Fisc. Entry No.") THEN
        //FiscPostedSalesDocAdd.INIT;
        //IF FiscLog.FINDFIRST THEN
        //FiscLog.TESTFIELD("Waiting for Fisc.")
        //ELSE BEGIN
        //IF FiscalizationSetup.CountryCodeRS THEN
            //FiscLog.InsertFiscLogEntryText(DocumentType,SalesInvHdr."No.",SalesInvHdr."Bill-to Customer No.",Text050,'',
            //'',0,FiscPostedSalesDocAdd."Fisc. Subject", FALSE)
        //ELSE
            //FiscLog.InsertFiscLogEntryText(DocumentType,SalesInvHdr."No.",SalesInvHdr."Bill-to Customer No.",Text050,'',
            //CreateFullFiscDocNoInvoice(SalesInvHdr."No.",FiscPostedSalesDocAdd),0,FiscPostedSalesDocAdd."Fisc. Subject", FALSE);
        //END;
        //IF not FiscalizationSetup.CountryCodeRS THEN
            //CreateFullFiscDocNoInvoice(SalesInvHdr),0,FiscPostedSalesDocAdd."Fisc. Subject", FALSE);
        //FiscLog.SETRANGE("Document Type",DocumentType);
        //FiscLog.SETRANGE("Document No.",SalesInvHdr."No.");
        //FiscLog.SETRANGE("Entry Type",FiscLog."Entry Type"::Initial);
        //IF FiscLog.FINDFIRST THEN BEGIN
        //FiscLog."Fisc. Late Delivery" := TRUE;
        //FiscLog.MODIFY;
        //END;
        COMMIT; //zapis za“…etka fiskalizacije v bazo
    end;
    procedure CreateFullFiscDocNoInvoice(var SalesInvHeader : Record "Sales Invoice Header") : Text[20]
    begin
        //IF SalesInvHeader."Fisc. Location Code" = '' THEN
            //ERROR(Text065,SalesInvHeader.FIELDCAPTION("Fisc. Location Code"),SalesInvHeader."No.");
        //IF SalesInvHeader."Fisc. Terminal" = '' THEN
            //ERROR(Text065,SalesInvHeader.FIELDCAPTION("Fisc. Terminal"),SalesInvHeader."No.");
        //IF SalesInvHeader."Fisc. Doc. No." = '' THEN
            //ERROR(Text065,SalesInvHeader.FIELDCAPTION("Fisc. Doc. No."),SalesInvHeader."No.");

        //EXIT(SalesInvHeader."Fisc. Doc. No."+'-'+SalesInvHeader."Fisc. Location Code" + '-' + FORMAT(SalesInvHeader."Fisc. Terminal"));
    end;
}