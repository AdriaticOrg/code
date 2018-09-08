pageextension 13062538 "CompanyInfo-adl" extends "Company Information" //1
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
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        VATFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::VAT);
        // </adl.0>
    end;
}