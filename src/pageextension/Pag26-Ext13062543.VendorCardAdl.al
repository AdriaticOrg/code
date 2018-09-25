pageextension 13062543 "Vendor Card-Adl" extends "Vendor Card" //26
{
    layout
    {
        addlast(Invoicing)
        {
            // <adl.24>
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Sector Code';
            }
            // </adl.24>
            // <adl.25>
            field("KRD Non-Resident Sector Code-Adl"; "KRD Non-Resident Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Non-Resident Code';
            }
            field("KRD Affiliation Type-Adl"; "KRD Affiliation Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Affiliation Type';
            }
            // </adl.25>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::BST);
        // </adl.0>
    end;
}
