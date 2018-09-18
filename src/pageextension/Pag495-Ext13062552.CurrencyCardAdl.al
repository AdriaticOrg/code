pageextension 13062552 "Currency Card-Adl" extends "Currency Card" //495
{
    layout
    {
        // <adl.24>
        addafter(Code)
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