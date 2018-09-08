pageextension 13062539 "GLAccountCard-adl" extends "G/L Account Card" //17
{
    layout
    {
        // <adl.24>
        addlast(Reporting)
        {
            field("FAS Account"; "FAS Account")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Type"; "FAS Type")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Posting"; "FAS Sector Posting")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Posting"; "FAS Instrument Posting")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code"; "FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code"; "FAS Instrument Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // <adl.26>
            field("BST Value Posting"; "BST Value Posting")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
            }
            field("BST Code"; "BST Code")
            {
                ApplicationArea = All;
                Visible = BSTFeatureEnabled;
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
            action("GLExport")
            {
                Caption = 'GL Export';
                Promoted = true;
                PromotedCategory = Report;
                Image = Report;
                ApplicationArea = All;
                Visible = VATFeatureEnabled;

                trigger OnAction()
                var
                    GLExportSIadl: Report "GL ExportSI-adl";
                    GLAccount: Record "G/L Account";
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
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::BST);
        // </adl.0>
    end;
}