page 13062660 "Reporting_SI Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Reporting_SI Setup";
    Caption = 'Reporting_SI Setup';

    layout
    {
        area(Content)
        {
            group(FAS)
            {
                field("FAS Report No. Series"; "FAS Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("FAS Resp. User ID"; "FAS Resp. User ID")
                {
                    ApplicationArea = All;
                }
                field("FAS Prep. By User ID"; "FAS Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("FAS Director User ID"; "FAS Director User ID")
                {
                    ApplicationArea = All;
                }
                field("Budget User Code"; "Budget User Code")
                {
                    ApplicationArea = All;
                }
                field("Company Sector Code"; "Company Sector Code")
                {
                    ApplicationArea = All;
                }
            }
            group(KRD)
            {
                field("KRD Report No. Series"; "KRD Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("KRD Resp. User ID"; "KRD Resp. User ID")
                {
                    ApplicationArea = All;
                }
                field("KRD Prep. By User ID"; "KRD Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("Default KRD Affiliation Type"; "Default KRD Affiliation Type")
                {
                    ApplicationArea = All;
                }
                field("KRD Blank LCY Code"; "KRD Blank LCY Code")
                {
                    ApplicationArea = All;
                }
                field("KRD Blank LCY Num."; "KRD Blank LCY Num.")
                {
                    ApplicationArea = All;
                }
            }
            group(BST)
            {
                field("BST Report No. Series"; "BST Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("BST Prep. By User ID"; "BST Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("BST Resp. User ID"; "BST Resp. User ID")
                {
                    ApplicationArea = All;
                }
            }
            group(VIES)
            {
                field("Default VIES Country"; "Default VIES Country")
                {
                    ApplicationArea = All;
                }
                field("Default VIES Type"; "Default VIES Type")
                {
                    ApplicationArea = All;
                }
                field("VIES Company Branch Code"; "VIES Company Branch Code")
                {
                    ApplicationArea = All;
                }
                field("VIES Report No. Series"; "VIES Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("VIES Prep. By User ID"; "VIES Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("VIES Resp. User ID"; "VIES Resp. User ID")
                {
                    ApplicationArea = All;
                }
            }
            group(PDO)
            {
                field("PDO Report No. Series"; "PDO Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("PDO Prep. By User ID"; "PDO Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("PDO Resp. User ID"; "PDO Resp. User ID")
                {
                    ApplicationArea = All;
                }
                field("PDO VAT Ident. Filter Code "; "PDO VAT Ident. Filter Code ")
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
            action("Adjust FAS on Entries")
            {
                Caption = 'Adjust FAS on Entries';
                ApplicationArea = All;
                Image = Suggest;

                trigger OnAction()
                begin
                    report.RunModal(Report::"Adjust FAS on Entries");
                end;
            }
        }
    }
}