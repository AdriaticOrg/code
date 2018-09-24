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
                ToolTip = 'Specifies FAS Account-Adl';
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code-Adl"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies FAS Instrument Code-Adl';
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies FAS Sector Code-Adl';
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
                ToolTip = 'TODO: Tooltip - Export GL and VAT';
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
                ToolTip = 'TODO: Tooltip - Detail Trial Balance Extended';
                RunObject = report "Detail Trial Balance-Adl";
            }
            // </adl.27>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        FASFeatureEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FAS);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        // </adl.0>
    end;
}