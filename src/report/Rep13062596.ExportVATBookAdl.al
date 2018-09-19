report 13062596 "Export VAT Book-Adl"
{
    Caption = 'Input Output VAT Book';
    ProcessingOnly = true;

    dataset
    {

        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = sorting ("Document No.", "Posting Date") order(Ascending) where (Type = FILTER (<> Settlement));
            RequestFilterFields = "Posting Date", "Document No.";

            dataitem("VAT Book Column Name"; "VAT Book Column Name-Adl")
            {
                DataItemTableView = sorting ("VAT Book Code", "Column No.") order(Ascending);

                dataitem("VAT Book Group"; "VAT Book Group-Adl")
                {
                    DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                    DataItemTableView = sorting ("VAT Book Code", Code) order(Ascending);

                    trigger OnPreDataItem()
                    begin
                        SetRange("VAT Book Code", VATBookCode);
                    end;

                    trigger OnAfterGetRecord()
                    begin

                    end;
                }

                trigger OnAfterGetRecord()
                begin

                end;
            }

            trigger OnPreDataItem();
            begin
                VATBookGrp.Reset();
                VATBookGrp.SetRange("VAT Book Code", VATBookCode);
                if VATBookGrp.FindFirst() then;

                if "VAT Entry".GetFilter("Posting Date") <> '' then
                    VATEntry.Setfilter("Posting Date", "VAT Entry".GetFilter("Posting Date"));
                FilterGroup(10);
                if "VAT Entry".GetFilter("Document No.") <> '' then
                    VATEntry.Setfilter("Document No.", "VAT Entry".GetFilter("Document No."));
                FilterGroup(2);
            end;

            trigger OnAfterGetRecord()
            var
                VATBookColumnName: Record "VAT Book Column Name-Adl";
                DecVal: Decimal;
                Found: Boolean;
                i: Integer;
            begin
                SetRange("Document No.", "Document No.");
                FindLast();
                setrange("Document No.");

                VATEntry.SetRange("Document No.", "Document No.");
                If VATEntry.FindFirst() then;

                VATBookColumnName.Reset();
                VATBookColumnName.SetRange("VAT Book Code", VATBookCode);
                if VATBookColumnName.FindSet() then
                    repeat
                        Result := 0;
                        VATBookCalc.CalcCellValue(VATBookGrp, VATBookColumnName."Column No.", Result, '', VATEntry);
                        ListResut.Insert(VATBookColumnName."Column No.", Result);
                    until VATBookColumnName.Next() = 0;

                for i := 1 to ListResut.Count() do begin
                    Clear(DecVal);
                    ListResut.Get(i, DecVal);
                    If (DecVal > 0) then
                        Found := true;
                end;

                if Found then begin
                    CreateBookLine(VATEntry);

                    VATBookColumnName.Reset();
                    VATBookColumnName.SetRange("VAT Book Code", VATBookCode);
                    if VATBookColumnName.FindSet() then
                        repeat
                            ListResut.Get(VATBookColumnName."Column No.", Result);
                            if (Result = 0) then
                                TextWriterAdl.FixedField(OutStr, DummyText, VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter)
                            else
                                TextWriterAdl.FixedField(OutStr, Result, VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter);
                        until VATBookColumnName.Next() = 0;
                    TextWriterAdl.NewLine(OutStr);
                    Found := false;
                end;

                Clear(ListResut);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(General)
                {
                    field(VATBookCode; VATBookCode)
                    {
                        Caption = 'VAT Book Code';
                        TableRelation = "VAT Book-Adl".Code;
                        ApplicationArea = All;
                        ToolTip = 'Specifies filter for VAT Book Code.';
                    }
                }
            }
        }

        trigger OnClosePage()
        begin
            if (VATBookCode = '') then begin
                Message('%1', Text001Txt);
                Error('');
            end;

        end;
    }
    var
        VATEntry: Record "VAT Entry";
        Customer: Record Customer;
        Vendor: Record Vendor;
        VATBookGrp: Record "VAT Book Group-Adl";
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        TextWriterAdl: Codeunit "TextWriter-Adl";
        VATBookCode: Code[20];
        Result: Decimal;
        ResultTxt: Text;
        VATRegNo: Text[20];
        VendCustName: Text;
        ColumnNo: Integer;
        NotFoundDetails: Boolean;
        VATBookColumnNo: array[100] of Integer;
        VATBookColumnLengt: array[100] of integer;
        OutStr: OutStream;
        OutStrColumn: OutStream;
        PadCharacter: Text[1];
        FieldDelimiter: Text[1];
        DummyText: Text;
        FileNameLbl: Label 'IZPIS ODBITKA DDV.TXT';
        ToFilterLbl: Label '*.txt|*.TXT';
        DialogTitleLbl: Label 'Save to';
        Text001Txt: Label 'VAT Group Code must be selected!';
        VATPeriodLbl: Label 'VAT Period';
        CreationDateLbl: Label 'Creation Date';
        DocumentReceiptLbl: Label 'Document Receipt Date';
        DocumentNoLbl: Label 'Document No.';
        DocumentDateLbl: Label 'Document Date';
        VendCustomLbl: Label 'Firm / Name and place of supplier';
        VATRegistrationNoLbl: Label 'VAT Registration No.';
        ListResut: List of [Decimal];
        ResultArr: array[100] of Decimal;

    trigger OnPreReport();
    begin
        VATEntry.CopyFilters("VAT Entry");
        TextWriterAdl.Create(OutStr);
        PadCharacter := ' ';
        FieldDelimiter := ';';
        DummyText := ' ';

        CreateHeaderBook();
    end;

    trigger OnPostReport()
    begin
        TextWriterAdl.Download(DialogTitleLbl, ToFilterLbl, FileNameLbl);
    end;

    local procedure CreateHeaderBook()
    var
        VATBookColumnName: Record "VAT Book Column Name-Adl";
        Counter: Integer;
    begin
        //<Davčno obdobje>, Posting Date 
        TextWriterAdl.FixedField(OutStr, VATPeriodLbl, 4, PadCharacter, 1, FieldDelimiter);

        //<Datum knjiženja>, Creation Date
        TextWriterAdl.FixedField(OutStr, CreationDateLbl, 8, PadCharacter, 1, FieldDelimiter);

        //<Datum prejema listine> Document Receipt Date
        TextWriterAdl.FixedField(OutStr, DocumentReceiptLbl, 8, PadCharacter, 1, FieldDelimiter);

        //<Številka listine> Document No.,
        TextWriterAdl.FixedField(OutStr, DocumentNoLbl, 30, PadCharacter, 1, FieldDelimiter);

        //<Datum listine>, Document Date
        TextWriterAdl.FixedField(OutStr, DocumentDateLbl, 8, PadCharacter, 1, FieldDelimiter);

        //Firma/Ime in sedež dobavitelja
        TextWriterAdl.FixedField(OutStr, VendCustomLbl, 50, PadCharacter, 1, FieldDelimiter);

        //VAT Registration No., <ID za DDV>
        TextWriterAdl.FixedField(OutStr, VATRegistrationNoLbl, 20, PadCharacter, 1, FieldDelimiter);

        VATBookColumnName.Reset();
        VATBookColumnName.SetRange("VAT Book Code", VATBookCode);
        if VATBookColumnName.FindSet() then
            repeat
                Counter += 1;
                VATBookColumnNo[Counter] := VATBookColumnName."Column No.";
                VATBookColumnLengt[Counter] := VATBookColumnName."Fixed text length";
                if (VATBookColumnName."Fixed text length" = 0) then
                    TextWriterAdl.FixedField(OutStr, VATBookColumnName.Description, StrLen(VATBookColumnName.Description), PadCharacter, 1, FieldDelimiter)
                else
                    TextWriterAdl.FixedField(OutStr, VATBookColumnName.Description, VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter);
            until VATBookColumnName.Next() = 0;
        TextWriterAdl.NewLine(OutStr);
    end;

    local procedure CreateBookLine(VATEntry: Record "VAT Entry")
    var
        MinDatePeriod: Date;
        MaxDatePeriod: Date;
    begin
        GetCustVendInfo(VATEntry);
        With VATEntry do begin
            If GetFilter("Posting Date") <> '' then begin
                if GetRangeMin("Posting Date") <> 0D then
                    MinDatePeriod := "Posting Date"
                else
                    MinDatePeriod := 0D;
                if GetRangeMax("Posting Date") <> 0D then
                    MaxDatePeriod := "Posting Date"
                else
                    MAXDatePeriod := 0D;

                TextWriterAdl.FixedField(OutStr, FORMAT(MinDatePeriod, 0, '<Month,2>') + '' + FORMAT(MaxDatePeriod, 0, '<Month,2>'), 4, PadCharacter, 1, FieldDelimiter)
            end else
                TextWriterAdl.FixedField(OutStr, FORMAT("Posting Date", 0, '<Month,2><Month,2>'), 4, PadCharacter, 1, FieldDelimiter);

            TextWriterAdl.FixedField(OutStr, "Posting Date", 8, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Posting Date", 8, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Document No.", 30, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Document Date", 8, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, VendCustName, 50, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "VAT Registration No.", 20, PadCharacter, 1, FieldDelimiter);
        end;
    end;


    local procedure GetCustVendInfo(VATEntry: Record "VAT Entry");
    var
        PurchInvHeader: Record "Purch. Inv. Header";
        PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
        Vendor: Record Vendor;
    begin
        VendCustName := '';
        VATRegNo := '';
        with VATEntry do begin
            case "Document Type" of
                "Document Type"::Invoice:
                    if PurchInvHeader.get("Document No.") then begin
                        if (PurchInvHeader."Pay-to Name" <> '') then
                            VendCustName += PurchInvHeader."Pay-to Name" + ' ';
                        if (PurchInvHeader."Pay-to Address" <> '') then
                            VendCustName += PurchInvHeader."Pay-to Address" + ' ';
                        if (PurchInvHeader."Pay-to City" <> '') then
                            VendCustName += PurchInvHeader."Pay-to City" + ' ';
                        if (PurchInvHeader."Pay-to Country/Region Code" <> '') then
                            VendCustName += PurchInvHeader."Pay-to Country/Region Code" + ' ';
                    end;

                "Document Type"::"Credit Memo":
                    if PurchCrMemoHdr.get("Document No.") then begin
                        if (PurchCrMemoHdr."Pay-to Name" <> '') then
                            VendCustName += PurchCrMemoHdr."Pay-to Name" + ' ';
                        if (PurchCrMemoHdr."Pay-to Address" <> '') then
                            VendCustName += PurchCrMemoHdr."Pay-to Address" + ' ';
                        if (PurchCrMemoHdr."Pay-to City" <> '') then
                            VendCustName += PurchCrMemoHdr."Pay-to City" + ' ';
                        if (PurchCrMemoHdr."Pay-to Country/Region Code" <> '') then
                            VendCustName += PurchCrMemoHdr."Pay-to Country/Region Code" + ' ';
                    end;
            end;

            if Vendor.Get("Bill-to/Pay-to No.") then begin
                if (Vendor.Name <> '') then
                    VendCustName += Vendor.Name + '';
                if (Vendor.Address <> '') then
                    VendCustName += Vendor.Address + '';
                if (Vendor.City <> '') then
                    VendCustName += Vendor.City + '';
                if ("Country/Region Code" <> '') then
                    VendCustName += Vendor."Country/Region Code";
            end;
        end;
    end;
}
