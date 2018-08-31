tableextension 13062526 "PurchaseHeader-Adl" extends "Purchase Header"  //38
{
    fields
    {
        // <adl.6>
	field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';

            trigger OnValidate();
            begin
                if "VAT Date-Adl" <> "Posting Date" then
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT"
                else
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Realized VAT";
            end;
        }
	// </adl.6>
	// <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
	// </adl.10>
        // <adl.18>
	field(13062581; "Goods Return Type-Adl"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Goods Return Type';
            TableRelation = "Goods Return Type-Adl";
        }
	// </adl.18>
    }
}