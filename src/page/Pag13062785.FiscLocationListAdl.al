page 13062785 "Fisc. Location List-Adl"
{   // <adl.20>
    Caption = 'Fiscalization Location List';
    UsageCategory = Documents;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Fiscalization Location-Adl";
    CardPageId = "Fisc. Location Card-Adl";
    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Fisc. Location Code"; "Fisc. Location Code")
                {
                    ToolTip = 'Specifies Fisc. Location Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Street"; "Fisc. Street")
                {
                    ToolTip = 'Specifies Fisc. Street';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. House Number"; "Fisc. House Number")
                {
                    ToolTip = 'Specifies Fisc. House Number';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. House Number Appendix"; "Fisc. House Number Appendix")
                {
                    ToolTip = 'Specifies Fisc. House Number Appendix';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Settlement"; "Fisc. Settlement")
                {
                    ToolTip = 'Specifies Fisc. Settlement';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. City/Municipality"; "Fisc. City/Municipality")
                {
                    ToolTip = 'Specifies Fisc. City/Municipality';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Post Code"; "Fisc. Post Code")
                {
                    ToolTip = 'Specifies Fisc. Post Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Location Description"; "Fisc. Location Description")
                {
                    ToolTip = 'Specifies Fisc. Location Description';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Working Hours"; "Working Hours")
                {
                    ToolTip = 'Specifies Working Hours';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Date Of Application"; "Date Of Application")
                {
                    ToolTip = 'Specifies Date Of Application';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. No. Series"; "Fisc. No. Series")
                {
                    ToolTip = 'Specifies Fisc. No. Series';
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Fisc. Active"; "Fisc. Active")
                {
                    ToolTip = 'Specifies Fisc. Active';
                    Visible = FISCFeatureEnabled;
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Creation Date"; "Creation Date")
                {
                    ToolTip = 'Specifies Creation Date';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Creation Time"; "Creation Time")
                {
                    ToolTip = 'Specifies Creation Time';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ToolTip = 'Specifies User ID';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Ending Date"; "Ending Date")
                {
                    ToolTip = 'Specifies Ending Date';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Fiscalization Location Mapping")
            {
                Visible = FISCFeatureEnabled;
                ApplicationArea = all;
                trigger OnAction()
                var
                    FiscalizationLocationMapping: Record "Fiscalization Loc. Mapping-Adl";
                    FiscalizationLocationMappingPage: Page "Fisc. Location Mapping-Adl";
                begin
                    FiscalizationLocationMapping.SETRANGE("Fisc. Location Code", "Fisc. Location Code");
                    FiscalizationLocationMappingPage.SETTABLEVIEW(FiscalizationLocationMapping);
                    FiscalizationLocationMappingPage.RUNMODAL();
                end;
            }
        }
    }
    // </adl.20>

    var
        // <adl.0
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