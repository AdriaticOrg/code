page 13062597 "VAT Book Setup Matrix-Adl"
{
    Caption = 'VAT Book Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "VAT Book Group Identifier-Adl";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("VAT Book Code"; "VAT Book Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            repeater(Lines)
            {
                Editable = false;
                FreezeColumn = "VAT Identifier";
                field("VAT Book Group Code"; "VAT Book Group Code")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = True;
                    ApplicationArea = All;
                }
                field("VAT Identifier"; "VAT Identifier")
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = True;
                    ApplicationArea = All;
                }
                field(Field1; MATRIX_CellData[1])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Visible = Field1Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(1);
                    end;
                }
                field(Field2; MATRIX_CellData[2])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[2];
                    Visible = Field2Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(2);
                    end;
                }
                field(Field3; MATRIX_CellData[3])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[3];
                    Visible = Field3Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(3);
                    end;
                }
                field(Field4; MATRIX_CellData[4])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[4];
                    Visible = Field4Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(4);
                    end;
                }
                field(Field5; MATRIX_CellData[5])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[5];
                    Visible = Field5Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(5);
                    end;
                }
                field(Field6; MATRIX_CellData[6])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[6];
                    Visible = Field6Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(6);
                    end;
                }
                field(Field7; MATRIX_CellData[7])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[7];
                    Visible = Field7Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(7);
                    end;
                }
                field(Field8; MATRIX_CellData[8])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[8];
                    Visible = Field8Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(8);
                    end;
                }
                field(Field9; MATRIX_CellData[9])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[9];
                    Visible = Field9Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(9);
                    end;
                }
                field(Field10; MATRIX_CellData[10])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[10];
                    Visible = Field10Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(10);
                    end;
                }
                field(Field11; MATRIX_CellData[11])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[11];
                    Visible = Field11Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(11);
                    end;
                }
                field(Field12; MATRIX_CellData[12])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[12];
                    Visible = Field12Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(12);
                    end;
                }
                field(Field13; MATRIX_CellData[13])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[13];
                    Visible = Field13Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(13);
                    end;
                }
                field(Field14; MATRIX_CellData[14])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[14];
                    Visible = Field14Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(14);
                    end;
                }
                field(Field15; MATRIX_CellData[15])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[15];
                    Visible = Field15Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(15);
                    end;
                }
                field(Field16; MATRIX_CellData[16])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[16];
                    Visible = Field16Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(16);
                    end;
                }
                field(Field17; MATRIX_CellData[17])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[17];
                    Visible = Field17Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(17);
                    end;
                }
                field(Field18; MATRIX_CellData[18])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[18];
                    Visible = Field18Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(18);
                    end;
                }
                field(Field19; MATRIX_CellData[19])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[19];
                    Visible = Field19Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(19);
                    end;
                }
                field(Field20; MATRIX_CellData[20])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[20];
                    Visible = Field20Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(20);
                    end;
                }

                field(Field21; MATRIX_CellData[21])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[21];
                    Visible = Field21Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(21);
                    end;
                }
                field(Field22; MATRIX_CellData[22])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[22];
                    Visible = Field22Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(22);
                    end;
                }
                field(Field23; MATRIX_CellData[23])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[23];
                    Visible = Field23Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(23);
                    end;
                }
                field(Field24; MATRIX_CellData[24])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[24];
                    Visible = Field24Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[25];
                    Visible = Field25Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(25);
                    end;
                }
                field(Field26; MATRIX_CellData[26])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[26];
                    Visible = Field26Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(26);
                    end;
                }
                field(Field27; MATRIX_CellData[27])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[27];
                    Visible = Field27Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(27);
                    end;
                }
                field(Field28; MATRIX_CellData[28])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[28];
                    Visible = Field28Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(28);
                    end;
                }
                field(Field29; MATRIX_CellData[29])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[29];
                    Visible = Field29Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(29);
                    end;
                }
                field(Field30; MATRIX_CellData[30])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[30];
                    Visible = Field30Visible;
                    ApplicationArea = All;

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(30);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        MatrixOnAfterGetRecord();
    end;

    trigger OnInit();
    begin
        Field30Visible := true;
        Field29Visible := true;
        Field28Visible := true;
        Field27Visible := true;
        Field26Visible := true;
        Field25Visible := true;
        Field24Visible := true;
        Field23Visible := true;
        Field22Visible := true;
        Field21Visible := true;
        Field20Visible := true;
        Field19Visible := true;
        Field18Visible := true;
        Field17Visible := true;
        Field16Visible := true;
        Field15Visible := true;
        Field14Visible := true;
        Field13Visible := true;
        Field12Visible := true;
        Field11Visible := true;
        Field10Visible := true;
        Field9Visible := true;
        Field8Visible := true;
        Field7Visible := true;
        Field6Visible := true;
        Field5Visible := true;
        Field4Visible := true;
        Field3Visible := true;
        Field2Visible := true;
        Field1Visible := true;
    end;

    trigger OnOpenPage();
    begin
        InitCaption();
    end;

    var
        MatrixRec: Record "VAT Book View Formula-Adl";
        MATRIX_CellData: array[30] of Text;
        MatrixColumnCaptions: array[30] of Text[100];
        [InDataSet]
        Field1Visible: Boolean;
        [InDataSet]
        Field2Visible: Boolean;
        [InDataSet]
        Field3Visible: Boolean;
        [InDataSet]
        Field4Visible: Boolean;
        [InDataSet]
        Field5Visible: Boolean;
        [InDataSet]
        Field6Visible: Boolean;
        [InDataSet]
        Field7Visible: Boolean;
        [InDataSet]
        Field8Visible: Boolean;
        [InDataSet]
        Field9Visible: Boolean;
        [InDataSet]
        Field10Visible: Boolean;
        [InDataSet]
        Field11Visible: Boolean;
        [InDataSet]
        Field12Visible: Boolean;
        [InDataSet]
        Field13Visible: Boolean;
        [InDataSet]
        Field14Visible: Boolean;
        [InDataSet]
        Field15Visible: Boolean;
        [InDataSet]
        Field16Visible: Boolean;
        [InDataSet]
        Field17Visible: Boolean;
        [InDataSet]
        Field18Visible: Boolean;
        [InDataSet]
        Field19Visible: Boolean;
        [InDataSet]
        Field20Visible: Boolean;
        [InDataSet]
        Field21Visible: Boolean;
        [InDataSet]
        Field22Visible: Boolean;
        [InDataSet]
        Field23Visible: Boolean;
        [InDataSet]
        Field24Visible: Boolean;
        [InDataSet]
        Field25Visible: Boolean;
        [InDataSet]
        Field26Visible: Boolean;
        [InDataSet]
        Field27Visible: Boolean;
        [InDataSet]
        Field28Visible: Boolean;
        [InDataSet]
        Field29Visible: Boolean;
        [InDataSet]
        Field30Visible: Boolean;

    local procedure InitCaption();
    var
        VATBookColumnName: Record "VAT Book Column Name-Adl";
    begin
        CLEAR(MatrixColumnCaptions);

        VATBookColumnName.SetFilter("VAT Book Code", GetFILTER("VAT Book Code"));
        if VATBookColumnName.FindSet() then
            repeat
                MatrixColumnCaptions[VATBookColumnName."Column No."] := VATBookColumnName.Description;
            until VATBookColumnName.Next() = 0;
        SetVisible();
    end;

    local procedure MatrixOnAfterGetRecord();
    var
        I: Integer;
        FilterLbl: Label 'FILTERS:';
    begin
        For I := 1 TO ArrayLen(MATRIX_CellData) do begin
            MATRIX_CellData[I] := '';
            if MatrixRec.Get("VAT Book Code", "VAT Book Group Code", "VAT Identifier", I) then
                if MatrixRec.Condition <> '' then
                    MATRIX_CellData[I] := StrSubstNo('%1%2%3%4 %5%6',
                                                        Format(MatrixRec.Operator1),
                                                        Format(MatrixRec.Value1),
                                                        Format(MatrixRec.Operator2),
                                                        Format(MatrixRec.Value2),
                                                        FilterLbl,
                                                        MatrixRec.Condition)
                else
                    MATRIX_CellData[I] := StrSubstNo('%1%2%3%4',
                                                        Format(MatrixRec.Operator1),
                                                        Format(MatrixRec.Value1),
                                                        Format(MatrixRec.Operator2),
                                                        Format(MatrixRec.Value2));
            SetVisible();
        end;
    end;

    local procedure MatrixOnDrillDown(Column: Integer);
    var
        VATBookViewFormula: Record "VAT Book View Formula-Adl";
    begin
        VATBookViewFormula.Reset();
        VATBookViewFormula.SetRange("VAT Book Code", "VAT Book Code");
        VATBookViewFormula.SetRange("VAT Book Group Code", "VAT Book Group Code");
        VATBookViewFormula.SetRange("VAT Identifier", "VAT Identifier");
        VATBookViewFormula.SetRange("Column No.", Column);
        Page.RunModal(0, VATBookViewFormula);
        CurrPage.Update(false);
    end;

    procedure SetVisible();
    begin
        Field1Visible := MatrixColumnCaptions[1] <> '';
        Field2Visible := MatrixColumnCaptions[2] <> '';
        Field3Visible := MatrixColumnCaptions[3] <> '';
        Field4Visible := MatrixColumnCaptions[4] <> '';
        Field5Visible := MatrixColumnCaptions[5] <> '';
        Field6Visible := MatrixColumnCaptions[6] <> '';
        Field7Visible := MatrixColumnCaptions[7] <> '';
        Field8Visible := MatrixColumnCaptions[8] <> '';
        Field9Visible := MatrixColumnCaptions[9] <> '';
        Field10Visible := MatrixColumnCaptions[10] <> '';
        Field11Visible := MatrixColumnCaptions[11] <> '';
        Field12Visible := MatrixColumnCaptions[12] <> '';
        Field13Visible := MatrixColumnCaptions[13] <> '';
        Field14Visible := MatrixColumnCaptions[14] <> '';
        Field15Visible := MatrixColumnCaptions[15] <> '';
        Field16Visible := MatrixColumnCaptions[16] <> '';
        Field17Visible := MatrixColumnCaptions[17] <> '';
        Field18Visible := MatrixColumnCaptions[18] <> '';
        Field19Visible := MatrixColumnCaptions[19] <> '';
        Field20Visible := MatrixColumnCaptions[20] <> '';
        Field21Visible := MatrixColumnCaptions[21] <> '';
        Field22Visible := MatrixColumnCaptions[22] <> '';
        Field23Visible := MatrixColumnCaptions[23] <> '';
        Field24Visible := MatrixColumnCaptions[24] <> '';
        Field25Visible := MatrixColumnCaptions[25] <> '';
        Field26Visible := MatrixColumnCaptions[26] <> '';
        Field27Visible := MatrixColumnCaptions[27] <> '';
        Field28Visible := MatrixColumnCaptions[28] <> '';
        Field29Visible := MatrixColumnCaptions[29] <> '';
        Field30Visible := MatrixColumnCaptions[30] <> '';
    end;
}

