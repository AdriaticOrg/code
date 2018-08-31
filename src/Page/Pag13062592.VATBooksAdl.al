page 13062592 "VAT Books-Adl"
{

    Caption = 'VAT Books';
    Editable = true;
    PageType = List;
    SourceTable = "VAT Book-Adl";
    SourceTableView = sorting ("Sorting Appearance") order(Ascending);
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code to VAT book which is uses for regional VAT reporting legislation.';
                }
                
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the VAT book';
                }
                field("Include in XML"; "Include in XML")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if book is set to export to XML via action "Export to XML".';
                }
                field("Sorting Appearance"; "Sorting Appearance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies sorting appearance of VAT book in VAT reporting and XML.';
                }
                field("Tag Name"; "Tag Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies tag name in XML file which is exported via action "Export to XML".';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Setup")
            {
                Caption = 'Setup';
                action("Column Name Setup")
                {
                    Caption = 'Column Name Setup';
                    ToolTip = 'View or edit the VAT book columns which is used as setup for VAT reporting and XML.';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Column Names-Adl";
                    RunPageLink = "VAT Book Code" = field (Code);
                    ApplicationArea = All;
                }
                action("VAT Book Groups")
                {
                    Caption = 'VAT Book Groups';
                    ToolTip = 'View or edit the VAT book groups which is used as setup for VAT reporting and XML.';
                    Image = IndustryGroups;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Groups-Adl";
                    RunPageLink = "VAT Book Code" = field (Code);
                    ApplicationArea = All;
                }
                action("VAT Book Setup")
                {
                    Caption = 'VAT Book Setup';
                    ToolTip = 'Setup VAT book matrix calculation which is used as setup for VAT reporting and XML.';
                    Image = SetupLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Setup Matrix-Adl";
                    RunPageLink = "VAT Book Code" = field (Code);
                    ApplicationArea = All;
                }
                action("VAT Review")
                {
                    Caption = 'VAT Review';
                    ToolTip = 'Shows VAT book matrix preview.';
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ApplicationArea = All;

                    trigger OnAction();
                    var
                        VATReviewMatrix: Page "VAT Review Matrix-Adl";
                    begin
                        VATReviewMatrix.Load(Code, '', '', 2);
                        VATReviewMatrix.RunModal;
                    end;
                }
            }
        }
        area(reporting)
        {
            action(VATBook)
            {
                Caption = 'VAT Book';
                ToolTip = 'View or print the VAT book.';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                var
                    VATBookColumnName: Record "VAT Book Column Name-Adl";
                begin
                    VATBookColumnName.SetRange("VAT Book Code", Code);
                    Report.RunModal(Report::"VAT Book-Adl", true, false, VATBookColumnName);
                end;
            }
            action(ExportToXML)
            {
                Caption = 'Export to XML';
                ToolTip = 'Export to XML VAT books for certain period.';
                Image = CreateXMLFile;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Report.RunModal(Report::"Export VAT Books To XML-Adl", true, false);
                end;
            }
        }
    }

    procedure SetSelection(var VATBook: Record "VAT Book-Adl");
    begin
        CurrPage.SetSelectionFilter(VATBook);
    end;
}