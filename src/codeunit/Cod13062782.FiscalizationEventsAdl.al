codeunit 13062782 "FiscalizationEvents-Adl"
{
    [EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
    local procedure HandleOnAfterCopyGLEntryFromGenJnlLine(VAR GLEntry: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;
        GLEntry."Full Fisc. Doc. No.-Adl" := GenJournalLine."Full Fisc. Doc. No.-Adl";
    end;

    [EventSubscriber(ObjectType::Table, 254, 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure HandleOnAfterCopyFromGenJnlLine(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;
        VATEntry."Full Fisc. Doc. No.-Adl" := GenJournalLine."Full Fisc. Doc. No.-Adl";
    end;

    [EventSubscriber(ObjectType::Table, 81, 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure HandleOnAfterCopyGenJnlLineFromSalesHeader(SalesHeader: Record "Sales Header"; VAR GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;
        GenJournalLine."Full Fisc. Doc. No.-Adl" := SalesHeader."Full Fisc. Doc. No.-Adl";
    end;

    [EventSubscriber(ObjectType::Table, 21, 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    local procedure HandleOnAfterCopyCustLedgerEntryFromGenJnlLine(VAR CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        ADLCore: Record "CoreSetup-Adl";
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;
        CustLedgerEntry."Full Fisc. Doc. No.-Adl" := GenJournalLine."Full Fisc. Doc. No.-Adl";
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Payment Method Code', true, true)]
    local procedure HandleOnAfterValidatePaymentMethodCodeOnSalesHeader(VAR Rec: Record "Sales Header"; VAR xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        PaymentMethod: Record "Payment Method";
        FiscalizationPaymentMethod: Record "Fisc. Payment Method-Adl";
        FiscalSetup: Record "Fiscalization Setup-Adl";
        FiscalizationMgt: Codeunit "Fisc. Management-Adl";
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;

        IF Rec."Payment Method Code" <> '' THEN
            PaymentMethod.GET(Rec."Payment Method Code");

        IF FiscalSetup.IsActive() THEN BEGIN
            FiscalSetup.GET();
            CASE TRUE OF
                FiscalSetup.CountryCodeSI():
                    IF FiscalizationPaymentMethod.GET(PaymentMethod."Fisc. Payment Method-Adl") THEN
                        Rec."Fisc. Subject-Adl" := FiscalizationPaymentMethod."Subject to Fiscalization";
                FiscalSetup.CountryCodeHR(), FiscalSetup.CountryCodeRS():
                    BEGIN
                        Rec."Fisc. Subject-Adl" := FALSE;
                        IF FiscalSetup.IsActive() THEN
                            Rec."Fisc. Subject-Adl" := FiscalizationMgt.GetFiscSubject(PaymentMethod."Fisc. Payment Method-Adl");
                    END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Table, 36, 'OnAfterValidateEvent', 'Location Code', true, true)]
    local procedure HandleOnAfterValidateLocationCodeOnSalesHeader(VAR Rec: Record "Sales Header"; VAR xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        FiscalSetup: Record "Fiscalization Setup-Adl";
        FiscalizationLocationMapping: Record "Fiscalization Loc. Mapping-Adl";
        FiscalizationManagement: Codeunit "Fisc. Management-Adl";
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;

        IF FiscalSetup.IsActive() THEN BEGIN
            FiscalSetup.GET();
            CASE TRUE OF
                FiscalSetup.CountryCodeSI():
                    IF Rec."Fisc. Location Code-Adl" = '' THEN BEGIN
                        FiscalizationLocationMapping.SETRANGE("Location Code", Rec."Location Code");
                        IF FiscalizationLocationMapping.FINDFIRST() THEN
                            Rec.VALIDATE("Fisc. Location Code-Adl", FiscalizationLocationMapping."Fisc. Location Code")
                        ELSE
                            Rec.VALIDATE("Fisc. Location Code-Adl", '');
                    END;
                FiscalSetup.CountryCodeHR():
                    IF FiscalSetup.IsActive() THEN BEGIN
                        IF (Rec."Location Code" <> '') THEN
                            Rec.VALIDATE("Fisc. Location Code-Adl", FiscalizationManagement.GetFiscLocationCodeMapping(Rec."Location Code"));

                        IF (Rec."Location Code" <> '') THEN
                            Rec.VALIDATE("Fisc. Terminal-Adl", FiscalizationManagement.GetFiscWholesaleTerminalLoc(Rec."Fisc. Location Code-Adl"));
                    END;
                FiscalSetup.CountryCodeRS():
                    IF FiscalSetup.IsActive() THEN BEGIN
                        IF (Rec."Location Code" <> '') THEN
                            Rec.VALIDATE("Fisc. Location Code-Adl", FiscalizationManagement.GetFiscLocationCodeMapping(Rec."Location Code"));

                        IF (Rec."Location Code" <> '') THEN
                            Rec.VALIDATE("Fisc. Terminal-Adl", FiscalizationManagement.GetFiscWholesaleTerminalLoc(Rec."Fisc. Location Code-Adl"));
                    END;
            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', true, true)]
    local procedure HandleOnAfterSalesInvHeaderInsert(VAR SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;
        SalesInvHeader."Posting TimeStamp-Adl" := CurrentDateTime();
        SalesInvHeader."Full Fisc. Doc. No.-Adl" := GetFullFiscDocNo(SalesInvHeader."Fisc. No. Series-Adl", SalesInvHeader."Fisc. Location Code-Adl", SalesInvHeader."Fisc. Terminal-Adl");
    end;

    [EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesCrMemoHeaderInsert', '', true, true)]
    local procedure HandleOnAfterSalesCrMemoHeaderInsert(VAR SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    begin
        if not ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC) then exit;
        SalesCrMemoHeader."Posting TimeStamp-Adl" := CurrentDateTime();
        SalesCrMemoHeader."Full Fisc. Doc. No.-Adl" := GetFullFiscDocNo(SalesCrMemoHeader."Fisc. No. Series-Adl", SalesCrMemoHeader."Fisc. Location Code-Adl", SalesCrMemoHeader."Fisc. Terminal-Adl");
    end;

    local procedure GetFullFiscDocNo(FiscNoSeries: code[20]; FiscLocCode: code[10]; FiscTermCode: text[30]) RetVal: code[20]
    var
        NoSeries: Record "No. Series";
        FiscalSetup: Record "Fiscalization Setup-Adl";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        FiscNo: code[20];
    begin
        if not NoSeries.Get(FiscNoSeries) then
            exit('');
        NoSeriesMgt.InitSeries(FiscNoSeries, '', 0D, FiscNo, FiscNoSeries);
        CASE TRUE OF
            FiscalSetup.CountryCodeSI():
                exit(CopyStr(StrSubstNo('%1-%2-%3', FiscLocCode, FiscTermCode, FiscNo), 1, MaxStrLen(RetVal)));
            FiscalSetup.CountryCodeHR():
                exit(CopyStr(StrSubstNo('%1-%2-%3', FiscNo, FiscLocCode, FiscTermCode), 1, MaxStrLen(RetVal)));
        end;
    end;

    var
        ADLCore: Record "CoreSetup-Adl";
}