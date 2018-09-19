pageextension 13062537 "VAT Posting Setup Card-Adl" extends "VAT Posting Setup Card"  //473
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
                ToolTip = 'TODO: Tooltip - VAT Identifier';
                Visible = VATFeatureEnabled;
                TableRelation = "VAT Identifier-Adl";
            }
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
        addafter("Tax Category")
        {
            // <adl.11>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Full VAT Posting';
            }
            // </adl.11>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        // </adl.0>
    end;
}