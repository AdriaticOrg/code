codeunit 50100 "VAT Management"
{
    var
        CallLevel: Integer;
        CircularRefErr: TextConst ENU = 'Because of circular references, the program cannot calculate a formula.',
                            SRM = 'Program ne može da izračuna formulu zbog cirkularnih referenci.';

    procedure CalculateValue(IsFirstValue: Boolean; var TempAmount: Decimal; VATBookViewLine: Record "VAT Book View Line"; VatEntry: Record "VAT Entry");
    var
        TempValue: Decimal;
    begin
        with VATBookViewLine do
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
                        TempValue := VatEntry."VAT Base (retro.)";
                    Value1::"Unrealizied Base" :
                        TempValue := VatEntry."Unrealized Base";
                    Value1::"Unrealized Amount" :
                        TempValue := VatEntry."Unrealized Amount";
                    Value1::"Unrealized Amount Inc. VAT" :
                        TempValue := VatEntry."Unrealized Base" + VatEntry."Unrealized Amount";
                    Value1::"VAT Retro" :
                        TempValue := VatEntry."VAT Amount (retro.)";
                    Value1::"Amount Inc. VAT(retro)" :
                        TempValue := VatEntry."VAT Base (retro.)" + VatEntry."VAT Amount (retro.)";
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
                        TempValue := VatEntry."VAT Base (retro.)";
                    Value2::"Unrealizied Base" :
                        TempValue := VatEntry."Unrealized Base";
                    Value2::"Unrealized Amount" :
                        TempValue := VatEntry."Unrealized Amount";
                    Value2::"Unrealized Amount Inc. VAT" :
                        TempValue := VatEntry."Unrealized Base" + VatEntry."Unrealized Amount";
                    Value2::"VAT Retro" :
                        TempValue := VatEntry."VAT Amount (retro.)";
                    Value2::"Amount Inc. VAT(retro)" :
                        TempValue := VatEntry."VAT Base (retro.)" + VatEntry."VAT Amount (retro.)";
                end;
                if Operator2 = Operator2::"-" then
                    TempAmount := TempAmount - TempValue
                else
                    TempAmount := TempAmount + TempValue;
            end;
        end;
    end;

    procedure GetVATIdentifierFilter(VATBookGroup: Record "VAT Book Group") VATIdentifierFilter: Text;
    var
        VATBookGroupIdentifier: Record "VAT Book Group Identifier";
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

    local procedure CalcCellValue(VATBookGroup: Record "VAT Book Group"; ColumnNo: Integer; var Result: Decimal; DateFilter: Text);
    var
        VATBookViewLine: Record "VAT Book View Line";
        VATEntry: Record "VAT Entry";
    begin
        VATBookViewLine.Reset;
        VATBookViewLine.SetRange("VAT Book Code", VATBookGroup."VAT Book Code");
        VATBookViewLine.SetRange("VAT Book Group Code", VATBookGroup.Code);
        VATBookViewLine.SetFilter("VAT Identifier", GetVATIdentifierFilter(VATBookGroup));
        VATBookViewLine.SetRange("Column No.", ColumnNo);
        VATEntry.SetCurrentKey(Type, "Posting Date", "VAT Identifier");
        VATEntry.SetFilter(Type, '<>%1', VATEntry.Type::Settlement);
        if DateFilter <> '' then
            VATEntry.SetFilter("Posting Date", DateFilter);
        if VATBookViewLine.FindSet then
            repeat
                VATEntry.SetFilter("VAT Identifier", VATBookViewLine."VAT Identifier");
                if VATEntry.FindSet then
                    repeat
                        if VATBookViewLine.Operator1 <> VATBookViewLine.Operator1::" " then
                            CalculateValue(true, Result, VATBookViewLine, VATEntry);
                        if VATBookViewLine.Operator2 <> VATBookViewLine.Operator2::" " then
                            CalculateValue(false, Result, VATBookViewLine, VATEntry);
                    until VATEntry.Next = 0;
            until VATBookViewLine.Next = 0;
    end;

    procedure EvaluateExpression(VATBookGroup: Record "VAT Book Group"; ColumnNo: Integer; DateFilter: Text) Result: Decimal;
    var
        VATBookGroupIdent: Record "VAT Book Group Identifier";
        VATBookViewLine2: Record "VAT Book View Line";
        VBGroup: Record "VAT Book Group";
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

