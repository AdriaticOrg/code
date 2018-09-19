pageextension 13062558 "Accountant Role Center-Adl" extends "Accountant Role Center" // 9027
{
    actions
    {
        addafter("VAT Statements")
        {
            action("VAT Books-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                RunObject = page "VAT Books-Adl";
                ToolTip = 'TODO: Tooltip - VATBooks';
            }
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        CoreSetup: Record "CoreSetup-Adl";
        VATFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        // </adl.0>
    end;
}