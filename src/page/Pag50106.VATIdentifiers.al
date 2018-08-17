page 50106 "VAT Identifiers"
{
    CaptionML = ENU = 'VAT Identifiers',
                SRM = 'Identifikatori za PDV';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "VAT Identifier";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Code"; Code) { }
                field(Description; Description) { }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
    }
}

