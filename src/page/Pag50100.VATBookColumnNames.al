page 50100 "VAT Book Column Names"
{
    CaptionML = ENU = 'VAT Book Column Names',
                SRM = 'Nazivi kolona knjige PDV-a';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "VAT Book Column Name";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Column No."; "Column No.") { }
                field(Description; Description) { }
            }
        }
    }

    procedure SetSelection(var VATBookColumnName: Record "VAT Book Column Name");
    begin
        CurrPage.SetSelectionFilter(VATBookColumnName);
    end;
}

