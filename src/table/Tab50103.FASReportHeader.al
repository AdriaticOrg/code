table 50103 "FAS Report Header"
{    
    Caption = 'FAS Report Header';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    RepSISetup.GET;
                    TestNoSeriesManual;
                    "No. Series" := '';
                END;
            end;
        }

        field(6; "No. Series"; code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        
        field(10; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Year:Integer;
            begin
                Year := Date2DMY("Period Start Date",3);
                "Period Year" := Year;
            end;
        }
        field(11; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            DataClassification = ToBeClassified;
        }
        field(12; "Period Year"; Integer)
        {
            Caption = 'Period Year';
            DataClassification = ToBeClassified;
        }
        field(13; "Period Round"; Integer)
        {
            Caption = 'Period Round';
            DataClassification = ToBeClassified;
        }
                
        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            Editable = false;
            DataClassification = ToBeClassified;
        }

        field(16; "Last Suggest on Date"; Date)
        {
            Caption = 'Last Suggest on Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(17; "Last Suggest at Time"; Time)
        {
            Caption = 'Last Suggest at Time';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(18; "Last Export on Date"; Date)
        {
            Caption = 'Last Export on Date';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(19; "Last Export at Time"; Time)
        {
            Caption = 'Last Export at Time';
            Editable = false;
            DataClassification = ToBeClassified;
        }              
        
        field(20; "Status"; Option)
        {
            OptionMembers = "Open","Realesed";
            Caption = 'Status';
            Editable = false;
            DataClassification = ToBeClassified;
        }        
    }
    
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        RepSISetup.GET ;
        IF "No." = '' THEN BEGIN
            TestNoSeries;
            NoSeriesMgt.InitSeries(GetNoSeriesCode,xRec."No. Series",0D,"No.","No. Series");
        END;

        "User ID" := UserId();
    end;

    trigger OnModify()
    begin
        TestField(Status,Status::Open);
    end;

    local procedure TestNoSeries()
    begin
        RepSISetup.TestField("FAS Report No. Series");
    end;
    local procedure TestNoSeriesManual()
    begin
        NoSeriesMgt.TestManual(RepSISetup."FAS Report No. Series");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        exit(RepSISetup."FAS Report No. Series")
    end;

    procedure AssistEdit(OldFASRepHead:record "FAS Report Header"): Boolean
    begin
        with FASRepHead do begin
            copy(Rec);
            RepSISetup.Get();
            TestNoSeries();
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode,OldFASRepHead."No. Series","No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");

                Rec := FASRepHead;
                EXIT(TRUE);                
            end;
        end;
    end;
    var
        RepSISetup:Record "Reporting_SI Setup";
        NoSeriesMgt:Codeunit NoSeriesManagement;
        FASRepHead:Record "FAS Report Header";
}