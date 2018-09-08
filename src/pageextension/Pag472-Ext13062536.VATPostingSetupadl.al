pageextension 13062536 "VATPostingSetup-Adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        // <adl.14>
        modify("VAT Identifier")
        {
            Visible = not VATFeatureEnabled;
        }
        addafter("VAT Identifier")
        {
            field("VAT Identifier-Adl"; "VAT Identifier")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                TableRelation = "VAT Identifier-Adl";
            }
            // <adl.11>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
            // </adl.11>
        }
        // </adl.14>
        // <adl.13>
        addafter("VAT %")
        {
            field("VAT % (Informative)-Adl"; "VAT % (Informative)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
        }
        // </adl.13>
        // <adl.22>
        addlast(Control1)
        {
            field("VIES Goods Sales"; "VIES Goods Sales")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
            }
            field("VIES Service Sales"; "VIES Service Sales")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
            }
        }
        // </adl.22>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        VIESFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::VAT);
        VIESFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::VIES);
        // </adl.0>
    end;
}