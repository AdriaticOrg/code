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
                ToolTip = 'Specifies if negative transfers are posted as correction.';
            }
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        RedReversalEnable: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        RedReversalEnable := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        // </adl.0>
    end;
}