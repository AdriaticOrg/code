pageextension 13062532 "PostedSalesCreditMemo-Adl" extends "Posted Sales Credit Memo" //134
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
            }
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // </adl.10>
            // <adl.10>
            // <adl.22>
            field("VAT Correction Date"; "VAT Correction Date")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
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
                Visible = EUCustomsFeatureEnabled;
            }
            // <adl.22>
            field("EU Customs Procedure"; "EU Customs Procedure")
            {
                ApplicationArea = All;
                Visible = EUCustomsFeatureEnabled;
            }
            // </adl.22>
        }
        // </adl.18>
    }
    actions
    {
        addafter(Dimensions)
        {
            group(Functions)
            {
                // <adl.10>
                action(PostPostponed)
                {
                    Caption = 'Post postponed VAT';
                    ApplicationArea = All;
                    Visible = VATFeatureEnabled;

                    trigger OnAction()
                    var
                        PostCorr: Report "Post or Corr Postponed VAT-Adl";
                        CustomerVendor: Option Customer,Vendor;
                    begin
                        CLEAR(PostCorr);
                        TESTFIELD("Postponed VAT-Adl", "Postponed VAT-Adl"::"Postponed VAT");
                        PostCorr.SetParameters(DATABASE::"Sales Cr.Memo Header", "No.", CustomerVendor::Customer, "Postponed VAT-Adl", true);
                        PostCorr.RUNMODAL();
                    end;
                }
                action(CorrectPostponed)
                {
                    Caption = 'Correct postponed VAT';
                    ApplicationArea = All;
                    Visible = VATFeatureEnabled;

                    trigger OnAction()
                    var
                        PostCorr: Report "Post or Corr Postponed VAT-Adl";
                        CustomerVendor: Option Customer,Vendor;
                    begin
                        CLEAR(PostCorr);
                        TESTFIELD("Postponed VAT-Adl", "Postponed VAT-Adl"::"Realized VAT");
                        PostCorr.SetParameters(DATABASE::"Sales Cr.Memo Header", "No.", CustomerVendor::Customer, "Postponed VAT-Adl", false);
                        PostCorr.RUNMODAL();
                    end;
                }
                // </adl.10>
            }
        }
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        CoreSetup: Record "CoreSetup-Adl";
        VATFeatureEnabled: Boolean;
        EUCustomsFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        EUCustomsFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::EUCustoms);
        // </adl.0>
    end;
}