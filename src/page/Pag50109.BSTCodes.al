page 50109 "BST Codes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    Editable = true;
    SourceTable = "BST Code";
    
    layout
    {
        area(content)
        {
            repeater(Control1100636000)
            {
                IndentationControls = Description;
                ShowCaption = false;

                field(Code;Code) {
                    ApplicationArea = All;
                }
                field("Serial Num.";"Serial Num.") {
                    ApplicationArea = All;
                }
                field(Description;Description) {
                    ApplicationArea = All;
                }
                field(Totaling;Totaling) {
                    ApplicationArea = All;
                }
                field(Type;Type) {
                    ApplicationArea = All;
                }
                field(Indentaion;Indentaion) {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}