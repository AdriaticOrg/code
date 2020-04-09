pageextension 13062552 "Currency Card-Adl" extends "Currency Card" //495
{
    layout
    {
        // <adl.24>
        addafter(Code)
        {
            field("Numeric Code-Adl"; "Numeric Code-Adl")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
                ToolTip = 'Specifies Numeric Code';
            }
        }
        // </adl.24>        
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        ADLCoreEnabled: Boolean;
    // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::Core);
        // </adl.0>
    end;
}
