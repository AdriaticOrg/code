page 13062605 "Fiscalization Setup-ADL"
{
    Caption ='Fiscalization Setup-ADL';
    PageType = Card;
    SourceTable = "Fiscalization Setup-ADL";
    InsertAllowed = true;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Active)
                {
                    ApplicationArea = All;
                }
                field("End Date"; Active)
                {
                    ApplicationArea = All;
                }
                field("Default Fiscalization Location"; Active)
                {
                    ApplicationArea = All;
                }
                field("Default Fiscalization Terminal"; Active)
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }
    
    actions
    {
        area(processing)
        {
            action(FiscalizationTerminalList)
            {
                RunObject = Page "Fisc. Terminal List-ADL";
                image = SetupList;
                Promoted = True;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    
                end;
            }
            action(FiscalizationLocationList)
            {
                RunObject = Page "Fisc. Location List-ADL";
                image = SetupList;
                Promoted = True;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    
                end;
            }
            action(FiscalizationLocationMapping)
            {
                RunObject = Page "Fisc. Location Mapping-ADL";
                image = SetupList;
                Promoted = True;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
    var
      VisibleHR : Boolean;
      VisibleSI : Boolean;
    trigger OnOpenPage()
    begin
        IF NOT GET THEN
          INSERT;
        IF GetCountryCode() = 'SI' THEN BEGIN
          VisibleSI := TRUE;
        END ELSE 
          IF GetCountryCode() = 'HR' THEN
            VisibleHR := TRUE;
    end;
}