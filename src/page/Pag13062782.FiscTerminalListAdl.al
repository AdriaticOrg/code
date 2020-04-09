page 13062782 "Fisc. Terminal List-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Terminal List';
    PageType = List;
    UsageCategory = Documents;
    ApplicationArea = All;
    SourceTable = "Fiscalization Terminal-Adl";
    SourceTableView = SORTING("Fisc. Terminal Code", "Fisc. Location Code", "User ID");

    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Fisc. Terminal Code"; "Fisc. Terminal Code")
                {
                    ToolTip = 'Specifies Fisc. Terminal Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ToolTip = 'Specifies Name';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. No. Series"; "Fisc. No. Series")
                {
                    ToolTip = 'Specifies Fisc. No. Series';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    Visible = FISCFeatureEnabled AND VisibleHR;
                    ToolTip = 'Specifies User ID';
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

            }
        }
    }

    var
        ADLcore: Record "CoreSetup-Adl";
        VisibleHR: Boolean;
        //UNUSED//VisibleSI: Boolean;
        FISCFeatureEnabled: Boolean;

    trigger OnInit()
    var
        FiscalizationSetup: Record "Fiscalization Setup-Adl";
    begin
        FiscalizationSetup.GET();
        CASE TRUE OF
            // SI
            //UNUSED//FiscalizationSetup.CountryCodeSI:
            //UNUSED//VisibleSI := TRUE;
            // HR
            FiscalizationSetup.CountryCodeHR():
                VisibleHR := TRUE;
        END;
    end;

    trigger OnOpenPage();
    begin
        // <adl.0>
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;

    // </adl.20>
}