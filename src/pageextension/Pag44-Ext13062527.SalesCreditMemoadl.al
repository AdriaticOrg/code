pageextension 13062527 "Sales Credit Memo-Adl" extends "Sales Credit Memo" //44
{
    layout
    {
        addafter("Posting Date")
        {
            // <adl.6>
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
            // </adl.6>
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // </adl.10>
            // <adl.22>
            field("VAT Correction Date"; "VAT Correction Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
            // </adl.22>
        }

        // <adl.22>
        addafter("EU 3-Party Trade")
        {

            field("EU Customs Procedure"; "EU Customs Procedure-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
        }
        // </adl.22>
        // <adl.18>
        addlast("Credit Memo Details")
        {
            field("Goods Return Type-Adl"; "Goods Return Type-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
        }
        // </adl.18>
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