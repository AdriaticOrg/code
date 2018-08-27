report 50100 "GL ExportSI-adl"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Account";"G/L Account")
        {
            DataItemTableView = SORTING("No.") WHERE("Account Type"=FILTER(Posting));
            RequestFilterFields = "No.","Date Filter";
            dataitem(GLAccountOpen;"G/L Account")
            {
                DataItemLink = "No."=FIELD("No.");
                column(GLAccountNoOpen;"No.")
                {
                    
                }
                column(GLAccountNameOpen;Name)
                {
                }
                column(PostingDateOpen;DummyText)
                {
                }
                column(DocumentDateOpen;DummyText)
                {
                }
                column(DocumentNoOpen;DummyText)
                {
                }
                column(TypeOpen;Type)
                {
                }
                column(DescriptionOpen;DummyText)
                {
                }
                column(DebitAmtOpen;"Debit Amount")
                {
                }
                column(CreditAmtOpen;"Credit Amount")
                {
                }
                column(NoteOpen;DummyText)
                {
                }

                trigger OnPreDataItem();
                begin
                    GLAccountOpen.SETFILTER("Date Filter", '%1', CLOSINGDATE("G/L Account".GETRANGEMAX("Date Filter")));
                    GLAccountOpen.setfilter("Balance at Date", '<>%1', 0);

                    CalcFields("Debit Amount", "Credit Amount");
                end;

                trigger OnAfterGetRecord()
                begin
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Name, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 30, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Type, 3, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Debit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Credit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 160, PadCharacter, 1, FieldDelimiter);
                end;

                trigger OnPostDataItem()
                begin
                    TextWriterAdl.NewLine(OutStr);
                end;
            }
            dataitem(GLEntryTrans;"G/L Entry")
            {
                DataItemLink = "G/L Account No."=FIELD("No.");
                column(GLAccountNoTrans;"G/L Account No.")
                {
                }
                column(GLAccountNameTrans;"G/L Account Name")
                {
                }
                column(PostingDateTrans;"Posting Date")
                {
                }
                column(DocumentDateTrans;"Document Date")
                {
                }
                column(DocumentNoTrans;"Document No.")
                {
                }
                column(TypeTrans;Type)
                {
                }
                column(DescriptionTrans;Description)
                {
                }
                column(DebitAmtTrans;"Debit Amount")
                {
                }
                column(CreditAmtTrans;"Credit Amount")
                {
                }
                column(NoteTrans;"Entry No.")
                {
                }

                trigger OnPreDataItem();
                begin
                    GLAccountOpen.SETRANGE("Date Filter", "G/L Account"."Date Filter");
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
                end;

                trigger OnPostDataItem()
                begin
                    TextWriterAdl.NewLine(OutStr);
                end;
            }
            dataitem(GLAccountBalance;"G/L Account")
            {
                DataItemLink = "No."=FIELD("No.");                
                column(GLAccountNoBalance;"No.")
                {
                }
                column(GLAccountNameBalance;Name)
                {
                }
                column(PostingDateBalance;DummyText)
                {
                }
                column(DocumentDateBalance;DummyText)
                {
                }
                column(DocumentNoBalance;DummyText)
                {
                }
                column(TypeBalance;Type)
                {
                }
                column(DescriptionBalance;DummyText)
                {
                }
                column(DebitAmtBalance;"Debit Amount")
                {
                }
                column(CreditAmtBalance;"Credit Amount")
                {
                }
                column(NoteBalance;DummyText)
                {
                }

                trigger OnPreDataItem()
                begin
                    CalcFields("Debit Amount", "Credit Amount");
                end;

                trigger OnAfterGetRecord()
                begin
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Name, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 8, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 30, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, Type, 3, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 50, PadCharacter, 1, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Debit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, "Credit Amount", 16, PadCharacter, 0, FieldDelimiter);
                    TextWriterAdl.FixedField(OutStr, DummyText, 160, PadCharacter, 1, FieldDelimiter);
                end;

                trigger OnPostDataItem()
                begin
                    TextWriterAdl.NewLine(OutStr);
                end;
            }

            trigger OnPreDataItem()
            begin
                FieldDelimiter:= '';
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
                TextWriterAdl.NewLine(OutStr);
                FieldDelimiter:= ';';
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
        ToFilter:= '*.txt|*.TXT';
        FileName:= 'IZPIS GLAVNE KNJIGE.TXT';
        DialogTitle:= 'Save to';
        PadCharacter:= ' ';
        FieldDelimiter:= ';';
        DummyText:= ' ';
    end;

    trigger OnPostReport()
    begin
        TextWriterAdl.Download(DialogTitle, ToFilter, FileName);
    end;

    var
        TextWriterAdl: Codeunit "TextWriter-adl";
        OutStr: OutStream;
        FileName: Text;
        ToFilter: Text;
        DialogTitle: Text;
        PadCharacter: Text[1];
        FieldDelimiter: Text[1];
        Type : Text[3];
        DummyText : Text;
        
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

