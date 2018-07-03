#/!\ A Retirer en cas d'erreurs / supprime les Msg d'erreur /!\
#$ErrorActionPreference = "SilentlyContinue"

$DomainUser = 'Cerenicimo\Utilisa. du domaine'
$SubFPath = 'Z:\!Users\*\'

Write-Output -InputObject 'Import des modules nécessaire'

Import-Module -Name NTFSSecurity
Import-Module -Name ActiveDirectory



 #DIRECTORY
    #Obtiens tous les membres du Groupe AD _Cere_Users // Membre Actif Consultim hors Expertim
        $user =  Get-ADGroupMember -Identity '_Cere - Actif'
        
    #Pour chaque membre du groupe AD Créer un Dossier et modifie le nom du dossier pour ne laisser que Prénom Nom
        Foreach ($user in $user) {
            
            #Modifie le nom
                $short = $user.Name.Replace(',OU=USERS,OU=Cerenicimo,DC=Cerenicimo,DC=local','').Replace('é','e')
            
            #Créer le dossier avec Nom simplifié
                New-Item -Name $short -Path 'Z:\!Users' -ItemType Directory 
                
            #Créer les sous-dossier #Scans# et #Sécurisé#
                New-Item -Name '#Scans#' -Path $SubFPath -ItemType Directory  | Disable-NTFSAccessInheritance
                New-Item -Name '#Securise#' -Path $SubFPath -ItemType Directory  | Disable-NTFSAccessInheritance

                
                
                #ACL
                    #Création de l'objet ACL pour les sous dossiers
                        
                        $destination = "Z:\!Users\$short\#Scans#"
                        $destination2 = "Z:\!Users\$short\#Securise#"
                        $domainName = 'Cerenicimo'
                        
                          #Mise en forme des strings. // Prénom NOM -> prenom.nom 
                            [string]$allow = ("$short").ToLower().Replace(' ','.').Replace('é','e')
                        
                            $inherit = [security.accesscontrol.InheritanceFlags]'ContainerInherit, ObjectInherit'
                            $propagation = [security.accesscontrol.PropagationFlags]'None'
                        
                            $acl = (Get-Item -Path $destination).GetAccessControl('Access')
                        
                              #Cerenicimo/prenom.nom
                                $user_acl = '{0}\{1}' -f "$domainName", $allow
                                $user_acl.trim()
                        
                                      $access = 'FullControl'
                                      $accessType = 'Allow'
                                      $accessRule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList @("$allow","$access", "$inherit", "$propagation", "$accessType")
                                      $acl.SetAccessRule($accessRule)
                                      Set-Acl -Path $destination -AclObject $acl 
                                      Set-Acl -Path $destination2 -AclObject $acl

                        
        }

  Write-Output -InputObject 'Suppression des droits sur les dossiers Scans et User'

    #Retire les droits NTFS sur les Dossiers Scans et Securise pour les Domains User
        Get-ChildItem -Path Z:\!Users\*\#Scans# | Get-NTFSAccess -Account $DomainUser | Remove-NTFSAccess
        Get-ChildItem -Path Z:\!Users\*\#Securise# | Get-NTFSAccess -Account $DomainUser | Remove-NTFSAccess