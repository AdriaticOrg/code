codeunit 13062525 "VAT Management-Adl"
{
    Permissions = tabledata 122 = rm,
                tabledata 124 = rm,
                tabledata 112 = rm,
                tabledata 114 = rm,
                tabledata 254 = irm;

    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInitRecord', '', false, false)]
    local procedure OnAfterInitRecord(var PurchHeader: Record "Purchase Header")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        PurchHeader."VAT Date-Adl" := PurchHeader."Posting Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidatePostingDate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;

        if Confirm(UpdVatDateQst, true) then
            Rec.Validate("VAT Date-Adl", Rec."Posting Date");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        GenJournalLine."VAT Date-Adl" := PurchaseHeader."VAT Date-Adl";
        GenJournalLine."Postponed VAT-Adl" := PurchaseHeader."Postponed VAT-Adl";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Inventory Posting To G/L", 'OnBeforePostInvtPostBuf', '', true, false)]
    local procedure OnBeforePostInvtPostBuf(var GenJournalLine: Record "Gen. Journal Line"; var InvtPostingBuffer: Record "Invt. Posting Buffer"; ValueEntry: Record "Value Entry"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        //TODO: we must get values here!
        //GenJournalLine."VAT Bus. Posting Group" := InvtPostingBuffer.
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyFromGenJnlLine(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        VATEntry."Postponed VAT-Adl" := GenJournalLine."Postponed VAT-Adl";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertVATEntry', '', false, false)]
    local procedure OnBeforeInsertVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        VATPostingSetup.Get(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group");
        VATEntry."VAT Identifier-Adl" := VATPostingSetup."VAT Identifier";
        CASE GenJournalLine."Postponed VAT-Adl" OF
            GenJournalLine."Postponed VAT-Adl"::"Postponed VAT":
                BEGIN
                    VATEntry."Remaining Unrealized Amount" := 0;
                    VATEntry."Remaining Unrealized Base" := 0;
                END;
            GenJournalLine."Postponed VAT-Adl"::"Realized VAT":
                if GenJournalLine."Posting Date" <> GenJournalLine."VAT Date-Adl" then begin
                    VATEntry."Unrealized Amount" := -VATEntry.Amount;
                    VATEntry."Unrealized Base" := -VATEntry.Base;
                end;
        END;
        //TEST

        //<adl.11>
        VATEntry."VAT % (retrograde)-Adl" := VATPostingSetup."VAT % (retrograde)-Adl";
        if VATPostingSetup."VAT % (retrograde)-Adl" <> 0 then
            VATEntry."VAT Base (retro.)-Adl" := (VATEntry.Base + VATEntry.Amount) * 100 / VATPostingSetup."VAT % (retrograde)-Adl";
        //</adl.11>
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure SalesHeaderOnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        SalesHeader."VAT Date-Adl" := SalesHeader."Posting Date";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure GenJournalLineOnAfterValidateDocumentDate(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        GenJournalLine."VAT Date-Adl" := SalesHeader."VAT Date-Adl";
        GenJournalLine."Postponed VAT-Adl" := SalesHeader."Postponed VAT-Adl";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidateEventPostingDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;

        if Confirm(UpdVatDateQst, false) then
            Rec.Validate("VAT Date-Adl", Rec."Posting Date");
    end;

    //<adl.10>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBufferCu80(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, SalesHeader."VAT Date-Adl", SalesHeader."Posting Date", true, GenJnlPostLine, 0D, InvoicePostBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostInvPostBuffer', '', false, false)]
    local procedure OnAfterPostInvPostBufferCu80(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR SalesHeader: Record "Sales Header"; GLEntryNo: Integer; CommitIsSuppressed: Boolean; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, SalesHeader."VAT Date-Adl", SalesHeader."Posting Date", false, GenJnlPostLine, 0D, InvoicePostBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBufferCu90(VAR GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var PurchHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, PurchHeader."VAT Date-Adl", PurchHeader."Posting Date", true, GenJnlPostLine, PurchHeader."VAT Output Date-Adl", InvoicePostBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostInvPostBuffer', '', false, false)]
    local procedure OnAfterPostInvPostBufferCu90(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; PurchHeader: Record "Purchase Header"; GLEntryNo: Integer; CommitIsSupressed: Boolean; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, PurchHeader."VAT Date-Adl", PurchHeader."Posting Date", false, GenJnlPostLine, PurchHeader."VAT Output Date-Adl", InvoicePostBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostCommitPurchaseDoc', '', false, false)]
    local procedure OnBeforePostCommitPurchaseDoc(VAR PurchaseHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; ModifyHeader: Boolean; CommitIsSupressed: Boolean)
    begin
        if PurchaseHeader."VAT Date-Adl" <> 0D then
            PurchaseHeader."Postponed VAT-Adl" := PurchaseHeader."Postponed VAT-Adl"::"Realized VAT";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostCommitSalesDoc', '', false, false)]
    local procedure OnBeforePostCommitSalesDoc(VAR SalesHeader: Record "Sales Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; ModifyHeader: Boolean)
    begin
        if SalesHeader."VAT Date-Adl" <> 0D then
            SalesHeader."Postponed VAT-Adl" := SalesHeader."Postponed VAT-Adl"::"Realized VAT";
    end;
    //</adl.10>
    procedure HandlePostponedVAT(TableNo: Integer; No: Code[20]; PostDate: Date; Post: Boolean; SalesPurchase: Option Customer,Vendor; PostponedVAT: Option "Realized VAT","Postponed VAT"; Preview: Boolean; VatOutput: Boolean)
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvoice: Record "Purch. Inv. Header";
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
        SalesInvoice: Record "Sales Invoice Header";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        GenJnlLineLoc: Record "Gen. Journal Line";
        VATEntry: Record "VAT Entry";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPostPreview: Codeunit "Gen. Jnl.-Post Preview";
        LedgEntryFound: Boolean;
        SuccessfulPostingMsg: Label 'The Postponed VAT was successfully posted.';
        SuccessfulCorrectionMsg: Label 'The Postponed VAT was successfully corrected.';
        SuccessfulPostingVATOutputMsg: Label 'The VAT Output Date was successfully posted.';
        SuccessfulCorrectionVATOutputMsg: Label 'The VAT Output Date was successfully corrected.';
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        if PostDate = 0D then exit;
        case TableNo of
            DATABASE::"Sales Cr.Memo Header":
                begin
                    SalesCrMemo.Get(No);
                    if CustLedgerEntry.Get(SalesCrMemo."Cust. Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if not VatOutput then
                            if Post then
                                SalesCrMemo."Postponed VAT-Adl" := SalesCrMemo."Postponed VAT-Adl"::"Realized VAT"
                            else
                                SalesCrMemo."Postponed VAT-Adl" := SalesCrMemo."Postponed VAT-Adl"::"Postponed VAT";
                        SalesCrMemo.Modify;
                    end;
                end;
            DATABASE::"Sales Invoice Header":
                begin
                    SalesInvoice.Get(No);
                    if CustLedgerEntry.Get(SalesInvoice."Cust. Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if not VatOutput then
                            if Post then
                                SalesInvoice."Postponed VAT-Adl" := SalesInvoice."Postponed VAT-Adl"::"Realized VAT"
                            else
                                SalesInvoice."Postponed VAT-Adl" := SalesInvoice."Postponed VAT-Adl"::"Postponed VAT";
                        SalesInvoice.Modify;
                    end;
                end;
            DATABASE::"Purch. Inv. Header":
                begin
                    PurchInvoice.Get(No);
                    if VendLedgerEntry.Get(PurchInvoice."Vendor Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if not VatOutput then begin
                            if Post then
                                PurchInvoice."Postponed VAT-Adl" := PurchInvoice."Postponed VAT-Adl"::"Realized VAT"
                            else
                                PurchInvoice."Postponed VAT-Adl" := PurchInvoice."Postponed VAT-Adl"::"Postponed VAT";
                        end else
                            if Post then
                                PurchInvoice."VAT Output Date-Adl" := PostDate
                            else
                                PurchInvoice."VAT Output Date-Adl" := 0D;
                        PurchInvoice.Modify;
                    end;
                end;
            DATABASE::"Purch. Cr. Memo Hdr.":
                begin
                    PurchCrMemo.Get(No);
                    if VendLedgerEntry.Get(PurchCrMemo."Vendor Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if not VatOutput then begin
                            if Post then
                                PurchCrMemo."Postponed VAT-Adl" := PurchCrMemo."Postponed VAT-Adl"::"Realized VAT"
                            else
                                PurchCrMemo."Postponed VAT-Adl" := PurchCrMemo."Postponed VAT-Adl"::"Postponed VAT";
                        end else
                            if Post then
                                PurchCrMemo."VAT Output Date-Adl" := PostDate
                            else
                                PurchCrMemo."VAT Output Date-Adl" := 0D;
                        PurchCrMemo.Modify;
                    end;
                end;
        end;
        if LedgEntryFound then begin
            CASE SalesPurchase OF
                SalesPurchase::Customer:
                    begin
                        VATEntry.SetRange("Transaction No.", CustLedgerEntry."Transaction No.");
                        if VATEntry.FindSet() then
                            repeat
                                if not VatOutput then begin
                                    FillGeneralJournalLine(GenJnlLineLoc, 0, CustLedgerEntry, VendLedgerEntry, VATEntry, Post, PostDate);
                                    if Preview then
                                        GenJnlPostPreview.Preview(GenJnlPostLine, GenJnlLineLoc)
                                    else
                                        GenJnlPostLine.RunWithCheck(GenJnlLineLoc);
                                end;
                                ReverseVATSetup(VATEntry, Post);
                            until VATEntry.Next() = 0;
                    end;
                SalesPurchase::Vendor:
                    begin
                        VATEntry.SetRange("Transaction No.", VendLedgerEntry."Transaction No.");
                        if VatOutput then
                            VATEntry.SetRange(Type, VATEntry.Type::Sale);
                        if VATEntry.FindSet() then
                            repeat
                                if not VatOutput then begin
                                    FillGeneralJournalLine(GenJnlLineLoc, 1, CustLedgerEntry, VendLedgerEntry, VATEntry, Post, PostDate);
                                    if Preview then
                                        GenJnlPostPreview.Preview(GenJnlPostLine, GenJnlLineLoc)
                                    else
                                        GenJnlPostLine.RunWithCheck(GenJnlLineLoc);
                                end
                                else
                                    FillGeneralJournalLineVATOutput(GenJnlLineLoc, VendLedgerEntry, VATEntry, Post, PostDate);
                                ReverseVATSetup(VATEntry, Post);
                            until VATEntry.Next() = 0;
                    end;
            end;
            case Post of
                true:
                    if VatOutput then
                        Message(SuccessfulPostingVATOutputMsg)
                    else
                        Message(SuccessfulPostingMsg);
                false:
                    if VatOutput then
                        Message(SuccessfulCorrectionVATOutputMsg)
                    else
                        Message(SuccessfulCorrectionMsg);
            end;
        end;
    end;

    procedure FillGeneralJournalLine(VAR GenJnlLine: Record "Gen. Journal Line"; CustVend: Option Customer,Vendor; CustLedgEntry: Record "Cust. Ledger Entry"; VendLedgEntry: Record "Vendor Ledger Entry"; VATEntry: Record "VAT Entry"; Post: Boolean; PostDate: Date)
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        VATPostingSetup.Get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
        with GenJnlLine do begin
            Init();
            "Document No." := VATEntry."Document No.";
            Correction := NOT Post;
            "Posting Date" := PostDate;
            "Document Date" := "Posting Date";
            "Document Type" := "Document Type"::Invoice;
            "Account Type" := "Account Type"::"G/L Account";
            "Bal. Account Type" := "Bal. Account Type"::"G/L Account";
            "Gen. Bus. Posting Group" := VATEntry."Gen. Bus. Posting Group";
            "Gen. Prod. Posting Group" := VATEntry."Gen. Prod. Posting Group";
            "VAT Bus. Posting Group" := VATEntry."VAT Bus. Posting Group";
            "VAT Prod. Posting Group" := VATEntry."VAT Prod. Posting Group";
            "System-Created Entry" := true;
            "Gen. Posting Type" := VATEntry.Type;
            "Source Code" := VATEntry."Source Code";
            "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
            "VAT Calculation Type" := VATEntry."VAT Calculation Type";
            "Allow Application" := true;
            "VAT Amount" := VATEntry."Unrealized Amount";
            "VAT Amount (LCY)" := VATEntry."Unrealized Amount";
            Amount := -VATEntry."Unrealized Amount";
            "Amount (LCY)" := -VATEntry."Unrealized Amount";
            "VAT Base Amount" := VATEntry."Unrealized Base";
            "VAT Base Amount (LCY)" := VATEntry."Unrealized Base";
            case CustVend of
                CustVend::Customer:
                    begin
                        "Account No." := VATPostingSetup.GetSalesAccount(true);
                        "Dimension Set ID" := CustLedgEntry."Dimension Set ID";
                        Description := CustLedgEntry.Description;
                        "Source Type" := "Source Type"::Customer;
                        "Source No." := CustLedgEntry."Customer No.";
                        "Bill-to/Pay-to No." := CustLedgEntry."Customer No.";
                    end;
                CustVend::Vendor:
                    begin
                        "Account No." := VATPostingSetup.GetPurchAccount(true);
                        "Dimension Set ID" := VendLedgEntry."Dimension Set ID";
                        Description := VendLedgEntry.Description;
                        "Source Type" := "Source Type"::Vendor;
                        "Source No." := VendLedgEntry."Vendor No.";
                        "Bill-to/Pay-to No." := VendLedgEntry."Vendor No.";
                    end;
            end;
            case Post of
                false:
                    begin
                        "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT";
                        VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage;
                        VATPostingSetup.Modify();
                        IsPercent := true;
                        if CustVend = CustVend::Customer then
                            "Account No." := VATPostingSetup.GetSalesAccount(false)
                        else
                            "Account No." := VATPostingSetup.GetPurchAccount(false);
                    end;
            end;
            if VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then begin
                GenJnlLine.Amount := -GenJnlLine.Amount;
                GenJnlLine."Amount (LCY)" := -GenJnlLine."Amount (LCY)";
                GenJnlLine."Account No." := VATPostingSetup.GetRevChargeAccount(true);
                if CustVend = CustVend::Customer then
                    GenJnlLine."Bal. Account No." := VATPostingSetup.GetSalesAccount(true)
                else
                    GenJnlLine."Bal. Account No." := VATPostingSetup.GetPurchAccount(true);
            end
        end;
    end;

    procedure FillGeneralJournalLineVATOutput(VAR GenJnlLine: Record "Gen. Journal Line"; VendLedgEntry: Record "Vendor Ledger Entry"; VATEntry: Record "VAT Entry"; Post: Boolean; PostDate: Date)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        VATPostingSetup.Get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
        PurchaseSetup.Get();
        if (not PurchaseSetup."Use VAT Output Date-Adl") and (VATPostingSetup."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT") then exit;
        with GenJnlLine do begin
            Init();
            "Document No." := VATEntry."Document No.";
            Correction := NOT Post;
            "Posting Date" := PostDate;
            "Document Date" := "Posting Date";
            "Document Type" := "Document Type"::Invoice;
            "Account Type" := "Account Type"::"G/L Account";
            "Bal. Account Type" := "Bal. Account Type"::"G/L Account";
            "Gen. Bus. Posting Group" := VATEntry."Gen. Bus. Posting Group";
            "Gen. Prod. Posting Group" := VATEntry."Gen. Prod. Posting Group";
            "VAT Bus. Posting Group" := VATEntry."VAT Bus. Posting Group";
            "VAT Prod. Posting Group" := VATEntry."VAT Prod. Posting Group";
            "System-Created Entry" := true;
            "Gen. Posting Type" := VATEntry.Type;
            "Source Code" := VATEntry."Source Code";
            "VAT Posting" := "VAT Posting"::"Manual VAT Entry";
            "Allow Application" := true;
            "VAT Amount" := VATEntry."Unrealized Amount";
            "VAT Amount (LCY)" := VATEntry."Unrealized Amount";
            Amount := -VATEntry."Unrealized Amount";
            "Amount (LCY)" := -VATEntry."Unrealized Amount";
            "VAT Base Amount" := VATEntry."Unrealized Base";
            "VAT Base Amount (LCY)" := VATEntry."Unrealized Base";
            "Account No." := VATPostingSetup.GetPurchAccount(true);
            "Dimension Set ID" := VendLedgEntry."Dimension Set ID";
            Description := VendLedgEntry.Description;
            "Source Type" := "Source Type"::Vendor;
            "Source No." := VendLedgEntry."Vendor No.";
            "Bill-to/Pay-to No." := VendLedgEntry."Vendor No.";
            VATPostingSetup."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type"::"Normal VAT";
            "VAT Calculation Type" := "VAT Calculation Type"::"Normal VAT";
            "Gen. Posting Type" := "Gen. Posting Type"::Sale;
            case Post of
                true:
                    begin
                        VATPostingSetup."Unrealized VAT Type" := 0;
                        "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Realized VAT";
                        "Account No." := VATPostingSetup.GetSalesAccount(TRUE);
                    end;
                false:
                    begin
                        "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT";
                        VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage;
                        IsPercent := true;
                        "Account No." := VATPostingSetup.GetSalesAccount(false);  //
                    end;
            end;
            VATPostingSetup.Modify();
            GenJnlPostLine.RunWithCheck(GenJnlLine);
            VATPostingSetup."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT";
            VATPostingSetup."Unrealized VAT Type" := 0;
            VATPostingSetup.Modify();
        end;
    end;

    local procedure ReverseVATSetup(VATEntry: Record "VAT Entry"; Post: Boolean)
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        VATPostingSetup.Get(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
        if IsReverseVat then begin
            VATPostingSetup."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT";
            VATPostingSetup.Modify();
            IsReverseVat := false;
        end;
        if IsPercent then begin
            VATPostingSetup."Unrealized VAT Type" := 0;
            VATPostingSetup.Modify();
            IsPercent := false;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VAT Entry - Edit", 'OnBeforeVATEntryModify', '', true, true)]
    local procedure VATEntryEditOnBeforeVATEntryModify(var VATEntry: Record "VAT Entry"; FromVATEntry: Record "VAT Entry")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        VATEntry."VAT Identifier-Adl" := FromVATEntry."VAT Identifier-Adl";
    end;

    var
        CoreSetup: Record "CoreSetup-Adl";
        PurchaseSetup: Record "Purchases & Payables Setup";
        ADLCore: Codeunit "Adl Core-Adl";
        ManagePostponedVAT: Codeunit "Manage Postponed VAT-Adl";
        UpdVatDateQst: Label 'Do you want to change VAT Date';
        IsReverseVat: Boolean;
        IsPercent: Boolean;
}