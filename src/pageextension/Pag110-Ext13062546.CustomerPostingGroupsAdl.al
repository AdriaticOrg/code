pageextension 13062546 "Customer Posting Groups-Adl" extends "Customer Posting Groups" //110
{
    layout
    {
        addlast(Control1)
        {
            // <adl.25>
            field("KRD Claim/Liability-Adl"; "KRD Claim/Liability-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Claim/Liability';
            }
            field("KRD Instrument Type-Adl"; "KRD Instrument Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Instrument Type';
            }
            field("KRD Maturity-Adl"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Maturity';
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
