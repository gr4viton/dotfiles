schtasks /query /tn gr4_time_online_hourly
IF %ERRORLEVEL% EQU 1 (
    ECHO aa
    schtasks /create /tn gr4_time_online_hourly /tr gr4_time_online_update.bat /sc hourly /mo 1
    ECHO Task gr4_time_online_hourly scheduled succesfully
) ELSE (
    ECHO Task gr4_time_online_hourly already scheduled, proceeding to delete the task.
    schtasks /delete /tn gr4_time_online_hourly    
)


