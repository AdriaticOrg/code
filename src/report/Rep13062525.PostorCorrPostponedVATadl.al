report 13062525 "Post or Corr Postponed VAT-Adl"
{
    ProcessingOnly = true;
    dataset
    {

    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("New Posting Date"; NewPostingDate)
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    procedure SetParameters(parTableNo: Integer; parNo: Code[20]; parType: Option Customer,Vendor; parPostponedVAT: Option "Realized VAT","Postponed VAT"; parPost: Boolean)
    begin
        TableNo := parTableNo;
        No := parNo;
        CustomerVendor := parType;
        Postponed := parPostponedVAT;
        PostVAT := parPost;
    end;

    trigger OnPreReport()
    var
        SuccessMsgPost: Label 'The Postponed VAT was successfully posted.';
        SuccessMsgCorrect: Label 'The Postponed VAT was successfully corrected.';
        CnfrmPost: Label 'Do you really want to post Postponed VAT with VAT Date %1?';
        CnfrmRev: Label 'Do you really want to reverse Postponed VAT with VAT Date %1?';
        NewPostDateErr: Label 'You must enter new posting date.';
        PostVATErr: Label 'You must post Postponed VAT before correcting.';
        AlreadyPostedErr: Label 'You cannot post Postponed VAT because it has already been posted.';
    begin
        if NewPostingDate = 0D then
            Error(NewPostDateErr);
        if (Postponed = Postponed::"Postponed VAT") and not PostVAT then
            Error(PostVATErr);
        if (Postponed = Postponed::"Realized VAT") and PostVAT then
            Error(AlreadyPostedErr);

        if CurrReport.USEREQUESTPAGE then begin
            ;
            if not PostVAT then
                ConfirmMsg := CnfrmRev
            else
                ConfirmMsg := CnfrmPost;
            if not Confirm(ConfirmMsg, TRUE, NewPostingDate) then
                CurrReport.SKIP;
        end;

        VATManagement.HandlePostponedVAT(TableNo, No, NewPostingDate, PostVAT, CustomerVendor, Postponed);
        IF PostVAT THEN
            MESSAGE(SuccessMsgPost)
        ELSE
            MESSAGE(SuccessMsgCorrect);
    end;

    var
        VATManagement: Codeunit "VAT Management-Adl";
        NewPostingDate: Date;
        TableNo: Integer;
        No: Code[20];
        CustomerVendor: Option Customer,Vendor;
        Postponed: Option "Realized VAT","Postponed VAT";
        PostVAT: Boolean;
        ConfirmMsg: Text;
}