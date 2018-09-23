pageextension 13062548 "User Setup-Adl" extends "User Setup" //119
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("Reporting Name-Adl"; "Reporting Name-Adl")
            {
                Caption = 'Reporting Name';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
                ToolTip = 'Specifies Reporting Name-Adl';
            }
            field("Reporting Email-Adl"; "Reporting Email-Adl")
            {
                Caption = 'Reporting E-mail';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
                ToolTip = 'Specifies Reporting Email-Adl';
            }
            field("Reporting Phone-Adl"; "Reporting Phone-Adl")
            {
                Caption = 'Reporting Phone';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
                ToolTip = 'Specifies Reporting Phone-Adl';
            }
            field("Reporting Position-Adl"; "Reporting Position-Adl")
            {
                Caption = 'Reporting Position';
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
                ToolTip = 'Specifies Reporting Position-Adl';
            }
            // </adl.24>
            // <adl.27>
            field("Posting Approver-Adl"; "Posting Approver-Adl")
            {
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
                ToolTip = 'TODO: Tooltip - Detail Trial Balance Extended';
            }
            field("Posting Responsible Person-Adl"; "Posting Responsible Person-Adl")
            {
                ApplicationArea = All;
                Visible = ReportingFeaturesEnabled;
                ToolTip = 'TODO: Tooltip - Detail Trial Balance Extended';
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