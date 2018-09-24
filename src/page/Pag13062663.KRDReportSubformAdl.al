page 13062663 "KRD Report Subform-Adl"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "KRD Report Line-Adl";
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
                    ToolTip = 'Specifies Claim/Liability';
                }
                field("Affiliation Type"; "Affiliation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Affiliation Type';
                }
                field("Instrument Type"; "Instrument Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Instrument Type';
                }
                field(Maturity; Maturity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Maturity';
                }
                field("Non-Resident Sector Code"; "Non-Resident Sector Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Non-Resident Sector Code';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Country/Region Code';
                }
                field("Country/Region No."; "Country/Region No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Country/Region No.';
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Currency Code';
                }
                field("Other Changes"; "Other Changes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Other Changes';
                }
                field("Currency No."; "Currency No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Currency No.';
                }
                field("Opening Balance"; "Opening Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Opening Balance';
                }
                field("Increase Amount"; "Increase Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Increase Amount';
                }
                field("Decrease Amount"; "Decrease Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Decrease Amount';
                }
                field("Closing Balance"; "Closing Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Closing Balance';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("ShowVLE")
            {
                Caption = 'Show Vendor Ledger Entries';
                Image = ListPage;
                ApplicationArea = All;
                ToolTip = 'Shows related source entries';

                trigger OnAction()
                var
                    VLE: Record "Vendor Ledger Entry";
                    KRDRepHead: Record "KRD Report Header-Adl";
                    KRDSetup: Record "KRD Setup-Adl";
                begin
                    KRDSetup.Get();
                    KRDSetup.TestField("KRD Blank LCY Code");

                    KRDRepHead.get("Document No.");
                    KRDRepHead.TestField("Period Start Date");
                    KRDRepHead.TestField("Period End Date");

                    VLE.Reset();
                    VLE.SetRange("Posting Date", KRDRepHead."Period Start Date", KRDRepHead."Period End Date");
                    VLE.SetRange("KRD Claim/Liability-Adl", "Claim/Liability");
                    VLE.SetRange("KRD Affiliation Type-Adl", "Affiliation Type");
                    VLE.SetRange("KRD Instrument Type-Adl", "Instrument Type");
                    VLE.SetRange("KRD Maturity-Adl", Maturity);
                    VLE.SetRange("KRD Non-Resident Sector Code-Adl", "Non-Resident Sector Code");
                    VLE.SetRange("KRD Country/Region Code-Adl", "Country/Region Code");

                    if "Currency Code" = KRDSetup."KRD Blank LCY Code" then
                        VLE.SetFilter("Currency Code", '%1|%2', "Currency Code", '')
                    else
                        VLE.SetRange("Currency Code", "Currency Code");

                    PAGE.RunModal(0, VLE);
                end;
            }
            action("ShowCLE")
            {
                Caption = 'Show Customer Ledger Entries';
                Image = ListPage;
                ApplicationArea = All;

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    KRDRepHead: Record "KRD Report Header-Adl";
                    KRDSetup: Record "KRD Setup-Adl";
                begin
                    KRDSetup.Get();
                    KRDSetup.TestField("KRD Blank LCY Code");

                    KRDRepHead.get("Document No.");
                    KRDRepHead.TestField("Period Start Date");
                    KRDRepHead.TestField("Period End Date");

                    CLE.Reset();
                    CLE.SetRange("Posting Date", KRDRepHead."Period Start Date", KRDRepHead."Period End Date");
                    CLE.SetRange("KRD Claim/Liability-Adl", "Claim/Liability");
                    CLE.SetRange("KRD Affiliation Type-Adl", "Affiliation Type");
                    CLE.SetRange("KRD Instrument Type-Adl", "Instrument Type");
                    CLE.SetRange("KRD Maturity-Adl", Maturity);
                    CLE.SetRange("KRD Non-Resident Sector Code-Adl", "Non-Resident Sector Code");
                    CLE.SetRange("KRD Country/Region Code-Adl", "Country/Region Code");

                    if "Currency Code" = KRDSetup."KRD Blank LCY Code" then
                        CLE.SetFilter("Currency Code", '%1|%2', "Currency Code", '')
                    else
                        CLE.SetRange("Currency Code", "Currency Code");

                    PAGE.RunModal(0, CLE);
                end;
            }
        }
    }
}
