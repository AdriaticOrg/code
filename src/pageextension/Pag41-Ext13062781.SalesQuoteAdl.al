pageextension 13062781 "Sales Quote-Adl" extends "Sales Quote" //41
{
    layout
    {
        // <adl.20>
        addafter("Shipping and Billing")
        {
            group(Fiscalization)
            {
                field("Fisc. Subject-Adl"; "Fisc. Subject-Adl")
                {
                    ToolTip = 'Specifies Fisc. Subject';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. No. Series-Adl"; "Fisc. No. Series-Adl")
                {
                    ToolTip = 'Specifies Fisc. No. Series';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Terminal-Adl"; "Fisc. Terminal-Adl")
                {
                    ToolTip = 'Specifies Fisc. Terminal';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Location Code-Adl"; "Fisc. Location Code-Adl")
                {
                    ToolTip = 'Specifies Location Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }

                field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
                {
                    ToolTip = 'Specifies Full Fisc. Doc. No.';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
            }
        }
        // </adl.20>
    }


    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        FISCFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;
}
