pageextension 13062538 "Company Information-Adl" extends "Company Information" //1
{
    layout
    {
        // <adl.24>
        addafter("VAT Registration No.")
        {
            field("Registration No."; "Registration No.")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
        }
        // </adl.24>        
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