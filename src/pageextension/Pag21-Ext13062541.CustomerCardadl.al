pageextension 13062541 "Customer Card-Adl" extends "Customer Card" //21
{
    layout
    {
        addlast(Invoicing)
        {
            // <adl.24>
            field("FAS Sector Code"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // </adl.24>
            // <adl.25>
            field("KRD Non-Residnet Sector Code"; "KRD Non-Residnet Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Affiliation Type"; "KRD Affiliation Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            // <adl.25>
        }
    }
    // <adl.25>   
    actions
    {
        addlast(Documents)
        {
            action("Show Vendors")
            {
                RunObject = page "Vendor List";
                ApplicationArea = All;
            }
        }
    }
    // </adl.25>

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
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