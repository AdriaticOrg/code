page 13062643 "FAS Report-Adl"
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "FAS Report Header-Adl";
    Caption = 'FAS Report';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies No.';

                    trigger OnAssistEdit()
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Period Start Date';
                }
                field("Period End Date"; "Period End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Period End Date';
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
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies User ID';
                }

                field("Last Suggest on Date"; "Last Suggest on Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Last Suggest on Date';
                }
                field("Last Suggest at Time"; "Last Suggest at Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Last Suggest at Time';
                }
                field("Last Export on Date"; "Last Export on Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Last Export on Date';
                }
                field("Last Export at Time"; "Last Export at Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Last Export at Time';
                }

                field("Resp. User ID"; "Resp. User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Resp. User ID';
                }
                field("Prep. By User ID"; "Prep. By User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Prep. By User ID';
                }
                field("Previous Report No."; "Previous Report No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Previous Report No.';
                }
                field(Status; Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Status';
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
                ToolTip = 'Runs a periodic activity to populate document lines';

                trigger OnAction()
                var
                    GLEntry: Record "G/L Entry";
                    RepSuggestLines: Report "Suggest FAS Lines-Adl";
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
                ToolTip = 'Runs a report with xml file create option';

                trigger OnAction()
                var
                    FASRepHead: Record "FAS Report Header-Adl";
                begin
                    FASRepHead := Rec;
                    FASRepHead.SetRecFilter();
                    Report.RunModal(report::"Export FAS-Adl", true, false, FASRepHead);
                end;
            }
            action("Release")
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                ApplicationArea = All;
                ToolTip = 'Sets document to realesed state';

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
                ToolTip = 'Sets document to open state';

                trigger OnAction()
                begin
                    Status := Status::Open;
                    Modify();
                end;
            }
        }
    }
}
