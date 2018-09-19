page 13062622 "PDO Report-Adl"
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "PDO Report Header-Adl";
    Caption = 'PDO Report';

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
                field(Status; Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Status';
                }
            }
            part(Subpage; 13062621)
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
                    VATEntry: Record "VAT Entry";
                    PDOSetup: Record "PDO Setup-Adl";
                    RepSuggestLines: Report "Suggest PDO Lines-Adl";
                begin
                    TestField("No.");
                    TestField("Period Start Date");
                    TestField("Period End Date");

                    VATEntry.Reset();
                    VATEntry.SetRange("Posting Date", "Period Start Date", "Period End Date");

                    if PDOSetup.Get() and (PDOSetup."PDO VAT Ident. Filter Code" <> '') then
                        VATEntry.SetRange("VAT Identifier-Adl", PDOSetup."PDO VAT Ident. Filter Code");

                    RepSuggestLines.SetTableView(VATEntry);
                    RepSuggestLines.SetPDORepDocNo("No.");
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
                    PDORepHead: Record "PDO Report Header-Adl";
                begin
                    PDORepHead := Rec;
                    PDORepHead.SetRecFilter();
                    Report.RunModal(report::"Export PDO-Adl", true, false, PDORepHead);
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
