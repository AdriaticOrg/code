pageextension 13062542 "Customer Ledger Entries-Adl" extends "Customer Ledger Entries" //25
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Sector Code-Adl"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
                ToolTip = 'Specifies FAS Sector Code';
            }
            field("KRD Non-Resident Sector Code-Adl"; "KRD Non-Resident Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Non-Resident Sector Code';
            }
            field("KRD Affiliation Type-Adl"; "KRD Affiliation Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies Affiliation Type';
            }
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
                ToolTip = 'Specifies Instrument Type';
            }
            field("KRD Maturity-Adl"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Maturity';
            }
            field("KRD Country/Region Code-Adl"; "KRD Country/Region Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Country/Region Code';
            }
            field("KRD Other Changes-Adl"; "KRD Other Changes-Adl")
            {
                ApplicationArea = all;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Other Changes';
            }
            // </adl.24>
            // <adl.20>
            field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
            {
                ApplicationArea = All;
            }
            // </adl.20>
        }
    }

    actions
    {
        // <adl.28>
        addafter(IncomingDocument)
        {
            action("UnpaidReceivables-Adl")
            {
                Caption = 'Edit Extended Data';
                ApplicationArea = All;
                ToolTip = 'Edit extended data';
                RunObject = Page "Cust. Ledger Entries Ext.-Adl";
                Promoted = true;
                PromotedCategory = Process;
                Image = Edit;
            }
        }
        // </adl.28> 
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled("ADLFeatures-Adl"::BST);
        // </adl.0>
    end;

}
