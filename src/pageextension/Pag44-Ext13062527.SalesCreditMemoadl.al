pageextension 13062527 "SalesCreditMemo-Adl" extends "Sales Credit Memo" //44
{
    layout
    {
        // <adl.6>
	addafter("Posting Date")
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
        // <adl.22>
        field("VAT Correction Date";"VAT Correction Date") {
            ApplicationArea = All;
        }
        // </adl.22>
        }
	// </adl.6>
        // <adl.18>  
	addafter("EU 3-Party Trade")
        {
            // <adl.22>
            field("EU Customs Procedure";"EU Customs Procedure") {
                ApplicationArea = All;
            }
            // </adl.22>
            field("Goods Return Type-Adl"; "Goods Return Type-Adl")
            {
                ApplicationArea = All;
            }
        }
	// </adl.18>
    }
}