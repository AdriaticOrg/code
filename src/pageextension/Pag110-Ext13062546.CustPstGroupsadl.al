pageextension 13062546 "CustPstGroups-adl" extends "Customer Posting Groups" //110
{
    layout
    {
        addlast(Control1)
        {
            // <adl.25>
            field("KRD Claim/Liability"; "KRD Claim/Liability-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Instrument Type"; "KRD Instrument Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Maturity"; "KRD Maturity-Adl")
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