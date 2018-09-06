report 13062596 "Input VAT Book-adl"
{
    Caption = 'Input VAT Book';
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
                RequestFilterFields = "VAT Book Code";

                dataitem("VAT Book Group"; "VAT Book Group-Adl")
                {
                    DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                    DataItemTableView = sorting ("VAT Book Code", Code) order(Ascending);             



                    trigger OnAfterGetRecord()
                    begin
                        result:= 0;
                        VATEntry.SetRange("Document No.", "VAT Entry"."Document No.");     
                        VATBookCalc.CalcCellValue("VAT Book Group", "VAT Book Column Name"."Column No.", Result, '', VATEntry);

                        if (Result <>0) then 
                            TextWriterAdl.FixedField(OutStr, Result, 16, PadCharacter, 1, FieldDelimiter)
                        else
                            TextWriterAdl.FixedField(OutStr, ' ', 16, PadCharacter, 1, FieldDelimiter); 
                    end;                
                }

                trigger OnPreDataItem()
                begin
                    SetRange("VAT Book Code", 'DDV_ODB');        
                end;
            }

            trigger OnPreDataItem();
            begin
                //"VAT Book View Line".SetVATEntryFilters("VAT Entry");
                if "VAT Entry".GetFilter("Posting Date") <> '' then
                    VATEntry.Setfilter("Posting Date", "VAT Entry".GetFilter("Posting Date"));
                if "VAT Entry".GetFilter("Document No.") <> '' then
                    VATEntry.Setfilter("Document No.", "VAT Entry".GetFilter("Document No."));
                if "VAT Entry".GetFilter("VAT Bus. Posting Group") <> '' then
                    VATEntry.Setfilter("VAT Bus. Posting Group", "VAT Entry".GetFilter("VAT Bus. Posting Group"));             
                //"VAT Entry".CopyFilters("VAT Entry");
            end;

            trigger OnAfterGetRecord()
            begin
                GetCustVendInfo;
                SetRange("Document No.", "Document No.");

                TextWriterAdl.FixedField(OutStr, "Document No.", 20, PadCharacter, 1, FieldDelimiter); 

                FindLast();
                SetRange("Document No.");
                
                TextWriterAdl.NewLine(OutStr);
            end;

            trigger OnPostDataItem()
            begin
                TextWriterAdl.NewLine(OutStr);
            end;
        }
    }


    labels
    {
        PageLbl = 'Page';
        TitleLbl = 'VAT Book - VAT';
        RowNoLbl = 'No.';
        NameCityLbl = 'Name, City';
        VATRegNoLbl = 'VAT reg. No.';
        TotalLbl = 'Total';
        CustVendLbl = 'Customer/Vendor';
        DocumentLbl = 'Document';
        VATIdentFilterLbl = 'VAT Identifier filter:';
        VatDateLbl = 'VAT Date';
    }

    var
        VATEntry: Record "VAT Entry";
        VATEntryTemp: Record "VAT Entry" temporary;
        VATBook: Record "VAT Book-Adl";
        CompInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Result: Decimal;
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        ColumnAmt: Decimal;
        VATRegNo: Text[20];
        VendCustName: Text[100];
        ColumnNo: Integer;
        NotFoundDetails: Boolean;
        VATBookColumnNo: array[100] of Integer;
        VATBookColumnLengt: array[100] of integer;
        TextWriterAdl: Codeunit "TextWriter-adl";
        OutStr: OutStream;
        FileName: Text;
        ToFilter: Text;
        DialogTitle: Text;
        PadCharacter: Text[1];
        FieldDelimiter: Text[1];
        DummyText: Text;

    trigger OnPreReport();
    var
        Counter: Integer;
        VATBookColumnName: Record "VAT Book Column Name-Adl";
        
    begin
        VATEntry.CopyFilters("VAT Entry");
        TextWriterAdl.Create(OutStr);
        ToFilter := '*.txt|*.TXT';
        FileName := 'IZPIS ODBITKA DDV.TXT';
        DialogTitle := 'Save to';
        PadCharacter := ' ';
        FieldDelimiter := ';';
        DummyText := ' ';
      
        TextWriterAdl.FixedField(OutStr, 'Št. dokumenta', 20, PadCharacter, 1, FieldDelimiter); 
        VATBookColumnName.Reset();
        VATBookColumnName.SetRange("VAT Book Code", 'DDV_ODB');
        if VATBookColumnName.FindSet then
            repeat
                Counter += 1;
                VATBookColumnNo[Counter] := VATBookColumnName."Column No.";
                VATBookColumnLengt[Counter] := VATBookColumnName."Fixed text length";
                TextWriterAdl.FixedField(OutStr, VATBookColumnName.Description, VATBookColumnName."Fixed text length", PadCharacter, 1, FieldDelimiter);
            until VATBookColumnName.Next = 0;

        TextWriterAdl.NewLine(OutStr);
 
    end;

    trigger OnPostReport()
    var
        DocnNo: Code[20];
    begin
        TextWriterAdl.Download(DialogTitle, ToFilter, FileName);
    end;

    local procedure GetCustVendInfo();
    begin
        VendCustName := '';
        VATRegNo := '';
        with "VAT Entry" do begin
            case Type of
                Type::Sale:
                    if Customer.Get("Bill-to/Pay-to No.") then begin
                        if Customer.City <> '' then
                            VendCustName := Customer.Name + ', ' + Customer.City
                        else
                            VendCustName := Customer.Name;
                        VATRegNo := Customer."VAT Registration No.";
                    end;
                Type::Purchase:
                    if Vendor.Get("Bill-to/Pay-to No.") then begin
                        if Vendor.City <> '' then
                            VendCustName := Vendor.Name + ', ' + Vendor.City
                        else
                            VendCustName := Vendor.Name;
                        VATRegNo := Vendor."VAT Registration No.";
                    end;
            end;
        end;
    end;

    procedure GetVATIdentifierFilter(VATBookGroup: Record "VAT Book Group-Adl") VATIdentifierFilter: Text;
    var
        VATBookGroupIdentifier: Record "VAT Book Group Identifier-Adl";
    begin
        with VATBookGroup do begin
            VATIdentifierFilter := '';
            VATBookGroupIdentifier.Reset;
            VATBookGroupIdentifier.SetCurrentKey("VAT Book Code", "VAT Book Group Code", "VAT Identifier");
            VATBookGroupIdentifier.SetRange("VAT Book Code", "VAT Book Code");
            VATBookGroupIdentifier.SetRange("VAT Book Group Code", Code);
            if VATBookGroupIdentifier.FindSet then
                repeat
                    if VATIdentifierFilter = '' then
                        VATIdentifierFilter := VATBookGroupIdentifier."VAT Identifier"
                    else
                        VATIdentifierFilter += '|' + VATBookGroupIdentifier."VAT Identifier";
                until VATBookGroupIdentifier.Next = 0;
        end;
    end;

}
