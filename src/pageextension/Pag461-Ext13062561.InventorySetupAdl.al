pageextension 13062561 "Inventory Setup-Adl" extends "Inventory Setup" //461
{
    layout
    {
        addlast(General)
        {
            field("Post Neg. Transfers as Corr.-Adl"; "Post Neg. Transfers as Corr.-Adl")
            {
                ApplicationArea = All;
                Visible = RedReversalEnable;
                ToolTip = 'TODO: Tooltip - VAT Date';
            }
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        RedReversalEnable: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        RedReversalEnable := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        // </adl.0>
    end;
}