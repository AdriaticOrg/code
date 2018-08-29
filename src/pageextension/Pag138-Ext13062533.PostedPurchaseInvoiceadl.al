pageextension 13062533 "PostedPurchaseInvoice-adl" extends "Posted Purchase Invoice"  //138
{
    layout
    {
        addlast(General)
        {
            field("VAT Date -adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT -adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        addafter(Dimensions)
        {
            group(Functions)
            {
                action(PostPostponed)
                {
                    Caption = 'Post postponed VAT';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PostCorr: Report "Post or Corr Postponed VAT-adl";
                        CustomerVendor: Option Customer,Vendor;
                    begin
                        CLEAR(PostCorr);
                        TESTFIELD("Postponed VAT-adl", "Postponed VAT-adl"::"Postponed VAT");
                        PostCorr.SetParameters(DATABASE::"Purch. Inv. Header", "No.", CustomerVendor::Vendor, "Postponed VAT-adl", TRUE);
                        PostCorr.RUNMODAL;
                    end;
                }
                action(CorrectPostponed)
                {
                    Caption = 'Correct postponed VAT';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        PostCorr: Report "Post or Corr Postponed VAT-adl";
                        CustomerVendor: Option Customer,Vendor;
                    begin
                        CLEAR(PostCorr);
                        TESTFIELD("Postponed VAT-adl", "Postponed VAT-adl"::"Realized VAT");
                        PostCorr.SetParameters(DATABASE::"Purch. Inv. Header", "No.", CustomerVendor::Vendor, "Postponed VAT-adl", false);
                        PostCorr.RUNMODAL;
                    end;
                }
            }
        }
    }
}