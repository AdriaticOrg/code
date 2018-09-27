table 13062784 "Fiscalization Location-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Location';
    DataClassification = SystemMetadata;
    LookupPageId = "Fisc. Location List-Adl";
    DrillDownPageId = "Fisc. Location List-Adl";
    fields
    {
        field(1; "Fisc. Location Code"; Code[10])
        {
            Caption = 'Fisc. Location Code';
            NotBlank = True;
            DataClassification = SystemMetadata;
        }
        field(2; "Fisc. Street"; text[100])
        {
            Caption = 'Fisc. Street';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(3; "Fisc. House Number"; text[4])
        {
            Caption = 'Fisc. House Number';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(4; "Fisc. House Number Appendix"; text[4])
        {
            Caption = 'Fisc. House Number Appendix';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(5; "Fisc. Settlement"; Text[35])
        {
            Caption = 'Fisc. Settlement';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(6; "Fisc. City/Municipality"; Text[35])
        {
            Caption = 'Fisc. City/Municipality';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(7; "Fisc. Post Code"; Code[20])
        {
            Caption = 'Fisc. Post Code';
            DataClassification = SystemMetadata;
            TableRelation = "Post Code";
            trigger OnValidate()
            var
                PostCode: Record "Post Code";
            begin
                ValidateFiscData();
                PostCode.SETRANGE(Code, "Fisc. Post Code");
                IF PostCode.FINDFIRST() THEN
                    "Fisc. City/Municipality" := PostCode.City;
            end;
        }
        field(8; "Fisc. Location Description"; Text[100])
        {
            Caption = 'Fisc. Location Description';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(9; "Working Hours"; Text[100])
        {
            Caption = 'Working Hours';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                ValidateFiscData();
            end;
        }
        field(10; "Date Of Application"; Date)
        {
            Caption = 'Date Of Application';
            DataClassification = SystemMetadata;
        }
        field(11; "Fisc. No. Series"; Code[20])
        {
            Caption = 'Fisc. No. Series';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(12; "Fisc. Active"; Boolean)
        {
            Caption = 'Fisc. Active';
            Description = 'Active';
            DataClassification = SystemMetadata;
        }
        field(13; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            Editable = False;
            DataClassification = SystemMetadata;
        }
        field(14; "Creation Time"; Time)
        {
            Caption = 'Creation Time';
            Editable = False;
            DataClassification = SystemMetadata;
        }
        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(16; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            Editable = false;
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Fisc. Location Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Creation Date" := TODAY();
        "Creation Time" := TIME();
        "User ID" := copystr(UserId(), 1, 50);
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        ERROR('');
    end;

    procedure ValidateFiscData();
    var
        Msg001Txt: Label 'If you change this value location must be resubmited to provider. Do you wish to continue';
    begin
        IF (((Rec."Fisc. Street" <> xRec."Fisc. Street") OR
              (Rec."Fisc. House Number" <> xRec."Fisc. House Number") OR
              (Rec."Fisc. House Number Appendix" <> xRec."Fisc. House Number Appendix") OR
              (Rec."Fisc. Settlement" <> xRec."Fisc. Settlement") OR
              (Rec."Fisc. City/Municipality" <> xRec."Fisc. City/Municipality") OR
              (Rec."Fisc. Post Code" <> xRec."Fisc. Post Code") OR
              (Rec."Fisc. Location Description" <> xRec."Fisc. Location Description") OR
              (Rec."Working Hours" <> xRec."Working Hours")) AND
              (Rec."Fisc. Active"))
          THEN BEGIN
            IF GUIALLOWED() THEN
                IF NOT CONFIRM(Msg001Txt, FALSE) THEN BEGIN
                    Rec := xRec;
                    EXIT;
                END;
            "Fisc. Active" := FALSE;
        END;
    end;
    // </adl.20>
}