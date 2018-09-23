page 13062661 "KRD Report-Adl"
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "KRD Report Header-Adl";
    Caption = 'KRD Report';

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
            part(Subpage; 13062663)
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
                ToolTip = 'Runs a periodic activity to populate document lines';

                trigger OnAction()
                var
                    CLE: Record "Cust. Ledger Entry";
                    VLE: record "Vendor Ledger Entry";
                    RepSuggestLines: Report "Suggest KRD Lines-Adl";
                begin
                    TestField("No.");
                    TestField("Period Start Date");
                    TestField("Period End Date");

                    CLE.Reset();
                    CLE.SetRange("Posting Date", "Period Start Date", "Period End Date");
                    cle.SetFilter("KRD Non-Residnet Sector Code-Adl", '<>%1', '');

                    VLE.Reset();
                    VLE.SetRange("Posting Date", "Period Start Date", "Period End Date");
                    VLE.SetFilter("KRD Non-Residnet Sector Code-Adl", '<>%1', '');

                    RepSuggestLines.SetTableView(CLE);
                    RepSuggestLines.SetTableView(VLE);

                    RepSuggestLines.SetKRDRepDocNo("No.");
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
                    KRDRepHead: Record "KRD Report Header-Adl";
                begin
                    KRDRepHead := Rec;
                    KRDRepHead.SetRecFilter();
                    Report.RunModal(report::"Export KRD-Adl", true, false, KRDRepHead);
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
