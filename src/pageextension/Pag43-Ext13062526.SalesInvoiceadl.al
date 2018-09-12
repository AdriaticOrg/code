pageextension 13062526 "Sales Invoice-Adl" extends "Sales Invoice" //43
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
            field("VAT Output Date-Adl"; "VAT Output Date-Adl")
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
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
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