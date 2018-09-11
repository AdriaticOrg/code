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
       // <VAT.1132>
  //IF NOT FiscSalesDocAdd.GET(Rec."Fisc. Entry No.") THEN
    //FiscSalesDocAdd.InitData(Rec);

  //FiscSalesDocAdd.GET(Rec."Fisc. Entry No.");

  PaymentMethod.INIT;
  IF Rec."Payment Method Code" <> '' THEN
    PaymentMethod.GET(Rec."Payment Method Code");

  IF FiscSetup.IsActive THEN BEGIN
    FiscSetup.GET;
    CASE TRUE OF
      FiscSetup.CountryCodeSI:
        BEGIN
          IF FiscSetup."Send All Fisc Doc" THEN BEGIN
            Rec."Fisc. Subject" := TRUE
          END ELSE BEGIN
            IF FiscalizationPaymentMethod.GET(PaymentMethod."Fisc. Payment Method") THEN
              Rec."Fisc. Subject" := FiscalizationPaymentMethod."Subject to Fiscalization";
          END;
        END;
      FiscSetup.CountryCodeHR, FiscSetup.CountryCodeRS:
        BEGIN
          Rec."Fisc. Subject" := FALSE;
          IF FiscSetup.IsActive THEN BEGIN
            Rec."Fisc. Subject" := FiscalizationMgt.GetFiscSubject(PaymentMethod."Fisc. Payment Method");
          END;
        END;
    END;
  END;
  // </VAT.1132>
end;

[EventSubscriber(ObjectType::Table, 36,'OnAfterValidateEvent','Location Code',true,true)]
local procedure OnAfterValidateLocationCodeOnSalesHeader(VAR Rec : Record "Sales Header";VAR xRec : Record "Sales Header";CurrFieldNo : Integer)
var PaymentMethod : Record "Payment Method";
    FiscalizationManagement : Codeunit "Fisc. Management-ADL";
    FiscalizationPaymentMethod : Record "Fisc. Payment Method-ADL";
    FiscalizationSetup : Record "Fiscalization Setup-ADL";
    FiscalizationLocationMapping : Record "Fiscalization Loc. Mapping-ADL";
begin
// <VAT.1132>
//IF NOT FiscSalesDocAdd.GET(Rec."Fisc. Entry No.") THEN
//  FiscSalesDocAdd.InitData(Rec);

//FiscSalesDocAdd.GET(Rec."Fisc. Entry No.");

IF FiscalizationSetup.IsActive THEN BEGIN
  FiscalizationSetup.GET;
  CASE TRUE OF
    FiscalizationSetup.CountryCodeSI:
      BEGIN
        IF Rec."Fisc. Location Code" = '' THEN BEGIN
          FiscalizationLocationMapping.SETRANGE("Location Code", Rec."Location Code");
          IF FiscalizationLocationMapping.FINDFIRST THEN BEGIN
            Rec.VALIDATE("Fisc. Location Code",FiscalizationLocationMapping."Fisc. Location Code");
          END ELSE BEGIN
            Rec.VALIDATE("Fisc. Location Code",'');
          END;
        END;
      END;
    FiscalizationSetup.CountryCodeHR:
      BEGIN
        IF FiscalizationSetup.IsActive THEN BEGIN
          IF (Rec."Location Code" <> '') THEN
            Rec.VALIDATE("Fisc. Location Code",FiscalizationManagement.GetFiscLocationCodeMapping(Rec."Location Code"));

          IF (Rec."Location Code" <> '') THEN
            Rec.VALIDATE("Fisc. Terminal",FiscalizationManagement.GetFiscWholesaleTerminalLoc(Rec."Fisc. Location Code"));

          IF (Rec."Location Code" <> '') THEN
            Rec."Fisc. No. Series" := FiscalizationManagement.GetFiscNoSeriesMapp(Rec);
        END;
      END;
    FiscalizationSetup.CountryCodeRS:
      BEGIN
        IF FiscalizationSetup.IsActive THEN BEGIN
          IF (Rec."Location Code" <> '') THEN
            Rec.VALIDATE("Fisc. Location Code",FiscalizationManagement.GetFiscLocationCodeMapping(Rec."Location Code"));

          IF (Rec."Location Code" <> '') THEN
            Rec.VALIDATE("Fisc. Terminal",FiscalizationManagement.GetFiscWholesaleTerminalLoc(Rec."Fisc. Location Code"));
        END;
      END;
  END;
END;
// </VAT.1132>
end;

[EventSubscriber(ObjectType::Codeunit, 80, 'OnAfterPostSalesDoc', '', true, true)]
local procedure OnAfterFinalizeSalesPostOnAfterPostSalesDoc(VAR SalesHeader : Record "Sales Header";VAR GenJnlPostLine : Codeunit "Gen. Jnl.-Post Line"
 ;SalesShptHdrNo : Code[20];RetRcpHdrNo : Code[20];SalesInvHdrNo : Code[20];SalesCrMemoHdrNo : Code[20])

var SalesInvoiceHeader : Record "Sales Invoice Header";
  FiscalizationManagement : Codeunit "Fisc. Management-ADL";

begin
    //IF SalesHeader.Invoice THEN BEGIN
      //FiscalizationManagement.FinalizeFiscalization(SalesHeader."Document Type",SalesHeader."Posting Date",
       //SalesInvoiceHeader."Fisc. Subject",SalesInvoiceHeader,SalesCrMemoHeader,PostingPreview,IsNestedRun);
    //END;
end;

procedure OnAfterInsertSalesInvHeader(VAR SalesInvHeader : Record "Sales Invoice Header";SalesHeader : Record "Sales Header")
begin
  SalesInvHeader."Posting TimeStamp" := CurrentDateTime;
end;
procedure OnAfterInsertSalesCrMemoHeader(VAR SalesCrMemoHeader : Record "Sales Cr.Memo Header";SalesHeader : Record "Sales Header")
begin
  SalesCrMemoHeader."Posting TimeStamp" := CurrentDateTime;
end;
}