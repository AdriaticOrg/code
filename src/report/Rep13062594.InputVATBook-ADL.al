report 13062594 "Input VAT Book-adl"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vat Entry";"VAT Entry")
        {
            DataItemTableView = SORTING("Document No.") WHERE("Type"=filter(Purchase|Sale),"Unrealized Amount"=Filter(0)); //,"VAT Identifier-adl"=filter('<>*99*'));
            RequestFilterFields = "Document No.","VAT Bus. Posting Group","VAT Prod. Posting Group","Gen. Bus. Posting Group","Gen. Prod. Posting Group","Posting Date","VAT Calculation Type","Country/Region Code","Entry No.","Bill-to/Pay-to No.","External Document No.";  //"Document Receipt Date";
            dataitem(PurchaseInvHeader;"Purch. Inv. Header")
            {
                DataItemLink = "No."=FIELD("Document No.");
                column(PurchaseInvHeader;"No.")
                {
                    //TODO::
                }   
            }
         
            trigger OnPreDataItem()
            begin
                FieldDelimiter:= '';
                TextWriterAdl.NewLine(OutStr);
                FieldDelimiter:= ';';
            end;

            trigger OnAfterGetRecord()
            begin
                 TextWriterAdl.FixedField(OutStr, "Document No.", 10, PadCharacter, 1, FieldDelimiter);
            end;

            trigger OnPostDataItem()
            begin
                TextWriterAdl.NewLine(OutStr);
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
