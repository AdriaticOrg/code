pageextension 13062548 "User Setup-Adl" extends "User Setup" //119
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("Reporting Name"; "Reporting Name-Adl")
            {
                Caption = 'Reporting Name';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
            }
            field("Reporting Email"; "Reporting Email-Adl")
            {
                Caption = 'Reporting E-mail';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
            }
            field("Reporting Phone"; "Reporting Phone-Adl")
            {
                Caption = 'Reporting Phone';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
            }
            field("Reporting Position"; "Reporting Position-Adl")
            {
                Caption = 'Reporting Position';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
            }
            // </adl.24>
            // <adl.27>
            field("Posting Approver"; "Posting Approver-Adl")
            {
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
            }
            field("Posting Responsible Person"; "Posting Responsible Person-Adl")
            {
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
            }
            // </adl.27>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        ReportingFeaturesEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD);
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::BST);
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VIES);
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::PDO);
        ReportingFeaturesEnabled := ReportingFeaturesEnabled or ADLCore.FeatureEnabled(CoreSetup."ADL Features"::UnpaidReceivables);
        // </adl.0>
    end;
}