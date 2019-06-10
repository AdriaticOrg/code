codeunit 13062814 "Adl Core Subscriber-Adl"
{
    var
        ADLCoreNotification: Codeunit "Adl Core Notification-adl";

    [EventSubscriber(ObjectType::Table, Database::"Aggregated Assisted Setup", 'OnRegisterAssistedSetup', '', false, false)]
    local procedure HandleOnRegisterAggregatedSetup(var TempAggregatedAssistedSetup: Record "Aggregated Assisted Setup" temporary)
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        AssistedSetupAdl.Initialize();

        AssistedSetupAdl.SetRange(Visible, true);
        AssistedSetupAdl.SetFilter("Assisted Setup Page ID", '%1|%2', Page::"Basic Assist. Setup Wizard-Adl", Page::"Adv. Assist. Setup Wizard-Adl");
        if AssistedSetupAdl.FindSet() then
            repeat
                CLEAR(TempAggregatedAssistedSetup);
                TempAggregatedAssistedSetup.TransferFields(AssistedSetupAdl, TRUE);
                TempAggregatedAssistedSetup."External Assisted Setup" := FALSE;
                TempAggregatedAssistedSetup."Record ID" := AssistedSetupAdl.RecordId();
                TempAggregatedAssistedSetup.Insert();
            until AssistedSetupAdl.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Basic Assist. Setup Wizard-Adl", 'OnOpenPageEvent', '', false, false)]
    local procedure HandleOnPageEventADLWizard()
    var
        AssistedSetupAdl: Record "Assisted Setup-adl";
    begin
        If not AssistedSetupAdl.GET(Page::"Basic Assist. Setup Wizard-Adl") then
            AssistedSetupAdl.Initialize();
    end;

    [EventSubscriber(ObjectType::Page, page::"My Notifications", 'OnInitializingNotificationWithDefaultState', '', false, false)]
    procedure OnInitializingNotificationWithDefaultStat();
    var
        MyNotifications: Record "My Notifications";
        AdlCoreNotification: Codeunit "Adl Core Notification-adl";
        SetupADLTxt: Label 'Ask to setup Adriatic Localization.';
        SetupADLDescriptionTxt: Label 'If you have installed Adriatic Localization but don''t want to use it, switch off receiving the notification.';
    begin
        MyNotifications.InsertDefault(AdlCoreNotification.GetCoreSetupNotificationId(),
             CopyStr(SetupADLTxt, 1, 128), //TODO: find a way to avoid hardcoding string lengths
             SetupADLDescriptionTxt,
             true
        );
    end;

    [EventSubscriber(ObjectType::Page, Page::"Headline RC Business Manager", 'OnOpenPageEvent', '', false, false)]
    local procedure OnRCBusinessManagerOpen(rec: Record "Headline RC Business Manager")
    begin
        ADLCoreNotification.ShowSetupNotification();
    end;

    [EventSubscriber(ObjectType::Page, page::"SO Processor Activities", 'OnOpenPageEvent', '', false, false)]
    procedure OnSOProcessorActivitiesOpen()
    begin
        ADLCoreNotification.ShowSetupNotification();
    end;

}