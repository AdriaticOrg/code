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
        with PurchHeader do begin
            "VAT Date-Adl" := "Posting Date";
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidatePostingDate(var Rec: Record "Purchase Header"; var xRec: Record "Purchase Header"; CurrFieldNo: Integer)
    begin
        if Confirm(UpdVatDate, true) then
            Rec.Validate("VAT Date-Adl", Rec."Posting Date");
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromPurchHeader', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromPurchHeader(PurchaseHeader: Record "Purchase Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."VAT Date-Adl" := PurchaseHeader."VAT Date-Adl";
        GenJournalLine."Postponed VAT-Adl" := PurchaseHeader."Postponed VAT-Adl";
    end;

    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure OnAfterCopyFromGenJnlLine(GenJournalLine: Record "Gen. Journal Line"; var VATEntry: Record "VAT Entry")
    begin
        VATEntry."Posting Date" := GenJournalLine."VAT Date-Adl";
        VATEntry."Postponed VAT-Adl" := GenJournalLine."Postponed VAT-Adl";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertVATEntry', '', false, false)]
    local procedure OnBeforeInsertVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        VATPostingSetup: Record "VAT Posting Setup";
        vatAmount: Decimal;
        vatBase: Decimal;
    begin
        VATPostingSetup.Get(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group");
        VATEntry."VAT Identifier-Adl" := VATPostingSetup."VAT Identifier";
        if GenJournalLine."Posting Date" <> GenJournalLine."VAT Date-Adl" then begin
            vatAmount := VATEntry.Amount;
            vatBase := VATEntry.Base;
            VATEntry.Amount := 0;
            VATEntry.Base := 0;
            VATEntry."Unrealized Amount" := vatAmount;
            VATEntry."Unrealized Base" := vatBase;
            VATEntry."Remaining Unrealized Amount" := VATEntry."Unrealized Amount";
            VATEntry."Remaining Unrealized Base" := VATEntry."Unrealized Base";
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGLEntryBuffer', '', false, false)]
    local procedure OnBeforeInsertGLEntryBuffer(VAR TempGLEntryBuf: Record "G/L Entry"; VAR GenJournalLine: Record "Gen. Journal Line")
    var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        if GenJournalLine."Postponed VAT-Adl" = GenJournalLine."Postponed VAT-Adl"::"Postponed VAT" then begin
            if (TempGLEntryBuf."Source Type" = TempGLEntryBuf."Source Type"::Vendor) and (GenJournalLine."VAT Bus. Posting Group" <> '') and (GenJournalLine."VAT Prod. Posting Group" <> '')
                and (TempGLEntryBuf."VAT Amount" = 0) then begin
                if VATPostingSetup.Get(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group") then begin
                    VATPostingSetup.TestField("Purch VAT Postponed Account-Adl");
                    TempGLEntryBuf.Validate("G/L Account No.", VATPostingSetup."Purch VAT Postponed Account-Adl");
                end;
            end;
            if (TempGLEntryBuf."Source Type" = TempGLEntryBuf."Source Type"::Customer) and (GenJournalLine."VAT Bus. Posting Group" <> '') and (GenJournalLine."VAT Prod. Posting Group" <> '')
                and (TempGLEntryBuf."VAT Amount" = 0) then begin
                if VATPostingSetup.Get(GenJournalLine."VAT Bus. Posting Group", GenJournalLine."VAT Prod. Posting Group") then begin
                    VATPostingSetup.TestField("Sales VAT Postponed Account-Adl");
                    TempGLEntryBuf.Validate("G/L Account No.", VATPostingSetup."Sales VAT Postponed Account-Adl");
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInitRecord', '', true, true)]
    local procedure SalesHeaderOnAfterInitRecord(var SalesHeader: Record "Sales Header")
    begin
        SalesHeader."VAT Date-Adl" := SalesHeader."Posting Date";
    end;

    //OnAfterCopyGenJnlLineFromSalesHeader
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeader', '', true, true)]
    local procedure GenJournalLineOnAfterValidateDocumentDate(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    begin
        GenJournalLine."VAT Date-Adl" := SalesHeader."VAT Date-Adl";
        GenJournalLine."Postponed VAT-Adl" := SalesHeader."Postponed VAT-Adl";
    end;

    //OnAfterCopyFromGenJnlLine
    [EventSubscriber(ObjectType::Table, Database::"VAT Entry", 'OnAfterCopyFromGenJnlLine', '', true, true)]
    local procedure ValueEntrynAfterCopyFromGenJnlLine(VAR VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VATEntry."Posting Date" := GenJournalLine."VAT Date-Adl";
        VATEntry."Postponed VAT-Adl" := GenJournalLine."Postponed VAT-Adl";
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Posting Date', false, false)]
    local procedure OnAfterValidateEventPostingDate(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    begin
        if Confirm(UpdVatDate, false) then
            Rec.Validate("VAT Date-Adl", Rec."Posting Date");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure OnAfterFinalizePostingSales(VAR SalesHeader: Record "Sales Header"; VAR SalesShipmentHeader: Record "Sales Shipment Header"; VAR SalesInvoiceHeader: Record "Sales Invoice Header"; var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; var ReturnReceiptHeader: Record "Return Receipt Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        CustomerVendor: Option Customer,Vendor;
    begin
        with SalesHeader do begin
            if ("Postponed VAT-adl" = "Postponed VAT-adl"::"Postponed VAT") and ("VAT Date-adl" <> 0D) then begin
                case "Document Type" of
                    "Document Type"::Invoice, "Document Type"::Order:
                        HandlePostponedVAT(DATABASE::"Sales Invoice Header", SalesInvoiceHeader."No.", SalesInvoiceHeader."VAT Date-adl", TRUE, CustomerVendor::Customer, SalesInvoiceHeader."Postponed VAT-adl");
                    "Document Type"::"Credit Memo":
                        HandlePostponedVAT(DATABASE::"Sales Cr.Memo Header", SalesCrMemoHeader."No.", SalesCrMemoHeader."VAT Date-adl", TRUE, CustomerVendor::Customer, SalesCrMemoHeader."Postponed VAT-adl");
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterFinalizePosting', '', false, false)]
    local procedure OnAfterFinalizePostingPurchase(VAR PurchHeader: Record "Purchase Header"; VAR PurchRcptHeader: Record "Purch. Rcpt. Header"; VAR PurchInvHeader: Record "Purch. Inv. Header"; VAR PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; var ReturnShptHeader: Record "Return Shipment Header"; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line")
    var
        CustomerVendor: Option Customer,Vendor;
    begin
        with PurchHeader do begin
            if ("Postponed VAT-adl" = "Postponed VAT-adl"::"Postponed VAT") and ("VAT Date-adl" <> 0D) then begin
                case "Document Type" of
                    "Document Type"::Invoice, "Document Type"::Order:
                        HandlePostponedVAT(DATABASE::"Purch. Inv. Header", PurchInvHeader."No.", PurchInvHeader."VAT Date-adl", TRUE, CustomerVendor::Vendor, PurchInvHeader."Postponed VAT-adl");
                    "Document Type"::"Credit Memo":
                        HandlePostponedVAT(DATABASE::"Purch. Cr. Memo Hdr.", PurchCrMemoHdr."No.", PurchCrMemoHdr."VAT Date-adl", TRUE, CustomerVendor::Vendor, PurchCrMemoHdr."Postponed VAT-adl");
                end;
            end;
        end;
    end;

    procedure HandlePostponedVAT(TableNo: Integer; No: Code[20]; PostDate: Date; Post: Boolean; SalesPurchase: Option Customer,Vendor; PostponedVAT: Option "Realized VAT","Postponed VAT")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        PurchInvoice: Record "Purch. Inv. Header";
        PurchCrMemo: Record "Purch. Cr. Memo Hdr.";
        ServiceInvoice: Record "Service Invoice Header";
        ServiceCrMemo: Record "Service Cr.Memo Header";
        SalesInvoice: Record "Sales Invoice Header";
        SalesCrMemo: Record "Sales Cr.Memo Header";
        VATPostingSetup: Record "VAT Posting Setup";
        VATEntry: Record "VAT Entry";
        VarRecRef: Variant;
        GenJnlLineLoc: Record "Gen. Journal Line";
        LedgEntryFound: Boolean;
        DimSetID: Integer;
        AccNo: Code[20];
        PostponedAccNo: Code[20];
    begin
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
            if Post then begin
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
                end;
            end
            else begin
                CASE SalesPurchase OF
                    SalesPurchase::Customer:
                        begin
                            ReversePostponedVAT(GenJnlLineLoc, CustLedgerEntry."Transaction No.", SalesPurchase::Customer);
                        end;
                    SalesPurchase::Vendor:
                        begin
                            ReversePostponedVAT(GenJnlLineLoc, VendLedgerEntry."Transaction No.", SalesPurchase::Vendor);
                        end;
                end;
            end;
        end;
    end;

    local procedure PostPostponedVAT(VAR CustLedgEntry2: Record "Cust. Ledger Entry"; VAR VendLedgEntry2: Record "Vendor Ledger Entry"; VAR GenJnlLine2: Record "Gen. Journal Line"; SalesPurchase: Option Customer,Vendor)
    var
        SourceCodeSetupLoc: Record "Source Code Setup";
        GenJnlLine: Record "Gen. Journal Line";
        GLSetup: Record "General Ledger Setup";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
    begin
        GenJnlLine := GenJnlLine2;
        GLSetup.Get;
        SourceCodeSetupLoc.Get;
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
        IF ManagePostponedVAT.GetNextEntryNo = 0 THEN
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
        GenJnlLine := GenJnlLine2;
        SourceCodeSetup.GET;
        GenJnlLine."Source Code" := SourceCodeSetup.Reversal;
        IF ManagePostponedVAT.GetNextEntryNo = 0 THEN
            ManagePostponedVAT.StartPosting(GenJnlLine)
        ELSE
            ManagePostponedVAT.ContinuePosting(GenJnlLine);
        //GLReg.Reversed := TRUE;
        VATEntry.LOCKTABLE;
        UnrealVATEntry.SETCURRENTKEY("Transaction No.");
        UnrealVATEntry.SETRANGE("Transaction No.", TransactionNo);
        UnrealVATEntry.SETRANGE("Postponed VAT-Adl", UnrealVATEntry."Postponed VAT-Adl"::"Postponed VAT");
        IF UnrealVATEntry.FINDSET(TRUE) THEN
            REPEAT
                VATEntry.SETCURRENTKEY("Unrealized VAT Entry No.");
                VATEntry.SETRANGE("Unrealized VAT Entry No.", UnrealVATEntry."Entry No.");
                VATEntry.SETRANGE(Reversed, FALSE);
                IF VATEntry.FINDSET THEN
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
                        UnrealVATEntry.MODIFY;
                        CASE SalesPurchase OF
                            SalesPurchase::Customer:
                                BEGIN
                                    VATPostingSetup.TestField("Sales VAT Postponed Account-Adl");
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup.GetSalesAccount(FALSE),
                                        -VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", -VATEntry.Amount), TRUE);
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup."Sales VAT Postponed Account-Adl",
                                        VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount), TRUE);
                                END;
                            SalesPurchase::Vendor:
                                BEGIN
                                    VATPostingSetup.TestField("Purch VAT Postponed Account-Adl");
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup.GetPurchAccount(FALSE),
                                        -VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", -VATEntry.Amount), TRUE);
                                    ManagePostponedVAT.CreateGLEntry(GenJnlLine, VATPostingSetup."Purch VAT Postponed Account-Adl",
                                        VATEntry.Amount, ManagePostponedVAT.CalcAddCurrForUnapplication(VATEntry."Posting Date", VATEntry.Amount), TRUE);
                                END;
                        END;
                    UNTIL VATEntry.NEXT = 0;
            UNTIL UnrealVATEntry.NEXT = 0;
        ManagePostponedVAT.FinishPosting;
        GenJnlLine2 := GenJnlLine;


    end;
    
    var
        UpdVatDate: Label '<qualifier>Change</qualifier><payload>Do you want to change VAT Date <emphasize>Headline1</emphasize>.</payload>';
        ManagePostponedVAT: Codeunit "Manage Postponed VAT-Adl";
}