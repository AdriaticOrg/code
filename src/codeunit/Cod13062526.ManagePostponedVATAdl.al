codeunit 13062526 "Manage Postponed VAT-Adl"
{
    Permissions = tabledata 122 = rm,
                tabledata 124 = rm,
                tabledata 112 = rm,
                tabledata 114 = rm,
                tabledata 254 = irm,
                tabledata 17 = irm,
                tabledata 45 = irm;

    //<adl.10>
    procedure SetPostponedVAT(var GenJnlLine: Record "Gen. Journal Line"; VATDate: Date; PostDate: Date; PostPonedVAT: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; VATOutputDate: Date; InvoicePostBuffer: Record "Invoice Post. Buffer")
    var
        VATPostingSetup: Record "VAT Posting Setup";
        GenJnlLine2: Record "Gen. Journal Line";
        VATSetup: Record "VAT Setup-Adl";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT) then exit;
        if (not (GenJnlLine."Gen. Posting Type" in [GenJnlLine."Gen. Posting Type"::Purchase, GenJnlLine."Gen. Posting Type"::Sale])) or
            ((PostDate = VATDate) and (PostDate = VATOutputDate)) then
            exit;
        VATPostingSetup.GET(GenJnlLine."VAT Bus. Posting Group", GenJnlLine."VAT Prod. Posting Group");
        VATSetup.Get();
        CASE PostPonedVAT OF
            TRUE:
                if (GenJnlLine."VAT Calculation Type" = GenJnlLine."VAT Calculation Type"::"Reverse Charge VAT") and VATSetup."Use VAT Output Date-Adl" then begin
                    VATPostingSetup."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type"::"Normal VAT";
                    VATPostingSetup.MODIFY();
                    GenJnlLine."VAT Calculation Type" := GenJnlLine."VAT Calculation Type"::"Normal VAT";
                    GenJnlLine2 := GenJnlLine;
                    GenJnlLine2."Gen. Posting Type" := GenJnlLine2."Gen. Posting Type"::Sale;
                    GenJnlLine2."VAT Base Amount" := -GenJnlLine."VAT Base Amount";
                    GenJnlLine2."VAT Amount" := ROUND(GenJnlLine2."VAT Base Amount" * VATPostingSetup."VAT %" / 100);
                    GenJnlLine2.Amount := 0;
                    IF VATOutputDate <> PostDate THEN BEGIN
                        GenJnlLine2."Postponed VAT-Adl" := GenJnlLine2."Postponed VAT-Adl"::"Postponed VAT";
                        VATPostingSetup.TESTFIELD("Unrealized VAT Type", 0);
                        VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage;
                        VATPostingSetup.MODIFY();
                    END;
                    GenJnlPostLine.RunWithCheck(GenJnlLine2);

                    VATPostingSetup."Unrealized VAT Type" := 0;
                    VATPostingSetup.MODIFY();
                    IF (VATOutputDate <> PostDate) AND (VATOutputDate <> 0D) THEN BEGIN
                        GenJnlLine2."Postponed VAT-Adl" := GenJnlLine2."Postponed VAT-Adl"::"Realized VAT";
                        GenJnlLine2.Amount := GenJnlLine."VAT Amount";
                        GenJnlLine2."Amount (LCY)" := GenJnlLine."VAT Amount (LCY)";
                        GenJnlLine2."Posting Date" := VATOutputDate;
                        GenJnlLine2."Account No." := VATPostingSetup.GetSalesAccount(TRUE);
                        GenJnlPostLine.RunWithCheck(GenJnlLine2);
                    END;
                    IF VATDate <> PostDate THEN BEGIN
                        GenJnlLine."Postponed VAT-Adl" := GenJnlLine."Postponed VAT-Adl"::"Postponed VAT";
                        VATPostingSetup.TESTFIELD("Unrealized VAT Type", 0);
                        VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage;
                        VATPostingSetup.MODIFY();
                    END;
                end
                else
                    if VATDate <> PostDate then begin
                        GenJnlLine."Postponed VAT-Adl" := GenJnlLine."Postponed VAT-Adl"::"Postponed VAT";
                        VATPostingSetup.TESTFIELD("Unrealized VAT Type", 0);
                        VATPostingSetup."Unrealized VAT Type" := VATPostingSetup."Unrealized VAT Type"::Percentage;
                        VATPostingSetup.MODIFY();
                    end;
            FALSE:
                BEGIN
                    GenJnlLine."Postponed VAT-Adl" := 0;
                    VATPostingSetup."Unrealized VAT Type" := 0;
                    VATPostingSetup.MODIFY();
                    if (VATDate <> 0D) and (VATDate <> PostDate) then begin
                        GenJnlLine."Postponed VAT-Adl" := GenJnlLine."Postponed VAT-Adl"::"Realized VAT";
                        GenJnlLine."Posting Date" := VATDate;
                        GenJnlLine.Amount := -GenJnlLine."VAT Amount";
                        GenJnlLine."Amount (LCY)" := -GenJnlLine."VAT Amount (LCY)";
                        if VATPostingSetup."VAT Calculation Type" = VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then begin
                            GenJnlLine.Amount := GenJnlLine."VAT Amount";
                            GenJnlLine."Amount (LCY)" := GenJnlLine."VAT Amount (LCY)";
                            GenJnlLine."Account No." := VATPostingSetup.GetRevChargeAccount(true);
                            if GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::Sale then
                                GenJnlLine."Bal. Account No." := VATPostingSetup.GetSalesAccount(true)
                            else
                                GenJnlLine."Bal. Account No." := VATPostingSetup.GetPurchAccount(true);
                        end
                        else
                            if GenJnlLine."Gen. Posting Type" = GenJnlLine."Gen. Posting Type"::Sale then
                                GenJnlLine."Account No." := VATPostingSetup.GetSalesAccount(true)
                            else
                                GenJnlLine."Account No." := VATPostingSetup.GetPurchAccount(true);

                        GenJnlPostLine.RunWithCheck(GenJnlLine);
                    end;
                    if (InvoicePostBuffer."VAT Calculation Type" = InvoicePostBuffer."VAT Calculation Type"::"Reverse Charge VAT") and VATSetup."Use VAT Output Date-Adl" then begin
                        VATPostingSetup."VAT Calculation Type" := VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT";
                        VATPostingSetup.Modify();
                    end;
                END;
        END;
    end;
    //</adl.10>
    //<adl.7>
    procedure UpdateCorrection(var ValueEntry: Record "Value Entry"; CostToPost: Decimal) Correction: Boolean
    var
        InvtSetup: Record "Inventory Setup";
    begin
        InvtSetup.Get();
        WITH ValueEntry DO
            CASE "Item Ledger Entry Type" OF
                "Item Ledger Entry Type"::Purchase:
                    Correction := CostToPost < 0;
                "Item Ledger Entry Type"::Sale:
                    Correction := CostToPost > 0;
                "Item Ledger Entry Type"::"Positive Adjmt.":
                    Correction := CostToPost < 0;
                "Item Ledger Entry Type"::"Negative Adjmt.":
                    Correction := CostToPost > 0;
                "Item Ledger Entry Type"::Transfer:
                    IF "Valued Quantity" > 0 THEN
                        Correction := CostToPost < 0
                    ELSE
                        IF InvtSetup."Post Neg. Transfers as Corr.-Adl" THEN
                            Correction := CostToPost < 0
                        ELSE
                            Correction := CostToPost > 0;
                "Item Ledger Entry Type"::Consumption:
                    Correction := CostToPost > 0;
                "Item Ledger Entry Type"::Output:
                    Correction := CostToPost < 0;
                "Item Ledger Entry Type"::"Assembly Consumption":
                    Correction := CostToPost > 0;
                "Item Ledger Entry Type"::"Assembly Output":
                    Correction := CostToPost < 0;
                "Item Ledger Entry Type"::" ":
                    Correction := CostToPost < 0;
            END;
    end;
    //</adl.7>
    var
        CoreSetup: Record "CoreSetup-Adl";
        ADLCore: Codeunit "Adl Core-Adl";
}