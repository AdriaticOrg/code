pageextension 13062525 "Sales Order-Adl" extends "Sales Order" //42
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
        }
        // <adl.20>
        addafter("Shipping and Billing")
        {
            group(Fiscalization)
            {
                field("Fisc. Subject-Adl"; "Fisc. Subject-Adl")
                {
                    ApplicationArea = All;
                }
                field("Fisc. No. Series-Adl"; "Fisc. No. Series-Adl")
                {
                    ApplicationArea = All;
                }
                field("Fisc. Terminal-Adl"; "Fisc. Terminal-Adl")
                {
                    ApplicationArea = All;
                }
                field("Fisc. Location Code-Adl"; "Fisc. Location Code-Adl")
                {
                    ApplicationArea = All;
                }

                field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
                {
                    ApplicationArea = All;
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