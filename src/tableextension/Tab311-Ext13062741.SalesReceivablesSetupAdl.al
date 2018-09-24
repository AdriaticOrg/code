tableextension 13062741 "Sales & Receivables Setup-Adl" extends "Sales & Receivables Setup" //311
{
    fields
    {
        // <adl.13>
        field(13062741; "Ext. Data Start Bal. Date-Adl"; Date)
        {
            Caption = 'Extended Data Start Balance Date';
            DataClassification = SystemMetadata;
        }
        // </adl.28>
    }

    // <adl.28>
    trigger OnAfterModify()
    var
        ExtendedSetup: Record "Extended Setup-Adl";
    begin
        ExtendedSetup.ModifyExtDataStartBalDate("Ext. Data Start Bal. Date-Adl");
    end;
    // </adl.28>


}

