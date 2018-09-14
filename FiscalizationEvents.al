codeunit 13062626 FiscalizationEvents
{
    trigger OnRun()
    begin
        
    end;
    
[EventSubscriber(ObjectType::Table, 17, 'OnAfterCopyGLEntryFromGenJnlLine', '', true, true)]
local procedure MyProcedure(VAR GLEntry : Record "G/L Entry";VAR GenJournalLine : Record "Gen. Journal Line")
begin
     GLEntry."Full Fisc. Doc. No." := GenJournalLine."Full Fisc. Doc. No.";
end;

[EventSubscriber(ObjectType::Table, 254, 'OnAfterCopyFromGenJnlLine', '', true, true)]
local procedure MyProcedure2(VAR VATEntry : Record "VAT Entry";GenJournalLine : Record "Gen. Journal Line")
begin
     VATEntry."Full Fisc. Doc. No." := GenJournalLine."Full Fisc. Doc. No.";
end;

[EventSubscriber(ObjectType::Table, 81, 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
local procedure MyProcedure3(SalesHeader : Record "Sales Header";VAR GenJournalLine : Record "Gen. Journal Line")
begin
     GenJournalLine."Full Fisc. Doc. No." := SalesHeader."Full Fisc. Doc. No.";
end;

[EventSubscriber(ObjectType::Table, 21, 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
local procedure MyProcedure4(VAR CustLedgerEntry : Record "Cust. Ledger Entry";GenJournalLine : Record "Gen. Journal Line")
begin
     CustLedgerEntry."Full Fisc. Doc. No." := GenJournalLine."Full Fisc. Doc. No.";
end;

[EventSubscriber(ObjectType::Table, 36,'OnAfterValidateEvent','Payment Method Code',true,true)]
local procedure OnAfterValidatePaymentMethodCodeOnSalesHeader(VAR Rec : Record "Sales Header";VAR xRec : Record "Sales Header";CurrFieldNo : Integer)
var PaymentMethod : Record "Payment Method";
    FiscalizationMgt : Codeunit "Fisc. Management-ADL";
    FiscalizationPaymentMethod : Record "Fisc. Payment Method-ADL";
    FiscSetup : Record "Fiscalization Setup-ADL";
begin
  IF Rec."Payment Method Code" <> '' THEN
    PaymentMethod.GET(Rec."Payment Method Code");

  IF FiscSetup.IsActive() THEN BEGIN
    FiscSetup.GET();
    CASE TRUE OF
      FiscSetup.CountryCodeSI:
        IF FiscalizationPaymentMethod.GET(PaymentMethod."Fisc. Payment Method") THEN
          Rec."Fisc. Subject" := FiscalizationPaymentMethod."Subject to Fiscalization";
      FiscSetup.CountryCodeHR, FiscSetup.CountryCodeRS:
        BEGIN
          Rec."Fisc. Subject" := FALSE;
          IF FiscSetup.IsActive THEN
            Rec."Fisc. Subject" := FiscalizationMgt.GetFiscSubject(PaymentMethod."Fisc. Payment Method");
        END;
    END;
  END;
end;

[EventSubscriber(ObjectType::Table, 36,'OnAfterValidateEvent','Location Code',true,true)]
local procedure OnAfterValidateLocationCodeOnSalesHeader(VAR Rec : Record "Sales Header";VAR xRec : Record "Sales Header";CurrFieldNo : Integer)
var FiscalizationManagement : Codeunit "Fisc. Management-ADL";
    FiscalizationSetup : Record "Fiscalization Setup-ADL";
    FiscalizationLocationMapping : Record "Fiscalization Loc. Mapping-ADL";
begin
IF FiscalizationSetup.IsActive() THEN BEGIN
  FiscalizationSetup.GET();
  CASE TRUE OF
    FiscalizationSetup.CountryCodeSI:
        IF Rec."Fisc. Location Code" = '' THEN BEGIN
          FiscalizationLocationMapping.SETRANGE("Location Code", Rec."Location Code");
          IF FiscalizationLocationMapping.FINDFIRST THEN
            Rec.VALIDATE("Fisc. Location Code",FiscalizationLocationMapping."Fisc. Location Code")
          ELSE
            Rec.VALIDATE("Fisc. Location Code",'');
        END;
    FiscalizationSetup.CountryCodeHR:
      IF FiscalizationSetup.IsActive THEN BEGIN
        IF (Rec."Location Code" <> '') THEN
          Rec.VALIDATE("Fisc. Location Code",FiscalizationManagement.GetFiscLocationCodeMapping(Rec."Location Code"));

        IF (Rec."Location Code" <> '') THEN
          Rec.VALIDATE("Fisc. Terminal",FiscalizationManagement.GetFiscWholesaleTerminalLoc(Rec."Fisc. Location Code"));
      END;
    FiscalizationSetup.CountryCodeRS:
      IF FiscalizationSetup.IsActive THEN BEGIN
        IF (Rec."Location Code" <> '') THEN
          Rec.VALIDATE("Fisc. Location Code",FiscalizationManagement.GetFiscLocationCodeMapping(Rec."Location Code"));

        IF (Rec."Location Code" <> '') THEN
          Rec.VALIDATE("Fisc. Terminal",FiscalizationManagement.GetFiscWholesaleTerminalLoc(Rec."Fisc. Location Code"));
      END;
  END;
END;
end;

[EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesInvHeaderInsert', '', true, true)]
local procedure OnAfterInsertSalesInvHeader(VAR SalesInvHeader : Record "Sales Invoice Header";SalesHeader : Record "Sales Header")
begin
  SalesInvHeader."Posting TimeStamp" := CurrentDateTime();
  SalesInvHeader."Full Fisc. Doc. No." := GetFullFiscDocNo(SalesInvHeader."Fisc. No. Series",SalesInvHeader."Fisc. Location Code",SalesInvHeader."Fisc. Terminal");
end;
[EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterSalesCrMemoHeaderInsert', '', true, true)]
local procedure OnAfterInsertSalesCrMemoHeader(VAR SalesCrMemoHeader : Record "Sales Cr.Memo Header";SalesHeader : Record "Sales Header")
begin
  SalesCrMemoHeader."Posting TimeStamp" := CurrentDateTime();
  SalesCrMemoHeader."Full Fisc. Doc. No." := GetFullFiscDocNo(SalesCrMemoHeader."Fisc. No. Series",SalesCrMemoHeader."Fisc. Location Code",SalesCrMemoHeader."Fisc. Terminal");
end;

local procedure GetFullFiscDocNo(FiscNoSeries : code[20];FiscLocCode : code[10];FiscTermCode : text[30]) : code[20]
var
  NoSeries : Record "No. Series";
  NoSeriesMgt : Codeunit NoSeriesManagement;
  FiscNo : code[20];
  FiscalizationSetup : Record "Fiscalization Setup-ADL";
begin
  if not NoSeries.Get(FiscNoSeries) then
    exit('');
  NoSeriesMgt.InitSeries(FiscNoSeries,'',0D,FiscNo,FiscNoSeries);
    CASE TRUE OF
    FiscalizationSetup.CountryCodeSI:
        exit(StrSubstNo('%1-%2-%3',FiscLocCode,FiscTermCode,FiscNo));
    FiscalizationSetup.CountryCodeHR:
        exit(StrSubstNo('%1-%2-%3',FiscNo,FiscLocCode,FiscTermCode));
    end;
end;
}