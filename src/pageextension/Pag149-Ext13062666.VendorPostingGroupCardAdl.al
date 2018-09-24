pageextension 13062666 "VendorPostingGroupCard-Adl" extends "Vendor Posting Group Card" //149
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
                ToolTip = 'Specifies KRD Claim/Liability-Adl';
            }
            field("KRD Instrument Type-Adl"; "KRD Instrument Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Instrument Type-Adl';
            }
            field("KRD Maturity-Adl"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Maturity-Adl';
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
