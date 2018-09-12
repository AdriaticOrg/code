page 13062643 "FAS Report"
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "FAS Report Header";
    Caption = 'FAS Report';

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
                field("Period Year"; "Period Year")
                {
                    ApplicationArea = All;
                }
                field("Period Round"; "Period Round")
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
                field("Previous Report No."; "Previous Report No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                }

            }
            part(Subpage; 13062644)
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
                ApplicationArea = All;
                Image = CalculateLines;

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    RepSuggestLines: Report "Suggest FAS Lines";
                begin
                    TestField("No.");
                    TestField("Period Start Date");
                    TestField("Period End Date");

                    GLEntry.Reset();
                    GLEntry.SetRange("Posting Date", "Period Start Date", "Period End Date");

                    RepSuggestLines.SetTableView(GLEntry);
                    RepSuggestLines.SetFASRepDocNo("No.");
                    RepSuggestLines.RunModal();
                end;

            }
            action("Export Report")
            {
                Caption = 'Export Report';
                Promoted = true;
                Image = Export;
                ApplicationArea = All;
                //RunObject = report "Export FAS";

                trigger OnAction()
                var
                    FASRepHead: Record "FAS Report Header";
                begin
                    FASRepHead := Rec;
                    FASRepHead.SetRecFilter();
                    Report.RunModal(report::"Export FAS", true, false, FASRepHead);
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