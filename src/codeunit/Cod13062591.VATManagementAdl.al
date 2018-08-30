codeunit 13062591 "VAT Management-Adl"
{
    var
        CallLevel: Integer;
        CircularRefErr: Label 'Because of circular references, the program cannot calculate a formula.';

    procedure CalculateValue(IsFirstValue: Boolean; var TempAmount: Decimal; VATBookViewFormula: Record "VAT Book View Formula-Adl"; VatEntry: Record "VAT Entry");
    var
        TempValue: Decimal;
    begin
        with VATBookViewFormula do
        begin
            if IsFirstValue then begin
                case Value1 of
                    Value1::"Base Amount" :
                        TempValue := VatEntry.Base;
                    Value1::"VAT Amount" :
                        TempValue := VatEntry.Amount;
                    Value1::"Amount Inc. VAT" :
                        TempValue := VatEntry.Base + VatEntry.Amount;
                    Value1::"Base Amount(retro.)" :
                        TempValue := VatEntry."VAT Base (retro.)-Adl";
                    Value1::"Unrealizied Base" :
                        TempValue := VatEntry."Unrealized Base";
                    Value1::"Unrealized Amount" :
                        TempValue := VatEntry."Unrealized Amount";
                    Value1::"Unrealized Amount Inc. VAT" :
                        TempValue := VatEntry."Unrealized Base" + VatEntry."Unrealized Amount";
                    Value1::"VAT Retro" :
                        TempValue := VatEntry."VAT Amount (retro.)-Adl";
                    Value1::"Amount Inc. VAT(retro)" :
                        TempValue := VatEntry."VAT Base (retro.)-Adl" + VatEntry."VAT Amount (retro.)-Adl";
                end;
                if Operator1 = Operator1::"-" then
                    TempAmount := TempAmount - TempValue
                else
                    TempAmount := TempAmount + TempValue;
            end else begin
                case Value2 of
                    Value2::"Base Amount" :
                        TempValue := VatEntry.Base;
                    Value2::"VAT Amount" :
                        TempValue := VatEntry.Amount;
                    Value2::"Amount Inc. VAT" :
                        TempValue := VatEntry.Base + VatEntry.Amount;
                    Value2::"Base Amount(retro.)" :
                        TempValue := VatEntry."VAT Base (retro.)-Adl";
                    Value2::"Unrealizied Base" :
                        TempValue := VatEntry."Unrealized Base";
                    Value2::"Unrealized Amount" :
                        TempValue := VatEntry."Unrealized Amount";
                    Value2::"Unrealized Amount Inc. VAT" :
                        TempValue := VatEntry."Unrealized Base" + VatEntry."Unrealized Amount";
                    Value2::"VAT Retro" :
                        TempValue := VatEntry."VAT Amount (retro.)-Adl";
                    Value2::"Amount Inc. VAT(retro)" :
                        TempValue := VatEntry."VAT Base (retro.)-Adl" + VatEntry."VAT Amount (retro.)-Adl";
                end;
                if Operator2 = Operator2::"-" then
                    TempAmount := TempAmount - TempValue
                else
                    TempAmount := TempAmount + TempValue;
            end;
        end;
    end;

    procedure GetVATIdentifierFilter(VATBookGroup: Record "VAT Book Group-Adl") VATIdentifierFilter: Text;
    var
        VATBookGroupIdentifier: Record "VAT Book Group Identifier-Adl";
    begin
        with VATBookGroup do
        begin
            VATIdentifierFilter := '';
            VATBookGroupIdentifier.Reset;
            VATBookGroupIdentifier.SetCurrentKey("VAT Book Code", "VAT Book Group Code", "VAT Identifier");
            VATBookGroupIdentifier.SetRange("VAT Book Code", "VAT Book Code");
            VATBookGroupIdentifier.SetRange("VAT Book Group Code", Code);
            if VATBookGroupIdentifier.FindSet then
                repeat
                    if VATIdentifierFilter = '' then
                        VATIdentifierFilter := VATBookGroupIdentifier."VAT Identifier"
                    else
                        VATIdentifierFilter += '|' + VATBookGroupIdentifier."VAT Identifier";
                until VATBookGroupIdentifier.Next = 0;
        end;
    end;

    local procedure CalcCellValue(VATBookGroup: Record "VAT Book Group-Adl"; ColumnNo: Integer; var Result: Decimal; DateFilter: Text);
    var
        VATBookViewFormula: Record "VAT Book View Formula-Adl";
        VATEntry: Record "VAT Entry";
    begin
        VATBookViewFormula.Reset;
        VATBookViewFormula.SetRange("VAT Book Code", VATBookGroup."VAT Book Code");
        VATBookViewFormula.SetRange("VAT Book Group Code", VATBookGroup.Code);
        VATBookViewFormula.SetFilter("VAT Identifier", GetVATIdentifierFilter(VATBookGroup));
        VATBookViewFormula.SetRange("Column No.", ColumnNo);
        VATEntry.SetCurrentKey(Type, "Posting Date", "VAT Identifier-Adl");
        VATEntry.SetFilter(Type, '<>%1', VATEntry.Type::Settlement);
        if DateFilter <> '' then
            VATEntry.SetFilter("Posting Date", DateFilter);
        if VATBookViewFormula.FindSet then
            repeat
                VATEntry.SetFilter("VAT Identifier-Adl", VATBookViewFormula."VAT Identifier");
                if VATEntry.FindSet then
                    repeat
                        if VATBookViewFormula.Operator1 <> VATBookViewFormula.Operator1::" " then
                            CalculateValue(true, Result, VATBookViewFormula, VATEntry);
                        if VATBookViewFormula.Operator2 <> VATBookViewFormula.Operator2::" " then
                            CalculateValue(false, Result, VATBookViewFormula, VATEntry);
                    until VATEntry.Next = 0;
            until VATBookViewFormula.Next = 0;
    end;

    procedure EvaluateExpression(VATBookGroup: Record "VAT Book Group-Adl"; ColumnNo: Integer; DateFilter: Text) Result: Decimal;
    var
        VATBookGroupIdent: Record "VAT Book Group Identifier-Adl";
        VATBookViewFormula2: Record "VAT Book View Formula-Adl";
        VBGroup: Record "VAT Book Group-Adl";
        Parantheses: Integer;
        Operator: Char;
        LeftOperand: Text;
        RightOperand: Text;
        LeftResult: Decimal;
        RightResult: Decimal;
        i: Integer;
        IsExpression: Boolean;
        IsFilter: Boolean;
        Operators: Text[8];
        OperatorNo: Integer;
        VatIdentFilter: Text;
        Expression: Text;
    begin
        Result := 0;
        if VATBookGroup."Group Type" = VATBookGroup."Group Type"::Total then
            Expression := VATBookGroup.Totaling
        else
            Expression := VATBookGroup.Code;

        CallLevel := CallLevel + 1;
        if CallLevel > 25 then
            Error(CircularRefErr);

        Expression := DelChr(Expression, '<>', ' ');
        if StrLen(Expression) > 0 then begin
            Parantheses := 0;
            IsExpression := false;
            Operators := '+-*/';
            OperatorNo := 1;
            repeat
                i := StrLen(Expression);
                
                repeat
                    if Expression[i] = '(' then
                        Parantheses := Parantheses + 1
                    else if Expression[i] = ')' then
                        Parantheses := Parantheses - 1;
                    if(Parantheses = 0) and (Expression[i] = Operators[OperatorNo]) then
                        IsExpression := true
                    else
                        i := i - 1;
                until IsExpression or(i <= 0);

                if not IsExpression then
                    OperatorNo := OperatorNo + 1;
            until(OperatorNo > StrLen(Operators)) or IsExpression;

            if IsExpression then begin
                if i > 1 then
                    LeftOperand := CopyStr(Expression, 1, i - 1)
                else
                    LeftOperand := '';
                if i < StrLen(Expression) then
                    RightOperand := CopyStr(Expression, i + 1)
                else
                    RightOperand := '';
                Operator := Expression[i];
                VBGroup.SetRange("Book Link Code", LeftOperand);
                VBGroup.FindFirst;
                LeftResult := EvaluateExpression(VBGroup, ColumnNo, DateFilter);
                VBGroup.SetRange("Book Link Code", RightOperand);
                VBGroup.FindFirst;
                RightResult := EvaluateExpression(VBGroup, ColumnNo, DateFilter);
                case Operator of
                    '*' :
                        Result := LeftResult * RightResult;
                    '/' :
                        if RightResult = 0 then begin
                            Result := 0;
                        end else
                            Result := LeftResult / RightResult;
                    '+' :
                        Result := LeftResult + RightResult;
                    '-' :
                        Result := LeftResult - RightResult;
                end;
            end else if(Expression[1] = '(') and (Expression[StrLen(Expression)] = ')') then begin
                    VBGroup := VATBookGroup;
                    VBGroup.Totaling := CopyStr(Expression, 2, StrLen(Expression) - 2);
                    Result += EvaluateExpression(VBGroup, ColumnNo, DateFilter);
                end else begin
                    IsFilter := (StrPos(Expression, '..') + StrPos(Expression, '|') > 0);
                    if not IsFilter then
                        CalcCellValue(VATBookGroup, ColumnNo, Result, DateFilter)
                    else begin
                        VBGroup.SetCurrentKey("Book Link Code");
                        VBGroup.SetFilter("Book Link Code", Expression);
                        if VBGroup.FindSet then
                            repeat
                                Result += EvaluateExpression(VBGroup, ColumnNo, DateFilter);
                            until VBGroup.Next = 0;
                    end;
                end;
        end;
        CallLevel := CallLevel - 1;
    end;
}

