report 13062596 "Export VAT Book-adl"
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
                        result := 0;
                        VATEntry.SetRange("Document No.", "VAT Entry"."Document No.");
                        VATBookCalc.CalcCellValue("VAT Book Group", "VAT Book Column Name"."Column No.", Result, '', VATEntry);

                        if (Result <> 0) then
                            TextWriterAdl.FixedField(OutStr, result, "VAT Book Column Name"."Fixed text length", PadCharacter, 1, FieldDelimiter)

                        else
                            TextWriterAdl.FixedField(OutStr, DummyText, "VAT Book Column Name"."Fixed text length", PadCharacter, 1, FieldDelimiter)
                    end;
                }

                trigger OnPostDataItem()
                begin
                    TextWriterAdl.NewLine(OutStr);
                end;
            }

            trigger OnPreDataItem();
            begin
                if "VAT Entry".GetFilter("Posting Date") <> '' then
                    VATEntry.Setfilter("Posting Date", "VAT Entry".GetFilter("Posting Date"));
                if "VAT Entry".GetFilter("Document No.") <> '' then
                    VATEntry.Setfilter("Document No.", "VAT Entry".GetFilter("Document No."));
                if "VAT Entry".GetFilter("VAT Bus. Posting Group") <> '' then
                    VATEntry.Setfilter("VAT Bus. Posting Group", "VAT Entry".GetFilter("VAT Bus. Posting Group"));
            end;

            trigger OnAfterGetRecord()
            begin
                GetCustVendInfo("VAT Entry");
                SetRange("Document No.", "Document No.");

                CreateBookLine("VAT Entry");

                FindLast();
                SetRange("Document No.");
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
                    }
                }
            }
        }

        trigger OnClosePage()
        begin
            if (VATBookCode = '') then begin
                Message('%1', Text001);
                Error('');
            end;

        end;
    }
    var
        VATEntry: Record "VAT Entry";
        VATBookCode: Code[20];
        Customer: Record Customer;
        Vendor: Record Vendor;
        Result: Decimal;
        ResultTxt: Text;
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        VATRegNo: Text[20];
        VendCustName: Text[100];
        ColumnNo: Integer;
        NotFoundDetails: Boolean;
        VATBookColumnNo: array[100] of Integer;
        VATBookColumnLengt: array[100] of integer;
        TextWriterAdl: Codeunit "TextWriter-adl";
        OutStr: OutStream;
        OutStrColumn: OutStream;
        PadCharacter: Text[1];
        FieldDelimiter: Text[1];
        DummyText: Text;
        FileName: Label 'IZPIS ODBITKA DDV.TXT';
        ToFilter: Label '*.txt|*.TXT';
        DialogTitle: Label 'Save to';
        Text001: Label 'VAT Group Code must be selected!';
        VATPeriodLbl: Label 'VAT Period';
        CreationDateLbl: Label 'Creation Date';
        DocumentReceiptLbl: Label 'Document Receipt Date';
        DocumentNoLbl: Label 'Document No.';
        DocumentDateLbl: Label 'Document Date';
        VendCustomLbl: Label 'Firm / Name and place of supplier';
        VATRegistrationNoLbl: Label 'VAT Registration No.';

    trigger OnPreReport();
    begin
        VATEntry.CopyFilters("VAT Entry");
        TextWriterAdl.Create(OutStr);
        PadCharacter := ' ';
        FieldDelimiter := ';';
        DummyText := ' ';

        CreateHeaderBook; //Create header line txt 
    end;

    trigger OnPostReport()
    begin
        TextWriterAdl.Download(DialogTitle, ToFilter, FileName);
    end;

    local procedure CreateHeaderBook()
    var
        Counter: Integer;
        ColumnDesc: Text;
        VATBookColumnName: Record "VAT Book Column Name-Adl";
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
        if VATBookColumnName.FindSet then
            repeat
                Counter += 1;
                VATBookColumnNo[Counter] := VATBookColumnName."Column No.";
                VATBookColumnLengt[Counter] := VATBookColumnName."Fixed text length";

                if (VATBookColumnName."Fixed text length" = 0) then begin
                    TextWriterAdl.FixedField(OutStr, VATBookColumnName.Description, StrLen(VATBookColumnName.Description), PadCharacter, 1, FieldDelimiter);
                end else
                    TextWriterAdl.FixedField(OutStr, VATBookColumnName.Description, VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter);

            until VATBookColumnName.Next = 0;

        TextWriterAdl.NewLine(OutStr);
    end;

    local procedure CreateBookLine(var VATEntry: Record "VAT Entry")
    begin
        With VATEntry do begin
            TextWriterAdl.FixedField(OutStr, FORMAT("Posting Date", 0, '<Month,2><Month,2>'), 4, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Posting Date", 8, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Posting Date", 8, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Document No.", 30, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "Document Date", 8, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, VendCustName, 50, PadCharacter, 1, FieldDelimiter);
            TextWriterAdl.FixedField(OutStr, "VAT Registration No.", 20, PadCharacter, 1, FieldDelimiter);

        end;
    end;

    procedure FixedFieldTxt(var Result: Text; Value: variant; Length: integer; PadCharacter: Text[1]; Justification: Option Right,Left; FIeldDelimiter: Text[1])
    var
        StringConversionManagement: Codeunit StringConversionManagement;
        TextVal: Text[250];
    begin
        if (Value.IsDate()) then
            TextVal := Format(Value, 0, '<day,2><month,2><year,2>')
        else
            if (Value.IsDecimal()) then
                TextVal := Format(Value, 0, '<Precision,2><Standard Format,9>')
            else
                TextVal := Format(Value);

        TextVal :=
            StringConversionManagement.GetPaddedString(
                TextVal,
                Length,
                PadCharacter,
                Justification);

        if (FieldDelimiter <> '') then
            TextVal += FIeldDelimiter;
        Result += TextVal;
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
                    begin
                        with PurchInvHeader do begin
                            if get("Document No.") then begin
                                if ("Pay-to Name" <> '') then
                                    VendCustName += "Pay-to Name";
                                if ("Pay-to Address" <> '') then
                                    VendCustName += "Pay-to Address";
                                if ("Pay-to City" <> '') then
                                    VendCustName += "Pay-to City";
                                if ("Pay-to Country/Region Code" <> '') then
                                    VendCustName += "Pay-to Country/Region Code";
                            end;
                        end;
                    end;
                "Document Type"::"Credit Memo":
                    begin
                        with PurchCrMemoHdr do begin
                            if get("Document No.") then begin
                                if ("Pay-to Name" <> '') then
                                    VendCustName += "Pay-to Name";
                                if ("Pay-to Address" <> '') then
                                    VendCustName += "Pay-to Address";
                                if ("Pay-to City" <> '') then
                                    VendCustName += "Pay-to City";
                                if ("Pay-to Country/Region Code" <> '') then
                                    VendCustName += "Pay-to Country/Region Code";
                            end;
                        end;
                    end;
            end;

            if Vendor.Get("Bill-to/Pay-to No.") then begin
                with Vendor do begin
                    if (Name <> '') then
                        VendCustName += Name;
                    if (Address <> '') then
                        VendCustName += Address;
                    if (City <> '') then
                        VendCustName += City;
                    if ("Country/Region Code" <> '') then
                        VendCustName += "Country/Region Code";
                end;
            end;
        end;
    end;
}
