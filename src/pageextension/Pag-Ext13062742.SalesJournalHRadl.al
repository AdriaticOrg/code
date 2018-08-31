pageextension 13062742 "SalesJournalHR-adl" extends "Sales Journal" 
{
    layout
    {
        
        addlast(Control1)
        {
            // <#28>
            field("Original Document Amount (LCY)"; "Original Document Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original Document Amount (LCY)';
                Visible = false;

                trigger OnValidate();
                begin
                end;
            }
            field("Original VAT Amount (LCY)"; "Original VAT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original VAT Amount (LCY)';
                Visible = false;

                trigger OnValidate();
                begin
                end;
            }
            // </#28>
        }
        
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}