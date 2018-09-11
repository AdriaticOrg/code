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
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                 field("Official Code"; "Official Code")
                {
                    ApplicationArea = All;
                }
                field("Subject to Fiscalization"; "Subject to Fiscalization")
                {
                    ApplicationArea = All;
                }         
                field("Multiple Payment Methods"; "Multiple Payment Methods")
                {
                    ApplicationArea = All;
                }                         
            }
        }
    }
}