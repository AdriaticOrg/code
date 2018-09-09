page 13062596 "VAT Book View Formula-Adl"
{

    Caption = 'VAT Book View Lines';
    DataCaptionFields = "VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.";
    PageType = Worksheet;
    PopulateAllFields = true;
    SourceTable = "VAT Book View Formula-Adl";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field(Operator1; Operator1)
                {
                    ApplicationArea = All;
                }
                field(Value1; Value1)
                {
                    ApplicationArea = All;
                }
                field(Operator2; Operator2)
                {
                    ApplicationArea = All;
                }
                field(Value2; Value2)
                {
                    ApplicationArea = All;
                }
                field(Condition; Condition)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;

                    trigger OnAssistEdit();
                    begin
                        if CurrPage.Editable() then begin
                            SetFiltersForVATEntry();
                            CurrPage.Update(true);
                        end;
                    end;
                }
            }

        }
    }
}

