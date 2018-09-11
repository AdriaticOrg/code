codeunit 13062814 "Adl Notification-adl"
{
    trigger OnRun();
    begin
    end;

    var
        MyNotifications: Record "My Notifications";
        MyNotification: Notification;

    procedure ShowSetupNotification();
    var
        CoreSetup: Record "CoreSetup-Adl";
        BillingNotSetup: Label 'Adriatic Localization is installed but not setup. Do you want to do this now?';
        Yes: Label 'Yes';
        DontAskAgain: Label 'No, and please don''t remind me again.';
    begin
        IF CoreSetup.GET THEN
            exit;

        IF NOT My
        ;
        otifications.IsEnabled('3ab3f6f2-285f-4fa7-aa7c-b13858c5a3a9') THEN
            exit;

        MyNotification.ID := '3ab3f6f2-285f-4fa7-aa7c-b13858c5a3a9';
        MyNotification.MESSAGE := BillingNotSetup;
        MyNotification.ADDACTION(Yes, Codeunit::"Billing Notification Action", 'BillingSetup');
        MyNotification.ADDACTION(DontAskAgain, Codeunit::"Billing Notification Action", 'DisableBillingSetup');
        MyNotification.SEND;
    end;
}