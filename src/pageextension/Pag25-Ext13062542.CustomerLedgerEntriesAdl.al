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
                ToolTip = 'Specifies FAS Sector Code-Adl';
            }
            field("KRD Non-Residnet Sector Code-Adl"; "KRD Non-Residnet Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Non-Resident Sector Code-Adl';
            }
            field("KRD Affiliation Type-Adl"; "KRD Affiliation Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies Affiliation Type-Adl';
            }
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
                ToolTip = 'Specifies Instrument Type-Adl';
            }
            field("KRD Maturity-Adl"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Maturity-Adl';
            }
            field("KRD Country/Region Code-Adl"; "KRD Country/Region Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Country/Region Code-Adl';
            }
            field("KRD Other Changes-Adl"; "KRD Other Changes-Adl")
            {
                ApplicationArea = all;
                Visible = KRDFeatureEnabled;
                ToolTip = 'Specifies KRD Other Changes-Adl';
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
        CoreSetup: Record "CoreSetup-Adl";
        ADLCoreEnabled: Boolean;
        VATFeatureEnabled: Boolean;
        FASFeatureEnabled: Boolean;
        KRDFeatureEnabled: Boolean;
        BSTFeatureEnabled: Boolean;
        // </adl.0>

    trigger OnOpenPage();
    begin
        // <adl.0>
        ADLCoreEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::Core);
        VATFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::VAT);
        FASFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::FAS);
        KRDFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::KRD);
        BSTFeatureEnabled := ADLCore.FeatureEnabled(CoreSetup."ADL Features"::BST);
        // </adl.0>
    end;

}