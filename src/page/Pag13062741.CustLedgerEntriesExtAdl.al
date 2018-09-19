page 13062741 "Cust. Ledger Entries Ext.-Adl"
{
    Caption = 'Cust. Ledger Entries Extended';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Cust. Ledger Entry";
    sourceTableView = sorting ("Document Type", "Customer No.", "Posting Date", "Currency Code")
                      where ("Document Type" = filter (Invoice | "Finance Charge Memo"));
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; "Entry No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Customer No."; "Customer No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Original Amount"; "Original Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Original Amt. (LCY)"; "Original Amt. (LCY)")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Remaining Amt. (LCY)"; "Remaining Amt. (LCY)")
                {
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    Editable = false;
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';
                }
                field(OriginalDocumentAmount; OriginalDocumentAmount)
                {
                    Caption = 'Original Document Amount (LCY)';
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';

                    trigger OnValidate();
                    begin
                        if not CustLedgerEntryExtData.GET("Entry No.", false) then begin
                            CustLedgerEntryExtData.INIT();
                            CustLedgerEntryExtData."Entry No." := "Entry No.";
                            CustLedgerEntryExtData.init();
                            CustLedgerEntryExtData."Is Journal Line" := false;
                            CustLedgerEntryExtData.Insert();
                        end;

                        CustLedgerEntryExtData."Original Document Amount (LCY)" := OriginalDocumentAmount;
                        CustLedgerEntryExtData.modify();
                    end;
                }
                field(OriginalVATAmount; OriginalVATAmount)
                {
                    Caption = 'Original VAT Amount (LCY)';
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';

                    trigger OnValidate();
                    begin
                        if not CustLedgerEntryExtData.GET("Entry No.", false) then begin
                            CustLedgerEntryExtData.INIT();
                            CustLedgerEntryExtData."Entry No." := "Entry No.";
                            CustLedgerEntryExtData.init();
                            CustLedgerEntryExtData."Is Journal Line" := false;
                            CustLedgerEntryExtData.Insert();
                        end;

                        CustLedgerEntryExtData."Original VAT Amount (LCY)" := OriginalVATAmount;
                        CustLedgerEntryExtData.modify();
                    end;
                }
                field(OpenAmountLCYWithoutUnreal; OpenAmountLCYWithoutUnreal)
                {
                    Caption = 'Open Amount (LCY) Without Unrealized Exchange Rate Adjustment';
                    ApplicationArea = all;
                    ToolTip = 'TODO: Tooltip - Unpaid Receivables';

                    trigger OnValidate();
                    begin
                        if not CustLedgerEntryExtData.GET("Entry No.", false) then begin
                            CustLedgerEntryExtData.INIT();
                            CustLedgerEntryExtData."Entry No." := "Entry No.";
                            CustLedgerEntryExtData."Is Journal Line" := false;
                            CustLedgerEntryExtData."Entry No." := "Entry No.";
                            CustLedgerEntryExtData."Is Journal Line" := false;
                            CustLedgerEntryExtData.Insert();
                        end;

                        CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal." := OpenAmountLCYWithoutUnreal;
                        CustLedgerEntryExtData.modify();
                    end;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        OriginalDocumentAmount := 0;
        OriginalVATAmount := 0;
        if CustLedgerEntryExtData.GET("Entry No.", false) then begin
            OriginalDocumentAmount := CustLedgerEntryExtData."Original Document Amount (LCY)";
            OriginalVATAmount := CustLedgerEntryExtData."Original VAT Amount (LCY)";
            OpenAmountLCYWithoutUnreal := CustLedgerEntryExtData."Open Amount (LCY) w/o Unreal.";
        end;
    end;

    trigger OnOpenPage();
    var
        UnpaidReceivablesSetup: Record "Unpaid Receivables Setup-Adl";
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables) then exit;

        UnpaidReceivablesSetup.GET();
        UnpaidReceivablesSetup.testfield("Ext. Data Start Bal. Date-Adl");
        if UnpaidReceivablesSetup."Ext. Data Start Bal. Date-Adl" <> 0D then
            SetRange("Posting Date", 0D, UnpaidReceivablesSetup."Ext. Data Start Bal. Date-Adl")
        else
            exit;
    end;

    var
        CoreSetup: Record "CoreSetup-Adl";
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-Adl";
        ADLCore: Codeunit "Adl Core-Adl";
        OriginalDocumentAmount: Decimal;
        OriginalVATAmount: Decimal;
        OpenAmountLCYWithoutUnreal: Decimal;
}

