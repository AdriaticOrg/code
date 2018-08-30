pageextension 13062532 "PostedSalesCreditMemo-Adl" extends "Posted Sales Credit Memo" //134
{
    layout
    {
        // <adl.6>
	addafter("Posting Date")
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // <adl.10>
	    field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
	    // <adl.10>
        }
	// </adl.6>
	// <adl.18>
        addafter("EU 3-Party Trade")
        {
            field("Goods Return Type-Adl"; "Goods Return Type-Adl")
            {
                ApplicationArea = All;
            }
        }
	// </adl.18>
    }
}