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
}