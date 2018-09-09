page 13062663 "KRD Report Subform"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "KRD Report Line";
    AutoSplitKey = true;
    Caption = 'KRD Report Subform';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Claim/Liability"; "Claim/Liability")
                {
                    ApplicationArea = All;
                }
                field("Affiliation Type"; "Affiliation Type")
                {
                    ApplicationArea = All;
                }
                field("Instrument Type"; "Instrument Type")
                {
                    ApplicationArea = All;
                }
                field(Maturity; Maturity)
                {
                    ApplicationArea = All;
                }
                field("Non-Residnet Sector Code"; "Non-Residnet Sector Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("Country/Region No."; "Country/Region No.")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Other Changes"; "Other Changes")
                {
                    ApplicationArea = All;
                }
                field("Currency No."; "Currency No.")
                {
                    ApplicationArea = All;
                }
                field("Opening Balance"; "Opening Balance")
                {
                    ApplicationArea = All;
                }
                field("Increase Amount"; "Increase Amount")
                {
                    ApplicationArea = All;
                }
                field("Decrease Amount"; "Decrease Amount")
                {
                    ApplicationArea = All;
                }
                field("Closing Balance"; "Closing Balance")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ShowVLE)
            {
                Caption = 'Show Vendor Ledger Entries';
                Image = ListPage;
                ApplicationArea = All;

                trigger OnAction()
                var
                    VLE: Record "Vendor Ledger Entry";
                    KRDRepHead: Record "KRD Report Header";
                begin
                    KRDRepHead.get("Document No.");
                    KRDRepHead.TestField("Period Start Date");
                    KRDRepHead.TestField("Period End Date");

                    VLE.Reset();
                    VLE.SetRange("Posting Date", KRDRepHead."Period Start Date", KRDRepHead."Period End Date");
                    VLE.SetRange("KRD Claim/Liability", "Claim/Liability");
                    VLE.SetRange("KRD Affiliation Type", "Affiliation Type");
                    VLE.SetRange("KRD Instrument Type", "Instrument Type");
                    VLE.SetRange("KRD Maturity", Maturity);
                    VLE.SetRange("KRD Non-Residnet Sector Code", "Non-Residnet Sector Code");
                    VLE.SetRange("KRD Country/Region Code", "Country/Region Code");
                    VLE.SetRange("Currency Code", "Currency Code");
                    PAGE.RunModal(0, VLE);
                end;
            }
            action(ShowCLE)
            {
                Caption = 'Show Customer Ledger Entries';
                Image = ListPage;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    KRDRepHead: Record "KRD Report Header";
                begin
                    KRDRepHead.get("Document No.");
                    KRDRepHead.TestField("Period Start Date");
                    KRDRepHead.TestField("Period End Date");

                    CLE.Reset();
                    CLE.SetRange("Posting Date", KRDRepHead."Period Start Date", KRDRepHead."Period End Date");
                    CLE.SetRange("KRD Claim/Liability", "Claim/Liability");
                    CLE.SetRange("KRD Affiliation Type", "Affiliation Type");
                    CLE.SetRange("KRD Instrument Type", "Instrument Type");
                    CLE.SetRange("KRD Maturity", Maturity);
                    CLE.SetRange("KRD Non-Residnet Sector Code", "Non-Residnet Sector Code");
                    CLE.SetRange("KRD Country/Region Code", "Country/Region Code");
                    CLE.SetRange("Currency Code", "Currency Code");
                    PAGE.RunModal(0, CLE);
                end;
            }
        }
    }
}