xmlport 50100 "GL Export SI-adl"
{
    // version NAVW112.30

    Caption = 'GLExportSI-adl';
    Direction = Export;
    //FieldDelimiter = '';
    FileName = 'IZPIS GLAVNE KNJIGE.TXT ';
    Format = FixedText;
    TableSeparator = '<<NewLine>';
    TextEncoding = WINDOWS;
    UseRequestPage = true;

    schema
    {
        textelement(root)
        {
            tableelement(Integer;Integer)
            {
                XmlName = 'Caption';
                SourceTableView = SORTING(Number) WHERE(Number=CONST(1));
                textelement(No_Lbl)
                {
                    MinOccurs = Zero;
                    Width = 10;

                    trigger OnBeforePassVariable();
                    begin
                        No_Lbl:= Text_No;
                    end;
                }
                textelement(Name_Lbl)
                {
                    MinOccurs = Zero;
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Name_Lbl:= Text_Name;
                    end;
                }
                textelement(PostingDate_Lbl)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        PostingDate_Lbl:= Text_PostingDate;
                    end;
                }
                textelement(DocumentDate_Lbl)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentDate_Lbl:= Text_DocumentDate;
                    end;
                }
                textelement(DocumentNo_Lbl)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentNo_Lbl:= Text_DocumentNo;
                    end;
                }
                textelement(Type_Lbl)
                {
                    Width = 3;

                    trigger OnBeforePassVariable();
                    begin
                        Type_Lbl:= Text_Type;
                    end;
                }
                textelement(Description_Lbl)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_Lbl:= Text_Description;
                    end;
                }
                textelement(DebitAmt_Lbl)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        DebitAmt_Lbl:= Text_DebitAmt;
                    end;
                }
                textelement(CreditAmt_Lbl)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        CreditAmt_Lbl:= Text_CreditAmt
                    end;
                }
                textelement(Note_Lbl)
                {
                    Width = 160;

                    trigger OnBeforePassVariable();
                    begin
                        Note_Lbl:= Text_Note;
                    end;
                }
            }
            tableelement(glaccount;"G/L Account")
            {
                XmlName = 'GLAccount';
                SourceTableView = SORTING("No.") WHERE("Account Type"=FILTER(Posting));
                textelement(No_Open)
                {
                    MinOccurs = Zero;
                    Width = 10;

                    trigger OnBeforePassVariable();
                    begin
                        No_Open:= GLAccount."No.";
                    end;
                }
                textelement(Name_Open)
                {
                    MinOccurs = Zero;
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Name_Open:= GLAccount.Name;
                    end;
                }
                textelement(PostingDate_open)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        //PostingDate_Trans:= FORMAT(GLEntryTrans."Posting Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentDate_open)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        //DocumentDate_Trans:= FORMAT(GLEntryTrans."Document Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentNo_open)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        //DocumentNo_Trans:= GLEntryTrans."Document No.";
                    end;
                }
                textelement(Type_open)
                {
                    Width = 3;

                    trigger OnBeforePassVariable();
                    begin
                        Type_open:= 'OTV';
                    end;
                }
                textelement(Description_open)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_open:= 'Otvoritvena postavka za leto <Year4>';
                    end;
                }
                textelement(DebitAmt_open)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        GLAccount.CALCFIELDS("Debit Amount","Balance at Date");
                        //DebitAmt_open:= FORMAT(GLAccount."Debit Amount",0,9);
                        DebitAmt_open:= FORMAT(GLAccount."Balance at Date",0,9);
                    end;
                }
                textelement(CreditAmt_open)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        GLAccount.CALCFIELDS("Credit Amount");
                        CreditAmt_open:= FORMAT(GLAccount."Credit Amount",0,9);
                    end;
                }
                textelement(Note_open)
                {
                    Width = 160;

                    trigger OnBeforePassVariable();
                    begin
                        //Note_Trans:= FORMAT(GLEntryTrans."Entry No.");
                    end;
                }

                trigger OnPreXmlItem();
                begin
                    if AccountNo <>'' then
                      GLAccount.SETRANGE("No.", AccountNo);

                    if (FromDate <>0D) and (ToDate <>0D) then
                      GLAccount.SETFILTER("Date Filter", '..%1', CLOSINGDATE(ToDate))
                    else if (FromDate <>0D) and (ToDate =0D) then
                      GLAccount.SETFILTER("Date Filter", '..%1', CLOSINGDATE(FromDate));
                    GLAccount.SETFILTER("Balance at Date", '<>0');
                end;
            }
            tableelement(glentrytrans;"G/L Entry")
            {
                XmlName = 'GLEntryTrans';
                SourceTableView = SORTING("Entry No.");
                textelement(No_Trans)
                {
                    MinOccurs = Zero;
                    Width = 10;

                    trigger OnBeforePassVariable();
                    begin
                        No_Trans:= GLEntryTrans."G/L Account No.";
                    end;
                }
                textelement(Name_Trans)
                {
                    MinOccurs = Zero;
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        GLEntryTrans.CALCFIELDS("G/L Account Name");
                        Name_Trans:= GLEntryTrans."G/L Account Name";
                    end;
                }
                textelement(PostingDate_Trans)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        PostingDate_Trans:= FORMAT(GLEntryTrans."Posting Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentDate_Trans)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentDate_Trans:= FORMAT(GLEntryTrans."Document Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentNo_Trans)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentNo_Trans:= GLEntryTrans."Document No.";
                    end;
                }
                textelement(Type_Trans)
                {
                    Width = 3;
                }
                textelement(Description_Trans)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_Trans:= GLEntryTrans.Description;
                    end;
                }
                textelement(DebitAmt_Trans)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        DebitAmt_Trans:= FORMAT(GLEntryTrans."Debit Amount",0,9);
                    end;
                }
                textelement(CreditAmt_Trans)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        CreditAmt_Trans:= FORMAT(GLEntryTrans."Credit Amount",0,9);
                    end;
                }
                textelement(Note_Trans)
                {
                    Width = 160;

                    trigger OnBeforePassVariable();
                    begin
                        Note_Trans:= FORMAT(GLEntryTrans."Entry No.");
                    end;
                }

                trigger OnPreXmlItem();
                begin
                    if (FromDate <>0D) and (ToDate <>0D) then
                      GLEntryTrans.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate)
                    else
                      GLEntryTrans.SETRANGE("Posting Date", FromDate);
                    GLEntryTrans.SETFILTER("G/L Account No.", '%1', AccountNo);
                end;
            }
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field(FromDate;FromDate)
                {
                    Caption = 'From Date';
                }
                field(ToDate;ToDate)
                {
                    Caption = 'To Date';
                }
                field(AccountNo;AccountNo)
                {
                    Caption = 'Account No.';
                    TableRelation = "G/L Account"."No.";
                }
            }
        }

        actions
        {
        }
    }

    var
        Text_No : Label 'No.';
        Text_Name : Label 'Name';
        Text_PostingDate : Label 'Posting Date';
        Text_DocumentDate : Label 'Document Date';
        Text_DocumentNo : Label '"Document No "';
        Text_Type : Label 'Type';
        Text_Description : Label 'Description';
        Text_DebitAmt : Label 'Debit Amount';
        Text_CreditAmt : Label 'Credit Amount';
        Text_Note : Label 'Note';
        FromDate : Date;
        ToDate : Date;
        AccountNo : Code[20];
}

