page 13062786 "Fisc. Location Mapping-Adl"
{
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fiscalization Loc. Mapping-ADL";
    
    layout
    {
        area(content)
        {
            repeater(GroupName)
            {
                field("Location Code"; "Location Code")
                {
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Fisc. Location Code"; "Fisc. Location Code")
                {
                    TableRelation = "Fiscalization Location-ADL";
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}