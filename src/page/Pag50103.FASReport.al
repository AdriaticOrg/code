page 50103 "FAS Report"
{
    PageType = Document;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "FAS Report Header";
    Caption = 'FAS Report';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No.";"No.") {
                    ApplicationArea = All;

                    trigger OnAssistEdit() 
                    begin
                        IF AssistEdit(xRec) THEN
                            CurrPage.UPDATE;                        
                    end;                    
                }
                field("Period Start Date";"Period Start Date") {
                    ApplicationArea = All;
                }
                field("Period End Date";"Period End Date") {
                    ApplicationArea = All;
                }
                field("Period Year";"Period Year") {
                    ApplicationArea = All;
                }
                field("Period Round";"Period Round") {
                    ApplicationArea = All;
                }
                field("User ID";"User ID") {
                    ApplicationArea = All;
                }
                field(Status;Status) {
                    ApplicationArea = All;
                }
                
            }
            part(Subpage;50104) {
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
                ApplicationArea = All;
                //RunObject = report 50100;      

                trigger OnAction()
                var
                    RepSuggestLines:Report "Suggest FAS Lines";
                begin
                    TestField("No.");
                    TestField("Period Start Date");
                    TestField("Period End Date");
                    RepSuggestLines.SetFASRepDocNo("No.");
                    RepSuggestLines.RunModal();
                end;
                      
            }
            action("Release") {
                Caption = 'Release';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Status := Status::Realesed;
                    Modify;
                end;
            }
            action("Reopen") {
                Caption = 'Reopen';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Status := Status::Open;
                    Modify;
                end;
            }
        }
    }
}