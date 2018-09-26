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
                ToolTip = 'Describes what type of VAT is posted. If VAT Date is not equal to Posting Date then is Postponed VAT.';
            }
            // <adl.22> 
            field("VAT Correction Date-Adl"; "VAT Correction Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'Specifies VAT Correction Date';
            }
            // </adl.22> 
        }
        // </adl.10>
        // <adl.14>
        addafter(Amount)
        {
            field("VAT Identifier-Adl"; "VAT Identifier-Adl")
            {
                ApplicationArea = All;
                ToolTip = 'TODO: Tooltip - VAT Identifier';
                Visible = VATFeatureEnabled;
                // Editable = false;
                TableRelation = "VAT Identifier-Adl";
            }
        }
        // </adl.14>
        // <adl.22> 
        addbefore("EU 3-Party Trade")
        {
            field("EU Customs Procedure-Adl"; "EU Customs Procedure-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
                ToolTip = 'Specifies EU Customs Procedure';
            }
            // </adl.14>
            // <adl.10>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'Specifies percent for VAT Retrograde posting.';
            }
            // </adl.10>
            // <adl.10>
            field("VAT Base (retro.)-Adl"; "VAT Base (retro.)-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                // Editable = false;
                ToolTip = 'Specifies base for VAT Retrograde posting.';
            }
            // </adl.10>
        }
        // </adl.22> 
        // <adl.20>
        addlast(Control1)
        {
            field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
            {
                Visible = FISCFeatureEnabled;
                ApplicationArea = All;
            }
        }
        // </adl.20>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        VATFeatureEnabled: Boolean;
        VIESFeatureEnabled: Boolean;
        FISCFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        VIESFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VIES);
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;
}
