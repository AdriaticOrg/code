pageextension 50100 "ExtSalesOrder-adl" extends "Sales Order"
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Importance = Additional;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}