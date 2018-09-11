pageextension 13062548 "UserSetup-adl" extends "User Setup" //119
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("Reporting_SI Name"; "Reporting_SI Name-Adl")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Email"; "Reporting_SI Email-Adl")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Phone"; "Reporting_SI Phone-Adl")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Position"; "Reporting_SI Position-Adl")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            // </adl.24>
            // <adl.27>
            field("Posting Approver"; "Posting Approver-Adl")
            {
                ApplicationArea = All;
                Visible = RepHRFeatureEnabled;
            }
            field("Posting Responsible Person"; "Posting Responsible Person-Adl")
            {
                ApplicationArea = All;
                Visible = RepHRFeatureEnabled;
            }
            // </adl.27>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        CoreSetup: Record "CoreSetup-Adl";
        RepHRFeatureEnabled: Boolean;
        RepSIFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        RepHRFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::RepHR);
        RepSIFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::RepSI);
        // </adl.0>
    end;
}