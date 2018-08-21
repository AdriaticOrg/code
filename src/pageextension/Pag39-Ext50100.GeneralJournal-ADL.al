
pageextension 50100 "General Journal-adl-hr" extends "General Journal" 
{
    layout
    {
        
        addlast(Control1)
        {
            // <UnpaidReceivables>
            field("Original Document Amount (LCY)"; "Original Document Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original Document Amount (LCY)';

                trigger OnValidate();
                begin
                end;
            }
            field("Original VAT Amount (LCY)"; "Original VAT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original VAT Amount (LCY)';

                trigger OnValidate();
                begin
                end;
            }
            // </UnpaidReceivables>
        }
        
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}