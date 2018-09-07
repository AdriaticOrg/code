page 13062610 "Fisc. Payment Methods-ADL"
{
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fisc. Payment Method-ADL";
    
    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Code)
                {
                    ApplicationArea = All;
                }
                 field("Official Code"; Code)
                {
                    ApplicationArea = All;
                }
                field("Subject to Fiscalization"; Code)
                {
                    ApplicationArea = All;
                }         
                field("Multiple Payment Methods"; Code)
                {
                    ApplicationArea = All;
                }                         
            }
        }
    }
}