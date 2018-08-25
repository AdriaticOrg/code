page 50101 "FAS Sectors"
{
    Caption= 'Finance Sectors';
    PageType = List; 
    SourceTable = "FAS Sector";
    Editable = true;
    
    layout
    {
        area(content)
        {
            repeater(Control1100636000)
            {
                IndentationControls = Description;
                ShowCaption = false;
                field("Code";Code)
                {
                    ApplicationArea = All;
                }
                field(Description;Description)
                {
                    ApplicationArea = All;
                }
                field(Type;Type)
                {
                    ApplicationArea = All;
                }
                field(Totaling;Totaling)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Indentation;Indentation)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Show Credit/Debit";"Show Credit/Debit")
                {
                    ApplicationArea = All;
                }
                field("AOP Code";"AOP Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(ActionName)
            {
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    
    var
        myInt: Integer;
}