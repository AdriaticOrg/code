pageextension 13062552 "Currency-adl" extends "Currency Card" //495
{
    layout
    {
        // <adl.24>
        addafter(Code)
        {
            field("Numeric Code"; "Numeric Code")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
            }
        }
        // </adl.24>        
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
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