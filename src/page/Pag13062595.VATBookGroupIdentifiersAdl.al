page 13062595 "VAT Book Group Identifiers-Adl"
{
    Caption = 'VAT Book Group Identifiers';
    PageType = List;
    SourceTable = "VAT Book Group Identifier-Adl";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("VAT Identifier"; "VAT Identifier")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for VAT identifier which is selected to VAT book group of various VAT posting setups with similar attributes, for example VAT percentage.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: VATBooks';
                }
            }
        }
    }
}

