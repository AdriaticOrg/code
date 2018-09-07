pageextension 13062533 "PostedPurchaseInvoice-Adl" extends "Posted Purchase Invoice"  //138
{
    layout
    {
        addlast(General)
        {
            // <adl.6>
            field("VAT Date -Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // </adl.6>
            // <adl.10>
            field("Postponed VAT -Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // </adl.10>
        }
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
                        PostCorr.SetParameters(DATABASE::"Purch. Inv. Header", "No.", CustomerVendor::Vendor, "Postponed VAT-Adl", TRUE);
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
                        PostCorr.SetParameters(DATABASE::"Purch. Inv. Header", "No.", CustomerVendor::Vendor, "Postponed VAT-Adl", false);
                        PostCorr.RUNMODAL;
                    end;
                }
                // </adl.10>
            }
        }
    }
}