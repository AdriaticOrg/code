pageextension 13062544 "VendLedgEntries-adl" extends "Vendor Ledger Entries" //29
{
    layout
    {
        addlast(Control1)
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
            field("KRD Affiliation Type"; "KRD Affiliation Type")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Claim/Liability"; "KRD Claim/Liability")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Instrument Type"; "KRD Instrument Type")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Maturity"; "KRD Maturity")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Country/Region Code"; "KRD Country/Region Code")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Other Changes"; "KRD Other Changes")
            {
                ApplicationArea = all;
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