pageextension 13062665 "CustomerPostingGroupCard-Adl" extends "Customer Posting Group Card" //148
{
    layout
    {
        addlast(General)
        {
            // </adl.25>
            field("KRD Claim/Liability-Adl"; "KRD Claim/Liability-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Claim/Liability';
            }
            field("KRD Instrument Type-Adl"; "KRD Instrument Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Instrument Type';
            }
            field("KRD Maturity-Adl"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Maturity';
            }
            // </adl.25>
        }
    }

    var
        // <adl.0> 
        ADLCore: Codeunit "Adl Core-Adl";
        KRDFeatureEnabled: Boolean;
    // </adl.0> 
    trigger OnOpenPage()
    begin
        // <adl.0>
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::KRD);
        // </adl.0>        

    end;
}
