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
                    ToolTip = 'Specifies Type';
                }
                field("Applies-to Report No."; "Applies-to Report No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Applies-to Report No.';
                }
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Period Year';
                }
                field("Period Round"; "Period Round")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Period Round';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Country/Region Code';
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies VAT Registration No.';
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Amount (LCY';
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
                ToolTip = 'Shows related source entries';

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
