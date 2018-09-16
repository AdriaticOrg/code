pageextension 13062550 "Currencies-Adl" extends Currencies //5
{
    layout
    {
        // <adl.24> 
        addlast(Control1)
        {
            field("Numeric Code"; "Numeric Code-Adl")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
            }
        }
        // </adl.24>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        // </adl.0>
    end;
}