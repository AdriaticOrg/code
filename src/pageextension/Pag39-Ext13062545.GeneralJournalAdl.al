pageextension 13062545 "General Journal-Adl" extends "General Journal" //39
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type-Adl"; "FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Type-Adl';
            }
            field("FAS Instrument Code-Adl"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Instrument Code-Adl';
            }
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Sector Code-Adl';
            }
            field("Bal. FAS Type-Adl"; "Bal. FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies Bal. FAS Type-Adl';
            }
            field("Bal. FAS Instrument Code-Adl"; "Bal. FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies Bal. FAS Instrument Code-Adl';
            }
            field("Bal. FAS Sector Code-Adl"; "Bal. FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies Bal. FAS Sector Code-Adl';
            }
            // </adl.24>

            // <adl.28>
            field("OriginalDocumentAmountLCY-Adl"; OriginalDocumentAmountLCY)
            {
                Caption = 'Original Document Amount (LCY)';
                ApplicationArea = All;
                Visible = UnpaidRecEnabled;
                ToolTip = 'TODO: Tooltip - Unpaid Receivables';

                trigger OnValidate();
                var
                    CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-Adl";
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
            field("OriginalVATAmountLCY-Adl"; OriginalVATAmountLCY)
            {
                Caption = 'Original VAT Amount (LCY)';
                ApplicationArea = All;
                Visible = UnpaidRecEnabled;
                ToolTip = 'TODO: Tooltip - Unpaid Receivables';

                trigger OnValidate();
                var
                    CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-Adl";
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
            field("OpenAmounLCYtWithoutUnrealizedERF-Adl"; OpenAmounLCYtWithoutUnrealizedERF)
            {
                Caption = 'Open Amount (LCY) Without Unrealized Exchange Rate Adjustment';
                ApplicationArea = All;
                Visible = UnpaidRecEnabled;
                ToolTip = 'TODO: Tooltip - Unpaid Receivables';

                trigger OnValidate();
                var
                    CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-Adl";
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
        ADLCore: Codeunit "Adl Core-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        UnpaidRecEnabled: Boolean;
        // </adl.0>

        // <adl.28>
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-Adl";
        OriginalDocumentAmountLCY: Decimal;
        OriginalVATAmountLCY: Decimal;
        OpenAmounLCYtWithoutUnrealizedERF: Decimal;
        // </adl.28>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::BST);
        UnpaidRecEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::UnpaidReceivables);
        // </adl.0>
    end;

    trigger OnAfterGetRecord()
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
