pageextension 13062553 "General Ledger Setup-Adl" extends "General Ledger Setup" //118
{
    layout
    {
        // <adl.27>
        addlast(General)
        {
            field("Global Posting Approver-Adl"; "Global Posting Approver-Adl")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
                ToolTip = 'TODO: Tooltip - Detail Trial Balance Extended';
            }
            field("Global Posting Resp. Person-Adl"; "Global Posting Resp. Person-Adl")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
                ToolTip = 'TODO: Tooltip - Detail Trial Balance Extended';
            }
        }
        // </adl.27>
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