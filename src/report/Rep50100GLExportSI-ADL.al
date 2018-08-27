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
                end;

                trigger OnAfterGetRecord()
                begin
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
                    TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 0);
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
            }
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
        AccountNoLbl = 'Account';NameLbl = 'Account Name';PostingDateLbl = 'Posting Date';DocumentDateLbl = 'Document Date';lDocumentNoLbl = 'Document No.';
                                                                                                                                              
        TypeLbl = 'Type';DescriptionLbl = 'Description';DebitAmountLbl = 'Debit Amount';CreditAmountLbl = 'Credit Amount';Note = 'Note';
    }

    trigger OnInitReport();
    begin
        TextWriterAdl.Create(OutStr);
        ToFilter:= '*.txt|*.TXT';
        FileName:= 'IZPIS GLAVNE KNJIGE.TXT';
        PadCharacter:= ' ';
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
        Type : Text[3];
        DummyText : Text;
}

