pageextension 13062553 "General Ledger Setup-adl" extends "General Ledger Setup" //118
{
    layout
    {
        // <adl.27>
        addlast(General)
        {
            field("Global Posting Approver"; "Global Posting Approver")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
            }
            field("Global Posting Resp. Person"; "Global Posting Resp. Person")
            {
                ApplicationArea = All;
                Visible = ADLCoreEnabled;
            }
        }
        // </adl.27>
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
        "ADL Features": Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms;
        ADLCoreEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADL Features"::Core);
        // </adl.0>
    end;
}