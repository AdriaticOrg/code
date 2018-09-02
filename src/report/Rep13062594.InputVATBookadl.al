report 13062594 "Input VAT Book-adl"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Vat Entry";"VAT Entry")
        {
            DataItemTableView = SORTING("Document No.");
            RequestFilterFields = "Posting Date","Document No.","VAT Bus. Posting Group","VAT Prod. Posting Group","Gen. Bus. Posting Group","Gen. Prod. Posting Group","VAT Identifier-adl","VAT Calculation Type","Country/Region Code","Entry No.","Bill-to/Pay-to No.","External Document No.";
            MaxIteration = 1;
            // TODO: "Document Receipt Date"

            dataitem("VatEntry2";"VAT Entry")
            {    
                DataItemLink = "Entry No."=field("Entry No.");

                trigger OnPreDataItem()
                var 
                    Counter: Integer;
                begin
                    VATEntry2.CopyFilters("Vat Entry");

                    //prepare header names from setup
                    VATBook.SetRange("Tag Name", 'Input VAT Book');  //TODO: maybe Setup  
                    if VATBook.FindFirst then
                        VATBookColumnName.SetRange("VAT Book Code", VATBook.Code);
                    Counter:= 1;
                    if VATBookColumnName.FindSet then
                        repeat
                            VATBookColumnNo[Counter]:= VATBookColumnName."Column No.";
                            VATBookColumnLengt[Counter]:= VATBookColumnName."Fixed text length";
                            TextWriterAdl.FixedField(OutStr, VATBookColumnName.Description, VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter);
                            Counter+= 1;
                        until VATBookColumnName.Next = 0; 

                    TextWriterAdl.NewLine(OutStr);            
                end;


                trigger OnAfterGetRecord()
                var 
                    ColumnVal: Integer;
                begin          
                    SetRange("Document No.", "Document No.");
                    //setrange(Type, Type::Purchase);
                    FindLast();

                    //Column 1
                    ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnNo[1], '0D'); 
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[1], PadCharacter, 1, FieldDelimiter);

                    //Column 2
                    setrange(Type, Type::Sale);
                    ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnNo[2], '0D'); 
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[2], PadCharacter, 1, FieldDelimiter);

                    //Column 3
                    setrange(Type, Type::Sale);
                    ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnNo[3], '0D'); 
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[3], PadCharacter, 1, FieldDelimiter);

                    //Column 4
                    setrange(Type, Type::Sale);
                    ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnNo[4], '0D'); 
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[4], PadCharacter, 1, FieldDelimiter);

                    //Column 5
                    setrange(Type, Type::Sale);
                    ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnNo[5], '0D'); 
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[5], PadCharacter, 1, FieldDelimiter);

                    //Column 6
                    setrange(Type, Type::Sale);
                    ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, VATBookColumnNo[6], '0D'); 
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[6], PadCharacter, 1, FieldDelimiter);


                    setrange("Document No.");
                    TextWriterAdl.NewLine(OutStr);
                end;
            }      
                
                

            trigger OnPostDataItem()
            begin 
                //TextWriterAdl.NewLine(OutStr);
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
        VATBook: Record "VAT Book-Adl";
        VATBookGroup: Record "VAT Book Group-Adl";
        VATBookColumnName: Record "VAT Book Column Name-Adl";
        TextWriterAdl: Codeunit "TextWriter-adl";
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        OutStr: OutStream;
        VATBookColumnNo: array[20] of Integer;
        VATBookColumnLengt: array[20] of integer;
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

