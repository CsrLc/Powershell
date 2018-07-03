#Créer le dossier \\ Editer path 
New-Item -Name CONFIDENTIEL -ItemType Directory -Path D:\Consultim\PROGRAMMES\*

#Obtiens les ACL sur un dossier type \\ Stocke dans $dacl
$dacl = Get-Acl -Path D:\Consultim\PROGRAMMES\EXPERTIM

#Applique ACL du doosier type au dossier CONFIDENTIEL \\ Editer path
Set-Acl -AclObject $dacl -Path D:\Consultim\PROGRAMMES\*\"*CONFIDENTIEL*"

