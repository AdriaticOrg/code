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
                    ToolTip = 'Specifies Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ToolTip = 'Specifies Description';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Official Code"; "Official Code")
                {
                    ToolTip = 'Specifies Official Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Subject to Fiscalization"; "Subject to Fiscalization")
                {
                    ToolTip = 'Specifies Subject to Fiscalization';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Multiple Payment Methods"; "Multiple Payment Methods")
                {
                    ToolTip = 'Specifies Multiple Payment Methods';
                    Visible = FISCFeatureEnabled;
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