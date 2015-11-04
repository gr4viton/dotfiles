schtasks /query /tn gr4log_git_update_minute 
IF %ERRORLEVEL% EQU 1 (
    ECHO aa
    schtasks /create /tn gr4log_git_update_minute /tr _gr4log_git_updatee.bat /sc minute /mo 5
    ECHO Task gr4log_git_update_minute scheduled succesfully
) ELSE (
    ECHO Task gr4log_git_update_minute already scheduled, proceeding to delete the task.
    schtasks /delete /tn gr4log_git_update_minute    
)

