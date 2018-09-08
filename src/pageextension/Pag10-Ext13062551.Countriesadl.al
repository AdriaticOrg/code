pageextension 13062551 "Countries-adl" extends "Countries/Regions" //10
{
    layout
    {
        // <adl.24>
        addlast(Control1)
        {
            field("Numeric Code"; "Numeric Code")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
        }
        // </adl.24>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        FASFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::FAS);
        // </adl.0>
    end;
}