pageextension 13062655 "Purchases&PayablesSetup-Adl" extends "Purchases & Payables Setup"  //460
{
    layout
    {
        addlast(General)
        {
            field("Use VAT Output Date-Adl"; "Use VAT Output Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                ToolTip = 'TODO: Tooltip - VAT Date';
            }
        }
    }
    var
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        VATFeatureEnabled: Boolean;

    trigger OnOpenPage();
    begin
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
    end;
}