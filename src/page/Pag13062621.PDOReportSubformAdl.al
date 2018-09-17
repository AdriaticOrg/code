page 13062621 "PDO Report Subform-Adl"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "PDO Report Line-Adl";
    AutoSplitKey = true;
    Caption = 'PDO Report Subform';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Applies-to Report No."; "Applies-to Report No.")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                }
                field("Period Round"; "Period Round")
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)"; "Amount (LCY)")
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
            action("Show related entries")
            {
                Caption = 'Show related entries';
                ApplicationArea = All;
                Image = InsuranceLedger;

                trigger OnAction()
                var
                    VATEntry: Record "VAT Entry";
                    PDORepHead: Record "VIES Report Header-Adl";
                begin
                    PDORepHead.get("Document No.");

                    VATEntry.SetCurrentKey("VAT Identifier-Adl", "Posting Date");
                    VATEntry.SetRange("VAT Identifier-Adl", "VAT Identifier");
                    VATEntry.SetRange("VAT Registration No.", "VAT Registration No.");
                    VATEntry.SetRange("Posting Date", PDORepHead."Period Start Date", PDORepHead."Period End Date");
                    page.RunModal(0, VATEntry);
                end;
            }
        }
    }
}