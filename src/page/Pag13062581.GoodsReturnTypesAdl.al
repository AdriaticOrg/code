page 13062581 "Goods Return Types-Adl"
{
    Caption = 'Goods Return Types';
    PageType = List;
    SourceTable = "Goods Return Type-Adl";
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
                    ToolTip = 'Specifies a code for Goods Return Type';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the Goods Return Type';
                }
                field("VAT Bus. Posting Group"; "VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a VAT Bus. Posting Group on which this Goods Return Type have impact';
                }
                field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a VAT Prod. Posting Group on which this Goods Return Type have impact';
                }
                field("New VAT Prod. Posting Group"; "New VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies New VAT Prod. Posting Group for this Goods Return Type';
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