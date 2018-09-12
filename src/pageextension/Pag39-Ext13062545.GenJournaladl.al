pageextension 13062545 "General Journal-Adl" extends "General Journal" //39
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type"; "FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("Bal. FAS Type"; "Bal. FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("Bal. FAS Instrument Code"; "Bal. FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("Bal. FAS Sector Code"; "Bal. FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // </adl.24>

            // <adl.28>
            field(OriginalDocumentAmountLCY; OriginalDocumentAmountLCY)
            {
                Caption = 'Original Document Amount (LCY)';
                ApplicationArea = All;
                Visible = UnpaidRecEnabled;

                trigger OnValidate();
                var
                    CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-adl";
                    CustLedgerEntryExtDataLineNo: Integer;
                begin
                    CustLedgerEntryExtData.Reset();
                    CustLedgerEntryExtData.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    CustLedgerEntryExtData.SetRange("Journal Template Name", "Journal Template Name");
                    CustLedgerEntryExtData.SetRange("Journal Batch Name", "Journal Batch Name");
                    CustLedgerEntryExtData.SetRange("Line No.", "Line No.");
                    if CustLedgerEntryExtData.FindFirst() then begin
                        CustLedgerEntryExtData."Original Document Amount (LCY)" := OriginalDocumentAmountLCY;
                        CustLedgerEntryExtData.MODIFY();
                    end else begin
                        CustLedgerEntryExtData2.Reset();
                        CustLedgerEntryExtData2.SetRange("Is Journal Line", true);
                        if CustLedgerEntryExtData2.FindLast() then
                            CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                        else
                            CustLedgerEntryExtDataLineNo := 1;
                        CustLedgerEntryExtData2.Reset();
                        CustLedgerEntryExtData2.Init();
                        CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                        CustLedgerEntryExtData2."Is Journal Line" := true;
                        CustLedgerEntryExtData2."Journal Template Name" := "Journal Template Name";
                        CustLedgerEntryExtData2."Journal Batch Name" := "Journal Batch Name";
                        CustLedgerEntryExtData2."Line No." := "Line No.";
                        CustLedgerEntryExtData2."Original Document Amount (LCY)" := OriginalDocumentAmountLCY;
                        CustLedgerEntryExtData2.Insert();
                    end;
                end;
            }
            field(OriginalVATAmountLCY; OriginalVATAmountLCY)
            {
                Caption = 'Original VAT Amount (LCY)';
                ApplicationArea = All;
                Visible = UnpaidRecEnabled;

                trigger OnValidate();
                var
                    CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-adl";
                    CustLedgerEntryExtDataLineNo: Integer;
                begin
                    CustLedgerEntryExtData.Reset();
                    CustLedgerEntryExtData.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    CustLedgerEntryExtData.SetRange("Journal Template Name", "Journal Template Name");
                    CustLedgerEntryExtData.SetRange("Journal Batch Name", "Journal Batch Name");
                    CustLedgerEntryExtData.SetRange("Line No.", "Line No.");
                    if CustLedgerEntryExtData.FindFirst() then begin
                        CustLedgerEntryExtData."Original VAT Amount (LCY)" := OriginalVATAmountLCY;
                        CustLedgerEntryExtData.MODIFY();
                    end else begin
                        CustLedgerEntryExtData2.Reset();
                        CustLedgerEntryExtData2.SetRange("Is Journal Line", true);
                        if CustLedgerEntryExtData2.FindLast() then
                            CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                        else
                            CustLedgerEntryExtDataLineNo := 1;
                        CustLedgerEntryExtData2.Reset();
                        CustLedgerEntryExtData2.Init();
                        CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                        CustLedgerEntryExtData2."Is Journal Line" := true;
                        CustLedgerEntryExtData2."Journal Template Name" := "Journal Template Name";
                        CustLedgerEntryExtData2."Journal Batch Name" := "Journal Batch Name";
                        CustLedgerEntryExtData2."Line No." := "Line No.";
                        CustLedgerEntryExtData2."Original VAT Amount (LCY)" := OriginalVATAmountLCY;
                        CustLedgerEntryExtData2.Insert();
                    end;
                end;
            }
            field(OpenAmounLCYtWithoutUnrealizedERF; OpenAmounLCYtWithoutUnrealizedERF)
            {
                Caption = 'Open Amount (LCY) Without Unrealized Exchange Rate Adjustment';
                ApplicationArea = All;
                Visible = UnpaidRecEnabled;

                trigger OnValidate();
                var
                    CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-adl";
                    CustLedgerEntryExtDataLineNo: Integer;
                begin
                    CustLedgerEntryExtData.Reset();
                    CustLedgerEntryExtData.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    CustLedgerEntryExtData.SetRange("Journal Template Name", "Journal Template Name");
                    CustLedgerEntryExtData.SetRange("Journal Batch Name", "Journal Batch Name");
                    CustLedgerEntryExtData.SetRange("Line No.", "Line No.");
                    if CustLedgerEntryExtData.FindFirst() then begin
                        CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal." := OpenAmounLCYtWithoutUnrealizedERF;
                        CustLedgerEntryExtData.MODIFY();
                    end else begin
                        CustLedgerEntryExtData2.Reset();
                        CustLedgerEntryExtData2.SetRange("Is Journal Line", true);
                        if CustLedgerEntryExtData2.FindLast() then
                            CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                        else
                            CustLedgerEntryExtDataLineNo := 1;
                        CustLedgerEntryExtData2.Reset();
                        CustLedgerEntryExtData2.Init();
                        CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                        CustLedgerEntryExtData2."Is Journal Line" := true;
                        CustLedgerEntryExtData2."Journal Template Name" := "Journal Template Name";
                        CustLedgerEntryExtData2."Journal Batch Name" := "Journal Batch Name";
                        CustLedgerEntryExtData2."Line No." := "Line No.";
                        CustLedgerEntryExtData2."Open Amount (LCY) w/o Unreal." := OpenAmounLCYtWithoutUnrealizedERF;
                        CustLedgerEntryExtData2.Insert();
                    end;
                end;
            }
        }
        // </adl.28>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        UnpaidRecEnabled: Boolean;
        // </adl.0>

        // <adl.28>
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-adl";
        OriginalDocumentAmountLCY: Decimal;
        OriginalVATAmountLCY: Decimal;
        OpenAmounLCYtWithoutUnrealizedERF: Decimal;
        // </adl.28>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::BST);
        UnpaidRecEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables);
        // </adl.0>
    end;

    trigger OnAfterGetCurrRecord()
    begin
        // <adl.28>
        CustLedgerEntryExtData.Reset();
        CustLedgerEntryExtData.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        CustLedgerEntryExtData.SetRange("Journal Template Name", "Journal Template Name");
        CustLedgerEntryExtData.SetRange("Journal Batch Name", "Journal Batch Name");
        CustLedgerEntryExtData.SetRange("Line No.", "Line No.");
        IF not CustLedgerEntryExtData.FindFirst() THEN
            Clear(CustLedgerEntryExtData);
        OriginalDocumentAmountLCY := CustLedgerEntryExtData."Original Document Amount (LCY)";
        OriginalVATAmountLCY := CustLedgerEntryExtData."Original VAT Amount (LCY)";
        OpenAmounLCYtWithoutUnrealizedERF := CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
        // </adl.28>
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(CustLedgerEntryExtData); // <adl.28>
    end;
}
