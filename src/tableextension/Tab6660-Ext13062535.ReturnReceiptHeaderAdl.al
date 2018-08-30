tableextension 13062535 "Return Receipt Header-Adl" extends "Return Receipt Header"  //6660
{
    fields
    {
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