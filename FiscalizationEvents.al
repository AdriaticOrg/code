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
}