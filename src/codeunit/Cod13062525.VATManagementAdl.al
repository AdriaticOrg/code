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

        //TEST
        // if GenJournalLine."Posting Date" <> GenJournalLine."VAT Date-Adl" then begin
        //     vatAmount := VATEntry.Amount;
        //     vatBase := VATEntry.Base;
        //     VATEntry.Amount := 0;
        //     VATEntry.Base := 0;
        //     VATEntry."Unrealized Amount" := vatAmount;
        //     VATEntry."Unrealized Base" := vatBase;
        //     VATEntry."Remaining Unrealized Amount" := VATEntry."Unrealized Amount";
        //     VATEntry."Remaining Unrealized Base" := VATEntry."Unrealized Base";
        // end;

        CASE GenJournalLine."Postponed VAT-Adl" OF
            GenJournalLine."Postponed VAT-Adl"::"Postponed VAT":
                BEGIN
                    VATEntry."Remaining Unrealized Amount" := 0;
                    VATEntry."Remaining Unrealized Base" := 0;
                END;
            GenJournalLine."Postponed VAT-Adl"::"Realized VAT":
                BEGIN
                    VATEntry."Unrealized Amount" := -VATEntry.Amount;
                    VATEntry."Unrealized Base" := -VATEntry.Base;
                END;
        END;
        //TEST

        //<adl.11>
        VATEntry."VAT % (retrograde)-Adl" := VATPostingSetup."VAT % (retrograde)-Adl";
        if VATPostingSetup."VAT % (retrograde)-Adl" <> 0 then
            VATEntry."VAT Base (retro.)-Adl" := (VATEntry.Base + VATEntry.Amount) * 100 / VATPostingSetup."VAT % (retrograde)-Adl";
        //</adl.11>
    end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    // local procedure OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    // var
    //     VATPostingSetup: Record "VAT Posting Setup";
    // begin
    //     if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
    //     if GenJournalLine."Postponed VAT-Adl" = GenJournalLine."Postponed VAT-Adl"::"Postponed VAT" then begin
    //         if (TempGLEntryBuf."Source Type" = TempGLEntryBuf."Source Type"::Vendor) and (GenJournalLine."VAT Bus. Posting Group" <> '') and (GenJournalLine."VAT Prod. Posting Group" <> '')
    //             and (TempGLEntryBuf."VAT Amount" = 0) then begin
    //             if VATPostingSetup.Get(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group") then begin
    //                 //VATPostingSetup.TestField("Purch VAT Postponed Account-Adl");
    //                 //TempGLEntryBuf.Validate("G/L Account No.", VATPostingSetup."Purch VAT Postponed Account-Adl");
    //                 if VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then begin
    //                     VATPostingSetup.TestField("Reverse Chrg. VAT Unreal. Acc.");
    //                     TempGLEntryBuf.Validate("G/L Account No.", VATPostingSetup."Reverse Chrg. VAT Unreal. Acc.");
    //                 end else begin
    //                     VATPostingSetup.TestField("Purch. VAT Unreal. Account");
    //                     TempGLEntryBuf.Validate("G/L Account No.", VATPostingSetup."Purch. VAT Unreal. Account");
    //                 end;
    //             end;
    //         end;
    //         if (TempGLEntryBuf."Source Type" = TempGLEntryBuf."Source Type"::Customer) and (GenJournalLine."VAT Bus. Posting Group" <> '') and (GenJournalLine."VAT Prod. Posting Group" <> '')
    //             and (TempGLEntryBuf."VAT Amount" = 0) then begin
    //             if VATPostingSetup.Get(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group") then begin
    //                 VATPostingSetup.TestField("Sales VAT Unreal. Account");
    //                 TempGLEntryBuf.Validate("G/L Account No.", VATPostingSetup."Sales VAT Unreal. Account");
    //             end;
    //         end;
    //     end;
    // end;

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

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', false, false)]
    // local procedure OnAfterFinalizePostingSales(VAR SalesHeader: Record "Sales Header"; VAR SalesShipmentHeader: Record "Sales Shipment Header"; VAR SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    // var
    //     CustomerVendor: Option Customer,Vendor;
    // begin
    //     if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
    //     with SalesHeader do begin
    //         if ("Postponed VAT-adl" = "Postponed VAT-adl"::"Postponed VAT") and ("VAT Date-adl" <> 0D) then begin
    //             case "Document Type" of
    //                 "Document Type"::Invoice, "Document Type"::Order:
    //                     HandlePostponedVAT(DATABASE::"Sales Invoice Header", SalesInvoiceHeader."No.", SalesInvoiceHeader."VAT Date-adl", TRUE, CustomerVendor::Customer, SalesInvoiceHeader."Postponed VAT-adl");
    //                 "Document Type"::"Credit Memo":
    //                     HandlePostponedVAT(DATABASE::"Sales Cr.Memo Header", SalesCrMemoHeader."No.", SalesCrMemoHeader."VAT Date-adl", TRUE, CustomerVendor::Customer, SalesCrMemoHeader."Postponed VAT-adl");
    //             end;
    //         end;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', false, false)]
    // local procedure OnAfterFinalizePostingPurchase(VAR PurchHeader: Record "Purchase Header"; VAR PurchRcptHeader: Record "Purch. Rcpt. Header"; VAR PurchInvHeader: Record "Purch. Inv. Header"; VAR PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    // var
    //     CustomerVendor: Option Customer,Vendor;
    // begin
    //     if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
    //     with PurchHeader do begin
    //         if ("Postponed VAT-adl" = "Postponed VAT-adl"::"Postponed VAT") and ("VAT Date-adl" <> 0D) then begin
    //             case "Document Type" of
    //                 "Document Type"::Invoice, "Document Type"::Order:
    //                     HandlePostponedVAT(DATABASE::"Purch. Inv. Header", PurchInvHeader."No.", PurchInvHeader."VAT Date-adl", TRUE, CustomerVendor::Vendor, PurchInvHeader."Postponed VAT-adl");
    //                 "Document Type"::"Credit Memo":
    //                     HandlePostponedVAT(DATABASE::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr."No.", PurchCrMemoHdr."VAT Date-adl", TRUE, CustomerVendor::Vendor, PurchCrMemoHdr."Postponed VAT-adl");
    //             end;
    //         end;
    //     end;
    // end;
    //<adl.10>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBufferCu80(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, SalesHeader."VAT Date-Adl",SalesHeader."Posting Date", true, GenJnlPostLine,SalesHeader."VAT Date-Adl",InvoicePostBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostInvPostBuffer', '', false, false)]
    local procedure OnAfterPostInvPostBufferCu80(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR SalesHeader: Record "Sales Header"; GLEntryNo: Integer; CommitIsSuppressed: Boolean; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, SalesHeader."VAT Date-Adl", SalesHeader."Posting Date", false, GenJnlPostLine,SalesHeader."VAT Date-Adl",InvoicePostBuffer);
        if SalesHeader."VAT Date-Adl" <> 0D then
            SalesHeader."Postponed VAT-Adl" := SalesHeader."Postponed VAT-Adl"::"Realized VAT";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBufferCu90(VAR GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; var PurchHeader: Record "Purchase Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, PurchHeader."VAT Date-Adl",PurchHeader."Posting Date", true, GenJnlPostLine,PurchHeader."VAT Date-Adl",InvoicePostBuffer);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostInvPostBuffer', '', false, false)]
    local procedure OnAfterPostInvPostBufferCu90(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; PurchHeader: Record "Purchase Header"; GLEntryNo: Integer; CommitIsSupressed: Boolean; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        ManagePostponedVAT.SetPostponedVAT(GenJnlLine, PurchHeader."VAT Date-Adl",PurchHeader."Posting Date", false, GenJnlPostLine,PurchHeader."VAT Date-Adl",InvoicePostBuffer);
        if PurchHeader."VAT Date-Adl" <> 0D then
            PurchHeader."Postponed VAT-Adl" := PurchHeader."Postponed VAT-Adl"::"Realized VAT"; 
    end;
    //</adl.10>
    procedure HandlePostponedVAT(TableNo: Integer; No: Code[20]; PostDate: Date; Post: Boolean; SalesPurchase: Option Customer,Vendor; PostponedVAT: Option "Realized VAT","Postponed VAT")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvoice: Record "Purch. Inv. Header";
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
        SalesInvoice: Record "Sales Invoice Header";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        GenJnlLineLoc: Record "Gen. Journal Line";
        LedgEntryFound: Boolean;
        DimSetID: Integer;
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;

        case TableNo of
            DATABASE::"Sales Cr.Memo Header":
                begin
                    SalesCrMemo.Get(No);
                    if CustLedgerEntry.Get(SalesCrMemo."Cust. Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if Post then
                            SalesCrMemo."Postponed VAT-Adl" := SalesCrMemo."Postponed VAT-Adl"::"Realized VAT"
                        else
                            SalesCrMemo."Postponed VAT-Adl" := SalesCrMemo."Postponed VAT-Adl"::"Postponed VAT";
                        SalesCrMemo.Modify;
                        DimSetID := CustLedgerEntry."Dimension Set ID";
                    end;
                end;
            DATABASE::"Sales Invoice Header":
                begin
                    SalesInvoice.Get(No);
                    if CustLedgerEntry.Get(SalesInvoice."Cust. Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if Post then
                            SalesInvoice."Postponed VAT-Adl" := SalesInvoice."Postponed VAT-Adl"::"Realized VAT"
                        else
                            SalesInvoice."Postponed VAT-Adl" := SalesInvoice."Postponed VAT-Adl"::"Postponed VAT";
                        SalesInvoice.Modify;
                        DimSetID := CustLedgerEntry."Dimension Set ID";
                    end;
                end;
            DATABASE::"Purch. Inv. Header":
                begin
                    PurchInvoice.Get(No);
                    if VendLedgerEntry.Get(PurchInvoice."Vendor Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if Post then
                            PurchInvoice."Postponed VAT-Adl" := PurchInvoice."Postponed VAT-Adl"::"Realized VAT"
                        else
                            PurchInvoice."Postponed VAT-Adl" := PurchInvoice."Postponed VAT-Adl"::"Postponed VAT";
                        PurchInvoice.Modify;
                        DimSetID := VendLedgerEntry."Dimension Set ID";
                    end;
                end;
            DATABASE::"Purch. Cr. Memo Hdr.":
                begin
                    PurchCrMemo.Get(No);
                    if VendLedgerEntry.Get(PurchCrMemo."Vendor Ledger Entry No.") then begin
                        LedgEntryFound := true;
                        if Post then
                            PurchCrMemo."Postponed VAT-Adl" := PurchCrMemo."Postponed VAT-Adl"::"Realized VAT"
                        else
                            PurchCrMemo."Postponed VAT-Adl" := PurchCrMemo."Postponed VAT-Adl"::"Postponed VAT";
                        PurchCrMemo.Modify;
                        DimSetID := VendLedgerEntry."Dimension Set ID";
                    end;
                end;
        end;
        if LedgEntryFound then begin
            with GenJnlLineLoc do begin
                "Document No." := No;
                Correction := NOT Post;
                "Posting Date" := PostDate;
                Description := Description;
                "Dimension Set ID" := DimSetID;
            end;
            if Post then
                CASE SalesPurchase OF
                    SalesPurchase::Customer:
                        begin
                            CustLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            GenJnlLineLoc.Amount := CustLedgerEntry."Remaining Amt. (LCY)";
                            PostPostponedVAT(CustLedgerEntry, VendLedgerEntry, GenJnlLineLoc, SalesPurchase::Customer);
                        end;
                    SalesPurchase::Vendor:
                        begin
                            VendLedgerEntry.CALCFIELDS("Remaining Amt. (LCY)");
                            GenJnlLineLoc.Amount := VendLedgerEntry."Remaining Amt. (LCY)";
                            PostPostponedVAT(CustLedgerEntry, VendLedgerEntry, GenJnlLineLoc, SalesPurchase::Vendor);
                        end;
                end
            else
                CASE SalesPurchase OF
                    SalesPurchase::Customer:
                        ReversePostponedVAT(GenJnlLineLoc, CustLedgerEntry."Transaction No.", SalesPurchase::Customer);
                    SalesPurchase::Vendor:
                        ReversePostponedVAT(GenJnlLineLoc, VendLedgerEntry."Transaction No.", SalesPurchase::Vendor);
                end;
        end;
    end;

    procedure FillGeneralJournalLine(VAR GenJnlLine: Record "Gen. Journal Line";CustVend: Option Customer,Vendor;CustLedgEntry: Record "Cust. Ledger Entry";VendLedgEntry: Record "Vendor Ledger Entry";DocNo:Code[20];Post: Boolean;PostDate: Date)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        SourceCodeSetup: Record "Source Code Setup";
    begin
        with GenJnlLine do begin
            Init;
            "Document No." := DocNo;
            Correction := NOT Post;
            "Posting Date" := PostDate;
            "Document Date" := "Posting Date";
            "Document Type" := "Document Type"::Invoice;
            "Account Type" := "Account Type"::"G/L Account";
            case CustVend of 
                CustVend::Customer:
                    begin
                        "Gen. Posting Type" := "Gen. Posting Type"::Sale;
                        "Account No." := VATPostingSetup.GetSalesAccount(true);
                        "Source Code" := SourceCodeSetup.Sales;
                        "Dimension Set ID" := CustLedgEntry."Dimension Set ID";
                        Description := CustLedgEntry.Description;
                        "Source Type" := "Source Type"::Customer;
                        "Source Code" := CustLedgEntry."Customer No.";
                    end;
                CustVend::Vendor:
                    begin
                        "Gen. Posting Type" := "Gen. Posting Type"::Purchase;
                        GenJnlLine."Account No." := VATPostingSetup.GetPurchAccount(true);
                        "Source Code" := SourceCodeSetup.Purchases;
                        "Dimension Set ID" := VendLedgEntry."Dimension Set ID";
                        Description := VendLedgEntry.Description;
                        "Source Type" := "Source Type"::Vendor;
                        "Source Code" := VendLedgEntry."Vendor No.";
                    end;
            end;
        end;
    end;

    local procedure PostPostponedVAT(VAR CustLedgEntry2: Record "Cust. Ledger Entry"; VAR VendLedgEntry2: Record "Vendor Ledger Entry"; VAR GenJnlLine2: Record "Gen. Journal Line"; SalesPurchase: Option Customer,Vendor)
    var
        SourceCodeSetupLoc: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        GenJnlLine := GenJnlLine2;
        GLSetup.Get();
        SourceCodeSetupLoc.Get();
        case SalesPurchase of
            SalesPurchase::Customer:
                begin
                    GenJnlLine."Document Type" := CustLedgEntry2."Document Type";
                    GenJnlLine."Source Code" := SourceCodeSetupLoc.Sales;
                end;
            SalesPurchase::Vendor:
                begin
                    GenJnlLine."Source Code" := SourceCodeSetupLoc.Purchases;
                    GenJnlLine."Document Type" := VendLedgEntry2."Document Type";
                end;
        end;
        GenJnlLine."Postponed VAT-Adl" := GenJnlLine."Postponed VAT-Adl"::"Postponed VAT";
        IF ManagePostponedVAT.GetNextEntryNo() = 0 THEN
            ManagePostponedVAT.StartPosting(GenJnlLine)
        ELSE
            ManagePostponedVAT.ContinuePosting(GenJnlLine);
        CASE SalesPurchase OF
            SalesPurchase::Customer:
                BEGIN
                    CustLedgEntry2."Remaining Amt. (LCY)" := 0;
                    ManagePostponedVAT.CustUnrealizedVAT(GenJnlLine, CustLedgEntry2, GenJnlLine.Amount);
                END;
            SalesPurchase::Vendor:
                BEGIN
                    VendLedgEntry2."Remaining Amt. (LCY)" := 0;
                    ManagePostponedVAT.VendUnrealizedVAT(GenJnlLine, VendLedgEntry2, GenJnlLine.Amount);
                END;
        END;
        ManagePostponedVAT.FinishPosting();
        GenJnlLine2 := GenJnlLine;
    end;


    procedure ReversePostponedVAT(VAR GenJnlLine2: Record "Gen. Journal Line"; TransactionNo: Integer; SalesPurchase: Option Customer,Vendor)
    var
        VATEntry: Record "VAT Entry";
        UnrealVATEntry: Record "VAT Entry";
        RevVATEntry: Record "VAT Entry";
        SourceCodeSetup: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        GenJnlLine := GenJnlLine2;
        SourceCodeSetup.GET();
        GenJnlLine."Source Code" := SourceCodeSetup.Reversal;
        IF ManagePostponedVAT.GetNextEntryNo() = 0 THEN
            ManagePostponedVAT.StartPosting(GenJnlLine)
        ELSE
            ManagePostponedVAT.ContinuePosting(GenJnlLine);
        //GLReg.Reversed := TRUE;
        VATEntry.LOCKTABLE();
        UnrealVATEntry.SETCURRENTKEY("Transaction No.");
        UnrealVATEntry.SETRANGE("Transaction No.", TransactionNo);
        UnrealVATEntry.SETRANGE("Postponed VAT-Adl", UnrealVATEntry."Postponed VAT-Adl"::"Postponed VAT");
        IF UnrealVATEntry.FINDSET(TRUE) THEN
            REPEAT
                VATEntry.SETCURRENTKEY("Unrealized VAT Entry No.");
                VATEntry.SETRANGE("Unrealized VAT Entry No.", UnrealVATEntry."Entry No.");
                VATEntry.SETRANGE(Reversed, FALSE);
                IF VATEntry.FINDSET() THEN
                    REPEAT
                        VATPostingSetup.GET(VATEntry."VAT Bus. Posting Group", VATEntry."VAT Prod. Posting Group");
                        GenJnlLine."Posting Date" := VATEntry."Posting Date";
                        RevVATEntry.SETRANGE("Entry No.", VATEntry."Entry No.");
                        ManagePostponedVAT.ReverseVAT(RevVATEntry);
                        UnrealVATEntry."Remaining Unrealized Amount" :=
                        UnrealVATEntry."Remaining Unrealized Amount" + VATEntry.Amount;
                        UnrealVATEntry."Remaining Unrealized Base" :=
                        UnrealVATEntry."Remaining Unrealized Base" + VATEntry.Base;
                        UnrealVATEntry."Add.-Curr. Rem. Unreal. Amount" :=
                        UnrealVATEntry."Add.-Curr. Rem. Unreal. Amount" + VATEntry."Additional-Currency Amount";
                        UnrealVATEntry."Add.-Curr. Rem. Unreal. Base" :=
                        UnrealVATEntry."Add.-Curr. Rem. Unreal. Base" + VATEntry."Additional-Currency Base";
                        UnrealVATEntry.MODIFY();
                        CASE SalesPurchase OF
                            SalesPurchase::Customer:
                                BEGIN
                                    //VATPostingSetup.TestField("Sales VAT Postponed Account-Adl");
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup.GetSalesAccount(false),
                                        -VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", -VATEntry.Amount), TRUE);
                                    //ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup."Sales VAT Postponed Account-Adl",
                                    //VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount), TRUE);
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup.GetSalesAccount(true),
                                    VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount), TRUE);
                                END;
                            SalesPurchase::Vendor:
                                BEGIN
                                    //VATPostingSetup.TestField("Purch VAT Postponed Account-Adl");
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup.GetPurchAccount(false),
                                        -VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", -VATEntry.Amount), TRUE);
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup.GetPurchAccount(true),
                                        VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount), TRUE);
                                END;
                        END;
                    UNTIL VATEntry.NEXT() = 0;
            UNTIL UnrealVATEntry.NEXT() = 0;
        ManagePostponedVAT.FinishPosting();
        GenJnlLine2 := GenJnlLine;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VAT Entry - Edit", 'OnBeforeVATEntryModify', '', true, true)]
    local procedure VATEntryEditOnBeforeVATEntryModify(var VATEntry: Record "VAT Entry"; FromVATEntry: Record "VAT Entry")
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        VATEntry."VAT Identifier-Adl" := FromVATEntry."VAT Identifier-Adl";
    end;

    var
        CoreSetup: Record "CoreSetup-Adl";
        ADLCore: Codeunit "Adl Core";
        ManagePostponedVAT: Codeunit "Manage Postponed VAT-Adl";
        UpdVatDateQst: Label 'Do you want to change VAT Date';
}