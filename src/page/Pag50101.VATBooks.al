page 50101 "VAT Books"
{


    CaptionML = ENU = 'VAT Books',
                SRM = 'Knjige PDV-a';
    DelayedInsert = true;
    Editable = true;
    PageType = List;
    SourceTable = "VAT Book";
    SourceTableView = sorting ("Sorting Appearance") orDER(Ascending);
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("Code"; Code) { }
                field(Description; Description) { }
                field("Include in XML"; "Include in XML") { }
                field("Sorting Appearance"; "Sorting Appearance") { }
                field("Tag Name"; "Tag Name") { }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Setup")
            {
                CaptionML = ENU = 'Setup',
                            SRM = 'Podešavanje';
                action("Column Name Setup")
                {
                    CaptionML = ENU = 'Column Name Setup',
                                SRM = 'Podešavanje naziva kolona';
                    Image = SetupColumns;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Column Names";
                    RunPageLink = "VAT Book Code" = field (Code);
                }
                action("VAT Book Groups")
                {
                    CaptionML = ENU = 'VAT Book Groups',
                                SRM = 'Grupe knjige PDV-a';
                    Image = IndustryGroups;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Groups";
                    RunPageLink = "VAT Book Code" = field (Code);
                }
                action("VAT Book Setup")
                {
                    CaptionML = ENU = 'VAT Book Setup',
                                SRM = 'Podešavanje knjige PDV-a';
                    Image = SetupLines;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "VAT Book Setup Matrix";
                    RunPageLink = "VAT Book Code" = field (Code);
                }
                action("VAT Review")
                {
                    CaptionML = ENU = 'VAT Review',
                                SRM = 'Pregled PDV-a';
                    Image = ShowMatrix;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction();
                    var
                        VATReviewMatrix: Page "VAT Review Matrix";
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
                CaptionML = ENU = 'VAT Book',
                            SRM = 'PDV knjiga';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                var
                    VATBookColumnName: Record "VAT Book Column Name";
                begin
                    VATBookColumnName.SetRange("VAT Book Code", Code);
                    Report.RunModal(Report::"VAT Book", true, false, VATBookColumnName);
                end;
            }
            action(ExportToXML)
            {
                CaptionML = ENU = 'Export to XML',
                            SRM = 'Izvoz u XML';
                trigger OnAction();
                begin
                    //REPORT.RUNMODAL(REPORT::"Export VAT Books To XML",TRUE,FALSE);
                end;//GRM dodati property

            }
        }
    }

    procedure SetSelection(var VATBook: Record "VAT Book");
    begin
        CurrPage.SetSelectionFilter(VATBook);
    end;
}

