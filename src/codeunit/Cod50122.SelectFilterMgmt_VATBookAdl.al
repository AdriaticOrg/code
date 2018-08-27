codeunit 50122 "SelectFilterMgmt_VATBook-Adl"
{
    procedure GetSelectionFilterForVatBookGroup(var VATGroup: Record "VAT Book Group-Adl"): Text;
    var
        RecRef: RecordRef;
    begin
        RecRef.GETTABLE(VATGroup);
        exit(GetSelectionFilter(RecRef, VATGroup.FIELDNO("Book Link Code")));
    end;

    local procedure GetSelectionFilter(var TempRecRef: RecordRef; SelectionFieldID: Integer): Text;
    var
        RecRef: RecordRef;
        FieldRef: FieldRef;
        FirstRecRef: Text;
        LastRecRef: Text;
        SelectionFilter: Text;
        SavePos: Text;
        TempRecRefCount: Integer;
        More: Boolean;
    begin
        if TempRecRef.IsTemporary then begin
            RecRef := TempRecRef.Duplicate;
            RecRef.Reset;
        end else
            RecRef.Open(TempRecRef.Number);

        TempRecRefCount := TempRecRef.Count;
        if TempRecRefCount > 0 then begin
            TempRecRef.Ascending(true);
            TempRecRef.FIND('-');
            while TempRecRefCount > 0 do begin
                TempRecRefCount := TempRecRefCount - 1;
                RecRef.SetPosition(TempRecRef.GetPosition);
                RecRef.Find;
                FieldRef := RecRef.Field(SelectionFieldID);
                FirstRecRef := Format(FieldRef.Value);
                LastRecRef := FirstRecRef;
                More := TempRecRefCount > 0;
                while More do
                    if RecRef.Next = 0 then
                            More := false
                        else begin
                            SavePos := TempRecRef.GetPosition;
                            TempRecRef.SetPosition(RecRef.GetPosition);
                            if not TempRecRef.Find then begin
                                More := false;
                                TempRecRef.SetPosition(SavePos);
                            end else begin
                                FieldRef := RecRef.Field(SelectionFieldID);
                                LastRecRef := Format(FieldRef.Value);
                                TempRecRefCount := TempRecRefCount - 1;
                                if TempRecRefCount = 0 then
                                    More := false;
                            end;
                        end;
                if SelectionFilter <> '' then
                    SelectionFilter := SelectionFilter + '|';
                if FirstRecRef = LastRecRef then
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef)
                else
                    SelectionFilter := SelectionFilter + AddQuotes(FirstRecRef) + '..' + AddQuotes(LastRecRef);
                if TempRecRefCount > 0 then
                    TempRecRef.Next;
            end;
            exit(SelectionFilter);
        end;
    end;

    [Scope('Personalization')]
    procedure AddQuotes(inString: Text[1024]): Text;
    begin
        if DelChr(inString, '=', ' &|()*') = inString then
            exit(inString);
        exit('''' + inString + '''');
    end;
}

