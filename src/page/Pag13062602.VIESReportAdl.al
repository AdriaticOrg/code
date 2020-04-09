page 13062602 "VIES Report-Adl"
{
    PageType = Document;
    UsageCategory = Administration;
    SourceTable = "VIES Report Header-Adl";
    Caption = 'VIES Report';

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
                field("VIES Country"; "VIES Country")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies VIES Country';
                }
                field("VIES Type"; "VIES Type")
                {
                    ApplicationArea = All;
                    Editable = "VIES Country" = "VIES Country"::Croatia;
                    ToolTip = 'Specifies VIES Type';
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
            part(Subpage; 13062601)
            {
                SubPageLink = "Document No." = field("No.");
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
                    VATEntry: Record "VAT Entry";
                    RepSuggestLines: Report "Suggest VIES Lines-Adl";
                begin
                    CheckBaseData();

                    VATEntry.Reset();
                    VATEntry.SetRange("Posting Date", "Period Start Date", "Period End Date");

                    VATEntry.SetRange(Type, VATEntry.type::Sale);
                    if ("VIES Country" = "VIES Country"::Croatia) and ("VIES Type" = "VIES Type"::"PDV-S") then
                        VATEntry.SetRange(Type, VATEntry.Type::Purchase);

                    RepSuggestLines.SetTableView(VATEntry);
                    RepSuggestLines.SetVIESRepDocNo("No.");
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
                    VIESRepHead: Record "VIES Report Header-Adl";
                begin
                    VIESRepHead := Rec;
                    VIESRepHead.CheckBaseData();
                    VIESRepHead.SetRecFilter();
                    Report.RunModal(report::"Export VIES-Adl", true, false, VIESRepHead);
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
