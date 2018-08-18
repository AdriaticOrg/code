page 50104 "VAT Book Group Identifiers"
{
    CaptionML = ENU = 'VAT Book Group Identifiers',
                SRM = 'Identifikatori grupe knjige PDV-a';
    DelayedInsert = true;
    PageType = List;
    SourceTable = "VAT Book Group Identifier";

    layout
    {
        area(content)
        {
            repeater(Lines)
            {
                field("VAT Identifier"; "VAT Identifier") { }
                field(Description; Description) { }
            }
        }
    }
}

