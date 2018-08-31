page 13062591 "VAT Identifiers-Adl"
{
    Caption = 'VAT Identifiers';
    PageType = List;
    SourceTable = "VAT Identifier-Adl";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {

            repeater(Lines)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for VAT identifier which is selected to group of various VAT posting setups with similar attributes, for example VAT percentage.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the VAT identifier';
                }
            }
        }

        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }
}

