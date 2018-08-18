report 50101 "VAT Calc. Details"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/VAT Calc. Details.rdlc';

    CaptionML = ENU = 'VAT Calculation Details',
                SRM = 'Obračun PDV-a';
    EnableHyperlinks = true;

    dataset
    {
        dataitem("VAT Book Column Name"; "VAT Book Column Name")
        {
            DataItemTableView = sorting ("VAT Book Code", "Column No.") orDER(Ascending);
            column(Company_VAT_Reg_No; CompInfo."VAT Registration No.") { }
            column(Company_City; CompInfo."Post Code" + ' ' + CompInfo.City) { }
            column(Company_Address; CompInfo.Address + ' ' + CompInfo."Address 2") { }
            column(Company_Name; CompInfo.Name + ' ' + CompInfo."Name 2") { }
            column(VATBookCode; "VAT Book Code") { }
            column(VatPrewFilters; GetFILTERS) { }
            column(FromToDate; SetedDateFilter) { }
            column(ColumnNo; ColumnNo) { }
            column(ColumnDescription; Description) { }
            column(BookDescription; VATBook.Description) { }
            column(VATBookSorting; VATBook."Sorting Appearance") { }
            dataitem("VAT Book Group"; "VAT Book Group")
            {
                DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                DataItemTableView = sorting ("VAT Book Code", Code) orDER(Ascending);
                column(VATBookGroupCode; Code) { }
                column(GroupDescription; Description) { }
                column(Amount; VATManagement.EvaluateExpression("VAT Book Group", "VAT Book Column Name"."Column No.", SetedDateFilter)) { }

                trigger OnAfterGetRecord();
                var
                    VATBookGroupIdentifier: Record "VAT Book Group Identifier";
                    VATIdentifierFilter: Text;
                begin
                end;

                trigger OnPreDataItem();
                begin
                    SetRange("VAT Book Code", "VAT Book Column Name"."VAT Book Code");
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Evaluate(ColumnNo, Format("Column No."));
                VATBook.Get("VAT Book Code");
            end;

            trigger OnPreDataItem();
            begin
                if SetedBookFilter <> '' then
                    SetFilter("VAT Book Code", SetedBookFilter);
                CompInfo.Get;
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
                group(Options)
                {
                    CaptionML = ENU = 'Options',
                                SRM = 'Opcije';
                    field(SetedDateFilter; SetedDateFilter)
                    {
                        CaptionML = ENU = 'Date Filter',
                                    SRM = 'Filter datuma';

                        trigger OnValidate();
                        var
                            ApplicationManagement: Codeunit ApplicationManagement;
                        begin
                            ApplicationManagement.MakeDateFilter(SetedDateFilter);
                        end;
                    }
                    field(SetedBookFilter; SetedBookFilter)
                    {
                        CaptionML = ENU = 'VAT Book Filter',
                                    SRM = 'Filter PDV knjige';

                        trigger OnLookup(Text: Text): Boolean;
                        var
                            VATBook: Record "VAT Book";
                            VATBooks: Page "VAT Books";
                        begin
                            VATBook.Reset;
                            Clear(VATBooks);
                            VATBooks.LookupMode(true);
                            if VATBooks.RunModal = ACTION::LookupOK then begin
                                VATBooks.SetSelection(VATBook);
                                SetedBookFilter := '';
                                VATBook.MarkedOnly(true);
                                if VATBook.FindSet then begin
                                    repeat
                                    if SetedBookFilter = '' then
                                        SetedBookFilter := VATBook.Code
                                    else
                                        SetedBookFilter += '|' + VATBook.Code;
                                    until VATBook.Next = 0;
                                end;
                            end;
                        end;
                    }
                }
            }
        }
    }

    labels
    {
        label(TitleLbl; ENU = 'VAT Book - VAT',
                       SRM = 'PREGLED OBRAČUNA PDV')
        label(PageLbl; ENU = 'Page',
                      SRM = 'Str.')
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
    }

    var
        VATBook: Record "VAT Book";
        CompInfo: Record "Company Information";
        VATManagement: Codeunit "VAT Management";
        ColumnNo: Integer;
        SetedDateFilter: Text;
        SetedBookFilter: Text;

    procedure SetParameters(var DateFilter: Text; var BookCode: Code[20]);
    begin
        SetedDateFilter := DateFilter;
        SetedBookFilter := BookCode;
    end;

}