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
                Editable = false;
            }
            // <adl.10>
            field("Postponed VAT -Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
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
            }
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
                    trigger OnAction()
                    var
                        PostCorr: Report "Post or Corr Postponed VAT-Adl";
                        CustomerVendor: Option Customer,Vendor;
                    begin
                        CLEAR(PostCorr);
                        TESTFIELD("Postponed VAT-Adl", "Postponed VAT-Adl"::"Postponed VAT");
                        PostCorr.SetParameters(DATABASE::"Purch. Cr. Memo Hdr.", "No.", CustomerVendor::Vendor, "Postponed VAT-Adl", TRUE);
                        PostCorr.RUNMODAL;
                    end;
                }
                action(CorrectPostponed)
                {
                    Caption = 'Correct postponed VAT';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PostCorr: Report "Post or Corr Postponed VAT-Adl";
                        CustomerVendor: Option Customer,Vendor;
                    begin
                        CLEAR(PostCorr);
                        TESTFIELD("Postponed VAT-Adl", "Postponed VAT-Adl"::"Realized VAT");
                        PostCorr.SetParameters(DATABASE::"Purch. Cr. Memo Hdr.", "No.", CustomerVendor::Vendor, "Postponed VAT-Adl", false);
                        PostCorr.RUNMODAL;
                    end;
                }
                // </adl.10>
            }
        }
    }
}