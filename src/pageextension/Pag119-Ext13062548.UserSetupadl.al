pageextension 13062548 "UserSetup-adl" extends "User Setup" //119
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("Reporting_SI Name"; "Reporting_SI Name")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Email"; "Reporting_SI Email")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Phone"; "Reporting_SI Phone")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            field("Reporting_SI Position"; "Reporting_SI Position")
            {
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;
            }
            // </adl.24>
            // <adl.27>
            field("Posting Approver"; "Posting Approver")
            {
                ApplicationArea = All;
                Visible = RepHRFeatureEnabled;
            }
            field("Posting Responsible Person"; "Posting Responsible Person")
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
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        RepHRFeatureEnabled: Boolean;
        RepSIFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        RepHRFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::RepHR);
        RepSIFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::RepSI);
        // </adl.0>
    end;
}