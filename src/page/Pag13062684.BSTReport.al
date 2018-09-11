page 13062684 "BST Report"
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "BST Report Header";
    Caption = 'BST Report';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Period End Date"; "Period End Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
                field("Last Suggest on Date"; "Last Suggest on Date")
                {
                    ApplicationArea = All;
                }
                field("Last Suggest at Time"; "Last Suggest at Time")
                {
                    ApplicationArea = All;
                }
                field("Last Export on Date"; "Last Export on Date")
                {
                    ApplicationArea = All;
                }
                field("Last Export at Time"; "Last Export at Time")
                {
                    ApplicationArea = All;
                }

                field("Resp. User ID"; "Resp. User ID")
                {
                    ApplicationArea = All;
                }
                field("Prep. By User ID"; "Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

            }
            part(Subpage; 13062683)
            {
                SubPageLink = "Document No." = field ("No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Suggest Lines")
            {
                Caption = 'Suggest Lines';
                Promoted = true;
                Image = CalculateLines;
                ApplicationArea = All;

                trigger OnAction()
                var
                    RepSuggestLines: Report "Suggest BST Lines";
                    GLEntry: Record "G/L Entry";
                begin
                    TestField("No.");
                    TestField("Period Start Date");
                    TestField("Period End Date");

                    GLEntry.Reset();
                    GLEntry.SetRange("Posting Date", "Period Start Date", "Period End Date");

                    RepSuggestLines.SetTableView(GLEntry);
                    RepSuggestLines.SetBSTRepDocNo("No.");
                    RepSuggestLines.RunModal();
                end;

            }
            action("Export Report")
            {
                Caption = 'Export Report';
                Promoted = true;
                Image = Export;
                ApplicationArea = All;

                trigger OnAction()
                var
                    BSTRepHead: Record "BST Report Header";
                begin
                    BSTRepHead := Rec;
                    BSTRepHead.SetRecFilter();
                    Report.RunModal(report::"Export BST", true, false, BSTRepHead);
                end;
            }
            action("Release")
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Status := Status::Realesed;
                    Modify();
                end;
            }
            action("Reopen")
            {
                Caption = 'Reopen';
                Image = ReOpen;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Status := Status::Open;
                    Modify();
                end;
            }
        }
    }
}