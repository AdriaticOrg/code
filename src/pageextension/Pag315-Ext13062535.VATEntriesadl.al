pageextension 13062535 "VAT Entries-Adl" extends "VAT Entries"  //315
{
    layout
    {
        // <adl.10>
        addafter("Posting Date")
        {
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // <adl.22> 
            field("VAT Correction Date"; "VAT Correction Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // </adl.22> 
        }
        // </adl.10>
        // <adl.14>
        addafter(Amount)
        {
            field("VAT Identifier"; "VAT Identifier-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                //Editable = false;
                TableRelation = "VAT Identifier-Adl";
            }
        }
        // </adl.14>
        // <adl.22> 
        addbefore("EU 3-Party Trade")
        {
            field("EU Customs Procedure"; "EU Customs Procedure-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
            }
            // </adl.14>
            // <adl.10>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // </adl.10>
            // <adl.10>
            field("VAT Base (retro.)-Adl"; "VAT Base (retro.)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                //Editable = false;
            }
            // </adl.10>
        }
        // </adl.22> 
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        CoreSetup: Record "CoreSetup-Adl";
        VATFeatureEnabled: Boolean;
        VIESFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        VIESFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VIES);
        // </adl.0>
    end;
}