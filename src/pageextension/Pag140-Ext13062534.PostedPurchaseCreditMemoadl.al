pageextension 13062534 "PostedPurchaseCreditMemo-Adl" extends "Posted Purchase Credit Memo"  //140
{
    layout
    {
        // <adl.6>
        addlast(General)
        {
            field("VAT Date -Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            field("VAT Output Date-Adl"; "VAT Output Date-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // <adl.10>
            field("Postponed VAT -Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // <adl.10>
        }
        // </adl.6>
        // <adl.18>
        addafter("Location Code")
        {
            field("Goods Return Type-Adl"; "Goods Return Type-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
            }
        }
        // </adl.18>
    }
    actions
    {
        addafter(Vendor)
        {
            // <adl.10>
            action(PostPostponed)
            {
                Caption = 'Post postponed VAT';
                ApplicationArea = All;
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
                    ManagePostponedVAT.HandlePostponedVAT(Database::"Purch. Cr. Memo Hdr.", "No.", VATDate, true, CustVend::Vendor, "Postponed VAT-Adl",false,false);
                end;
            }
            action(CorrectPostponed)
            {
                Caption = 'Correct postponed VAT';
                ApplicationArea = All;
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
                    ManagePostponedVAT.HandlePostponedVAT(Database::"Purch. Cr. Memo Hdr.", "No.", VATDate, false, CustVend::Vendor, "Postponed VAT-Adl",false,false);
                end;
            }
            action(PostVATOutput)
            {
                Caption = 'Post VAT Output Date';
                ApplicationArea = All;
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
                    ManagePostponedVAT.HandlePostponedVAT(Database::"Purch. Cr. Memo Hdr.", "No.", VATDate, true, CustVend::Vendor, "Postponed VAT-Adl",false,true);
                end;
            }
            action(CorrectVATOutput)
            {
                Caption = 'Correct VAT Output Date';
                ApplicationArea = All;
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
                    ManagePostponedVAT.HandlePostponedVAT(Database::"Purch. Cr. Memo Hdr.", "No.", VATDate, false, CustVend::Vendor, "Postponed VAT-Adl",false,true);
                end;
            }
            // </adl.10>
        }
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