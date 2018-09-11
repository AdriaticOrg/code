table 13062643 "FAS Report Header"
{
    Caption = 'FAS Report Header';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    RepSISetup.GET();
                    TestNoSeriesManual();
                    "No. Series" := '';
                END;
            end;
        }

        field(6; "No. Series"; code[20])
        {
            Caption = 'No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }

        field(10; "Period Start Date"; Date)
        {
            Caption = 'Period Start Date';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            var
                Year: Integer;
            begin
                Year := Date2DMY("Period Start Date", 3);
                "Period Year" := Year;
            end;
        }
        field(11; "Period End Date"; Date)
        {
            Caption = 'Period End Date';
            DataClassification = SystemMetadata;
        }
        field(12; "Period Year"; Integer)
        {
            Caption = 'Period Year';
            DataClassification = SystemMetadata;
        }
        field(13; "Period Round"; Integer)
        {
            Caption = 'Period Round';
            DataClassification = SystemMetadata;
        }

        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User."User Name";
            Editable = false;
            DataClassification = SystemMetadata;
        }

        field(16; "Last Suggest on Date"; Date)
        {
            Caption = 'Last Suggest on Date';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(17; "Last Suggest at Time"; Time)
        {
            Caption = 'Last Suggest at Time';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(18; "Last Export on Date"; Date)
        {
            Caption = 'Last Export on Date';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(19; "Last Export at Time"; Time)
        {
            Caption = 'Last Export at Time';
            Editable = false;
            DataClassification = SystemMetadata;
        }

        field(20; "Status"; Option)
        {
            OptionMembers = "Open","Realesed";
            Caption = 'Status';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(30; "Previous Report No."; Code[20])
        {
            Caption = 'Previous Report No.';
            TableRelation = "FAS Report Header";
            DataClassification = SystemMetadata;
        }
        field(40; "Resp. User ID"; Text[100])
        {
            Caption = 'Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(41; "Prep. By User ID"; Text[100])
        {
            Caption = 'Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
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
    var
        ADLCore: Codeunit "Adl Core";
    begin
        RepSISetup.GET();
        IF "No." = '' THEN BEGIN
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
        END;

        RepSISetup.TestField("FAS Prep. By User ID");
        RepSISetup.TestField("FAS Resp. User ID");

        "Prep. By User ID" := RepSISetup."FAS Prep. By User ID";
        "Resp. User ID" := RepSISetup."FAS Resp. User ID";
        "User ID" := ADLCore.TrimmedUserID50();
    end;

    trigger OnModify()
    begin
        TestStatusOpen("No.");
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

    procedure AssistEdit(OldFASRepHead: record "FAS Report Header"): Boolean
    begin
        with FASRepHead do begin
            copy(Rec);
            RepSISetup.Get();
            TestNoSeries();
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldFASRepHead."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");

                Rec := FASRepHead;
                EXIT(TRUE);
            end;
        end;
    end;

    procedure ReleaseReopen(Direction: Option "Release","Reopen")
    begin
        if Direction = Direction::Release then
            Status := Status::Realesed
        else
            Status := Status::Open;
        Modify();
    end;

    procedure TestStatusOpen(DocNo: Code[20])
    var
        FASRepHead: Record "FAS Report Header";
    begin
        FASRepHead.get(DocNo);
        FASRepHead.TestField(Status, FASRepHead.Status::Open);
    end;

    var
        RepSISetup: Record "Reporting_SI Setup";
        FASRepHead: Record "FAS Report Header";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}
