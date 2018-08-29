page 13062593 "VAT Book Column Names-Adl"
{
    Caption = 'VAT Book Column Names';
    PageType = List;
    SourceTable = "VAT Book Column Name-Adl";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Column No."; "Column No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies column number which is used as setup for VAT reporting and XML.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the VAT book columns.';
                }
            }
        }
    }

    procedure SetSelection(var VATBookColumnName: Record "VAT Book Column Name-Adl");
    begin
        CurrPage.SetSelectionFilter(VATBookColumnName);
    end;
}

