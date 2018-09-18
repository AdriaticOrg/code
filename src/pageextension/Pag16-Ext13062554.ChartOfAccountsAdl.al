pageextension 13062554 "Chart of Accounts-Adl" extends "Chart of Accounts" //16
{
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
                Visible = VATFeatureEnabled;

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
        VATFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        // </adl.0>
    end;
}