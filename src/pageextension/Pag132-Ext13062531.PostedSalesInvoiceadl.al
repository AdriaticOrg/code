pageextension 13062531 "PostedSalesInvoice-Adl" extends "Posted Sales Invoice" //132
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
                Editable = false;
            }
            // </adl.6>
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Visible = VATFeatureEnabled;
                Editable = false;
            }
            // </adl.10>            
        }
        // <adl.22>
        addafter("EU 3-Party Trade")
        {
            field("EU Customs Procedure"; "EU Customs Procedure-Adl")
            {
                ApplicationArea = All;
                Visible = VIESFeatureEnabled;
                Editable = false;
            }
        }
        // </adl.22>        
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
                        PostCorr.SetParameters(DATABASE::"Sales Invoice Header", "No.", CustomerVendor::Customer, "Postponed VAT-Adl", TRUE);
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
                        PostCorr.SetParameters(DATABASE::"Sales Invoice Header", "No.", CustomerVendor::Customer, "Postponed VAT-Adl", false);
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