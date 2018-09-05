report 13062596 "Input VAT Book-adt test"
{
    Caption = 'Input VAT Book';
    ProcessingOnly = true;

    dataset
    {
        dataitem("VAT Book Column Name"; "VAT Book Column Name-Adl")
        {
            DataItemTableView = sorting ("VAT Book Code", "Column No.") order(Ascending) where("VAT Book Code"=filter('DDV_ODB'));
            
            dataitem("VAT Book Group"; "VAT Book Group-Adl")
            {
                DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                DataItemTableView = sorting ("VAT Book Code", Code) order(Ascending);


                dataitem("VAT Book View Line"; "VAT Book View Formula-Adl")
                {
                    DataItemLink = "VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field (Code);
                    DataItemTableView = sorting ("VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.") order(Ascending);
                                   

                    dataitem("VAT Entry"; "VAT Entry")
                    {
                        DataItemTableView = sorting ("Document No.", "Posting Date") order(Ascending) where (Type = FILTER (<> Settlement));
                        RequestFilterFields = "Posting Date", "Document No.";
                        
                        
                        trigger OnPreDataItem();
                        begin
                            VATEntry.CopyFilters("VAT Entry");
                        end;

                        trigger OnAfterGetRecord();
                        begin
                            SetFilter("VAT Identifier-Adl", "VAT Book View Line"."VAT Identifier");
                            setRange("Document No.", "Document No.");
                            if not FindLast() then
                                CurrReport.Break();

                            ColumnAmt := 0;
                  
                            if "VAT Book View Line".Operator1 <> "VAT Book View Line".Operator1::" " then 
                                VATBookCalc.CalculateValue(true, ColumnAmt, "VAT Book View Line", "VAT Entry");
                               
                            if "VAT Book View Line".Operator2 <> "VAT Book View Line".Operator2::" " then
                                VATBookCalc.CalculateValue(false, ColumnAmt, "VAT Book View Line", "VAT Entry");                           

                            If (ColumnAmt <>0) then begin
                                
                                TextWriterAdl.FixedField(OutStr, ColumnAmt, 16, PadCharacter, 1, FieldDelimiter);
                                TextWriterAdl.NewLine(OutStr);
                            end;
                            setRange("Document No.");
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        SetRange("VAT Book Code", "VAT Book Group"."VAT Book Code");
                        SetRange("VAT Book Group Code", "VAT Book Group".Code);
                        SetFilter("VAT Identifier", VATBookCalc.GetVATIdentifierFilter("VAT Book Group"));
                        SetRange("Column No.", "VAT Book Column Name"."Column No." - 1);         
                    end;
                }

                trigger OnPreDataItem();
                begin
                    CompInfo.Get;
                    if not FindSet then ;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                ColumnNo := 0;
                Evaluate(ColumnNo, Format("Column No."));
                if not VATBook.Get("VAT Book Code") then ;
            end;
        }
    }

    labels
    { }

    var
        VATEntry: Record "VAT Entry";
        VATBook: Record "VAT Book-Adl";
        CompInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        ColumnAmt: Decimal;
        VATRegNo: Text[20];
        VendCustName: Text[100];
        ColumnNo: Integer;

        TextWriterAdl: Codeunit "TextWriter-adl";
        OutStr: OutStream;
        FileName: Text;
        ToFilter: Text;
        DialogTitle: Text;
        PadCharacter: Text[1];
        FieldDelimiter: Text[1];
        DummyText : Text;


    
    trigger OnPreReport();
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

}