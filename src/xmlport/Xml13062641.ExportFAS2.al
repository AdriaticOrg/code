xmlport 13062641 "ExportFAS2"
{
    UseRequestPage = false;
    Direction = Export;
    schema
    {        
        textelement(AjpesDokument)
        {
            textelement(Ident) {
                textelement(Vrsta) {
                    trigger OnBeforePassVariable()
                    begin
                        Vrsta := 'sfr_' + FORMAT(DATE2DMY(ExpDate,3));
                    end;
                }
                textelement(Krog) {
                    trigger OnBeforePassVariable()
                    begin
                        Krog := format(FASRepHead."Period Round");
                    end;
                }
            }
            tableelement(FASReportLine;"FAS Report Line")
            {
                fieldelement(Sector;FASReportLine."Sector Code") {
                }
                fieldelement(Instrument;FASReportLine."Instrument Code") {

                
                }
            }
        }
    }    

    var
        Save2File:Boolean;
        ExpDate:Date;
        FASRepHead:Record "FAS Report Header";

    procedure SetParams(FASRepHeadLcl:record "FAS Report Header")
    begin
        ExpDate := Today();
        FASRepHead := FASRepHeadLcl;
        //Message('%1',FASRepHead."Period Round");
    end;
}