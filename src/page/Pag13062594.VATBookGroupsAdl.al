page 13062594 "VAT Book Groups-Adl"
{

    Caption = 'VAT Book Groups';
    PageType = List;
    SourceTable = "VAT Book Group-Adl";
    PopulateAllFields = true;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Code"; Code)
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                    ApplicationArea = All;
                    ToolTip = 'Specifies VAT book group code which is used as setup for VAT reporting and XML.';
                }
                field("Book Link Code"; "Book Link Code")
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the VAT book group';

                }
                field("Group Type"; "Group Type")
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Totaling; Totaling)
                {
                    Editable = "Group Type" <> "Group Type"::"VAT Entries";
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                    ApplicationArea = All;
                }
                field("Tag Name"; "Tag Name")
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                    ApplicationArea = All;
                }
                field("Include Columns"; "Include Columns")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Setup")
            {
                Caption = '&Setup';
                action("VAT Identifiers")
                {
                    Caption = 'VAT Identifiers';
                    Image = VATExemptionEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Group Identifiers-Adl";
                    RunPageLink = "VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field ("Code");
                    Enabled = ("Group Type" = "Group Type"::"VAT Entries");
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure SetSelection(var VatBookGroup: Record "VAT Book Group-Adl");
    begin
        CurrPage.SetSelectionFilter(VatBookGroup);
    end;

    procedure GetSelectionFilter(): Text;
    var
        VatBookGroup: Record "VAT Book Group-Adl";
        SelectionFilterManagement: Codeunit "SelectFilterMgmt_VATBook-Adl";
    begin
        CurrPage.SetSelectionFilter(VatBookGroup);
        exit(SelectionFilterManagement.GetSelectionFilterForVatBookGroup(VatBookGroup));
    end;
}

