pageextension 13062539 "G/L Account Card-Adl" extends "G/L Account Card" //17
{
    layout
    {
        // <adl.24>
        addlast(Reporting)
        {
            field("FAS Account-Adl"; "FAS Account-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("FAS Type-Adl"; "FAS Type-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("FAS Sector Posting-Adl"; "FAS Sector Posting-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("FAS Instrument Posting-Adl"; "FAS Instrument Posting-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("FAS Instrument Code-Adl"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            // <adl.26>
            field("BST Value Posting-Adl"; "BST Value Posting-Adl")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("BST Code-Adl"; "BST Code-Adl")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            // </adl.26>
        }
        // </adl.24>
    }
    actions
    {
        addafter("A&ccount")
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
        }
    }
    // </adl.24>

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::BST);
        // </adl.0>
    end;
}