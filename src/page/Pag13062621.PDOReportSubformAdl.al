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
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Applies-to Report No."; "Applies-to Report No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Period Round"; "Period Round")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
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
                ToolTip = 'TODO: Tooltip - Reporting';
                Image = InsuranceLedger;

                trigger OnAction()
                var
                    VATEntry: Record "VAT Entry";
                    PDORepHead: Record "PDO Report Header-Adl";
                begin
                    PDORepHead.get("Document No.");

                    VATEntry.SetCurrentKey("VAT Identifier-Adl", "Posting Date");
                    VATEntry.SetRange("VAT Registration No.", "VAT Registration No.");
                    VATEntry.SetRange("Posting Date", PDORepHead."Period Start Date", PDORepHead."Period End Date");
                    page.RunModal(0, VATEntry);
                end;
            }
        }
    }
}