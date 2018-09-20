pageextension 13062536 "VAT Posting Setup-Adl" extends "VAT Posting Setup"  //472
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
                ToolTip = 'Specifies VAT Identifier for combination of VAT posting.';
                Visible = VATFeatureEnabled;
                TableRelation = "VAT Identifier-Adl";
            }
            // <adl.11>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                ToolTip = 'Specifies percent for VAT Retrograde posting.';
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
                ToolTip = 'Input informative VAT % which will be calculated and shown only on Sales Invoice Document as informative VAT.';
            }
        }
        // </adl.13>
        // <adl.22>
        addlast(Control1)
        {
            field("VIES Goods-Adl"; "VIES Goods-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("VIES Service-Adl"; "VIES Service-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
        }
        // </adl.22>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        VIESFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        VIESFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VIES);
        // </adl.0>
    end;
}