tableextension 13062529 "Sales Cr.Memo Header-Adl" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        // <adl.6>
	field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = ToBeClassified;
        }
	// </adl.6>
	// <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            DataClassification = ToBeClassified;
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