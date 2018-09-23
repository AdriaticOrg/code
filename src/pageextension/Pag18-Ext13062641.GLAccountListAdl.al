pageextension 13062641 "G/L Account List-Adl" extends "G/L Account List" //18
{
    layout
    {
        // <adl.24>
        addlast(Control1)
        {
            field("FAS Account-Adl"; "FAS Account-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Account-Adl';
            }
            field("FAS Instrument Code-Adl"; "FAS Instrument Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Instrument Code-Adl';
            }
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Sector Code-Adl';
            }
        }
        // </adl.24>
    }
    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        FASFeatureEnabled: Boolean;
        // </adl.0>
    trigger OnOpenPage();
    begin
        // <adl.0>
        FASFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        // </adl.0>
    end;
}