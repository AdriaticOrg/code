report 13062594 "Input VAT Book-adl 2"
{
    Caption = 'Input VAT Book';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Vat Entry"; "VAT Entry")
        {
            DataItemTableView = SORTING ("Document No.");
            RequestFilterFields = "Posting Date", "Document No.", "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Gen. Bus. Posting Group", "Gen. Prod. Posting Group", "VAT Identifier-adl", "VAT Calculation Type", "Country/Region Code", "Entry No.", "Bill-to/Pay-to No.", "External Document No.";

            trigger OnPreDataItem()
            var
                Counter: Integer;
            begin
                //SetFilter(type, '%1|%2', Type::Purchase, Type::Sale);
                //SetRange("Unrealized Amount",0);
                //SetFilter("VAT Identifier-Adl", '<>%1', '*99*');
                VATEntry.CopyFilters("Vat Entry");


                //prepare header names from setup
                VATBook.SetRange("Tag Name", 'DDV_ODB');  //TODO: if Setup  
                if VATBook.FindFirst() then
                    VATBookColumnName.SetRange("VAT Book Code", VATBook.Code);
                Counter := 1;
                if VATBookColumnName.FindSet() then
                    repeat
                        VATBookColumnNo[Counter] := VATBookColumnName."Column No.";
                        VATBookColumnLengt[Counter] := VATBookColumnName."Fixed text length";
                        TextWriterAdl.FixedField(OutStr, CopyStr(VATBookColumnName.Description, 1, VATBookColumnName."Fixed text length"), VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter);
                        Counter += 1;
                    until VATBookColumnName.Next() = 0;

                TextWriterAdl.NewLine(OutStr);
            end;

            trigger OnAfterGetRecord()
            var
                PurchInvHeader: Record "Purch. Inv. Header";
                PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
                Vendor: Record Vendor;
                ColumnVal: Decimal;
                VendorData: Text;
            begin
                setRange("Document No.", "Document No.");
                FindLast();

                //<Davčno obdobje>, Posting Date 
                TextWriterAdl.FixedField(OutStr, FORMAT("Posting Date", 0, '<Month,2><Month,2>'), VATBookColumnLengt[1], PadCharacter, 1, FieldDelimiter);


                //<Datum knjiženja>, Creation Date
                TextWriterAdl.FixedField(OutStr, "Posting Date", VATBookColumnLengt[2], PadCharacter, 1, FieldDelimiter);


                //<Datum prejema listine> Document Receipt Date
                TextWriterAdl.FixedField(OutStr, "Posting Date", VATBookColumnLengt[3], PadCharacter, 1, FieldDelimiter);


                //<Številka listine> Document No.,SAD No.
                //TypeFilter:= GetFilter(Type);
                //SetFilter("SAD No.", '%1', '');
                //If ("SAD No." = '' ) then 
                //    TextWriterAdl.FixedField(OutStr, VatEntry2."Document No.", VATBookColumnLengt[4], PadCharacter, 1, FieldDelimiter); 
                //SetFilter("SAD No.");

                //SetFilter("SAD No.", '<>%1', '');
                //SetRange("Type", Type::Purchase);
                //If ("SAD No." <> '' ) then
                //    TextWriterAdl.FixedField(OutStr, VatEntry2."SAD No.", VATBookColumnLengt[4], PadCharacter, 1, FieldDelimiter); 

                //TextWriterAdl.FixedField(OutStr, VatEntry2."Posting Date", VATBookColumnLengt[4], PadCharacter, 1, FieldDelimiter); 
                //If (TypeFilter <>'') then
                //    SetFilter(Type, TypeFilter);
                TextWriterAdl.FixedField(OutStr, "Document No.", VATBookColumnLengt[4], PadCharacter, 1, FieldDelimiter);


                //<Datum listine>, Document Date
                TextWriterAdl.FixedField(OutStr, "Document Date", VATBookColumnLengt[5], PadCharacter, 1, FieldDelimiter);

                //Firma/Ime in sedež dobavitelja
                Clear(VendorData);
                IF ("Document Type" = "Document Type"::Invoice) then begin
                    with PurchInvHeader do begin
                        if get("Document No.") then begin
                            if ("Pay-to Name" <> '') then
                                VendorData += "Pay-to Name";
                            if ("Pay-to Address" <> '') then
                                VendorData += "Pay-to Address";
                            if ("Pay-to City" <> '') then
                                VendorData += "Pay-to City";
                            if ("Pay-to Country/Region Code" <> '') then
                                VendorData += "Pay-to Country/Region Code";
                        end;
                    end;
                end else
                    IF ("Document Type" = "Document Type"::"Credit Memo") then begin
                        PurchCrMemoHdr.get("Document No.");
                        with PurchCrMemoHdr do begin
                            if get("Document No.") then begin
                                if ("Pay-to Name" <> '') then
                                    VendorData += "Pay-to Name";
                                if ("Pay-to Address" <> '') then
                                    VendorData += "Pay-to Address";
                                if ("Pay-to City" <> '') then
                                    VendorData += "Pay-to City";
                                if ("Pay-to Country/Region Code" <> '') then
                                    VendorData += "Pay-to Country/Region Code";
                            end;
                        end;
                    end;

                If Vendor.get("Bill-to/Pay-to No.") then begin
                    with Vendor do begin
                        if (Name <> '') then
                            VendorData += Name;
                        if (Address <> '') then
                            VendorData += Address;
                        if (City <> '') then
                            VendorData += City;
                        if ("Country/Region Code" <> '') then
                            VendorData += "Country/Region Code";
                    end;
                end;
                TextWriterAdl.FixedField(OutStr, VendorData, VATBookColumnLengt[6], PadCharacter, 1, FieldDelimiter);


                //VAT Registration No., <ID za DDV>
                TextWriterAdl.FixedField(OutStr, "VAT Registration No.", VATBookColumnLengt[7], PadCharacter, 1, FieldDelimiter);

                //Calc. fields
                //Base, <Vrednost brez DDV> <8> + SUM <ReverseSign>
                Clear(ColumnVal);
                VATBookGroup.Reset();
                VATBookGroup.SetRange("VAT Book Code", VATBook.Code);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[8]));
                if VATBookGroup.FindFirst() then begin
                    repeat
                        //columnVal+= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                        ColumnVal += VATBookCalc.EvaluateExpression(VATBookGroup, 0, Datefilter);
                    until VATBookGroup.next = 0;
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[8], PadCharacter, 1, FieldDelimiter);
                end;


                //Base, <Blago in st.-brez samoob> <8.a>
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[9]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[9], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Blago in st.-samoob.> <8.b> <ReverseSign> Single
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[10]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry);
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[10], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Vred. nabav v SLO od samoobd> <9> <ReverseSign> Single
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[11]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[11], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Vred. obd.prid. bl. brez DDV> <10> + SUM <ReverseSign>
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[12]));
                if VATBookGroup.FindFirst() then begin
                    repeat
                        //ColumnVal+= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                        ColumnVal += VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    until VATBookGroup.next() = 0;
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[12], PadCharacter, 1, FieldDelimiter);
                end;


                //Base,<Vred. obd.prej. st. brez DDV> <11> <ReverseSign> Single
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[13]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[13], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Vred. obd.nab nepr. brez DDV <12> SUM <ReverseSign>
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[14]));
                if VATBookGroup.FindFirst() then begin
                    repeat
                        //ColumnVal+= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                        ColumnVal += VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    until VATBookGroup.next() = 0;
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[14], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Vred. obd.nab dr.OS brez DDV> <13> SUM <ReverseSign>
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[15]));
                if VATBookGroup.FindFirst() then begin
                    repeat
                        //ColumnVal+= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                        ColumnVal += VATBookCalc.EvaluateExpression(VATBookGroup, 0, Datefilter);
                    until VATBookGroup.next() = 0;
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[15], PadCharacter, 1, FieldDelimiter);
                end;


                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[16]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[17], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Vred. opr. nab. nepr. br DDV> <15>
                //VATid: 5008. Type: Purchase
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[17]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[17], PadCharacter, 1, FieldDelimiter);
                end;

                //Base, <Vred. opr. nab. OS brez DDV> <16>
                //VATid: 4008, 4309
                //Type: Purchase
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[18]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[18], PadCharacter, 1, FieldDelimiter);
                end;

                //"VAT Amount (Non Deductable)", <DDV, ki se ne odbije> <17> SUM
                //VAT id: 10, 4010, 5010, 311, 312, 4311, 4312, 110, 107, 108, 109, 42, 43, 5042, 5043, 5142, 5143, 142, 143, 4108, 4110, 20, 4020, 5020, 4042, 4043, 4143, 11, 12, 5011, 5012, 4011, 4012, 29, 991, 992, 11, 5041, 5040, 41, 40, 4041, 4040, 4023, 4026, 23, 13, 314, 313, 5016, 4314, 4313, 4016, 16, 15, 4108, 26, 25, 5314, 6053, 6063, 4653, 4663
                //Type: Purchase
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[19]));
                if VATBookGroup.FindFirst() then begin
                    repeat
                        //ColumnVal+= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                        ColumnVal += VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    until VATBookGroup.next() = 0;
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[19], PadCharacter, 1, FieldDelimiter);
                end;

                //Amount, <Odbitni DDV 20%>         <18>
                //VATid:	16, 314, 4314, 5314, 6023, 5016, 4016, 5141, 5041, 41, 141, 26, 12, 23, 112, 5012, 4012, 4023, 4026, 4112, 5112, 4041, 4623, 
                //Type: Purchase
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[20]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[20], PadCharacter, 0, FieldDelimiter);
                end;

                //Amount, <Odbitni DDV 8,5%>        <19>; 		
                //VAT ID 15, 313, 4313, 5313, 5140, 5040, 40, 140, 25, 11, 13, 111, 5011, 4011, 4013, 4111, 5111, 4040, 6013, 4613, 30; 
                //Type: Purchase
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[21]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[21], PadCharacter, 0, FieldDelimiter);
                end;

                //Amount, <Pavšalno nadomestilo 8%> <20>  VATid:29, Type: Purchase
                Clear(ColumnVal);
                VATBookGroup.SetRange("Include Columns", format(VATBookColumnNo[22]));
                if VATBookGroup.FindFirst() then begin
                    //ColumnVal:= VATBookCalc.EvaluateExpression(VATBookGroup, 0, '', VATEntry); 
                    ColumnVal := VATBookCalc.EvaluateExpression(VATBookGroup, 0, DateFilter);
                    TextWriterAdl.FixedField(OutStr, ColumnVal, VATBookColumnLengt[22], PadCharacter, 1, FieldDelimiter);
                end;

                //"VAT Date", <Opombe - Datum DDV> <21>
                //"", <Opombe - ostalo>            <21>

                SetRange("Document No.");
                TextWriterAdl.NewLine(OutStr);
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
        ToFilter := '*.txt|*.TXT';
        FileName := 'IZPIS ODBITKA DDV.TXT';
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
        VATEntry: Record "VAT Entry";
        VATBook: Record "VAT Book-Adl";
        VATBookGroup: Record "VAT Book Group-Adl";
        VATBookColumnName: Record "VAT Book Column Name-Adl";
        TextWriterAdl: Codeunit "TextWriter-adl";
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        OutStr: OutStream;
        VATBookColumnNo: array[100] of Integer;
        VATBookColumnLengt: array[100] of integer;
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
        DateFilter: Text;
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

