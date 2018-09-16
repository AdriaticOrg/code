pageextension 13062548 "User Setup-Adl" extends "User Setup" //119
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("Reporting_SI Name"; "Reporting_SI Name-Adl")
            {
                Caption = 'Reporting Name';
                ApplicationArea = All;
                Visible = (RepSIFeatureEnabled or UnpaidReceivablesEnabled);
            }
            field("Reporting_SI Email"; "Reporting_SI Email-Adl")
            {
                Caption = 'Reporting E-mail';
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Phone"; "Reporting_SI Phone-Adl")
            {
                Caption = 'Reporting Phone';
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Position"; "Reporting_SI Position-Adl")
            {
                Caption = 'Reporting Position';
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
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        RepHRFeatureEnabled: Boolean;
        RepSIFeatureEnabled: Boolean;
        // </adl.0>
        // <adl.28>
        UnpaidReceivablesEnabled: Boolean;


    trigger OnOpenPage();
    begin
        // <adl.0>
        RepHRFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::RepHR);
        RepSIFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::RepSI);
        UnpaidReceivablesEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables);
        // </adl.0>
    end;
}