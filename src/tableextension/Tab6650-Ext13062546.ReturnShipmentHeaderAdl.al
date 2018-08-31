tableextension 13062546 "Return Shipment Header -Adl" extends "Return Shipment Header" //6650
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