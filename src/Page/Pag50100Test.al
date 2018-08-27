page 50100 Test
{
    layout
    {
        
    }
    
    actions
    {
        area(processing)
        {
            action("&Navigate")
            {               
                CaptionML = ENU ='TestCU';
                Image=Navigate;
                Promoted=true;
                PromotedCategory=Process;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    TextWriter.Run();
                end;
            }
        }
    }

    
  var
    TextWriter : Codeunit "TextWriter-adl";
}