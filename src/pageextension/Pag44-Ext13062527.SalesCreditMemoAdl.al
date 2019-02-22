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
                ToolTip = 'Specifies VAT Correction Date';
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
                ToolTip = 'Specifies EU Customs Procedure';
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
            group("Fiscalization-Adl")
            {
                field("Fisc. Subject-Adl"; "Fisc. Subject-Adl")
                {
                    ToolTip = 'Specifies Fisc. Subject';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. No. Series-Adl"; "Fisc. No. Series-Adl")
                {
                    ToolTip = 'Specifies Fisc. No. Series';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Terminal-Adl"; "Fisc. Terminal-Adl")
                {
                    ToolTip = 'Specifies Fisc. Terminal';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
                field("Fisc. Location Code-Adl"; "Fisc. Location Code-Adl")
                {
                    ToolTip = 'Specifies Location Code';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }

                field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
                {
                    ToolTip = 'Specifies Full Fisc. Doc. No.';
                    Visible = FISCFeatureEnabled;
                    ApplicationArea = All;
                }
            }
        }
        // </adl.20>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        VATFeatureEnabled: Boolean;
        FISCFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;
}
