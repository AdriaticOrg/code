pageextension 13062549 "BankAccountCard-adl" extends "Bank Account Card" //370
{
    layout
    {
        addlast(General)
        {
            // <adl.24>
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
            // </adl.24>
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