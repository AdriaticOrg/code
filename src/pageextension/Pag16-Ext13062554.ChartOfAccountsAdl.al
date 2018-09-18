pageextension 13062554 "Chart of Accounts-Adl" extends "Chart of Accounts" //16
{
    layout
    {
        // <adl.24>
        addlast(Control1)
        {
            field("FAS Account-Adl"; "FAS Account-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code-Adl"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
        }
        // </adl.24>
    }
    actions
    {

        addlast(Reporting)
        {
            // <adl.21>
            action("GLExport-Adl")
            {
                Caption = 'GL Export';
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                ApplicationArea = All;
                Visible = RepSIFeatureEnabled;

                trigger OnAction()
                var
                    GLAccount: Record "G/L Account";
                    GLExportSIadl: Report "GL ExportSI-Adl";
                begin
                    GLAccount := Rec;
                    GLAccount.SetRecFilter();
                    GLExportSIadl.SetTableView(GLAccount);
                    GLExportSIadl.RunModal();
                end;
            }
            // </adl.21> 

            // <adl.27>
            action("DetailTrialBalance-Adl")
            {
                Caption = 'Detail Trial Balance Extended';
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                ApplicationArea = All;
                RunObject = report "Detail Trial Balance-Adl";
            }
            // </adl.27>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        RepSIFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        RepSIFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::RepSI);
        FASFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        // </adl.0>
    end;
}