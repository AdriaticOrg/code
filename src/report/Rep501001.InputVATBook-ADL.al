report 50101 "Input VAT Book-adl"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vat Entry";"VAT Entry")
        {
            DataItemTableView = SORTING("Entry No.") WHERE("Type"=filter(Purchase|Sale),"Unrealized Amount"=Filter(0));   //,"VAT Identifier"=filter('<>*99*'));
            RequestFilterFields = "Vat Date","Document No.";
            dataitem(GLAccountBal;"G/L Account")
            {
                //DataItemLink = "No."=FIELD("No.");
                column(GLAccountNoBal;"No.")
                {
                    
                }

                trigger OnPreDataItem();
                begin

                end;

                trigger OnAfterGetRecord()
                begin
                    //TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 1, FieldDelimiter);
                end;

                trigger OnPostDataItem()
                begin
                    Type:= '';
                    TextWriterAdl.NewLine(OutStr);
                end;
            }
            dataitem(GLEntryTrans;"G/L Entry")
            {
                DataItemLink = "G/L Account No."=FIELD("No.");
                column(GLAccountNoTrans;"G/L Account No.")
                {
                }

                trigger OnPreDataItem();
                begin
                    GLAccountZak.SETRANGE("Date Filter", "G/L Account"."Date Filter");
                end;

                trigger OnAfterGetRecord()
                begin
                    //TextWriterAdl.FixedField(OutStr, "G/L Account No.", 10, PadCharacter, 1, FieldDelimiter);
                end;

                trigger OnPostDataItem()
                begin
                    TextWriterAdl.NewLine(OutStr);
                end;
            }
            dataitem(GLAccountZAK;"G/L Account")
            {
                DataItemLink = "No."=FIELD("No.");                
                column(GLAccountNoZAK;"No.")
                {
                }
                column(GLAccountNameZAK;Name)
                {
                }
                column(PostingDateZAK;DummyText)
                {
                }
                column(DocumentDateZAK;DummyText)
                {
                }
                column(DocumentNoZAK;DummyText)
                {
                }
                column(TypeZAK;Type)
                {
                }
                column(DescriptionZAK;DummyText)
                {
                }
                column(DebitAmtZAK;"Debit Amount")
                {
                }
                column(CreditAmtZAK;"Credit Amount")
                {
                }
                column(NoteZAK;DummyText)
                {
                }

                trigger OnPreDataItem()
                begin  

                end;

                trigger OnAfterGetRecord()
                begin
                    //TextWriterAdl.FixedField(OutStr, "No.", 10, PadCharacter, 1, FieldDelimiter);
                end;

                trigger OnPostDataItem()
                begin
                    TextWriterAdl.NewLine(OutStr);
                end;
            }

            trigger OnPreDataItem()
            begin
                FieldDelimiter:= '';
                //TextWriterAdl.FixedField(OutStr, AccountNoLbl, 11, PadCharacter, 1, FieldDelimiter);
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
        FileName:= 'IZPIS ODBITKA DDV.TXT';
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
        BalanceAtDate: Decimal;
        DummyText : Text;
        BalanceYear: Integer;
        ClosingYear: Integer;
        BalanceDesc : Label 'Opening item for the year %1';
        BalanceDocumentNo : Label 'Opening %1';
        ClosingDesc : Label 'Closing GL account for the year %1';
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

