pageextension 13062544 "Vendor Ledger Entries-Adl" extends "Vendor Ledger Entries" //29
{
    layout
    {
        addlast(Control1)
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
            field("KRD Non-Resident Sector Code-Adl"; "KRD Non-Res. Sector Code-Adl")
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
            field("KRD Country/Region Code-Adl"; "KRD Country/Region Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Country/Region Code';
            }
            field("KRD Other Changes-Adl"; "KRD Other Changes-Adl")
            {
                ApplicationArea = all;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Other Changes';
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
