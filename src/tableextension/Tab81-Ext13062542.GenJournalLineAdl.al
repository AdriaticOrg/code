tableextension 13062542 "GenJournalLine-Adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            Editable = False;
            DataClassification = ToBeClassified;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            DataClassification = ToBeClassified;
        }
        // </adl.10>
        //<adl.11>
        field(13062527; "VAT % (retrograde)-Adl"; Decimal)
        {
            Caption = 'VAT % (retrograde)';
            DataClassification = ToBeClassified;
        }
        //</adl.11>
        // <adl.24>
        field(13062641; "FAS Instrument Code"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(13062642; "FAS Sector Code"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062643;"Bal. FAS Instrument Code";Code[10])
        {
            Caption = 'Bal. FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(13062644;"Bal. FAS Sector Code";Code[10])
        {
            Caption = 'Bal. FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }        
        // </adl.24>
        // <adl.22>
        field(13062601; "VAT Correction Date"; Date)
        {
            Caption = 'VAT Correction Date';
            DataClassification = ToBeClassified;
        } 
        field(13062602; "EU Customs Procedure"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = ToBeClassified;
        }                  
        // </adl.22>     	
	    // <adl.28>
        field(13062741;"Original Document Amount (LCY)";Decimal)
        {
    	    Caption = 'Original Document Amount (LCY)';
            DataClassification = ToBeClassified;

        }
        field(13062742;"Original VAT Amount (LCY)";Decimal)
        {
            Caption = '"Original VAT Amount (LCY)"';
            DataClassification = ToBeClassified;   
        }
        //</adl.28>    
    }
}