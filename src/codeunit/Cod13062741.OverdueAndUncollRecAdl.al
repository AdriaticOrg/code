
codeunit 13062741 "Overdue And Uncoll.Rec-Adl"
{
    // <adl.28>
    // Unpaid Receivables
    // <adl.28>
    Permissions = tabledata 21 = r;

    var
        CoreSetup: Record "CoreSetup-Adl";
        ADLCore: Codeunit "Adl Core-Adl";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostCust', '', false, false)]
    local procedure OverdueandUncollRec(var GenJournalLine: Record "Gen. Journal Line"; Balancing: Boolean)
    var
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-Adl";
        CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-Adl";
        CustLedgEntry: Record "Cust. Ledger Entry";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables) then exit;
        CustLedgEntry.FindLast();

        CustLedgerEntryExtData.Reset();
        CustLedgerEntryExtData.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        CustLedgerEntryExtData.SetRange("Journal Template Name", GenJournalLine."Journal Template Name");
        CustLedgerEntryExtData.SetRange("Journal Batch Name", GenJournalLine."Journal Batch Name");
        CustLedgerEntryExtData.SetRange("Line No.", GenJournalLine."Line No.");
        CustLedgerEntryExtData.SetRange("Is Journal Line", true);
        IF CustLedgerEntryExtData.FindFirst() then begin
            CustLedgerEntryExtData2.Init();
            CustLedgerEntryExtData2."Entry No." := CustLedgEntry."Entry No.";
            CustLedgerEntryExtData2."Is Journal Line" := false;
            CustLedgerEntryExtData2."Original Document Amount (LCY)" := CustLedgerEntryExtData."Original Document Amount (LCY)";
            CustLedgerEntryExtData2."Original VAT Amount (LCY)" := CustLedgerEntryExtData."Original VAT Amount (LCY)";
            CustLedgerEntryExtData2."Open Amount (LCY) w/o Unreal." := CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
            CustLedgerEntryExtData2.Insert();
            CustLedgerEntryExtData.Delete();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure OnDeleteCustLdgEntryExtData(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-Adl";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables) then exit;

        CustLedgerEntryExtData.Reset();
        CustLedgerEntryExtData.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        CustLedgerEntryExtData.SetRange("Journal Template Name", Rec."Journal Template Name");
        CustLedgerEntryExtData.SetRange("Journal Batch Name", Rec."Journal Batch Name");
        CustLedgerEntryExtData.SetRange("Line No.", Rec."Line No.");
        IF CustLedgerEntryExtData.FindFirst() THEN
            CustLedgerEntryExtData.Delete();
    end;

}