schtasks /query /tn gr4log_git_update_onlogon 
IF %ERRORLEVEL% EQU 1 (
    ECHO aa
    schtasks /create /tn gr4log_git_update_onlogon /tr D:\LOG\gr4log\_gr4log_git_update.bat /sc onlogon
    ECHO Task gr4log_git_update_onlogon scheduled succesfully
) ELSE (
    ECHO Task gr4log_git_update_onlogon already scheduled, proceeding to delete the task.
    schtasks /delete /tn gr4log_git_update_onlogon    
)
