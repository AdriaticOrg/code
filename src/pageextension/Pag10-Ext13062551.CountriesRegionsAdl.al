pageextension 13062551 "Countries/Regions-Adl" extends "Countries/Regions" //10
{
    layout
    {
        // <adl.24>
        addlast(Control1)
        {
            field("Numeric Code-Adl"; "Numeric Code-Adl")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Numeric Code';
                Visible = FASFeatureEnabled;
            }
        }
        // </adl.24>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        FASFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FAS);
        // </adl.0>
    end;
}
