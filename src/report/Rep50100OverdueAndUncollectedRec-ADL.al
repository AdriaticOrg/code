report 50100 "OverdueAndUncollectedRecHR-adl"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    
    dataset
    {
        dataitem(DataItemName; "G/L Account")
        {
            column(ColumnName; "No.")
            {
                
            }
        }
    }
    
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Name; Name)
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
                action(ActionName)
                {
                    ApplicationArea = All;
                    
                }
            }
        }
    }

    var name:Text;
}
