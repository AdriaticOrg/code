pageextension 13062534 "PostedPurchaseCreditMemo-Adl" extends "Posted Purchase Credit Memo"  //140
{
    layout
    {
        // <adl.6>
	addlast(General)
        {
            field("VAT Date -Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // <adl.10>
	    field("Postponed VAT -Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
	    // <adl.10>
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