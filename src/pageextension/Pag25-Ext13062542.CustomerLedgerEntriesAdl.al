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
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Non-Residnet Sector Code-Adl"; "KRD Non-Residnet Sector Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Affiliation Type-Adl"; "KRD Affiliation Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Claim/Liability-Adl"; "KRD Claim/Liability-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Instrument Type-Adl"; "KRD Instrument Type-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Maturity-Adl"; "KRD Maturity-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Country/Region Code-Adl"; "KRD Country/Region Code-Adl")
            {
                ApplicationArea = All;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
            }
            field("KRD Other Changes-Adl"; "KRD Other Changes-Adl")
            {
                ApplicationArea = all;
                Visible = KRDFeatureEnabled;
                ToolTip = 'TODO: Tooltip - Reporting';
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
                ToolTip = 'TODO: Tooltip - Unpaid Receivables';
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