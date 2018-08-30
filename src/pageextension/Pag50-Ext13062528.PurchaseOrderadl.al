pageextension 13062528 "PurchaseOrder-Adl" extends "Purchase Order" //50
{
    layout
    {
        addlast(General)
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
            }
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
            }
        }
    }
}