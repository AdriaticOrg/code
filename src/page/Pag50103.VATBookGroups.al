page 50103 "VAT Book Groups"
{

    CaptionML = ENU = 'VAT Book Groups',
                SRM = 'Grupe knjige PDV-a';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "VAT Book Group";

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
                }
                field("Book Link Code"; "Book Link Code") 
                { 
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                }
                field(Description; Description)
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";
                }
                field("Group Type"; "Group Type")
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";

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
                }
                field("Tag Name"; "Tag Name") 
                {
                    Style = Strong;
                    StyleExpr = "Group Type" <> "Group Type"::"VAT Entries";  
                }
                field("Include Columns";"Include Columns") { }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Setup")
            {
                CaptionML = ENU = '&Setup',
                            SRM = '&Podešavanje';
                action("VAT Identifiers")
                {
                    CaptionML = ENU = 'VAT Identifiers',
                                SRM = 'PDV Identifikatori';
                    Image = VATExemptionEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Group Identifiers";
                    RunPageLink = "VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field ("Code");
                }
            }
        }
    }

    procedure SetSelection(var VatBookGroup: Record "VAT Book Group");
    begin
        CurrPage.SetSelectionFilter(VatBookGroup);
    end;

    procedure GetSelectionFilter(): Text;
    var
        VatBookGroup: Record "VAT Book Group";
        SelectionFilterManagement: Codeunit SelectionFilterMgmt_VATBook;
    begin
        CurrPage.SetSelectionFilter(VatBookGroup);
        exit(SelectionFilterManagement.GetSelectionFilterForVatBookGroup(VatBookGroup));
    end;
}

