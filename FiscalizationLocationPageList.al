page 13062607 "Fisc. Location List-ADL"
{
    PageType = List;
    SourceTable = "Fiscalization Location-ADL";
    CardPageId = "Fisc. Location Card-ADL";
    layout
    {
        area(content)
        {
            repeater(List)
            {
                field("Fisc. Location Code"; "Fisc. Location Code")
                {
                    
                }
                field("Fisc. Street"; "Fisc. Street")
                {
                    
                }
                field("Fisc. House Number"; "Fisc. House Number")
                {
                    
                }
                field("Fisc. House Number Appendix"; "Fisc. House Number Appendix")
                {
                    
                }
                field("Fisc. Settlement"; "Fisc. Settlement")
                {
                    
                }
                field("Fisc. City/Municipality"; "Fisc. City/Municipality")
                {
                    
                }
                field("Fisc. Post Code"; "Fisc. Post Code")
                {
                    
                }
                field("Fisc. Location Description"; "Fisc. Location Description")
                {
                    
                }
                field("Working Hours"; "Working Hours")
                {
                    
                }
                field("Date Of Application"; "Date Of Application")
                {
                    
                }
                field("Fisc. No. Series"; "Fisc. No. Series")
                {
                    Visible = false;
                }
                field("Fisc. Active"; "Fisc. Active")
                {
                    Editable = false;
                }
                field("Creation Date"; "Creation Date")
                {
                    
                }
                field("Creation Time"; "Creation Time")
                {
                    
                }
                field("User ID"; "User ID")
                {
                    
                }
                field("Ending Date"; "Ending Date")
                {
                    
                }

            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(Register)
            {
                trigger OnAction()
                begin
                   //FiscLocation.GET("Fisc. Location Code");
                   //FiscLocation.TESTFIELD("Fisc. Active",FALSE);
                   //FiscLocation.TESTFIELD("Closing Tag",'');
                   //FiscLocation.TESTFIELD("Ending Date",0D);
                   //FiscManagementSI.RegisterPlace(FiscLocation);
                   //CurrPage.UPDATE; 
                end;
            }
            action(UnRegister)
            {
                trigger OnAction()
                var
                  Text001 : TextConst ENU='Do you really want to check out the place %1? Renotification of the same area is no longer possible.';
                begin
                    //TESTFIELD("Fisc. Active");
                    //TESTFIELD("Closing Tag",'');
                    //TESTFIELD("Ending Date",0D);
                    //IF GUIALLOWED THEN BEGIN
                      //IF CONFIRM(STRSUBSTNO(Text001,"Fisc. Location Code"),FALSE) THEN BEGIN
                        //FiscLocation.GET("Fisc. Location Code");
                        //FiscLocation."Closing Tag" := 'Z';
                        //FiscLocation.MODIFY;
                        //FiscManagementSI.RegisterPlace(FiscLocation);
                        //CurrPage.UPDATE;
                      //END;
                    //END;
                end;
            }
            action(SubmitLocation)
            {
                trigger OnAction()
                begin
                    //FiscManagementSI.SubmitLocationXMLFile(Rec);
                end;
            }
            action("Fiscalization Location Mapping")
            {
                trigger OnAction()
                var
                  FiscalizationLocationMappingPage : Page "Fisc. Location Mapping-ADL";
                  FiscalizationLocationMapping : Record "Fiscalization Loc. Mapping-ADL";
                begin
                    FiscalizationLocationMapping.SETRANGE("Fisc. Location Code","Fisc. Location Code");
                    FiscalizationLocationMappingPage.SETTABLEVIEW(FiscalizationLocationMapping);
                    FiscalizationLocationMappingPage.RUNMODAL;
                end;
            }
        }
    }
    
    var
        VisibleSI : boolean;
        VisibleHR : boolean;
        FiscManagementSI : Codeunit "Fisc. Management-ADL";
        FiscLocation : Record "Fiscalization Location-ADL";
        trigger OnInit()
            var
                FiscalizationSetup : Record "Fiscalization Setup-ADL";
            begin
                FiscalizationSetup.GET;
                CASE TRUE OF
                // SI
                FiscalizationSetup.CountryCodeSI:
                    BEGIN
                    VisibleSI := TRUE;
                    END;
                // HR
                FiscalizationSetup.CountryCodeHR:
                    BEGIN
                    VisibleHR := TRUE;
                    END;
                END;
            end;
}