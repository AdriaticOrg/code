page 13062599 "VAT Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "VAT Setup-Adl";
    Caption = 'VAT Setup';

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
                    ToolTip = 'TODO: Tooltip - VAT Date';
                }
            }
        }
    }
}