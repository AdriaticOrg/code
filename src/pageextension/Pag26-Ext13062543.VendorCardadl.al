pageextension 13062543 "VendorCard-adl" extends "Vendor Card" //26
{
    layout
    {
        addlast(Invoicing)
        {
            // <adl.24>
            field("FAS Sector Code"; "FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // </adl.24>
            // <adl.25>
            field("KRD Non-Residnet Sector Code"; "KRD Non-Residnet Sector Code")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            // </adl.25>
        }
    }

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