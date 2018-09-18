table 13062621 "PDO Report Header-Adl"
{
    Caption = 'PDO Report Header';
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
                    PDOSetup.GET();
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
                Month: Integer;
            begin
                Year := Date2DMY("Period Start Date", 3);
                Month := Date2DMY("Period Start Date", 2);
                "Period Year" := Year;
                "Period Round" := Month;
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
        ADLCore: Codeunit "Adl Core-Adl";
    begin
        PDOSetup.GET();
        IF "No." = '' THEN BEGIN
            TestNoSeries();
            NoSeriesMgt.InitSeries(GetNoSeriesCode(), xRec."No. Series", 0D, "No.", "No. Series");
        END;

        PDOSetup.TestField("PDO Prep. By User ID");
        PDOSetup.TestField("PDO Resp. User ID");

        "Prep. By User ID" := PDOSetup."PDO Prep. By User ID";
        "Resp. User ID" := PDOSetup."PDO Resp. User ID";
        "User ID" := ADLCore.TrimmedUserID50();
    end;

    trigger OnModify()
    begin
        TestStatusOpen("No.");
    end;

    local procedure TestNoSeries()
    begin
        PDOSetup.TestField("PDO Report No. Series");
    end;

    local procedure TestNoSeriesManual()
    begin
        NoSeriesMgt.TestManual(PDOSetup."PDO Report No. Series");
    end;

    local procedure GetNoSeriesCode(): Code[20]
    begin
        exit(PDOSetup."PDO Report No. Series")
    end;

    procedure AssistEdit(OldPDORepHead: record "PDO Report Header-Adl"): Boolean
    begin
        with PDORepHead do begin
            copy(Rec);
            PDOSetup.Get();
            TestNoSeries();
            IF NoSeriesMgt.SelectSeries(GetNoSeriesCode(), OldPDORepHead."No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");

                Rec := PDORepHead;
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
        PDORepHead: Record "PDO Report Header-Adl";
    begin
        PDORepHead.get(DocNo);
        PDORepHead.TestField(Status, PDORepHead.Status::Open);
    end;

    var
        PDOSetup: Record "PDO Setup-Adl";
        PDORepHead: Record "PDO Report Header-Adl";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}