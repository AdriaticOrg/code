report 13062731 "Detail Trial Balance-Adl"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep13062731.DetailTrialBalanceAdl.rdlc';
    Caption = 'Detail Trial Balance';
    PreviewMode = PrintLayout;
    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE ("Account Type" = CONST (Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(PeriodGLDtFilter; STRSUBSTNO(PeriodLbl, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TABLECAPTION() + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            column(PostingUserCaption; PostingUserLbl)
            {
            }
            column(PostingRespPersonCaption; PostingRespPersonLbl)
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING (Number) WHERE (Number = CONST (1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = FIELD ("No."), "Posting Date" = FIELD ("Date Filter"), "Global Dimension 1 Code" = FIELD ("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"), "Business Unit Code" = FIELD ("Business Unit Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING ("G/L Account No.", "Posting Date");
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; FORMAT("Posting Date"))
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(ExtDocNo_GLEntry; "External Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_GLEntry; Description)
                    {
                    }
                    column(GLBalance; GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "Entry No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    column(UserID_GLEntry; "User ID")
                    {
                    }
                    column(PostingResponsibleAndApproverUserID; PostingResponsiblePersonUserID + ', ' + PostingApproverUserID)
                    {
                    }
                    trigger OnAfterGetRecord();
                    var
                        ApproverUserSetup: Record "User Setup";
                        UserSetup: Record "User Setup";
                    begin
                        if PrintOnlyCorrections then
                            if not (("Debit Amount" < 0) or ("Credit Amount" < 0)) then
                                CurrReport.SKIP();
                        if not PrintReversedEntries and Reversed then
                            CurrReport.SKIP();
                        GLBalance := GLBalance + Amount;
                        if ("Posting Date" = CLOSINGDATE("Posting Date")) and
                           not PrintClosingEntries
                        then begin
                            "Debit Amount" := 0;
                            "Credit Amount" := 0;
                        end;
                        if "Posting Date" = CLOSINGDATE("Posting Date") then
                            ClosingEntry := true
                        else
                            ClosingEntry := false;
                        // <adl.27>
                        PostingResponsiblePersonUserID := GeneralLedgerSetup."Global Posting Resp. Person-Adl";
                        PostingApproverUserID := GeneralLedgerSetup."Global Posting Approver-Adl";
                        if UserSetup.GET("G/L Entry"."User ID") then
                            if UserSetup."Approver ID" <> '' then begin
                                ApproverUserSetup.GET(UserSetup."Approver ID");
                                PostingResponsiblePersonUserID := ApproverUserSetup."Posting Responsible Person-Adl";
                                PostingApproverUserID := ApproverUserSetup."Posting Approver-Adl";
                            end;
                        // </adl.27>
                    end;

                    trigger OnPreDataItem();
                    begin
                        GLBalance := StartBalance;
                    end;
                }
                trigger OnAfterGetRecord();
                begin
                end;
            }
            trigger OnAfterGetRecord();
            var
                GLEntry: Record "G/L Entry";
                Date: Record Date;
            begin
                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SETRANGE("Period Type", Date."Period Type"::Date);
                    Date.SETFILTER("Period Start", GLDateFilter);
                    if Date.FINDFIRST() then begin
                        SETRANGE("Date Filter", 0D, CLOSINGDATE(Date."Period Start" - 1));
                        CALCFIELDS("Net Change");
                        StartBalance := "Net Change";
                        SETFILTER("Date Filter", GLDateFilter);
                    end;
                end;
                if PrintOnlyOnePerPage then begin
                    GLEntry.RESET();
                    GLEntry.SETRANGE("G/L Account No.", "No.");
                    if GLEntry.FINDFIRST() then
                        PageGroupNo := PageGroupNo + 1;
                end;
            end;

            trigger OnPreDataItem();
            begin
                PageGroupNo := 1;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per G/L Acc.';
                        ToolTip = 'Specifies if each G/L account information is printed on a new page if you have chosen two or more G/L accounts to be included in the report.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for G/L accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the report to include closing entries. This is useful if the report covers an entire fiscal year. Closing entries are listed on a fictitious date between the last day of one fiscal year and the first day of the next one. They have a C before the date, such as C123194. If you do not select this field, no closing entries are shown.';
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Corrections Only';
                        ToolTip = 'Specifies if you want the report to show only the entries that have been reversed and their matching correcting entries.';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
        PostingDateCaption = 'Posting Date'; DocNoCaption = 'Document No.'; DescCaption = 'Description'; VATAmtCaption = 'VAT Amount'; EntryNoCaption = 'Entry No.';
    }
    trigger OnPreReport();
    begin
        GLFilter := "G/L Account".GETFILTERS();
        GLDateFilter := "G/L Account".GETFILTER("Date Filter");
        // <adl.27>
        GeneralLedgerSetup.GET();
        // </adl.27>
    end;

    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        PeriodLbl: Label 'Period: %1';
        GLDateFilter: Text;
        GLFilter: Text;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        PostingResponsiblePersonUserID: Code[50];
        PostingApproverUserID: Code[50];
        PostingUserLbl: Label 'Posting User';
        PostingRespPersonLbl: Label 'Posting Responsible Person';

    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean);
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;
}