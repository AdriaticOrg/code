page 13062601 "VIES Report Subform-Adl"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "VIES Report Line-Adl";
    AutoSplitKey = true;
    Caption = 'VIES Report Subform';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Source Type"; "Source Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                    Editable = false;
                }
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
                field("EU Sales Type"; "EU Sales Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("EU 3-Party Trade"; "EU 3-Party Trade")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("EU Customs Procedure"; "EU Customs Procedure")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Amount; Amount)
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
                    VIESRepHead: Record "VIES Report Header-Adl";
                begin
                    VIESRepHead.get("Document No.");

                    VATEntry.SetCurrentKey("VAT Identifier-Adl", "Posting Date");
                    VATEntry.SetRange("VAT Identifier-Adl", "VAT Identifier");
                    VATEntry.SetRange("VAT Registration No.", "VAT Registration No.");
                    VATEntry.SetRange("Posting Date", VIESRepHead."Period Start Date", VIESRepHead."Period End Date");
                    page.RunModal(0, VATEntry);
                end;
            }
        }
    }
}