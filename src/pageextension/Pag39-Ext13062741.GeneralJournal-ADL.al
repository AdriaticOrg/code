
pageextension 13062741 "GeneralJournalHR-adl" extends "General Journal" 
{
    layout
    {
        
        addlast(Control1)
        {
            // <#28>
            field("Original Document Amount (LCY)"; "Original Document Amount (LCY)")
            {
                ApplicationArea = Basic,Advanced;
                Caption = 'Original Document Amount (LCY)';

                trigger OnValidate();
                begin
                end;
            }
            field("Original VAT Amount (LCY)"; "Original VAT Amount (LCY)")
            {
                ApplicationArea = Basic,Advanced;
                Caption = 'Original VAT Amount (LCY)';

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