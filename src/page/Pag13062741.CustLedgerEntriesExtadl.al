page 13062741 "Cust. Ledger Entries Ext.-adl"
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

                }
                field("Customer No."; "Customer No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = all;
                }
                field("Document No."; "Document No.")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Description; Description)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Currency Code"; "Currency Code")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Original Amount"; "Original Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Original Amt. (LCY)"; "Original Amt. (LCY)")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Remaining Amount"; "Remaining Amount")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field("Remaining Amt. (LCY)"; "Remaining Amt. (LCY)")
                {
                    ApplicationArea = all;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    Editable = false;
                    ApplicationArea = all;
                }
                field(OriginalDocumentAmount; OriginalDocumentAmount)
                {
                    Caption = 'Original Document Amount (LCY)';
                    ApplicationArea = all;

                    trigger OnValidate();
                    begin
                        if not CustLedgerEntryExtData.GET("Entry No.", false) then begin
                            CustLedgerEntryExtData.INIT;
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

                    trigger OnValidate();
                    begin
                        if not CustLedgerEntryExtData.GET("Entry No.", false) then begin
                            CustLedgerEntryExtData.INIT;
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

                    trigger OnValidate();
                    begin
                        if not CustLedgerEntryExtData.GET("Entry No.", false) then begin
                            CustLedgerEntryExtData.INIT;
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
    begin
        if not ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables) then exit;

        SalesReceivablesSetup.GET;
        SalesReceivablesSetup.testfield("Exteded Data Start Bal. Date");
        if SalesReceivablesSetup."Exteded Data Start Bal. Date" <> 0D then
            SetRange("Posting Date", 0D, SalesReceivablesSetup."Exteded Data Start Bal. Date")
        else
            exit;
    end;

    var
        ADLCore: Codeunit "Adl Core";
        CoreSetup: Record "CoreSetup-Adl";
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-adl";
        OriginalDocumentAmount: Decimal;
        OriginalVATAmount: Decimal;
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        OpenAmountLCYWithoutUnreal: Decimal;
}

