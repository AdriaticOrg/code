pageextension 13062550 "Currencies-adl" extends Currencies //5
{
    layout
    {
        // <adl.24> 
        addlast(Control1)
        {
            field("Numeric Code"; "Numeric Code")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
            }
        }
        // </adl.24>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        ADLCoreEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADL Features"::Core);
        // </adl.0>
    end;
}