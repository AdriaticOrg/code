page 13062644 "FAS Report Subform-Adl"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "FAS Report Line-Adl";
    AutoSplitKey = true;
    Caption = 'FAS Report Subform';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("FAS Type"; "FAS Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies FAS Type';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Description';
                }
                field("AOP Code"; "AOP Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies AOP Code';
                }
                field("Sector Code"; "Sector Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Sector Code';
                }
                field("Instrument Code"; "Instrument Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Instrument Code';
                }
                field("Transactions Amt. in Period"; "Transactions Amt. in Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Transactions Amt. in Period';
                }
                field("Changes Amt. in Period"; "Changes Amt. in Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Changes Amt. in Period';
                }
                field("Period Closing Balance"; "Period Closing Balance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Period Closing Balance';
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
                    GLEntry: Record "G/L Entry";
                    FASRepHead: Record "FAS Report Header-Adl";
                begin
                    FASRepHead.get("Document No.");

                    GLEntry.SetCurrentKey("FAS Type-Adl", "FAS Instrument Code-Adl", "FAS Sector Code-Adl");
                    GLEntry.SetRange("FAS Type-Adl", "FAS Type");
                    GLEntry.SetRange("FAS Instrument Code-Adl", "Instrument Code");
                    GLEntry.SetRange("FAS Sector Code-Adl", "Sector Code");
                    GLEntry.SetRange("Posting Date", FASRepHead."Period Start Date", FASRepHead."Period End Date");
                    page.RunModal(0, GLEntry);

                end;
            }
        }
    }
}
