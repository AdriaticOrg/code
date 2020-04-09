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
                    ToolTip = 'Specifies ';
                    Visible = FISCFeatureEnabled;
                    TableRelation = Location;
                    ApplicationArea = All;
                }
                field("Fisc. Location Code"; "Fisc. Location Code")
                {
                    ToolTip = 'Specifies ';
                    Visible = FISCFeatureEnabled;
                    TableRelation = "Fiscalization Location-Adl";
                    ApplicationArea = All;
                }
            }
        }
    }
    // </adl.20>

    var
        // <adl.0>
        ADLCore: Record "CoreSetup-Adl";
        FISCFeatureEnabled: Boolean;
    // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;
}