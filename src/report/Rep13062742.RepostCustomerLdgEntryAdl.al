report 13062742 "Repost Customer Ldg. Entry-Adl"
{
    Caption = 'Repost Customer Ledger Entry';
    ProcessingOnly = true;

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING ("Entry No.");
            RequestFilterFields = "Entry No.";

            trigger OnAfterGetRecord();
            var
                Customer: Record Customer;
                SalesInvoiceHeader: Record "Sales Invoice Header";
                SalesCrMemoHeader: Record "Sales Cr.Memo Header";
                ServiceInvoiceHeader: Record "Service Invoice Header";
                ServiceCrMemoHeader: Record "Service Cr.Memo Header";
            begin
                case "Document Type" of
                    "Document Type"::Invoice:
                        begin
                            SalesInvoiceHeader.SETRANGE("No.", "Document No.");
                            SalesInvoiceHeader.SETRANGE("Posting Date", "Posting Date");
                            if not SalesInvoiceHeader.ISEMPTY() then
                                ERROR(RepostingCLENotAllowedPostedErr, "Document No.", "Document Type");
                            ServiceInvoiceHeader.SETRANGE("No.", "Document No.");
                            ServiceInvoiceHeader.SETRANGE("Posting Date", "Posting Date");
                            if not ServiceInvoiceHeader.ISEMPTY() then
                                ERROR(RepostingCLENotAllowedServiceErr, "Document No.", "Document Type");
                        end;
                    "Document Type"::"Credit Memo":
                        begin
                            SalesCrMemoHeader.SETRANGE("No.", "Document No.");
                            SalesCrMemoHeader.SETRANGE("Posting Date", "Posting Date");
                            if not SalesCrMemoHeader.ISEMPTY then
                                ERROR(RepostingCLENotAllowedPostedErr, "Document No.", "Document Type");
                            ServiceCrMemoHeader.SETRANGE("No.", "Document No.");
                            ServiceCrMemoHeader.SETRANGE("Posting Date", "Posting Date");
                            if not ServiceCrMemoHeader.ISEMPTY then
                                ERROR(RepostingCLENotAllowedServiceErr, "Document No.", "Document Type");
                        end;
                end;

                TESTFIELD(Open);
                CALCFIELDS("Remaining Amount", "Remaining Amt. (LCY)");

                GenJnlLine.INIT();
                LineNo += 10000;
                GenJnlLine."Journal Template Name" := TemplateName;
                GenJnlLine."Journal Batch Name" := BatchName;
                GenJnlLine."Line No." := LineNo;
                GenJnlLine."Source Code" := GenJnlTemplate."Source Code";
                if PostingDate <> 0D then
                    GenJnlLine."Posting Date" := PostingDate
                else
                    GenJnlLine."Posting Date" := "Posting Date";
                GenJnlLine."Document Date" := "Document Date";
                GenJnlLine."Due Date" := "Due Date";
                GenJnlLine.Description := Description;

                Customer.GET("Cust. Ledger Entry"."Customer No.");
                DescSameAsName := false;
                if GenJnlLine.Description = Customer.Name then
                    DescSameAsName := true;

                GenJnlLine."Shortcut Dimension 1 Code" := "Global Dimension 1 Code";
                GenJnlLine."Shortcut Dimension 2 Code" := "Global Dimension 2 Code";
                GenJnlLine."Dimension Set ID" := "Dimension Set ID";
                GenJnlLine."Reason Code" := "Reason Code";
                GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Source Type" := GenJnlLine."Account Type"::Customer;
                GenJnlLine."Account No." := "Customer No.";
                GenJnlLine."Source No." := "Customer No.";
                case "Document Type" of
                    "Document Type"::Payment:
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Refund;
                    "Document Type"::Invoice:
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::"Credit Memo";
                    "Document Type"::"Credit Memo":
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Invoice;
                    "Document Type"::Refund:
                        GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
                    else
                        ERROR(DocumentTypeNotAallowedErr, "Document Type");
                end;
                GenJnlLine."Document No." := "Document No.";
                GenJnlLine."External Document No." := "External Document No.";
                GenJnlLine.VALIDATE("Currency Code", "Currency Code");
                GenJnlLine."Source Currency Code" := "Currency Code";
                GenJnlLine."Applies-to ID" := '';

                if GenJnlLine."Source Code" = '' then
                    GenJnlLine."Source Code" := "Source Code";
                GenJnlLine."Salespers./Purch. Code" := "Salesperson Code";
                GenJnlLine."Posting No. Series" := '';
                GenJnlLine."Payment Method Code" := "Payment Method Code";
                GenJnlLine."On Hold" := '';
                GenJnlLine."Sell-to/Buy-from No." := "Sell-to Customer No.";
                GenJnlLine.Prepayment := Prepayment;
                GenJnlLine."Allow Zero-Amount Posting" := true;
                GenJnlLine."Posting Group" := "Customer Posting Group";
                if ApplyAmount <> 0 then
                    GenJnlLine.VALIDATE(Amount, -("Remaining Amount" / ABS("Remaining Amount")) * ABS(ApplyAmount))
                else
                    GenJnlLine.VALIDATE(Amount, -"Remaining Amount");
                GenJnlLine."Applies-to Doc. Type" := "Document Type";
                GenJnlLine."Applies-to Doc. No." := "Document No.";

                GenJnlLine."Sales/Purch. (LCY)" := -"Sales (LCY)";
                GenJnlLine."Profit (LCY)" := -"Profit (LCY)";
                GenJnlLine."Inv. Discount (LCY)" := -"Inv. Discount (LCY)";

                GenJnlLine.Correction := Correction;
                GenJnlLine.UpdateLineBalance();
                LineCounter += 1;
                if RepostType = RepostType::Fill then
                    GenJnlLine.INSERT()
                else begin
                    GenJnlLine."Recurring Method" := 1;

                    GenJnlLineFirstLine := GenJnlLine;
                end;

                LineNo += 10000;
                GenJnlLine."Line No." := LineNo;
                if (NewCustNo <> '') and (NewCustNo <> "Customer No.") then begin
                    Customer.GET(NewCustNo);
                    GenJnlLine."Account No." := NewCustNo;
                    GenJnlLine."Source No." := NewCustNo;
                    GenJnlLine."Sell-to/Buy-from No." := NewCustNo;
                    GenJnlLine."Posting Group" := Customer."Customer Posting Group";
                    if DescSameAsName then
                        GenJnlLine.Description := Customer.Name;
                end;
                if (NewPostingGroup <> '') and (NewPostingGroup <> GenJnlLine."Posting Group") then
                    GenJnlLine."Posting Group" := NewPostingGroup;

                if DimChange then begin
                    GenJnlLine."Shortcut Dimension 1 Code" := GlobalDim1;
                    GenJnlLine."Shortcut Dimension 2 Code" := GlobalDim2;
                    GenJnlLine."Dimension Set ID" := DimSetID;
                end;

                if (GenJnlLine."Account No." = "Customer No.") and (GenJnlLine."Posting Group" = "Customer Posting Group") and (GenJnlLine."Dimension Set ID" = "Dimension Set ID") then
                    ERROR(NoDifferenceInLedgerEntryErr, "Entry No.");

                GenJnlLine."Document Type" := "Document Type";
                if ApplyAmount <> 0 then
                    GenJnlLine.VALIDATE(Amount, ("Remaining Amount" / ABS("Remaining Amount")) * ABS(ApplyAmount))
                else begin
                    GenJnlLine.VALIDATE(Amount, "Remaining Amount");
                    GenJnlLine."Source Currency Amount" := "Remaining Amount";
                end;
                GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::" ";
                GenJnlLine."Applies-to Doc. No." := '';

                // <FIN.3848>
                InsertOriginalDocAndVatAmount(GenJnlLine."Document No.", "Cust. Ledger Entry"."Entry No.");
                // </FIN.3848>

                GenJnlLine."Sales/Purch. (LCY)" := 0;
                GenJnlLine."Profit (LCY)" := 0;
                GenJnlLine."Inv. Discount (LCY)" := 0;
                GenJnlLine.Correction := false;
                GenJnlLine.UpdateLineBalance();
                LineCounter += 1;
                if RepostType = RepostType::Fill then
                    GenJnlLine.INSERT()
                else begin
                    GenJnlPostLine.RunWithCheck(GenJnlLineFirstLine);
                    GenJnlPostLine.RunWithCheck(GenJnlLine);
                end;

            end;

            trigger OnPostDataItem();
            begin
                if LineCounter <> 0 then
                    if RepostType = RepostType::Fill then
                        MESSAGE(JournalLinesFilledMsg, FORMAT(LineCounter))
                    else
                        MESSAGE(JournalLinesPostedMsg, FORMAT(LineCounter));
            end;

            trigger OnPreDataItem();
            begin
                if (NewCustNo = '') and (NewPostingGroup = '') and (DimChange and (DimSetID = 0)) then
                    ERROR(SelectCustomerCustomerPostingGroupErr);

                if (ApplyAmount <> 0) and (COUNT() <> 1) then
                    ERROR(OnlyOneCustomerLedgerEntryErr);

                if DimChange and (DimSetID = 0) then
                    ERROR(UndefinedDimensionValueErr);

                GenJnlTemplate.GET(TemplateName);
                GenJnlLine.SETRANGE("Journal Template Name", TemplateName);
                GenJnlLine.SETRANGE("Journal Batch Name", BatchName);
                if GenJnlLine.FINDLAST() then
                    LineNo := GenJnlLine."Line No.";
            end;
        }
    }

    requestpage
    {
        Caption = 'Repost Customer Ledger Entry';
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDate; PostingDate)
                    {
                        Caption = 'Posting Date';
                    }
                    field(NewCustNo; NewCustNo)
                    {
                        Caption = 'New Customer No.';
                        TableRelation = Customer;
                    }
                    field(NewPostingGroup; NewPostingGroup)
                    {
                        Caption = 'New Posting Group';
                        TableRelation = "Customer Posting Group";
                    }
                    field(Correction; Correction)
                    {
                        Caption = 'Post As Correction';
                    }
                    field(RepostType; RepostType)
                    {
                        Caption = 'Reposting Type';
                        OptionCaption = 'Auto Post,Fill G/L Journal';

                        trigger OnValidate();
                        begin
                            UpdateRequestPage();
                        end;
                    }
                    field(ApplyAmount; ApplyAmount)
                    {
                        Caption = 'Apply Amount';
                    }
                    group(Control1000000007)
                    {
                        Visible = FillVisible;
                        field(TemplateName; TemplateName)
                        {
                            Caption = 'G/L Template Name';
                            TableRelation = "Gen. Journal Template";

                            trigger OnLookup(Text: Text): Boolean;
                            var
                                JnlSelected: Boolean;
                            begin
                                GenJnlManagement.TemplateSelection(PAGE::"General Journal", 0, false, GenJnlLine, JnlSelected);
                                TemplateName := GenJnlLine.GETRANGEMAX("Journal Template Name");
                                BatchName := '';
                            end;
                        }
                        field(BatchName; BatchName)
                        {
                            Caption = 'G/L Batch Name';

                            trigger OnLookup(Text: Text): Boolean;
                            begin
                                LookupBatch();
                            end;

                            trigger OnValidate();
                            begin
                                GenJnlManagement.CheckName(BatchName, GenJnlLine);
                            end;
                        }
                    }
                    field(DimChange; DimChange)
                    {
                        Caption = 'Dimension Value Change';

                        trigger OnValidate();
                        begin
                            UpdateRequestPage();
                        end;
                    }
                    group(Control1000000009)
                    {
                        Visible = DimVisible;
                        field(GlobalDim1; GlobalDim1)
                        {
                            CaptionClass = '1,2,1';
                            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

                            trigger OnLookup(Text: Text): Boolean;
                            begin
                                DimMgt.LookupDimValueCode(1, GlobalDim1);
                                DimMgt.ValidateShortcutDimValues(1, GlobalDim1, DimSetID);
                            end;

                            trigger OnValidate();
                            begin
                                DimMgt.ValidateShortcutDimValues(1, GlobalDim1, DimSetID);
                            end;
                        }
                        field(GlobalDim2; GlobalDim2)
                        {
                            CaptionClass = '1,2,2';
                            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

                            trigger OnLookup(Text: Text): Boolean;
                            begin
                                DimMgt.LookupDimValueCode(2, GlobalDim2);
                                DimMgt.ValidateShortcutDimValues(2, GlobalDim2, DimSetID);
                            end;

                            trigger OnValidate();
                            begin
                                DimMgt.ValidateShortcutDimValues(2, GlobalDim2, DimSetID);
                            end;
                        }
                        field(DimSetID; DimSetID)
                        {
                            Caption = 'Dimension Set ID';
                            Editable = false;

                            trigger OnLookup(Text: Text): Boolean;
                            begin
                                DimSetID := DimMgt.EditDimensionSet2(DimSetID, '', GlobalDim1, GlobalDim2);
                            end;
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            UpdateRequestPage();
        end;
    }

    labels
    {
    }

    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlLineFirstLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlManagement: Codeunit GenJnlManagement;
        DimMgt: Codeunit DimensionManagement;
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        [InDataSet]
        FillVisible: Boolean;
        [InDataSet]
        DimVisible: Boolean;
        PostingDate: Date;
        NewCustNo: Code[20];
        NewPostingGroup: Code[20];
        Correction: Boolean;
        RepostType: Option Post,Fill;
        TemplateName: Code[10];
        BatchName: Code[10];
        DimChange: Boolean;
        GlobalDim1: Code[20];
        GlobalDim2: Code[20];
        DimSetID: Integer;
        LineNo: Integer;
        SelectCustomerCustomerPostingGroupErr: Label 'Select New Customer No. or New Customer Posting Group or define New Dimension Values.';
        UndefinedDimensionValueErr: Label 'Define dimension values when Dimension Value Change is selected.';
        NoDifferenceInLedgerEntryErr: Label 'There are no differences in Customer No., Customer Posting Group or Dimension Values on Ledger Entry No. %1.';
        JournalLinesFilledMsg: Label 'The journal lines were successfully filled.';
        LineCounter: Integer;
        JournalLinesPostedMsg: Label 'The journal lines were successfully posted.';
        DocumentTypeNotAallowedErr: Label '%1 is not allowed Document Type for reposting.';
        RepostingCLENotAllowedPostedErr: Label 'You can not repost customer ledger entry with Document No. %1 due to existing Posted %2.';
        RepostingCLENotAllowedServiceErr: Label 'You can not repost customer ledger entry with Document No. %1 due to existing Service %2.';
        ApplyAmount: Decimal;
        OnlyOneCustomerLedgerEntryErr: Label 'Only one Customer Ledger Entry must be selected when Apply Amount is defined.';
        DescSameAsName: Boolean;

    procedure UpdateRequestPage();
    begin
        FillVisible := RepostType = RepostType::Fill;
        FillVisible := true;
        DimVisible := DimChange;
    end;

    procedure LookupBatch();
    var
        GenJnlBatch: Record "Gen. Journal Batch";
    begin
        GenJnlBatch.FILTERGROUP(2);
        GenJnlBatch.SETRANGE("Journal Template Name", TemplateName);
        GenJnlBatch.FILTERGROUP(0);
        if PAGE.RUNMODAL(0, GenJnlBatch) = ACTION::LookupOK then
            BatchName := GenJnlBatch.Name;
    end;

    local procedure InsertOriginalDocAndVatAmount(DocumentNo: Code[20]; EntryNo: Integer);
    var
        VATEntry: Record "VAT Entry";
        CustLedgerEntryExtData: Record "Cust.Ledger Entry ExtData-Adl";
        CustLedgerEntryExtData2: Record "Cust.Ledger Entry ExtData-Adl";
        InvoiceAmount: Decimal;
        VATAmount: Decimal;
        CustLedgerEntryExtDataLineNo: Integer;
    begin
        VATEntry.RESET();
        VATEntry.SETCURRENTKEY("Document No.", "Posting Date");
        VATEntry.SETRANGE(Type, VATEntry.Type::Sale);
        VATEntry.SETFILTER("Document No.", "Cust. Ledger Entry"."Document No.");
        VATAmount := 0;
        InvoiceAmount := 0;
        if VATEntry.FINDSET() then
            repeat
                InvoiceAmount := InvoiceAmount - VATEntry.Base;
                VATAmount := VATAmount - VATEntry.Amount;
            until VATEntry.NEXT() = 0
        else begin
            if CustLedgerEntryExtData.GET(EntryNo, false) then begin
                InvoiceAmount := CustLedgerEntryExtData."Original Document Amount (LCY)";
                VATAmount := CustLedgerEntryExtData."Original VAT Amount (LCY)";
            end;
            InvoiceAmount := InvoiceAmount - VATAmount;
        end;

        if InvoiceAmount <> 0 then begin
            CustLedgerEntryExtData.RESET();
            CustLedgerEntryExtData.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
            CustLedgerEntryExtData.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            CustLedgerEntryExtData.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            CustLedgerEntryExtData.SETRANGE("Line No.", GenJnlLine."Line No.");
            if CustLedgerEntryExtData.FINDFIRST() then begin
                CustLedgerEntryExtData."Original Document Amount (LCY)" := InvoiceAmount + VATAmount;
                CustLedgerEntryExtData.MODIFY();
            end else begin
                CustLedgerEntryExtData2.RESET();
                CustLedgerEntryExtData2.SETRANGE("Is Journal Line", true);
                if CustLedgerEntryExtData2.FINDLAST() then
                    CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                else
                    CustLedgerEntryExtDataLineNo := 1;
                CustLedgerEntryExtData2.RESET();
                CustLedgerEntryExtData2.INIT();
                CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                CustLedgerEntryExtData2."Is Journal Line" := true;
                CustLedgerEntryExtData2."Journal Template Name" := GenJnlLine."Journal Template Name";
                CustLedgerEntryExtData2."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                CustLedgerEntryExtData2."Line No." := GenJnlLine."Line No.";
                CustLedgerEntryExtData2."Original Document Amount (LCY)" := InvoiceAmount + VATAmount;
                CustLedgerEntryExtData2.INSERT();
            end;
        end;

        if VATAmount <> 0 then begin
            CustLedgerEntryExtData.RESET();
            CustLedgerEntryExtData.SETCURRENTKEY("Journal Template Name", "Journal Batch Name", "Line No.");
            CustLedgerEntryExtData.SETRANGE("Journal Template Name", GenJnlLine."Journal Template Name");
            CustLedgerEntryExtData.SETRANGE("Journal Batch Name", GenJnlLine."Journal Batch Name");
            CustLedgerEntryExtData.SETRANGE("Line No.", GenJnlLine."Line No.");
            if CustLedgerEntryExtData.FINDFIRST() then begin
                CustLedgerEntryExtData."Original VAT Amount (LCY)" := VATAmount;
                CustLedgerEntryExtData.MODIFY();
            end else begin
                CustLedgerEntryExtData2.RESET();
                CustLedgerEntryExtData2.SETRANGE("Is Journal Line", true);
                if CustLedgerEntryExtData2.FINDLAST() then
                    CustLedgerEntryExtDataLineNo := CustLedgerEntryExtData2."Entry No." + 1
                else
                    CustLedgerEntryExtDataLineNo := 1;
                CustLedgerEntryExtData2.RESET();
                CustLedgerEntryExtData2.INIT();
                CustLedgerEntryExtData2."Entry No." := CustLedgerEntryExtDataLineNo;
                CustLedgerEntryExtData2."Is Journal Line" := true;
                CustLedgerEntryExtData2."Journal Template Name" := GenJnlLine."Journal Template Name";
                CustLedgerEntryExtData2."Journal Batch Name" := GenJnlLine."Journal Batch Name";
                CustLedgerEntryExtData2."Line No." := GenJnlLine."Line No.";
                CustLedgerEntryExtData2."Original VAT Amount (LCY)" := VATAmount;
                CustLedgerEntryExtData2.INSERT();
            end;
        end;
    end;
}

