$ErrorActionPreference = "SilentlyContinue"

#Créer le dossier
New-Item -Name CONFIDENTIEL -ItemType Directory -Path C:\Users\cesar.lefranc\Desktop\test*

#Obtiens les ACL sur un dossier type \\ Stocke dans $dacl
$dacl = Get-Acl -Path D:\Consultim\PROGRAMMES\EXPERTIM\CONFIDENTIEL

#Applique ACL du doosier type au dossier CONFIDENTIEL \\ Editer path
Set-Acl -AclObject $dacl -Path D:\Consultim\PROGRAMMES\*\"*CONFIDENTIEL*"

