report 13062592 "VAT Calc. Details-Adl"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/reportlayout/Rep13062592.VATCalcDetailsAdl.rdlc';

    Caption = 'VAT Calculation Details';
    EnableHyperlinks = true;

    dataset
    {
        dataitem("VAT Book Column Name"; "VAT Book Column Name-Adl")
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
            dataitem("VAT Book Group"; "VAT Book Group-Adl")
            {
                DataItemLink = "VAT Book Code" = field ("VAT Book Code");
                DataItemTableView = sorting ("VAT Book Code", Code) orDER(Ascending);
                column(VATBookGroupCode; Code) { }
                column(GroupDescription; Description) { }
                column(Amount; VATManagement.EvaluateExpression("VAT Book Group", "VAT Book Column Name"."Column No.", SetedDateFilter)) { }

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
                    Caption = 'Options';
                    field(SetedDateFilter; SetedDateFilter)
                    {
                        Caption = 'Date Filter';
                        ApplicationArea = All;

                        trigger OnValidate();
                        var
                            TextManagement: Codeunit TextManagement; 
                        begin
                            TextManagement.MakeDateFilter(SetedDateFilter); 
                        end;
                    }
                    field(SetedBookFilter; SetedBookFilter)
                    {
                        Caption = 'VAT Book Filter';
                        ApplicationArea = All;

                        trigger OnLookup(Text: Text): Boolean;
                        var
                            VATBook: Record "VAT Book-Adl";
                            VATBooks: Page "VAT Books-Adl";
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
        TitleLbl = 'VAT Book - VAT';
        PageLbl = 'Page';
        RowNoLbl = 'No.';
        NameCityLbl = 'Name, City';
        VATRegNoLbl = 'VAT reg. No.';
        TotalLbl = 'Total';
        CustVendLbl = 'Customer/Vendor';
        DocumentLbl = 'Document';
    }

    var
        VATBook: Record "VAT Book-Adl";
        CompInfo: Record "Company Information";
        VATManagement: Codeunit "VAT Management-Adl";
        ColumnNo: Integer;
        SetedDateFilter: Text;
        SetedBookFilter: Text;

    procedure SetParameters(var DateFilter: Text; var BookCode: Code[20]);
    begin
        SetedDateFilter := DateFilter;
        SetedBookFilter := BookCode;
    end;

}