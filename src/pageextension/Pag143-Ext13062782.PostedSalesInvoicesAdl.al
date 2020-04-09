pageextension 13062782 "Posted Sales Invoices-Adl" extends "Posted Sales Invoices" //143
{
    layout
    {
        // <adl.20>
        addlast(Control1)
        {
            field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
            {
                Visible = FISCFeatureEnabled;
                ApplicationArea = All;
            }
        }
        // </adl.20>
    }


    var
        // </adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        FISCFeatureEnabled: Boolean;
    // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        FISCFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FISC);
        // </adl.0>
    end;
}
