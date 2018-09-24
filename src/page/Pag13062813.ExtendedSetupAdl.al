page 13062813 "Extended Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Extended Setup-Adl";
    Caption = 'Adriatic Extended Setup';

    layout
    {
        area(Content)
        {
            group(VIES)
            {
                Caption = 'VAT';
                field("Use VAT Output Date-Adl"; "Use VAT Output Date-Adl")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if VAT Output Date is used when posting document.';
                }
            }
        }
    }
}