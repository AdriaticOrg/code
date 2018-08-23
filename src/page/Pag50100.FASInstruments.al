page 50100 "FAS Instruments"
{
    Caption= 'Finance Instruments';
    PageType = List;
    DelayedInsert = true;
    SourceTable = "FAS Instrument";
    
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
                }
                field(Description;Description)
                {
                }
                field(Type;Type)
                {
                }
                field(Totaling;Totaling)
                {
                    Editable = false;
                }
                field(Indentation;Indentation)
                {
                    Editable = false;
                }
                field("AOP Code";"AOP Code")
                {
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