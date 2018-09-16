report 13062595 "GL ExportSI-Adl"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING ("No.") WHERE ("Account Type" = FILTER (Posting));
            RequestFilterFields = "No.", "Date Filter";
            dataitem(GLAccountBal; "G/L Account")
            {
                DataItemLink = "No." = FIELD ("No.");
                column(GLAccountNoBal; "No.")
                {

                }
                column(GLAccountNameBal; Name)
                {
                }
                column(PostingDateBal; DummyText)
                {
                }
                column(DocumentDateBal; DummyText)
                {
                }
                column(DocumentNoBal; DummyText)
                {
                }
                column(TypeBal; Type)
                {
                }
                column(DescriptionBal; DummyText)
                {
                }
                column(DebitAmtBal; "Debit Amount")
                {
                }
                column(CreditAmtBal; "Credit Amount")
                {
                }
                column(NoteBal; DummyText)
                {
                }

                trigger OnPreDataItem();
                begin
                    GLAccountBal.SETFILTER("Date Filter", '..%1', "G/L Account".GetrangeMIN("Date Filter"));
                    GLAccountBal.setfilter("Balance at Date", '<>%1', 0);
                    CalcFields("Balance at Date");
                    BalanceAtDate := GLAccountBal."Balance at Date";
                    BalanceYear := Date2DMY("G/L Account".GetrangeMIN("Date Filter"), 3);
                    Type := 'OTV';
                    IF (BalanceAtDate = 0) then
                        CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Name, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, BalanceDocumentNo, 30, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Type, 3, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, StrSubstNo(BalanceDesc, BalanceYear), 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, BalanceAtDate, 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 160, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.NewLine(OutStr);
                end;

                trigger OnPostDataItem()
                begin
                    Type := '';
                    TextWriterAdl.NewLine(OutStr);
                end;
            }
            dataitem(GLEntryTrans; "G/L Entry")
            {
                DataItemLink = "G/L Account No." = FIELD ("No.");
                column(GLAccountNoTrans; "G/L Account No.")
                {
                }
                column(GLAccountNameTrans; "G/L Account Name")
                {
                }
                column(PostingDateTrans; "Posting Date")
                {
                }
                column(DocumentDateTrans; "Document Date")
                {
                }
                column(DocumentNoTrans; "Document No.")
                {
                }
                column(TypeTrans; Type)
                {
                }
                column(DescriptionTrans; Description)
                {
                }
                column(DebitAmtTrans; "Debit Amount")
                {
                }
                column(CreditAmtTrans; "Credit Amount")
                {
                }
                column(NoteTrans; "Entry No.")
                {
                }

                trigger OnPreDataItem();
                begin
                    GLAccountZak.SETRANGE("Date Filter", "G/L Account"."Date Filter");
                end;

                trigger OnAfterGetRecord()
                begin
                    TextWriterAdl.FixedField(OutStr, "G/L Account No.", 10, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "G/L Account Name", 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Posting Date", 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Document Date", 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Document No.", 30, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Type, 3, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Description, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Debit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Credit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Entry No.", 160, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.NewLine(OutStr);
                end;

                trigger OnPostDataItem()
                begin
                    //TextWriterAdl.NewLine(OutStr);
                end;
            }
            dataitem(GLAccountZAK; "G/L Account")
            {
                DataItemLink = "No." = FIELD ("No.");
                column(GLAccountNoZAK; "No.")
                {
                }
                column(GLAccountNameZAK; Name)
                {
                }
                column(PostingDateZAK; DummyText)
                {
                }
                column(DocumentDateZAK; DummyText)
                {
                }
                column(DocumentNoZAK; DummyText)
                {
                }
                column(TypeZAK; Type)
                {
                }
                column(DescriptionZAK; DummyText)
                {
                }
                column(DebitAmtZAK; "Debit Amount")
                {
                }
                column(CreditAmtZAK; "Credit Amount")
                {
                }
                column(NoteZAK; DummyText)
                {
                }

                trigger OnPreDataItem()
                begin
                    GLAccountZAK.SETFILTER("Date Filter", '%1', CLOSINGDATE("G/L Account".GetRangeMax("Date Filter")));
                    CalcFields("Debit Amount", "Credit Amount");
                    ClosingYear := Date2DMY(CLOSINGDATE("G/L Account".GetRangeMax("Date Filter")), 3);
                    Type := 'ZAK';
                    IF ("Debit Amount" = 0) AND ("Credit Amount" = 0) then
                        CurrReport.Break();
                end;

                trigger OnAfterGetRecord()
                begin
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Name, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 30, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Type, 3, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, StrSubstNo(ClosingDesc, ClosingYear), 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Debit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Credit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 160, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.NewLine(OutStr);
                end;

                trigger OnPostDataItem()
                begin
                    //TextWriterAdl.NewLine(OutStr);
                    Type := '';
                end;
            }

            trigger OnPreDataItem()
            begin
                FieldDelimiter := '';
                TextWriterAdl.FixedField(OutStr, AccountNoLbl, 11, PadCharacter, 1, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, NameLbl, 51, PadCharacter, 1, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, PostingDateLbl, 9, PadCharacter, 0, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, DocumentDateLbl, 9, PadCharacter, 0, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, DocumentNoLbl, 31, PadCharacter, 1, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, TypeLbl, 4, PadCharacter, 1, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, DescriptionLbl, 51, PadCharacter, 1, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, DebitAmountLbl, 17, PadCharacter, 0, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, CreditAmountLbl, 17, PadCharacter, 0, FieldDelimiter);
                TextWriterAdl.FixedField(OutStr, NoteLbl, 161, PadCharacter, 1, FieldDelimiter);
                FieldDelimiter := ';';
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        TextWriterAdl.Create(OutStr);
        ToFilter := '*.txt|*.TXT';
        FileName := 'IZPIS GLAVNE KNJIGE.TXT';
        DialogTitle := 'Save to';
        PadCharacter := ' ';
        FieldDelimiter := ';';
        DummyText := ' ';
    end;

    trigger OnPostReport()
    begin
        TextWriterAdl.Download(DialogTitle, ToFilter, FileName);
    end;

    var
        TextWriterAdl: Codeunit "TextWriter-Adl";
        OutStr: OutStream;
        FileName: Text;
        ToFilter: Text;
        DialogTitle: Text;
        PadCharacter: Text[1];
        FieldDelimiter: Text[1];
        Type: Text[3];
        BalanceAtDate: Decimal;
        DummyText: Text;
        BalanceYear: Integer;
        ClosingYear: Integer;
        BalanceDesc: Label 'Opening item for the year %1';
        BalanceDocumentNo: Label 'Opening %1';
        ClosingDesc: Label 'Closing GL account for the year %1';
        AccountNoLbl: Label 'Account';
        NameLbl: Label 'Account Name';
        PostingDateLbl: Label 'Post.Date';
        DocumentDateLbl: Label 'Doc.Date';
        DocumentNoLbl: Label 'Document No.';
        TypeLbl: Label 'Type';
        DescriptionLbl: Label 'Description';
        DebitAmountLbl: Label 'Debit Amount';
        CreditAmountLbl: Label 'Credit Amount';
        NoteLbl: Label 'Note';
}

