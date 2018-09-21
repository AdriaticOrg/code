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
                ToolTip = 'Specifies which date is used for posting VAT.';
            }
            // </adl.6>
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'Describes what type of VAT is posted. If VAT Date is not equal to Posting Date then is Postponed VAT.';
            }
            // </adl.10>
            // <adl.22>
            field("VAT Correction Date-Adl"; "VAT Correction Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            // </adl.22>
        }

        // <adl.22>
        addafter("EU 3-Party Trade")
        {

            field("EU Customs Procedure-Adl"; "EU Customs Procedure-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
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
                ToolTip = 'Select Goods Return Type if it is goods return transaction';
            }
        }
        // </adl.18>
        // <adl.20>
        addafter(Billing)
        {
            group(Fiscalization)
            {
                field("Fisc. Subject-Adl"; "Fisc. Subject-Adl")
                {

                }
                field("Fisc. No. Series-Adl"; "Fisc. No. Series-Adl")
                {

                }
                field("Fisc. Terminal-Adl"; "Fisc. Terminal-Adl")
                {

                }
                field("Fisc. Location Code-Adl"; "Fisc. Location Code-Adl")
                {

                }

                field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
                {

                }
            }
        }
        // </adl.20>
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