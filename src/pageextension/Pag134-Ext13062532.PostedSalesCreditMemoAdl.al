pageextension 13062532 "Posted Sales Credit Memo-Adl" extends "Posted Sales Credit Memo" //134
{
    layout
    {
        // <adl.6>
        addafter("Posting Date")
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'Specifies which date is used for posting VAT.';
            }
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'Describes what type of VAT is posted. If VAT Date is not equal to Posting Date then is Postponed VAT.';
            }
            // </adl.10>
            // <adl.10>
            // <adl.22>
            field("VAT Correction Date-Adl"; "VAT Correction Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            // </adl.22>
        }
        // </adl.6>
        // <adl.18>
        addafter("EU 3-Party Trade")
        {
            field("Goods Return Type-Adl"; "Goods Return Type-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
                Editable = false;
                ToolTip = 'Goods Return Type when it was goods return transaction.';
            }
            // <adl.22>
            field("EU Customs Procedure-Adl"; "EU Customs Procedure-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
                Editable = false;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            // </adl.22>
        }
        // </adl.18>
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
                field("Posting TimeStamp-Adl"; "Posting TimeStamp-Adl")
                {
                    ApplicationArea = All;
                }
            }
        }
        // </adl.20>    
    }
    actions
    {
        addafter(Customer)
        {
            // <adl.10>
            action("PostPostponed-Adl")
            {
                Caption = 'Post postponed VAT';
                ApplicationArea = All;
                ToolTip = 'Posts Postponed VAT on specified date.';
                Visible = VATFeatureEnabled;
                Image = "ReverseRegister";
                trigger OnAction()
                var
                    ManagePostponedVAT: Codeunit "VAT Management-Adl";
                    PostApplication: Page "Post Application";
                    CustVend: Option Customer,Vendor;
                    VATDate: Date;
                begin
                    PostApplication.SetValues("No.", WorkDate());
                    PostApplication.RunModal();
                    PostApplication.GetValues("No.", VATDate);
                    ManagePostponedVAT.HandlePostponedVAT(Database::"Sales Cr.Memo Header", "No.", VATDate, true, CustVend::Customer, "Postponed VAT-Adl", false, false);
                end;
            }
            action("CorrectPostponed-Adl")
            {
                Caption = 'Correct postponed VAT';
                ApplicationArea = All;
                ToolTip = 'Corrects Postponed VAT on specified date.';
                Visible = VATFeatureEnabled;
                Image = "ReverseRegister";
                trigger OnAction()
                var
                    ManagePostponedVAT: Codeunit "VAT Management-Adl";
                    PostApplication: Page "Post Application";
                    CustVend: Option Customer,Vendor;
                    VATDate: Date;
                begin
                    PostApplication.SetValues("No.", WorkDate());
                    PostApplication.RunModal();
                    PostApplication.GetValues("No.", VATDate);
                    ManagePostponedVAT.HandlePostponedVAT(Database::"Sales Cr.Memo Header", "No.", VATDate, false, CustVend::Customer, "Postponed VAT-Adl", false, false);
                end;
            }
            // </adl.10>
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
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