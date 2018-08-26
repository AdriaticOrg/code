tableextension 50113 "UserSetup-adl" extends "User Setup" 
{
    fields {

        field(50100;"Reporting_SI Name";Text[100]) {
            Caption = 'Reporting_SI Name';
            DataClassification = ToBeClassified;            
        }
        field(50101; "Reporting_SI Email"; text[100])
        {
            Caption = 'Reporting_SI Email';
            DataClassification = ToBeClassified;
        }
        field(50102; "Reporting_SI Position"; Text[100])
        {
            Caption = 'Reporting_SI Position';
            DataClassification = ToBeClassified;
        }
        field(50103; "Reporting_SI Phone"; Text[30])
        {
            Caption = 'Reporting_SI Phone';
            DataClassification = ToBeClassified;
        }             

    }
    
}