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
                ToolTip = 'TODO: Tooltip - VAT Date';
            }
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
                ToolTip = 'TODO: Tooltip - Postponed VAT';
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
                ToolTip = 'TODO: Tooltip - Postponed VAT';
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
                ToolTip = 'TODO: Tooltip - Postponed VAT';
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