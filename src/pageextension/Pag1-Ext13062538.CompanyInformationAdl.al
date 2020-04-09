pageextension 13062538 "Company Information-Adl" extends "Company Information" //1
{
    layout
    {
        // <adl.24>
        addafter("VAT Registration No.")
        {
            field("Registration No.-Adl"; "Registration No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies Registration No.';
                Visible = VATFeatureEnabled;
            }
        }
        // </adl.24>        
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        VATFeatureEnabled: Boolean;
    // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        // </adl.0>
    end;
}
