page 13062598 "VAT Review Matrix-Adl"
{
    Caption = 'VAT Review';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "VAT Book Group-Adl";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'VAT Book Review';
                field("VAT Book Code"; "VAT Book Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies a value of VAT Book Code';
                }
                field(PeriodType; PeriodType)
                {
                    Caption = 'View by';
                    OptionCaption = 'Day,Week,Month,Quarter,Year,Accounting Period';
                    ToolTip = 'Specifies by which period amounts are displayed.';
                    ApplicationArea = All;

                    trigger OnValidate();
                    begin
                        FindPeriod('');
                        CurrPage.Update();
                    end;
                }
                field(DateFilter; DateFilter)
                {
                    Caption = 'Date Filter';
                    ApplicationArea = All;
                    ToolTip = 'Specifies a Date filter for data preview.';

                    trigger OnValidate();
                    begin
                        TextManagement.MakeDateFilter(DateFilter);
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(Lines)
            {
                Editable = false;
                FreezeColumn = "Code";
                field("Code"; Code)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = True;
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code of VAT Book Group.';
                }
                field("Book Link Code"; "Book Link Code") { }
                field(Description; Description)
                {
                    Style = Strong;
                    StyleExpr = true;
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of VAT Book Group.';
                }
                field(Field1; MATRIX_CellData[1])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[1];
                    Visible = Field1Visible;
                    ApplicationArea = All;
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(20);
                    end;
                }
                field(Field21; MATRIX_CellData[11])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[21];
                    Visible = Field21Visible;
                    ApplicationArea = All;
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(24);
                    end;
                }
                field(Field25; MATRIX_CellData[25])
                {
                    CaptionClass = '3,' + MatrixColumnCaptions[25];
                    Visible = Field15Visible;
                    ApplicationArea = All;
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

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
                    ToolTip = 'Preview value, as result of calculated formula on VAT Book Matrix Setup.';

                    trigger OnDrillDown();
                    begin
                        MatrixOnDrillDown(30);
                    end;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";
            }
            action("PreviousPeriod")
            {
                Caption = 'Previous Period';
                ToolTip = 'Show the information based on the previous period. If you set the View by field to Day, the date filter changes to the day before.';
                Image = PreviousRecord;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    FindPeriod('<=');
                end;
            }
            action("NextPeriod")
            {
                Caption = 'Next Period';
                ToolTip = 'Show the information based on the next period. If you set the View by field to Day, the date filter changes to the day before.';
                Image = NextRecord;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    FindPeriod('>=');
                end;
            }
        }

        area(reporting)
        {
            action("VATBook")
            {
                Caption = 'VAT Calculation Details';
                ToolTip = 'View or print the VAT calculation details.';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Clear(VATBookCalcDetails);
                    VATBookCalcDetails.SetParameters(DateFilter, "VAT Book Code");
                    VATBookCalcDetails.Run();
                end;
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

    var
        VATBookCalcDetails: Report "VAT Calc. Details-Adl";
        VATBookCalc: Codeunit "VAT Book Calculation-Adl";
        TextManagement: Codeunit "Filter Tokens";
        MatrixColumnCaptions: array[30] of Text[100];
        DateFilter: Text;
        MATRIX_CellData: array[30] of Decimal;
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
        PeriodType: Option Day,Week,Month,Quarter,Year,"Accounting Period";

    procedure Load(VatBookCode: Code[20]; VatBookGroupFilter: Text[250]; DateFilterPar: Text; PeriodTypePar: Integer);
    var
        VATBookColumnName: Record "VAT Book Column Name-Adl";
    begin
        if VatBookGroupFilter <> '' then begin
            SetCurrentKey("Book Link Code");
            SetFilter("Book Link Code", VatBookGroupFilter);
        end else
            SetRange("VAT Book Code", VatBookCode);
        if DateFilterPar = '' then
            DateFilter := Format(CalcDate('<-CM>', Today())) + '..' + Format(CalcDate('<CM>', Today()))
        else
            DateFilter := DateFilterPar;
        PeriodType := PeriodTypePar;
        VATBookColumnName.SetFilter("VAT Book Code", VatBookCode);
        if VATBookColumnName.FindSet() then
            repeat
                MatrixColumnCaptions[VATBookColumnName."Column No."] := VATBookColumnName.Description;
            until VATBookColumnName.Next() = 0;
        SetVisible();
    end;

    local procedure MatrixOnAfterGetRecord();
    var
        i: Integer;
    begin
        for i := 1 to ArrayLen(MATRIX_CellData) do
            MATRIX_CellData[i] := VATBookCalc.EvaluateExpression(Rec, i, DateFilter);
    end;

    local procedure MatrixOnDrillDown(Column: Integer);
    /*
    var
        VATEntry: Record "VAT Entry";
        VATBookViewFormula: Record "VAT Book View Formula-Adl";
        VATReviewMatrix: Page "VAT Review Matrix-Adl";
    */
    begin
        /*GRMToDo
        case "Group Type" of
            "Group Type"::"VAT Entries":
                begin
                    VATEntry.SetCurrentKey(Type, "Posting Date", "VAT Identifier-Adl");
                    VATEntry.SetFilter(Type, '<>%1', VATEntry.Type::Settlement);
                    if DateFilter <> '' then
                        VATEntry.SetFilter("Posting Date", DateFilter);
                    VATEntry.SetFilter("VAT Identifier-Adl", VATBookCalc.GetVATIdentifierFilter(Rec));
                    Page.RunModal(0, VATEntry);
                end;
            "Group Type"::Total:
                if (StrPos(Totaling, '..') + StrPos(Totaling, '|') > 0) then begin
                    VATReviewMatrix.Load("VAT Book Code", Totaling, DateFilter, PeriodType);
                    VATReviewMatrix.RunModal;
                end;
        end;
        */
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

    local procedure FindPeriod(SearchText: Code[3]);
    var
        Calendar: Record Date;
        PeriodFormMgt: Codeunit PeriodFormManagement;
    begin
        if DateFilter <> '' then begin
            Calendar.SetFilter("Period Start", DateFilter);
            if not PeriodFormMgt.FindDate('+', Calendar, PeriodType) then
                PeriodFormMgt.FindDate('+', Calendar, PeriodType::Day);
            Calendar.SetRange("Period Start");
        end;
        PeriodFormMgt.FindDate(SearchText, Calendar, PeriodType);
        if Calendar."Period Start" = Calendar."Period End" then
            DateFilter := Format(Calendar."Period Start")
        else
            DateFilter := Format(Calendar."Period Start") + '..' + Format(Calendar."Period End");
    end;
}

