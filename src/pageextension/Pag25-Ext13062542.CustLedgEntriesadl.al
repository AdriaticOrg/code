pageextension 13062542 "CustLedgEntries-adl" extends "Customer Ledger Entries" //25
{
    layout
    {
        addlast(Control1)
        {
            // <adl.24>
            field("FAS Sector Code"; "FAS Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = FASFeatureEnabled;
            }
            field("KRD Non-Residnet Sector Code"; "KRD Non-Residnet Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Affiliation Type"; "KRD Affiliation Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Claim/Liability"; "KRD Claim/Liability-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Instrument Type"; "KRD Instrument Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Maturity"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Country/Region Code"; "KRD Country/Region Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
            }
            field("KRD Other Changes"; "KRD Other Changes-Adl")
            {
                ApplicationArea = all;
                Visible = KRDFeatureEnabled;
            }
            // </adl.24>
        }
    }

    actions
    {
        // <adl.28>
        addafter(IncomingDocument)
        {
            action(UnpaidReceivables)
            {
                Caption = 'Edit Extended Data';
                ApplicationArea = All;
                RunObject = Page "Cust. Ledger Entries Ext.-adl";
                Promoted = true;
                PromotedCategory = Process;
                Image = Edit;
            }
        }
        // </adl.28> 
    }

    var
        // <adl.0>
        ADLCore: Codeunit "Adl Core";
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