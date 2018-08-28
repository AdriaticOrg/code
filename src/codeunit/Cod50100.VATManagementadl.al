codeunit 50100 "VAT Management-adl"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    begin
        with PurchHeader do begin
            "VAT Date-adl" := "Posting Date";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidatePostingDate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Confirm(UpdVatDate, true) then
            Rec."VAT Date-adl" := Rec."Posting Date";
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."VAT Date-adl" := PurchaseHeader."VAT Date-adl";
        GenJournalLine."Postponed VAT-adl" := PurchaseHeader."Postponed VAT-adl";
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry")
    begin
        VATEntry."VAT Date-adl" := GenJournalLine."VAT Date-adl";
        VATEntry."Postponed VAT-adl" := GenJournalLine."Postponed VAT-adl";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertVATEntry', '', false, false)]
    local procedure OnBeforeInsertVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        vatAmount: Decimal;
        vatBase: Decimal;
    begin
        if GenJournalLine."Posting Date" <> GenJournalLine."VAT Date-adl" then begin
            vatAmount := VATEntry.Amount;
            vatBase := VATEntry.Base;
            VATEntry.Amount := 0;
            VATEntry.Base := 0;
            VATEntry."Unrealized Amount" := vatAmount;
            VATEntry."Unrealized Base" := vatBase;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertVATEntry', '', false, false)]
    local procedure OnAfterInsertVATEntry(GenJnlLine: Record "Gen. Journal Line";VATEntry: Record "VAT Entry";GLEntryNo: Integer;var NextEntryNo: Integer)
    var
        PurchaseInvHeader: Record "Purch. Inv. Header";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PostJnlLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        
    end;



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
        GenJournalLine."Postponed VAT-adl" := SalesHeader."Postponed VAT-adl";
    end;

    //OnAfterCopyFromGenJnlLine
    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure ValueEntrynAfterCopyFromGenJnlLine(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VATEntry."VAT Date-adl" := GenJournalLine."VAT Date-adl";
        VATEntry."Postponed VAT-adl" := GenJournalLine."Postponed VAT-adl";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidateEventPostingDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        if Confirm(UpdVatDate, false) then
            Rec."VAT Date-adl" := Rec."Posting Date";
    end;

    var
        UpdVatDate: TextConst ENU = '<qualifier>Change</qualifier><payload>Do you want to change VAT Date <emphasize>Headline1</emphasize>.</payload>';
}