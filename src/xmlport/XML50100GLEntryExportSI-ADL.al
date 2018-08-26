xmlport 60000 "GLExportSI-adl"
{
    // version NAVW112.30

    Caption = 'GLExportSI-adl';
    Direction = Export;
    FieldDelimiter = '<>';
    FileName = 'IZPIS GLAVNE KNJIGE.TXT ';
    Format = VariableText;
    TableSeparator = '<NewLine>';
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
                        No_Lbl:=
                          StringConversionManagement.GetPaddedString(
                            Text_No,
                            10,
                            ' ',
                            1);
                    end;
                }
                textelement(Name_Lbl)
                {
                    MinOccurs = Zero;
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Name_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_Name,
                            50,
                            ' ',
                            1);
                    end;
                }
                textelement(PostingDate_Lbl)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        PostingDate_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_PostingDate,
                            8,
                            ' ',
                            1);
                    end;
                }
                textelement(DocumentDate_Lbl)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentDate_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_DocumentDate,
                            8,
                            ' ',
                            1);
                    end;
                }
                textelement(DocumentNo_Lbl)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentNo_Lbl:=
                          StringConversionManagement.GetPaddedString(
                            Text_DocumentNo,
                            30,
                            ' ',
                            1);
                    end;
                }
                textelement(Type_Lbl)
                {
                    Width = 3;

                    trigger OnBeforePassVariable();
                    begin
                        Type_Lbl:=
                          StringConversionManagement.GetPaddedString(
                            Text_Type,
                            3,
                            ' ',
                            1);
                    end;
                }
                textelement(Description_Lbl)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_Description,
                            50,
                            ' ',
                            1);
                    end;
                }
                textelement(DebitAmt_Lbl)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        DebitAmt_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_DebitAmt,
                            16,
                            ' ',
                            1);
                    end;
                }
                textelement(CreditAmt_Lbl)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        CreditAmt_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_CreditAmt,
                            16,
                            ' ',
                            1);
                    end;
                }
                textelement(Note_Lbl)
                {
                    Width = 160;

                    trigger OnBeforePassVariable();
                    begin
                        Note_Lbl:=
                         StringConversionManagement.GetPaddedString(
                            Text_Note,
                            160,
                            ' ',
                            1);
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
                textelement(PostingDate_Open)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        //PostingDate_Trans:= FORMAT(GLEntryTrans."Posting Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentDate_Open)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        //DocumentDate_Trans:= FORMAT(GLEntryTrans."Document Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentNo_Open)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        //DocumentNo_Trans:= GLEntryTrans."Document No.";
                    end;
                }
                textelement(Type_Open)
                {
                    Width = 3;

                    trigger OnBeforePassVariable();
                    begin
                        Type_Open:= 'OTV';
                    end;
                }
                textelement(Description_Open)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_Open:= 'Otvoritvena postavka za leto <Year4>';
                    end;
                }
                textelement(DebitAmt_Open)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        GLAccount.CALCFIELDS("Debit Amount","Balance at Date");
                        //DebitAmt_open:= FORMAT(GLAccount."Debit Amount",0,9);
                        DebitAmt_Open:= FORMAT(GLAccount."Balance at Date",0,9);
                    end;
                }
                textelement(CreditAmt_Open)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        GLAccount.CALCFIELDS("Credit Amount");
                        CreditAmt_Open:= FORMAT(GLAccount."Credit Amount",0,9);
                    end;
                }
                textelement(Note_Open)
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
                        No_Trans:=
                          StringConversionManagement.GetPaddedString(
                            GLEntryTrans."G/L Account No.",
                            10,
                            ' ',
                            1);
                    end;
                }
                textelement(Name_Trans)
                {
                    MinOccurs = Zero;
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        GLEntryTrans.CALCFIELDS("G/L Account Name");
                        Name_Trans:=
                          StringConversionManagement.GetPaddedString(
                            GLEntryTrans."G/L Account Name",
                            50,
                            ' ',
                            1);
                    end;
                }
                textelement(PostingDate_Trans)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        PostingDate_Trans:=
                          StringConversionManagement.GetPaddedString(
                            FORMAT(GLEntryTrans."Posting Date",0,'<day,2><month,2><year,2>'),
                            8,
                            ' ',
                            0);
                    end;
                }
                textelement(DocumentDate_Trans)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentDate_Trans:=
                          StringConversionManagement.GetPaddedString(
                            FORMAT(GLEntryTrans."Document Date",0,'<day,2><month,2><year,2>'),
                            8,
                            ' ',
                            0);
                    end;
                }
                textelement(DocumentNo_Trans)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        DocumentNo_Trans:=
                         StringConversionManagement.GetPaddedString(
                            GLEntryTrans."Document No.",
                            3,
                            ' ',
                            1);
                    end;
                }
                textelement(Type_Trans)
                {
                    Width = 3;

                    trigger OnBeforePassVariable();
                    begin
                        Type_Trans :=
                         StringConversionManagement.GetPaddedString(
                            '',
                            3,
                            ' ',
                            1);
                    end;
                }
                textelement(Description_Trans)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_Trans:=
                         StringConversionManagement.GetPaddedString(
                          GLEntryTrans.Description,
                            50,
                            ' ',
                            1);
                    end;
                }
                textelement(DebitAmt_Trans)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        DebitAmt_Trans:=
                         StringConversionManagement.GetPaddedString(
                          FORMAT(GLEntryTrans."Debit Amount",0,'<Precision,2><Standard Format,9>'),
                            16,
                            ' ',
                            0);
                    end;
                }
                textelement(CreditAmt_Trans)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        CreditAmt_Trans:=
                         StringConversionManagement.GetPaddedString(
                          FORMAT(GLEntryTrans."Credit Amount",0,'<Precision,2><Standard Format,9>'),
                            16,
                            ' ',
                            0);
                    end;
                }
                textelement(Note_Trans)
                {
                    Width = 160;

                    trigger OnBeforePassVariable();
                    begin
                        Note_Trans:=
                        StringConversionManagement.GetPaddedString(
                          FORMAT(GLEntryTrans."Entry No."),
                            160,
                            ' ',
                            1);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    Counter += 1;
                    Window.UPDATE(1,Counter);
                end;

                trigger OnPreXmlItem();
                begin
                    if (FromDate <>0D) and (ToDate <>0D) then
                      GLEntryTrans.SETFILTER("Posting Date", '%1..%2', FromDate, ToDate)
                    else
                      GLEntryTrans.SETRANGE("Posting Date", FromDate);
                    GLEntryTrans.SETFILTER("G/L Account No.", '%1', AccountNo);
                end;
            }
            tableelement(glaccount2;"G/L Account")
            {
                XmlName = 'GLAccount';
                SourceTableView = SORTING("No.") WHERE("Account Type"=FILTER(Posting));
                textelement(No_Close)
                {
                    MinOccurs = Zero;
                    Width = 10;

                    trigger OnBeforePassVariable();
                    begin
                        No_Open:= GLAccount."No.";
                    end;
                }
                textelement(Name_Close)
                {
                    MinOccurs = Zero;
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Name_Open:= GLAccount.Name;
                    end;
                }
                textelement(PostingDate_Close)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        //PostingDate_Trans:= FORMAT(GLEntryTrans."Posting Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentDate_Close)
                {
                    Width = 8;

                    trigger OnBeforePassVariable();
                    begin
                        //DocumentDate_Trans:= FORMAT(GLEntryTrans."Document Date",0,'<day,2><month,2><year,2>');
                    end;
                }
                textelement(DocumentNo_Close)
                {
                    Width = 30;

                    trigger OnBeforePassVariable();
                    begin
                        //DocumentNo_Trans:= GLEntryTrans."Document No.";
                    end;
                }
                textelement(Type_Close)
                {
                    Width = 3;

                    trigger OnBeforePassVariable();
                    begin
                        Type_Open:= 'ZAP';
                    end;
                }
                textelement(Description_Close)
                {
                    Width = 50;

                    trigger OnBeforePassVariable();
                    begin
                        Description_Open:= 'Otvoritvena postavka za leto <Year4>';
                    end;
                }
                textelement(DebitAmt_Close)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        GLAccount.CALCFIELDS("Debit Amount","Balance at Date");
                        //DebitAmt_open:= FORMAT(GLAccount."Debit Amount",0,9);
                        DebitAmt_Open:= FORMAT(GLAccount."Balance at Date",0,9);
                    end;
                }
                textelement(CreditAmt_Close)
                {
                    Width = 16;

                    trigger OnBeforePassVariable();
                    begin
                        GLAccount.CALCFIELDS("Credit Amount");
                        CreditAmt_Open:= FORMAT(GLAccount."Credit Amount",0,9);
                    end;
                }
                textelement(Note_Close)
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

            trigger OnBeforePassVariable();
            begin
                Window.OPEN(ProgressMsg);
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

    trigger OnInitXmlPort();
    begin
        currXMLport.FIELDDELIMITER('');
        currXMLport.FIELDSEPARATOR('');
    end;

    trigger OnPostXmlPort();
    begin
        if ErrorText <> '' then
          ERROR(ErrorText);

        Window.CLOSE;
    end;

    trigger OnPreXmlPort();
    begin
        currXMLport.FIELDSEPARATOR(';');
    end;

    var
        ProgressMsg : Label 'Exporting line no. #1######';
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
        StringConversionManagement : Codeunit StringConversionManagement;
        Window : Dialog;
        FromDate : Date;
        ToDate : Date;
        AccountNo : Code[20];
        ErrorText : Text;
        Counter : Integer;
}

