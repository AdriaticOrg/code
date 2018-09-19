page 13062786 "Fisc. Location Mapping-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Location Mapping';
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fiscalization Loc. Mapping-Adl";

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
                    TableRelation = "Fiscalization Location-Adl";
                    ApplicationArea = All;
                }
            }
        }
    }
    // </adl.20>
}