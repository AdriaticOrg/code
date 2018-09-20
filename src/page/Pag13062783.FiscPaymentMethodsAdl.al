page 13062783 "Fisc. Payment Methods-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Payment Methods';
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fisc. Payment Method-Adl";

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
    // </adl.20>
}