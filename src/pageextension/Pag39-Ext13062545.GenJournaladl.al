pageextension 13062545 "GenJournal-adl" extends "General Journal" //39
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type"; "FAS Type")
            {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("FAS Instrument Code"; "FAS Instrument Code")
            {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("FAS Sector Code"; "FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("Bal. FAS Type"; "Bal. FAS Type")
            {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("Bal. FAS Instrument Code"; "Bal. FAS Instrument Code")
            {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("Bal. FAS Sector Code"; "Bal. FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASEnabled;
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
                    CustLedgerEntryExtData.RESET;
                    CustLedgerEntryExtData.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
                    CustLedgerEntryExtData.SETRANGE("Journal Template Name", "Journal Template Name");
                    CustLedgerEntryExtData.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    CustLedgerEntryExtData.SETRANGE("Line No.", "Line No.");
                    if CustLedgerEntryExtData.FINDFIRST then begin
                        CustLedgerEntryExtData."Original Document Amount (LCY)" := OriginalDocumentAmountLCY;
                        CustLedgerEntryExtData.MODIFY;
                    end else begin
                        CustLedgerEntryExtData2.RESET;
                        CustLedgerEntryExtData2.SETRANGE("Is Journal Line", true);
                        if CustLedgerEntryExtData2.FINDLAST then
                            CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                        else
                            CustLedgerEntryExtDataLineNo := 1;
                        CustLedgerEntryExtData2.RESET;
                        CustLedgerEntryExtData2.INIT;
                        CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                        CustLedgerEntryExtData2."Is Journal Line" := true;
                        CustLedgerEntryExtData2."Journal Template Name" := "Journal Template Name";
                        CustLedgerEntryExtData2."Journal Batch Name" := "Journal Batch Name";
                        CustLedgerEntryExtData2."Line No." := "Line No.";
                        CustLedgerEntryExtData2."Original Document Amount (LCY)" := OriginalDocumentAmountLCY;
                        CustLedgerEntryExtData2.INSERT;
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
                    CustLedgerEntryExtData.RESET;
                    CustLedgerEntryExtData.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
                    CustLedgerEntryExtData.SETRANGE("Journal Template Name", "Journal Template Name");
                    CustLedgerEntryExtData.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    CustLedgerEntryExtData.SETRANGE("Line No.", "Line No.");
                    if CustLedgerEntryExtData.FINDFIRST then begin
                        CustLedgerEntryExtData."Original VAT Amount (LCY)" := OriginalVATAmountLCY;
                        CustLedgerEntryExtData.MODIFY;
                    end else begin
                        CustLedgerEntryExtData2.RESET;
                        CustLedgerEntryExtData2.SETRANGE("Is Journal Line", true);
                        if CustLedgerEntryExtData2.FINDLAST then
                            CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                        else
                            CustLedgerEntryExtDataLineNo := 1;
                        CustLedgerEntryExtData2.RESET;
                        CustLedgerEntryExtData2.INIT;
                        CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                        CustLedgerEntryExtData2."Is Journal Line" := true;
                        CustLedgerEntryExtData2."Journal Template Name" := "Journal Template Name";
                        CustLedgerEntryExtData2."Journal Batch Name" := "Journal Batch Name";
                        CustLedgerEntryExtData2."Line No." := "Line No.";
                        CustLedgerEntryExtData2."Original VAT Amount (LCY)" := OriginalVATAmountLCY;
                        CustLedgerEntryExtData2.INSERT;
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
                    CustLedgerEntryExtData.RESET;
                    CustLedgerEntryExtData.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
                    CustLedgerEntryExtData.SETRANGE("Journal Template Name", "Journal Template Name");
                    CustLedgerEntryExtData.SETRANGE("Journal Batch Name", "Journal Batch Name");
                    CustLedgerEntryExtData.SETRANGE("Line No.", "Line No.");
                    if CustLedgerEntryExtData.FINDFIRST then begin
                        CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal." := OpenAmounLCYtWithoutUnrealizedERF;
                        CustLedgerEntryExtData.MODIFY;
                    end else begin
                        CustLedgerEntryExtData2.RESET;
                        CustLedgerEntryExtData2.SETRANGE("Is Journal Line", true);
                        if CustLedgerEntryExtData2.FINDLAST then
                            CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                        else
                            CustLedgerEntryExtDataLineNo := 1;
                        CustLedgerEntryExtData2.RESET;
                        CustLedgerEntryExtData2.INIT;
                        CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                        CustLedgerEntryExtData2."Is Journal Line" := true;
                        CustLedgerEntryExtData2."Journal Template Name" := "Journal Template Name";
                        CustLedgerEntryExtData2."Journal Batch Name" := "Journal Batch Name";
                        CustLedgerEntryExtData2."Line No." := "Line No.";
                        CustLedgerEntryExtData2."Open Amount (LCY) w/o Unreal." := OpenAmounLCYtWithoutUnrealizedERF;
                        CustLedgerEntryExtData2.INSERT;
                    end;
                end;
            }
        }
        // </adl.28>
    }


    // <adl.24>
    trigger OnOpenPage()
    begin
        RepSIMgt.GetReporSIEnabled(FASEnabled, KRDEnabled, BSTEnabled);

        if AdlCore.FeatureEnabled("ADL Features"::"Unpaid Receivables") then
            UnpaidRecEnabled := True;
    end;

    var
        RepSIMgt: Codeunit "Reporting SI Mgt.";
        AdlCore: Codeunit "Adl Core";
        "ADL Features": Option VAT,FAS,KRD,BST,VIES,"Unpaid Receivables";
        FASEnabled: Boolean;
        KRDEnabled: Boolean;
        BSTEnabled: Boolean;
        // </adl.24>
        // <adl.28>
        UnpaidRecEnabled: Boolean;
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-adl";
        OriginalDocumentAmountLCY: Decimal;
        OriginalVATAmountLCY: Decimal;
        OpenAmounLCYtWithoutUnrealizedERF: Decimal;
        // <adl.28>
}