schtasks /query /tn gr4log_git_update_onstart 
IF %ERRORLEVEL% EQU 1 (
    ECHO aa
    schtasks /create /tn gr4log_git_update_onstart /tr _gr4log_git_updatee.bat /sc onstart
    ECHO Task gr4log_git_update_onstart scheduled succesfully
) ELSE (
    ECHO Task gr4log_git_update_onstart already scheduled, proceeding to delete the task.
    schtasks /delete /tn gr4log_git_update_onstart    
)
