pageextension 13062545 "GenJournal-adl" extends "General Journal" //39
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Type"; "FAS Type")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Instrument Code"; "FAS Instrument Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("FAS Sector Code"; "FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("Bal. FAS Type"; "Bal. FAS Type")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("Bal. FAS Instrument Code"; "Bal. FAS Instrument Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("Bal. FAS Sector Code"; "Bal. FAS Sector Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            // </adl.24>

            // <adl.28>
            field("Original Document Amount (LCY)"; "Original Document Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original Document Amount (LCY)';
                Visible = ADLCoreEnabled;
            }
            field("Original VAT Amount (LCY)"; "Original VAT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original VAT Amount (LCY)';
                Visible = ADLCoreEnabled;
            }
            // </adl.28>
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