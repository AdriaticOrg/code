codeunit 13062526 "Manage Postponed VAT-Adl"
{
    Permissions = tabledata 122 = rm,
                tabledata 124 = rm,
                tabledata 112 = rm,
                tabledata 114 = rm,
                tabledata 254 = irm,
                tabledata 17 = irm,
                tabledata 45 = irm;
    procedure CustUnrealizedVAT(GenJnlLine: Record "Gen. Journal Line"; VAR CustLedgEntry2: Record "Cust. Ledger Entry"; SettledAmount: Decimal)
    var
        VATEntry2: Record "VAT Entry";
        VATPostingSetup: Record "VAT Posting Setup";
        PaidAmount: Decimal;
        TotalUnrealVATAmountLast: Decimal;
        TotalUnrealVATAmountFirst: Decimal;
        LastConnectionNo: Integer;
        VATPart: Decimal;
        SalesVATAccount: Code[20];
        SalesVATUnrealAccount: Code[20];
        VATAmount: Decimal;
        VATBase: Decimal;
        VATAmountAddCurr: Decimal;
        VATBaseAddCurr: Decimal;
        TaxJurisdiction: Record "Tax Jurisdiction";
        GLSetup: Record "General Ledger Setup";
    begin
        PaidAmount := CustLedgEntry2.Amount - CustLedgEntry2."Remaining Amount";
        VATEntry2.RESET;
        VATEntry2.SETCURRENTKEY("Transaction No.");
        VATEntry2.SETRANGE("Transaction No.", CustLedgEntry2."Transaction No.");
        VATEntry2.SETRANGE("Postponed VAT-Adl", GenJnlLine."Postponed VAT-Adl");
        IF VATEntry2.FINDSET THEN
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF VATPostingSetup."Unrealized VAT Type" IN
                    [VATPostingSetup."Unrealized VAT Type"::Last, VATPostingSetup."Unrealized VAT Type"::"Last (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountLast := TotalUnrealVATAmountLast - VATEntry2."Remaining Unrealized Amount";
                IF VATPostingSetup."Unrealized VAT Type" IN
                    [VATPostingSetup."Unrealized VAT Type"::First, VATPostingSetup."Unrealized VAT Type"::"First (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountFirst := TotalUnrealVATAmountFirst - VATEntry2."Remaining Unrealized Amount";
            UNTIL VATEntry2.NEXT = 0;
        IF VATEntry2.FINDSET THEN BEGIN
            LastConnectionNo := 0;
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF LastConnectionNo <> VATEntry2."Sales Tax Connection No." THEN BEGIN
                    InsertSummarizedVAT(GenJnlLine);
                    LastConnectionNo := VATEntry2."Sales Tax Connection No.";
                END;

                VATPart := VATEntry2.GetUnrealizedVATPart(
                                SettledAmount,
                                PaidAmount,
                                CustLedgEntry2."Original Amount",
                                TotalUnrealVATAmountFirst,
                                TotalUnrealVATAmountLast);
                if VATEntry2."Postponed VAT-Adl" = VATEntry2."Postponed VAT-Adl"::"Postponed VAT" then
                    VATPart := 1;
                IF VATPart > 0 THEN BEGIN
                    CASE VATEntry2."VAT Calculation Type" OF
                        VATEntry2."VAT Calculation Type"::"Normal VAT",
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT",
                        VATEntry2."VAT Calculation Type"::"Full VAT":
                            BEGIN
                                SalesVATAccount := VATPostingSetup.GetSalesAccount(FALSE);
                                IF GenJnlLine."Postponed VAT-Adl" = GenJnlLine."Postponed VAT-Adl"::"Postponed VAT" THEN begin
                                    VATPostingSetup.TestField("Sales VAT Postponed Account-Adl");
                                    SalesVATUnrealAccount := VATPostingSetup."Sales VAT Postponed Account-Adl";
                                end
                                ELSE
                                    SalesVATUnrealAccount := VATPostingSetup.GetSalesAccount(TRUE);
                            END;
                        VATEntry2."VAT Calculation Type"::"Sales Tax":
                            BEGIN
                                TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                                SalesVATAccount := TaxJurisdiction.GetSalesAccount(FALSE);
                                SalesVATUnrealAccount := TaxJurisdiction.GetSalesAccount(TRUE);
                            END;
                    END;
                    IF VATEntry2."Postponed VAT-Adl" = VATEntry2."Postponed VAT-Adl"::"Postponed VAT" THEN
                        IF GenJnlLine."Postponed VAT-Adl" = GenJnlLine."Postponed VAT-Adl"::"Postponed VAT" THEN
                            VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage
                        ELSE
                            VATPostingSetup."Unrealized VAT Type" := 0;

                    IF VATPart = 1 THEN BEGIN
                        VATAmount := VATEntry2."Remaining Unrealized Amount";
                        VATBase := VATEntry2."Remaining Unrealized Base";
                        VATAmountAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Amount";
                        VATBaseAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Base";
                    END ELSE BEGIN
                        VATAmount := ROUND(VATEntry2."Remaining Unrealized Amount" * VATPart, GLSetup."Amount Rounding Precision");
                        VATBase := ROUND(VATEntry2."Remaining Unrealized Base" * VATPart, GLSetup."Amount Rounding Precision");
                        VATAmountAddCurr :=
                        ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Amount" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                        VATBaseAddCurr :=
                        ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Base" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                    END;
                    InitGLEntryVAT(
                        GenJnlLine, SalesVATUnrealAccount, SalesVATAccount, -VATAmount, -VATAmountAddCurr, FALSE);
                    InitGLEntryVATCopy(
                        GenJnlLine, SalesVATAccount, SalesVATUnrealAccount, VATAmount, VATAmountAddCurr, VATEntry2);
                    PostUnrealVATEntry(GenJnlLine, VATEntry2, VATAmount, VATBase, VATAmountAddCurr, VATBaseAddCurr);
                END;
            UNTIL VATEntry2.NEXT = 0;

            InsertSummarizedVAT(GenJnlLine);
        END;
    end;

    procedure VendUnrealizedVAT(GenJnlLine: Record "Gen. Journal Line"; VAR VendLedgEntry2: Record "Vendor Ledger Entry"; SettledAmount: Decimal)
    var
        VATEntry2: Record "VAT Entry";
        TaxJurisdiction: Record "Tax Jurisdiction";
        VATPostingSetup: Record "VAT Posting Setup";
        VATPart: Decimal;
        VATAmount: Decimal;
        VATBase: Decimal;
        VATAmountAddCurr: Decimal;
        VATBaseAddCurr: Decimal;
        PaidAmount: Decimal;
        TotalUnrealVATAmountFirst: Decimal;
        TotalUnrealVATAmountLast: Decimal;
        PurchVATAccount: Code[20];
        PurchVATUnrealAccount: Code[20];
        PurchReverseAccount: Code[20];
        PurchReverseUnrealAccount: Code[20];
        LastConnectionNo: Integer;
    begin
        VATEntry2.RESET;
        VATEntry2.SETCURRENTKEY("Transaction No.");
        VATEntry2.SETRANGE("Transaction No.", VendLedgEntry2."Transaction No.");
        VATEntry2.SETRANGE("Postponed VAT-Adl", GenJnlLine."Postponed VAT-Adl");
        PaidAmount := -VendLedgEntry2."Amount (LCY)" + VendLedgEntry2."Remaining Amt. (LCY)";
        IF VATEntry2.FINDSET THEN
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF VATPostingSetup."Unrealized VAT Type" IN
                    [VATPostingSetup."Unrealized VAT Type"::Last, VATPostingSetup."Unrealized VAT Type"::"Last (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountLast := TotalUnrealVATAmountLast - VATEntry2."Remaining Unrealized Amount";
                IF VATPostingSetup."Unrealized VAT Type" IN
                    [VATPostingSetup."Unrealized VAT Type"::First, VATPostingSetup."Unrealized VAT Type"::"First (Fully Paid)"]
                THEN
                    TotalUnrealVATAmountFirst := TotalUnrealVATAmountFirst - VATEntry2."Remaining Unrealized Amount";
            UNTIL VATEntry2.NEXT = 0;
        IF VATEntry2.FINDSET THEN BEGIN
            LastConnectionNo := 0;
            REPEAT
                VATPostingSetup.GET(VATEntry2."VAT Bus. Posting Group", VATEntry2."VAT Prod. Posting Group");
                IF LastConnectionNo <> VATEntry2."Sales Tax Connection No." THEN BEGIN
                    InsertSummarizedVAT(GenJnlLine);
                    LastConnectionNo := VATEntry2."Sales Tax Connection No.";
                END;

                VATPart :=
                        VATEntry2.GetUnrealizedVATPart(
                            ROUND(SettledAmount / VendLedgEntry2.GetOriginalCurrencyFactor),
                            PaidAmount,
                            VendLedgEntry2."Original Amt. (LCY)",
                            TotalUnrealVATAmountFirst,
                            TotalUnrealVATAmountLast);
                if VATEntry2."Postponed VAT-Adl" = VATEntry2."Postponed VAT-Adl"::"Postponed VAT" then
                    VATPart := 1;
                IF VATPart > 0 THEN BEGIN
                    CASE VATEntry2."VAT Calculation Type" OF
                        VATEntry2."VAT Calculation Type"::"Normal VAT",
                        VATEntry2."VAT Calculation Type"::"Full VAT":
                            BEGIN
                                PurchVATAccount := VATPostingSetup.GetPurchAccount(FALSE);
                                IF GenJnlLine."Postponed VAT-Adl" = GenJnlLine."Postponed VAT-Adl"::"Postponed VAT" THEN begin
                                    VATPostingSetup.TestField("Purch VAT Postponed Account-Adl");
                                    PurchVATUnrealAccount := VATPostingSetup."Purch VAT Postponed Account-Adl";
                                end
                                ELSE
                                    PurchVATUnrealAccount := VATPostingSetup.GetPurchAccount(TRUE);
                            END;
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT":
                            BEGIN
                                PurchVATAccount := VATPostingSetup.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := VATPostingSetup.GetPurchAccount(TRUE);
                                PurchReverseAccount := VATPostingSetup.GetRevChargeAccount(FALSE);
                                PurchReverseUnrealAccount := VATPostingSetup.GetRevChargeAccount(TRUE);
                            END;
                        VATEntry2."VAT Calculation Type"::"Sales Tax":
                            IF (VATEntry2.Type = VATEntry2.Type::Purchase) AND VATEntry2."Use Tax" THEN BEGIN
                                TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                                PurchVATAccount := TaxJurisdiction.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := TaxJurisdiction.GetPurchAccount(TRUE);
                                PurchReverseAccount := TaxJurisdiction.GetRevChargeAccount(FALSE);
                                PurchReverseUnrealAccount := TaxJurisdiction.GetRevChargeAccount(TRUE);
                            END ELSE BEGIN
                                TaxJurisdiction.GET(VATEntry2."Tax Jurisdiction Code");
                                PurchVATAccount := TaxJurisdiction.GetPurchAccount(FALSE);
                                PurchVATUnrealAccount := TaxJurisdiction.GetPurchAccount(TRUE);
                            END;
                    END;
                    IF VATEntry2."Postponed VAT-Adl" = VATEntry2."Postponed VAT-Adl"::"Postponed VAT" THEN
                        IF GenJnlLine."Postponed VAT-Adl" = GenJnlLine."Postponed VAT-Adl"::"Postponed VAT" THEN
                            VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage
                        ELSE
                            VATPostingSetup."Unrealized VAT Type" := 0;

                    IF VATPart = 1 THEN BEGIN
                        VATAmount := VATEntry2."Remaining Unrealized Amount";
                        VATBase := VATEntry2."Remaining Unrealized Base";
                        VATAmountAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Amount";
                        VATBaseAddCurr := VATEntry2."Add.-Curr. Rem. Unreal. Base";
                    END ELSE BEGIN
                        VATAmount := ROUND(VATEntry2."Remaining Unrealized Amount" * VATPart, GLSetup."Amount Rounding Precision");
                        VATBase := ROUND(VATEntry2."Remaining Unrealized Base" * VATPart, GLSetup."Amount Rounding Precision");
                        VATAmountAddCurr :=
                        ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Amount" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                        VATBaseAddCurr :=
                        ROUND(
                            VATEntry2."Add.-Curr. Rem. Unreal. Base" * VATPart,
                            AddCurrency."Amount Rounding Precision");
                    END;

                    InitGLEntryVAT(
                        GenJnlLine, PurchVATUnrealAccount, PurchVATAccount, -VATAmount, -VATAmountAddCurr, FALSE);
                    InitGLEntryVATCopy(
                        GenJnlLine, PurchVATAccount, PurchVATUnrealAccount, VATAmount, VATAmountAddCurr, VATEntry2);

                    IF (VATEntry2."VAT Calculation Type" =
                        VATEntry2."VAT Calculation Type"::"Reverse Charge VAT") OR
                        ((VATEntry2."VAT Calculation Type" =
                        VATEntry2."VAT Calculation Type"::"Sales Tax") AND
                        (VATEntry2.Type = VATEntry2.Type::Purchase) AND VATEntry2."Use Tax")
                    THEN BEGIN
                        InitGLEntryVAT(
                        GenJnlLine, PurchReverseUnrealAccount, PurchReverseAccount, VATAmount, VATAmountAddCurr, FALSE);
                        InitGLEntryVATCopy(
                        GenJnlLine, PurchReverseAccount, PurchReverseUnrealAccount, -VATAmount, -VATAmountAddCurr, VATEntry2);
                    END;

                    PostUnrealVATEntry(GenJnlLine, VATEntry2, VATAmount, VATBase, VATAmountAddCurr, VATBaseAddCurr);
                END;
            UNTIL VATEntry2.NEXT = 0;

            InsertSummarizedVAT(GenJnlLine);
        END;
    end;

    procedure InitGLEntryVAT(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; BalAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmtAddCurr: Boolean)
    var
        GLEntry: Record "G/L Entry";
    begin
        IF UseAmtAddCurr THEN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE)
        ELSE BEGIN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
            GLEntry."Additional-Currency Amount" := AmountAddCurr;
            GLEntry."Bal. Account No." := BalAccNo;
        END;
        SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
    end;

    procedure InitGLEntryVATCopy(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; BalAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; VATEntry: Record "VAT Entry")
    var
        GLEntry: Record "G/L Entry";
    begin
        InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
        GLEntry."Additional-Currency Amount" := AmountAddCurr;
        GLEntry."Bal. Account No." := BalAccNo;
        GLEntry.CopyPostingGroupsFromVATEntry(VATEntry);
        SummarizeVAT(GLSetup."Summarize G/L Entries", GLEntry);
    end;

    procedure PostUnrealVATEntry(GenJnlLine: Record "Gen. Journal Line"; VAR VATEntry2: Record "VAT Entry"; VATAmount: Decimal; VATBase: Decimal; VATAmountAddCurr: Decimal; VATBaseAddCurr: Decimal)
    begin
        VATEntry.LOCKTABLE;
        VATEntry := VATEntry2;
        VATEntry."Entry No." := NextVATEntryNo;
        VATEntry."Posting Date" := GenJnlLine."Posting Date";
        VATEntry."Document No." := GenJnlLine."Document No.";
        VATEntry."External Document No." := GenJnlLine."External Document No.";
        VATEntry."Document Type" := GenJnlLine."Document Type";
        VATEntry.Amount := VATAmount;
        VATEntry.Base := VATBase;
        VATEntry."Additional-Currency Amount" := VATAmountAddCurr;
        VATEntry."Additional-Currency Base" := VATBaseAddCurr;
        VATEntry.SetUnrealAmountsToZero;
        VATEntry."User ID" := USERID;
        VATEntry."Source Code" := GenJnlLine."Source Code";
        VATEntry."Reason Code" := GenJnlLine."Reason Code";
        VATEntry."Closed by Entry No." := 0;
        VATEntry.Closed := FALSE;
        VATEntry."Transaction No." := NextTransactionNo;
        VATEntry."Sales Tax Connection No." := NextConnectionNo;
        VATEntry."Unrealized VAT Entry No." := VATEntry2."Entry No.";
        VATEntry."Postponed VAT-Adl" := GenJnlLine."Postponed VAT-Adl"::"Realized VAT";
        VATEntry.INSERT(TRUE);
        NextVATEntryNo := NextVATEntryNo + 1;

        VATEntry2."Remaining Unrealized Amount" :=
        VATEntry2."Remaining Unrealized Amount" - VATEntry.Amount;
        VATEntry2."Remaining Unrealized Base" := VATEntry2."Remaining Unrealized Base" - VATBase;
        VATEntry2."Add.-Curr. Rem. Unreal. Amount" :=
        VATEntry2."Add.-Curr. Rem. Unreal. Amount" - VATEntry."Additional-Currency Amount";
        VATEntry2."Add.-Curr. Rem. Unreal. Base" :=
        VATEntry2."Add.-Curr. Rem. Unreal. Base" - VATEntry."Additional-Currency Base";
        VATEntry2.MODIFY;
    end;

    procedure InsertSummarizedVAT(GenJnlLine: Record "Gen. Journal Line")
    begin
        IF TempGLEntryVAT.FINDSET THEN BEGIN
            REPEAT
                InsertGLEntry(GenJnlLine, TempGLEntryVAT, TRUE);
            UNTIL TempGLEntryVAT.NEXT = 0;
            TempGLEntryVAT.DELETEALL;
            InsertedTempGLEntryVAT := 0;
        END;
        NextConnectionNo := NextConnectionNo + 1;
    end;

    procedure InitGLEntry(GenJnlLine: Record "Gen. Journal Line"; VAR GLEntry: Record "G/L Entry"; GLAccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean; SystemCreatedEntry: Boolean)
    var
        GLAcc: Record "G/L Account";
    begin
        IF GLAccNo <> '' THEN BEGIN
            GLAcc.GET(GLAccNo);
            GLAcc.TESTFIELD(Blocked, FALSE);
            GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);

            // Check the Value Posting field on the G/L Account if it is not checked already in Codeunit 11
            IF (NOT
                ((GLAccNo = GenJnlLine."Account No.") AND
                (GenJnlLine."Account Type" = GenJnlLine."Account Type"::"G/L Account")) OR
                ((GLAccNo = GenJnlLine."Bal. Account No.") AND
                (GenJnlLine."Bal. Account Type" = GenJnlLine."Bal. Account Type"::"G/L Account"))) AND
                NOT FADimAlreadyChecked
            THEN
                CheckGLAccDimError(GenJnlLine, GLAccNo);
        END;

        GLEntry.INIT;
        GLEntry.CopyFromGenJnlLine(GenJnlLine);
        GLEntry."Entry No." := NextEntryNo;
        GLEntry."Transaction No." := NextTransactionNo;
        GLEntry."G/L Account No." := GLAccNo;
        GLEntry."System-Created Entry" := SystemCreatedEntry;
        GLEntry.Amount := Amount;
        GLEntry."Additional-Currency Amount" :=
        GLCalcAddCurrency(Amount, AmountAddCurr, GLEntry."Additional-Currency Amount", UseAmountAddCurr, GenJnlLine);
    end;

    procedure SummarizeVAT(SummarizeGLEntries: Boolean; GLEntry: Record "G/L Entry")
    var
        InsertedTempVAT: Boolean;
    begin
        InsertedTempVAT := FALSE;
        IF SummarizeGLEntries THEN
            IF TempGLEntryVAT.FINDSET THEN
                REPEAT
                    IF (TempGLEntryVAT."G/L Account No." = GLEntry."G/L Account No.") AND
                        (TempGLEntryVAT."Bal. Account No." = GLEntry."Bal. Account No.")
                    THEN BEGIN
                        TempGLEntryVAT.Amount := TempGLEntryVAT.Amount + GLEntry.Amount;
                        TempGLEntryVAT."Additional-Currency Amount" :=
                        TempGLEntryVAT."Additional-Currency Amount" + GLEntry."Additional-Currency Amount";
                        TempGLEntryVAT.MODIFY;
                        InsertedTempVAT := TRUE;
                    END;
                UNTIL (TempGLEntryVAT.NEXT = 0) OR InsertedTempVAT;
        IF NOT InsertedTempVAT OR NOT SummarizeGLEntries THEN BEGIN
            TempGLEntryVAT := GLEntry;
            TempGLEntryVAT."Entry No." :=
                TempGLEntryVAT."Entry No." + InsertedTempGLEntryVAT;
            TempGLEntryVAT.INSERT;
            InsertedTempGLEntryVAT := InsertedTempGLEntryVAT + 1;
        END;
    end;

    procedure CheckGLAccDimError(GenJnlLine: Record "Gen. Journal Line"; GLAccNo: Code[20])
    var
        DimMgt: Codeunit DimensionManagement;
        TableID: array[10] of Integer;
        AccNo: array[10] of Code[20];
    begin
        IF (GenJnlLine.Amount = 0) AND (GenJnlLine."Amount (LCY)" = 0) THEN
            EXIT;

        TableID[1] := DATABASE::"G/L Account";
        AccNo[1] := GLAccNo;
        IF DimMgt.CheckDimValuePosting(TableID, AccNo, GenJnlLine."Dimension Set ID") THEN
            EXIT;

        IF GenJnlLine."Line No." <> 0 THEN
            ERROR(
                DimensionUsedErr,
                GenJnlLine.TABLECAPTION, GenJnlLine."Journal Template Name",
                GenJnlLine."Journal Batch Name", GenJnlLine."Line No.",
                DimMgt.GetDimValuePostingErr);

        ERROR(DimMgt.GetDimValuePostingErr);
    end;

    procedure GLCalcAddCurrency(Amount: Decimal; AddCurrAmount: Decimal; OldAddCurrAmount: Decimal; UseAddCurrAmount: Boolean; GenJnlLine: Record "Gen. Journal Line"): Decimal
    begin
        IF (AddCurrencyCode <> '') AND
        (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::None)
        THEN BEGIN
            IF (GenJnlLine."Source Currency Code" = AddCurrencyCode) AND UseAddCurrAmount THEN
                EXIT(AddCurrAmount);

            EXIT(ExchangeAmtLCYToFCY2(Amount));
        END;
        EXIT(OldAddCurrAmount);
    end;

    procedure ExchangeAmtLCYToFCY2(Amount: Decimal): Decimal
    begin
        IF UseCurrFactorOnly THEN
            EXIT(
                ROUND(
                CurrExchRate.ExchangeAmtLCYToFCYOnlyFactor(Amount, CurrencyFactor),
                AddCurrency."Amount Rounding Precision"));
        EXIT(
        ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
            CurrencyDate, AddCurrencyCode, Amount, CurrencyFactor),
            AddCurrency."Amount Rounding Precision"));
    end;

    procedure ContinuePosting(GenJnlLine: Record "Gen. Journal Line")
    begin
        WITH GenJnlLine DO BEGIN
            IF (LastDocType <> "Document Type") OR (LastDocNo <> "Document No.") OR
                (LastDate <> "Posting Date") OR ((CurrentBalance = 0) AND (TotalAddCurrAmount = 0)) AND NOT "System-Created Entry"
            THEN BEGIN
                CheckPostUnrealizedVAT(GenJnlLine, FALSE);
                NextTransactionNo := NextTransactionNo + 1;
                InitLastDocDate(GenJnlLine);
                FirstNewVATEntryNo := NextVATEntryNo;
            END;

            GetCurrencyExchRate(GenJnlLine);
            TempGLEntryBuf.DELETEALL;
            CalculateCurrentBalance(
                "Account No.", "Bal. Account No.", IncludeVATAmount, "Amount (LCY)", "VAT Amount");
        END;
    end;

    procedure CheckPostUnrealizedVAT(GenJnlLine: Record "Gen. Journal Line"; CheckCurrentBalance: Boolean)
    begin
        IF CheckCurrentBalance AND (CurrentBalance = 0) OR NOT CheckCurrentBalance THEN
            PostUnrealizedVAT(GenJnlLine);
    end;

    procedure PostUnrealizedVAT(GenJnlLine: Record "Gen. Journal Line")
    begin
        IF CheckUnrealizedCust THEN BEGIN
            CustUnrealizedVAT(GenJnlLine, UnrealizedCustLedgEntry, UnrealizedRemainingAmountCust);
            CheckUnrealizedCust := FALSE;
        END;
        IF CheckUnrealizedVend THEN BEGIN
            VendUnrealizedVAT(GenJnlLine, UnrealizedVendLedgEntry, UnrealizedRemainingAmountVend);
            CheckUnrealizedVend := FALSE;
        END;
    end;

    procedure GetCurrencyExchRate(GenJnlLine: Record "Gen. Journal Line")
    var
        NewCurrencyDate: Date;
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        AddCurrency.GET(AddCurrencyCode);
        AddCurrency.TESTFIELD("Amount Rounding Precision");
        AddCurrency.TESTFIELD("Residual Gains Account");
        AddCurrency.TESTFIELD("Residual Losses Account");

        NewCurrencyDate := GenJnlLine."Posting Date";
        IF GenJnlLine."Reversing Entry" THEN
            NewCurrencyDate := NewCurrencyDate - 1;
        IF (NewCurrencyDate <> CurrencyDate) OR
            UseCurrFactorOnly
        THEN BEGIN
            UseCurrFactorOnly := FALSE;
            CurrencyDate := NewCurrencyDate;
            CurrencyFactor :=
                CurrExchRate.ExchangeRate(CurrencyDate, AddCurrencyCode);
        END;
        IF (GenJnlLine."FA Add.-Currency Factor" <> 0) AND
            (GenJnlLine."FA Add.-Currency Factor" <> CurrencyFactor)
        THEN BEGIN
            UseCurrFactorOnly := TRUE;
            CurrencyDate := 0D;
            CurrencyFactor := GenJnlLine."FA Add.-Currency Factor";
        END;
    end;

    procedure InitLastDocDate(GenJnlLine: Record "Gen. Journal Line")
    begin
        WITH GenJnlLine DO BEGIN
            LastDocType := "Document Type";
            LastDocNo := "Document No.";
            LastDate := "Posting Date";
        END;
    end;

    procedure CalculateCurrentBalance(AccountNo: Code[20]; BalAccountNo: Code[20]; InclVATAmount: Boolean; AmountLCY: Decimal; VATAmount: Decimal)
    begin
        IF (AccountNo <> '') AND (BalAccountNo <> '') THEN
            EXIT;

        IF AccountNo = BalAccountNo THEN
            EXIT;

        IF NOT InclVATAmount THEN
            VATAmount := 0;

        IF BalAccountNo <> '' THEN
            CurrentBalance -= AmountLCY + VATAmount
        ELSE
            CurrentBalance += AmountLCY + VATAmount;
    end;

    procedure StartPosting(GenJnlLine: Record "Gen. Journal Line")
    var
        GenJnlTemplate: Record "Gen. Journal Template";
        AccountingPeriod: Record "Accounting Period";
    begin
        WITH GenJnlLine DO BEGIN
            GlobalGLEntry.LOCKTABLE;
            IF GlobalGLEntry.FINDLAST THEN BEGIN
                NextEntryNo := GlobalGLEntry."Entry No." + 1;
                NextTransactionNo := GlobalGLEntry."Transaction No." + 1;
            END ELSE BEGIN
                NextEntryNo := 1;
                NextTransactionNo := 1;
            END;

            InitLastDocDate(GenJnlLine);
            CurrentBalance := 0;

            AccountingPeriod.RESET;
            AccountingPeriod.SETCURRENTKEY(Closed);
            AccountingPeriod.SETRANGE(Closed, FALSE);
            AccountingPeriod.FINDFIRST;
            FiscalYearStartDate := AccountingPeriod."Starting Date";

            GLSetup.Get;

            IF NOT GenJnlTemplate.GET("Journal Template Name") THEN
                GenJnlTemplate.INIT;

            VATEntry.LOCKTABLE;
            IF VATEntry.FINDLAST THEN
                NextVATEntryNo := VATEntry."Entry No." + 1
            ELSE
                NextVATEntryNo := 1;
            NextConnectionNo := 1;
            FirstNewVATEntryNo := NextVATEntryNo;

            GLReg.LOCKTABLE;
            IF GLReg.FINDLAST THEN
                GLReg."No." := GLReg."No." + 1
            ELSE
                GLReg."No." := 1;
            GLReg.INIT;
            GLReg."From Entry No." := NextEntryNo;
            GLReg."From VAT Entry No." := NextVATEntryNo;
            GLReg."Creation Date" := TODAY;
            GLReg."Source Code" := "Source Code";
            GLReg."Journal Batch Name" := "Journal Batch Name";
            GLReg."User ID" := USERID;
            IsGLRegInserted := FALSE;


            GetCurrencyExchRate(GenJnlLine);
            TempGLEntryBuf.DELETEALL;
            CalculateCurrentBalance(
                "Account No.", "Bal. Account No.", IncludeVATAmount, "Amount (LCY)", "VAT Amount");
        END;
    end;

    procedure GetNextEntryNo(): Integer
    begin
        exit(NextEntryNo);
    end;

    procedure FinishPosting()
    var
        CostAccSetup: Record "Cost Accounting Setup";
        TransferGlEntriesToCA: Codeunit "Transfer GL Entries to CA";
        IsTransactionConsistent: Boolean;
    begin
        IsTransactionConsistent :=
        (BalanceCheckAmount = 0) AND (BalanceCheckAmount2 = 0) AND
        (BalanceCheckAddCurrAmount = 0) AND (BalanceCheckAddCurrAmount2 = 0);

        IF TempGLEntryBuf.FINDSET THEN BEGIN
            REPEAT
                GlobalGLEntry := TempGLEntryBuf;
                IF AddCurrencyCode = '' THEN BEGIN
                    GlobalGLEntry."Additional-Currency Amount" := 0;
                    GlobalGLEntry."Add.-Currency Debit Amount" := 0;
                    GlobalGLEntry."Add.-Currency Credit Amount" := 0;
                END;
                GlobalGLEntry."Prior-Year Entry" := GlobalGLEntry."Posting Date" < FiscalYearStartDate;
                GlobalGLEntry.INSERT(TRUE);
            UNTIL TempGLEntryBuf.NEXT = 0;

            GLReg."To VAT Entry No." := NextVATEntryNo - 1;
            GLReg."To Entry No." := GlobalGLEntry."Entry No.";
            IF IsTransactionConsistent THEN
                IF IsGLRegInserted THEN
                    GLReg.MODIFY
                ELSE BEGIN
                    GLReg.INSERT;
                    IsGLRegInserted := TRUE;
                END;
        END;
        GlobalGLEntry.CONSISTENT(IsTransactionConsistent);

        IF CostAccSetup.GET THEN
            IF CostAccSetup."Auto Transfer from G/L" THEN
               // TransferGlEntriesToCA.GetGLEntries;

        FirstEntryNo := 0;
    end;

    procedure InsertGLEntry(GenJnlLine: Record "Gen. Journal Line"; GLEntry: Record "G/L Entry"; CalcAddCurrResiduals: Boolean)
    begin
        WITH GLEntry DO BEGIN
            TESTFIELD("G/L Account No.");

            IF Amount <> ROUND(Amount) THEN
                FIELDERROR(
                    Amount,
                    STRSUBSTNO(NeedsRoundingErr, Amount));

            UpdateCheckAmounts(
                "Posting Date", Amount, "Additional-Currency Amount",
                BalanceCheckAmount, BalanceCheckAmount2, BalanceCheckAddCurrAmount, BalanceCheckAddCurrAmount2);

            UpdateDebitCredit(GenJnlLine.Correction);
        END;

        TempGLEntryBuf := GLEntry;

        TempGLEntryBuf.INSERT;

        IF FirstEntryNo = 0 THEN
            FirstEntryNo := TempGLEntryBuf."Entry No.";
        NextEntryNo := NextEntryNo + 1;

        IF CalcAddCurrResiduals THEN
            HandleAddCurrResidualGLEntry(GenJnlLine, GLEntry.Amount, GLEntry."Additional-Currency Amount");
    end;

    procedure UpdateCheckAmounts(PostingDate: Date; Amount: Decimal; AddCurrAmount: Decimal; VAR BalanceCheckAmount: Decimal; VAR BalanceCheckAmount2: Decimal; VAR BalanceCheckAddCurrAmount: Decimal; VAR BalanceCheckAddCurrAmount2: Decimal)
    begin
        IF PostingDate = NORMALDATE(PostingDate) THEN BEGIN
            BalanceCheckAmount :=
                BalanceCheckAmount + Amount * ((PostingDate - 00000101D) MOD 99 + 1);
            BalanceCheckAmount2 :=
                BalanceCheckAmount2 + Amount * ((PostingDate - 00000101D) MOD 98 + 1);
        END ELSE BEGIN
            BalanceCheckAmount :=
                BalanceCheckAmount + Amount * ((NORMALDATE(PostingDate) - 00000101D + 50) MOD 99 + 1);
            BalanceCheckAmount2 :=
                BalanceCheckAmount2 + Amount * ((NORMALDATE(PostingDate) - 00000101D + 50) MOD 98 + 1);
        END;

        IF AddCurrencyCode <> '' THEN
            IF PostingDate = NORMALDATE(PostingDate) THEN BEGIN
                BalanceCheckAddCurrAmount :=
                BalanceCheckAddCurrAmount + AddCurrAmount * ((PostingDate - 00000101D) MOD 99 + 1);
                BalanceCheckAddCurrAmount2 :=
                BalanceCheckAddCurrAmount2 + AddCurrAmount * ((PostingDate - 00000101D) MOD 98 + 1);
            END ELSE BEGIN
                BalanceCheckAddCurrAmount :=
                BalanceCheckAddCurrAmount +
                AddCurrAmount * ((NORMALDATE(PostingDate) - 00000101D + 50) MOD 99 + 1);
                BalanceCheckAddCurrAmount2 :=
                BalanceCheckAddCurrAmount2 +
                AddCurrAmount * ((NORMALDATE(PostingDate) - 00000101D + 50) MOD 98 + 1);
            END
        ELSE BEGIN
            BalanceCheckAddCurrAmount := 0;
            BalanceCheckAddCurrAmount2 := 0;
        END;
    end;

    procedure HandleAddCurrResidualGLEntry(GenJnlLine: Record "Gen. Journal Line"; Amount: Decimal; AmountAddCurr: Decimal)
    var
        GLAcc: Record "G/L Account";
        GLEntry: Record "G/L Entry";
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        TotalAddCurrAmount := TotalAddCurrAmount + AmountAddCurr;
        TotalAmount := TotalAmount + Amount;

        IF (GenJnlLine."Additional-Currency Posting" = GenJnlLine."Additional-Currency Posting"::None) AND
        (TotalAmount = 0) AND (TotalAddCurrAmount <> 0) AND
        CheckNonAddCurrCodeOccurred(GenJnlLine."Source Currency Code")
        THEN BEGIN
            GLEntry.INIT;
            GLEntry.CopyFromGenJnlLine(GenJnlLine);
            GLEntry."External Document No." := '';
            GLEntry.Description :=
                COPYSTR(
                STRSUBSTNO(
                    ResidualRoundingErr,
                    GLEntry.FIELDCAPTION("Additional-Currency Amount")),
                1, MAXSTRLEN(GLEntry.Description));
            GLEntry."Source Type" := 0;
            GLEntry."Source No." := '';
            GLEntry."Job No." := '';
            GLEntry.Quantity := 0;
            GLEntry."Entry No." := NextEntryNo;
            GLEntry."Transaction No." := NextTransactionNo;
            IF TotalAddCurrAmount < 0 THEN
                GLEntry."G/L Account No." := AddCurrency."Residual Losses Account"
            ELSE
                GLEntry."G/L Account No." := AddCurrency."Residual Gains Account";
            GLEntry.Amount := 0;
            GLEntry."System-Created Entry" := TRUE;
            GLEntry."Additional-Currency Amount" := -TotalAddCurrAmount;
            GLAcc.GET(GLEntry."G/L Account No.");
            GLAcc.TESTFIELD(Blocked, FALSE);
            GLAcc.TESTFIELD("Account Type", GLAcc."Account Type"::Posting);
            InsertGLEntry(GenJnlLine, GLEntry, FALSE);

            CheckGLAccDimError(GenJnlLine, GLEntry."G/L Account No.");

            TotalAddCurrAmount := 0;
        END;
    end;

    procedure CheckNonAddCurrCodeOccurred(CurrencyCode: Code[10]): Boolean
    begin
        NonAddCurrCodeOccured :=
            NonAddCurrCodeOccured OR (AddCurrencyCode <> CurrencyCode);
        EXIT(NonAddCurrCodeOccured);
    end;

    procedure ReverseVAT(VAR VATEntry: Record "VAT Entry")
    var
        NewVATEntry: Record "VAT Entry";
        ReversedVATEntry: Record "VAT Entry";
        GenJnlLine: Record "Gen. Journal Line";
        ReversedGLEntryTemp: Record "G/L Entry" temporary;
    begin
        IF VATEntry.FINDSET THEN
            REPEAT
                IF VATEntry."Reversed by Entry No." <> 0 THEN
                    ERROR(Text015);
                WITH NewVATEntry DO BEGIN
                    NewVATEntry := VATEntry;
                    Base := -Base;
                    Amount := -Amount;
                    "Unrealized Amount" := -"Unrealized Amount";
                    "Unrealized Base" := -"Unrealized Base";
                    "Remaining Unrealized Amount" := -"Remaining Unrealized Amount";
                    "Remaining Unrealized Base" := -"Remaining Unrealized Base";
                    "Additional-Currency Amount" := -"Additional-Currency Amount";
                    "Additional-Currency Base" := -"Additional-Currency Base";
                    "Add.-Currency Unrealized Amt." := -"Add.-Currency Unrealized Amt.";
                    "Add.-Curr. Rem. Unreal. Amount" := -"Add.-Curr. Rem. Unreal. Amount";
                    "Add.-Curr. Rem. Unreal. Base" := -"Add.-Curr. Rem. Unreal. Base";
                    "VAT Difference" := -"VAT Difference";
                    "Add.-Curr. VAT Difference" := -"Add.-Curr. VAT Difference";

                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT";

                    "Transaction No." := NextTransactionNo;
                    "Source Code" := GenJnlLine."Source Code";
                    "User ID" := USERID;
                    "Entry No." := NextVATEntryNo;
                    "Reversed Entry No." := VATEntry."Entry No.";
                    Reversed := TRUE;
                    // Reversal of Reversal
                    IF VATEntry."Reversed Entry No." <> 0 THEN BEGIN
                        ReversedVATEntry.GET(VATEntry."Reversed Entry No.");
                        ReversedVATEntry."Reversed by Entry No." := 0;
                        ReversedVATEntry.Reversed := FALSE;
                        ReversedVATEntry.MODIFY;
                        VATEntry."Reversed Entry No." := "Entry No.";
                        "Reversed by Entry No." := VATEntry."Entry No.";
                    END;
                    VATEntry."Reversed by Entry No." := "Entry No.";
                    VATEntry.Reversed := TRUE;
                    VATEntry.MODIFY;
                    INSERT;
                    GLEntryVATEntryLink.SETRANGE("VAT Entry No.", VATEntry."Entry No.");
                    IF GLEntryVATEntryLink.FINDSET THEN
                        REPEAT
                            ReversedGLEntryTemp.SETRANGE("Reversed Entry No.", GLEntryVATEntryLink."G/L Entry No.");
                            IF ReversedGLEntryTemp.FINDFIRST THEN
                                GLEntryVATEntryLink.InsertLink(ReversedGLEntryTemp."Entry No.", NewVATEntry."Entry No.");
                        UNTIL GLEntryVATEntryLink.NEXT = 0;
                    NextVATEntryNo := NextVATEntryNo + 1;
                END;
            UNTIL VATEntry.NEXT = 0;
    end;

    procedure CreateGLEntry(GenJnlLine: Record "Gen. Journal Line"; AccNo: Code[20]; Amount: Decimal; AmountAddCurr: Decimal; UseAmountAddCurr: Boolean)
    var
        GLEntry: Record "G/L Entry";
    begin
        IF UseAmountAddCurr THEN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, AmountAddCurr, TRUE, TRUE)
        ELSE BEGIN
            InitGLEntry(GenJnlLine, GLEntry, AccNo, Amount, 0, FALSE, TRUE);
            GLEntry."Additional-Currency Amount" := AmountAddCurr;
        END;
        InsertGLEntry(GenJnlLine, GLEntry, TRUE);
    end;

    procedure CalcAddCurrForUnapplication(Date: Date; Amt: Decimal): Decimal
    begin
        IF AddCurrencyCode = '' THEN
            EXIT;

        AddCurrency.GET(AddCurrencyCode);
        AddCurrency.TESTFIELD("Amount Rounding Precision");

        EXIT(
        ROUND(
            CurrExchRate.ExchangeAmtLCYToFCY(
            Date, AddCurrencyCode, Amt, CurrExchRate.ExchangeRate(Date, AddCurrencyCode)),
            AddCurrency."Amount Rounding Precision"));
    end;

    var
        AddCurrency: Record Currency;
        GLSetup: Record "General Ledger Setup";
        VATEntry: Record "VAT Entry";
        TempGLEntryVAT: Record "G/L Entry" temporary;
        CurrExchRate: Record "Currency Exchange Rate";
        UnrealizedCustLedgEntry: Record "Cust. Ledger Entry";
        UnrealizedVendLedgEntry: Record "Vendor Ledger Entry";
        TempGLEntryBuf: Record "G/L Entry" temporary;
        GlobalGLEntry: Record "G/L Entry";
        GLReg: Record "G/L Register";
        GLEntryVATEntryLink: Record "G/L Entry - VAT Entry Link";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        AddCurrencyCode: Code[10];
        CurrencyFactor: Decimal;
        CurrencyDate: Date;
        NextVATEntryNo: Integer;
        NextTransactionNo: Integer;
        NextConnectionNo: Integer;
        InsertedTempGLEntryVAT: Integer;
        NextEntryNo: Integer;
        UseCurrFactorOnly: Boolean;
        NonAddCurrCodeOccured: Boolean;
        FADimAlreadyChecked: Boolean;
        LastDocType: Option " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
        LastDate: Date;
        LastDocNo: Code[20];
        CurrentBalance: Decimal;
        TotalAddCurrAmount: Decimal;
        TotalAmount: Decimal;
        FirstEntryNo: Integer;
        FirstNewVATEntryNo: Integer;
        CheckUnrealizedCust: Boolean;
        CheckUnrealizedVend: Boolean;
        UnrealizedRemainingAmountCust: Decimal;
        UnrealizedRemainingAmountVend: Decimal;
        FiscalYearStartDate: Date;
        IsGLRegInserted: Boolean;
        BalanceCheckAmount2: Decimal;
        BalanceCheckAmount: Decimal;
        BalanceCheckAddCurrAmount: Decimal;
        BalanceCheckAddCurrAmount2: Decimal;
        DimensionUsedErr: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5.';
        NeedsRoundingErr: Label  '%1 needs to be rounded';
        ResidualRoundingErr: Label 'Residual caused by rounding of %1';

        Text015: Label 'You cannot reverse the transaction, because it has already been reversed.';
}