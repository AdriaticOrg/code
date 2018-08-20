codeunit 50100 "VAT Date-Sales Mgt-adl"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure SalesHeaderOnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader.Validate("VAT Date-adl");
    end;

    //OnAfterCopyGenJnlLineFromSalesHeader
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure GenJournalLineOnAfterValidateDocumentDate(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."VAT Date-adl" := SalesHeader."VAT Date-adl";
    end;

    //OnAfterCopyFromGenJnlLine
    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure ValueEntrynAfterCopyFromGenJnlLine(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VATEntry."VAT Date-adl" := GenJournalLine."VAT Date-adl";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidateEventPostingDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        if Confirm(UpdateVatDate, false) then
            Rec."VAT Date-adl" := Rec."Posting Date";
    end;

    var
        UpdateVatDate: TextConst ENU = '<qualifier>Change</qualifier><payload>Do you want to change VAT Date <emphasize>Headline1</emphasize>.</payload>';
}