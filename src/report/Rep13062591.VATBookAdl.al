report 13062591 "VAT Book-Adl"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep13062591.VATBookAdl.rdlc';
    Caption = 'VAT Book';
    EnableHyperlinks = true;

    dataset
    {
        dataitem("VAT Book Column Name"; "VAT Book Column Name-Adl")
        {
            DataItemTableView = sorting ("VAT Book Code", "Column No.") orDER(Ascending);
            RequestFilterFields = "VAT Book Code";
            column(ColumnDescription; Description) { }
            column(ColumnNo; ColumnNo) { }
            column(VATBookCode; "VAT Book Code") { }
            column(Company_VAT_Reg_No; CompInfo."VAT Registration No.") { }
            column(Company_City; CompInfo."Post Code" + ' ' + CompInfo.City) { }
            column(Company_Address; CompInfo.Address + ' ' + CompInfo."Address 2") { }
            column(Company_Name; CompInfo.Name) { }
            column(NotFoundDetails; NotFoundDetails) { }
            column(VATIdentifierFilter; "VAT Book View Line".GetFILTER("VAT Identifier")) { }
            column(VATBookSorting; VATBook."Sorting Appearance") { }
            dataitem("VAT Book Group"; "VAT Book Group-Adl")
            {
                DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                DataItemTableView = sorting ("VAT Book Code", Code) orDER(Ascending);
                RequestFilterFields = "VAT Book Code", "Code";
                column(VatPrewFilters; GetFilters()) { }
                column(EntryFilter; "VAT Entry".GetFilters()) { }
                column(VATBookGroupCode; Code) { }
                dataitem("VAT Book View Line"; "VAT Book View Formula-Adl")
                {
                    DataItemLink = "VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field (Code);
                    DataItemTableView = sorting ("VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.") orDER(Ascending);
                    RequestFilterFields = "VAT Identifier";
                    dataitem("VAT Entry"; "VAT Entry")
                    {
                        DataItemLink = "VAT Identifier-Adl" = field ("VAT Identifier");
                        DataItemTableView = sorting ("Document No.", "Posting Date") orDER(Ascending) where (Type = FILTER (<> Settlement));
                        RequestFilterFields = "Posting Date", "Document No.", "VAT Bus. Posting Group";
                        column(DocumentNo; "Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(DocumentDate_VATEntry; "Document Date")
                        {
                            IncludeCaption = true;
                        }
                        column(PostingDate; "Posting Date")
                        {
                            IncludeCaption = true;
                        }
                        column(Name; VendCustName) { }
                        column(VATRegNo; VATRegNo) { }
                        column(Amount; ColumnAmt) { }
                        column(ExternalDocumentNo_VATEntry; "External Document No.")
                        {
                            IncludeCaption = true;
                        }
                        column(VATDate_VATEntry; "Posting Date") { }
                        column(BilltoPaytoNo_VATEntry; "Bill-to/Pay-to No.") { }

                        trigger OnAfterGetRecord();
                        begin
                            ColumnAmt := 0;
                            GetCustVendInfo();

                            if "VAT Book View Line".Operator1 <> "VAT Book View Line".Operator1::" " then
                                VATBookCalc.CalculateValue(true, ColumnAmt, "VAT Book View Line", "VAT Entry");
                            if "VAT Book View Line".Operator2 <> "VAT Book View Line".Operator2::" " then
                                VATBookCalc.CalculateValue(false, ColumnAmt, "VAT Book View Line", "VAT Entry");
                        end;

                        trigger OnPreDataItem();
                        begin
                            "VAT Book View Line".SetVATEntryFilters("VAT Entry");
                            if VATEntry.GetFilter("Posting Date") <> '' then
                                "VAT Entry".Setfilter("Posting Date", VATEntry.GetFilter("Posting Date"));
                            if VATEntry.GetFilter("Document No.") <> '' then
                                "VAT Entry".Setfilter("Document No.", VATEntry.GetFilter("Document No."));

                            if VATEntry.GetFilter("VAT Bus. Posting Group") <> '' then
                                "VAT Entry".Setfilter("VAT Bus. Posting Group", VATEntry.GetFilter("VAT Bus. Posting Group"));
                            if not FindSet() then
                                NotFoundDetails := true;
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        SetRange("Column No.", "VAT Book Column Name"."Column No.");
                        if not FindSet() then
                            NotFoundDetails := true;
                    end;
                }

                trigger OnPreDataItem();
                begin
                    CompInfo.Get();
                    if not FindSet() then
                        NotFoundDetails := true;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                ColumnNo := 0;
                Evaluate(ColumnNo, Format("Column No."));
                NotFoundDetails := false;
                if not VATBook.Get("VAT Book Code") then;
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
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
        VATBook: Record "VAT Book-Adl";
        CompInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        ColumnAmt: Decimal;
        VATRegNo: Text[20];
        VendCustName: Text[100];
        ColumnNo: Integer;
        NotFoundDetails: Boolean;

    trigger OnPreReport();
    begin
        VATEntry.CopyFilters("VAT Entry");
    end;

    local procedure GetCustVendInfo();
    begin
        VendCustName := '';
        VATRegNo := '';
        with "VAT Entry" do
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

}

