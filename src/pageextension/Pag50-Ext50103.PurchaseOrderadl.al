pageextension 50103 "PurchaseOrder-adl" extends "Purchase Order" //50
{
    layout
    {
        addlast(General)
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
            }
            field("Postponed VAT-adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
            }
        }
    }

}