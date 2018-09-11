codeunit 13062815 "Adl Core Notification-adl"
{
    var
        MyNotifications: Record "My Notifications";
        MyNotification: Notification;

    procedure ShowSetupNotification();
    var
        CoreSetup: Record "CoreSetup-Adl";
        CoreSetupIsNotQst: Label 'Adriatic Localization is installed but not setup. Do you want to do this now?';
        Yes: Label 'Yes';
        DontAskAgain: Label 'No, and please don''t remind me again.';
    begin
        IF CoreSetup.Get() THEN
            exit;
        IF not IsCoreSetupNotificationEnabled() then
            exit;
        MyNotification.ID := GetCoreSetupNotificationId();
        MyNotification.Message := CoreSetupIsNotQst;
        MyNotification.AddAction(Yes, Codeunit::"Adl Notification Action-adl", 'CoreSetupNotify');
        MyNotification.AddAction(DontAskAgain, Codeunit::"Adl Notification Action-adl", 'DisableCoreSetupNotify');
        MyNotification.Send();
    end;

    procedure GetCoreSetupNotificationId(): GUID;
    begin
        exit('2712AD06-C48B-4C20-820E-347A60C9AD01');
    end;

    procedure IsCoreSetupNotificationEnabled(): Boolean;
    var
        MyNotifications: Record "My Notifications";
    begin
        exit(MyNotifications.IsEnabled(GetCoreSetupNotificationId()));
    end;

}