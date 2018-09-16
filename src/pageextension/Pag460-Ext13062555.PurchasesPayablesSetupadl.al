pageextension 13062555 "Purchases&PayablesSetup-Adl" extends "Purchases & Payables Setup"  //460
{
    layout
    {
        addlast(General)
        {
            field("Use VAT Output Date-Adl"; "Use VAT Output Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
        }
    }
    var
        ADLCore: Codeunit "Adl Core";
        CoreSetup: Record "CoreSetup-Adl";
        VATFeatureEnabled: Boolean;

    trigger OnOpenPage();
    begin
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
    end;
}