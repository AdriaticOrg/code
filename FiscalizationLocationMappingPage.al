page 13062609 "Fisc. Location Mapping-ADL"
{
    PageType = List;
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
                }
                field("Fisc. Location Code"; "Fisc. Location Code")
                {
                    TableRelation = "Fiscalization Location-ADL";
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