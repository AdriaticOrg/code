pageextension 13062526 "SalesInvoice-Adl" extends "Sales Invoice" //43
{
    layout
    {
        addafter("Posting Date")
        {
            // <adl.6>
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
            }
            // </adl.6>
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // </adl.10>
        }
        // <adl.22>
        addafter("EU 3-Party Trade") {
            field("EU Customs Procedure";"EU Customs Procedure") {
                ApplicationArea =All;
            }
        }
        // </adl.22>
    }

}