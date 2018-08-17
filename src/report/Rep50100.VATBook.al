report 50100 "VAT Book"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep50100.VATBook.rdlc';
    CaptionML = ENU = 'VAT Book',
                SRM = 'PDV knjiga';
    EnableHyperlinks = true;

    dataset
    {
        dataitem("VAT Book Column Name"; "VAT Book Column Name")
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
            dataitem("VAT Book Group"; "VAT Book Group")
            {
                DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                DataItemTableView = sorting ("VAT Book Code", Code) orDER(Ascending);
                RequestFilterFields = "VAT Book Code", "Code";
                column(VatPrewFilters; GetFILTERS) { }
                column(EntryFilter; "VAT Entry".GetFILTERS) { }
                column(VATBookGroupCode; Code) { }
                dataitem("VAT Book View Line"; "VAT Book View Line")
                {
                    DataItemLink = "VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field (Code);
                    DataItemTableView = sorting ("VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.") orDER(Ascending);
                    RequestFilterFields = "VAT Identifier";
                    dataitem("VAT Entry"; "VAT Entry")
                    {
                        DataItemLink = "VAT Identifier" = field ("VAT Identifier");
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
                        column(VATDate_VATEntry; "VAT Date") { }
                        column(BilltoPaytoNo_VATEntry; "Bill-to/Pay-to No.") { }

                        trigger OnAfterGetRecord();
                        begin
                            ColumnAmt := 0;
                            GetCustVendInfo;
                            if "VAT Book View Line".Operator1 <> "VAT Book View Line".Operator1::" " then
                                VATManagement.CalculateValue(true, ColumnAmt, "VAT Book View Line", "VAT Entry");
                            if "VAT Book View Line".Operator2 <> "VAT Book View Line".Operator2::" " then
                                VATManagement.CalculateValue(false, ColumnAmt, "VAT Book View Line", "VAT Entry");
                        end;

                        trigger OnPreDataItem();
                        begin
                            if not FindSet then
                                NotFoundDetails := true;
                        end;
                    }

                    trigger OnPreDataItem();
                    begin
                        SetRange("Column No.", "VAT Book Column Name"."Column No.");
                        if not FindSet then
                            NotFoundDetails := true;
                    end;
                }

                trigger OnAfterGetRecord();
                var
                    VATBookGroupIdentifier: Record "VAT Book Group Identifier";
                    VATIdentifierFilter: Text;
                begin
                end;

                trigger OnPreDataItem();
                begin
                    CompInfo.Get;
                    if not FindSet then
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
        label(PageLbl; ENU = 'Page',
                       SRM = 'Str.')
        label(TitleLbl; ENU = 'VAT Book - VAT',
                        SRM = 'PDV knjiga')
        label(RowNoLbl; ENU = 'No.',
                        SRM = 'Br.')
        label(NameCityLbl; ENU = 'Name, City',
                           SRM = 'Ime, grad')
        label(VATRegNoLbl; ENU = 'VAT reg. No.',
                           SRM = 'Poreski br.')
        label(TotalLbl; ENU = 'Total',
                        SRM = 'Ukupno')
        label(CustVendLbl; ENU = 'Customer/Vendor',
                           SRM = 'Kupac/Dobavljač')
        label(DocumentLbl; ENU = 'Document',
                           SRM = 'Dokument')
        label(VATIdentFilterLbl; ENU = 'VAT Identifier filter:',
                                 SRM = 'Filter identifikatora PDV-a:')
        label(VatDateLbl; ENU = 'VAT Date',
                          SRM = 'Datum PDV-a')
    }

    var
        VATBook: Record "VAT Book";
        CompInfo: Record "Company Information";
        Customer: Record Customer;
        Vendor: Record Vendor;
        VATManagement: Codeunit "VAT Management";
        ColumnAmt: Decimal;
        VATRegNo: Text[20];
        VendCustName: Text[100];
        ColumnNo: Integer;
        NotFoundDetails: Boolean;

    local procedure GetCustVendInfo();
    begin
        VendCustName := '';
        VATRegNo := '';
        with "VAT Entry" do
        begin
            case Type of
                Type::Sale :
                    if Customer.Get("Bill-to/Pay-to No.") then begin
                        if Customer.City <> '' then
                            VendCustName := Customer.Name + ', ' + Customer.City
                        else
                            VendCustName := Customer.Name;
                        VATRegNo := Customer."VAT Registration No.";
                    end;
                Type::Purchase :
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

