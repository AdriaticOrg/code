pageextension 13062530 "PurchaseCreditMemo-Adl" extends "Purchase Credit Memo"  //52
{
    layout
    {
        // <adl.6>
	addlast(General)
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
            }
            // <adl.10>
	    field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
            }
	    // </adl.10>
        }
	// </adl.6>
	// <adl.18>
        addafter("Location Code")
        {
            field("Goods Return Type-Adl"; "Goods Return Type-Adl")
            {
                ApplicationArea = All;
            }
        }
	// </adl.18>
    }
}