pageextension 50101 "PostedSalesInvoice-adl" extends "Posted Sales Invoice" //132
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT-adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
      addafter(Dimensions){
          group(Functions){
              action(PostPostponed){
                  Caption = 'Post postponed VAT';
                  ApplicationArea = All;
                  trigger OnAction()
                  var
                      PostCorr: Report "Post or Corr Postponed VAT-adl";
                      CustomerVendor: Option Customer,Vendor;
                  begin
                      CLEAR(PostCorr);
                      TESTFIELD("Postponed VAT-adl","Postponed VAT-adl"::"Postponed VAT");
                      PostCorr.SetParameters(DATABASE::"Sales Invoice Header","No.",CustomerVendor::Customer,"Postponed VAT-adl",TRUE);
                      PostCorr.RUNMODAL;
                  end;
              }
              action(CorrectPostponed){
                  Caption = 'Correct postponed VAT';
                  ApplicationArea = All;
                  trigger OnAction()
                  var
                      PostCorr: Report "Post or Corr Postponed VAT-adl";
                      CustomerVendor: Option Customer,Vendor;
                  begin
                      CLEAR(PostCorr);
                      TESTFIELD("Postponed VAT-adl","Postponed VAT-adl"::"Realized VAT");
                      PostCorr.SetParameters(DATABASE::"Sales Invoice Header","No.",CustomerVendor::Customer,"Postponed VAT-adl",false);
                      PostCorr.RUNMODAL;
                  end;
              }
          }
      }
    }
}