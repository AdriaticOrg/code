pageextension 13062742 "SalesJournal-adl" extends "Sales Journal" //253 
{
    layout
    {

        addlast(Control1)
        {
            // <adl.28>
            field("Original Document Amount (LCY)"; "Original Document Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original Document Amount (LCY)';
                Visible = RepHRFeatureEnabled;
            }
            field("Original VAT Amount (LCY)"; "Original VAT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original VAT Amount (LCY)';
                Visible = RepHRFeatureEnabled;
            }
            // </adl.28>
        }

    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        RepHRFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        RepHRFeatureEnabled := ADLCore.FeatureEnabled("ADL Features"::RepHR);
        // </adl.0>
    end;
}