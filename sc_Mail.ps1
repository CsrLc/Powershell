$ErrorActionPreference = "SilentlyContinue"

#Local user Logged
    $username = "$env:username"

#Installation et Import des module nécessaire
           
           Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force -Scope CurrentUser
           Install-Module -Name PSFTP -Scope CurrentUser -Force
           Import-Module PSFTP -Force -Scope Local


#Check path + Créa /Signatures
    
    $path = "C:\Users\$username\AppData\Roaming\Microsoft\Signatures"
If(!(Test-Path $path))
{
      New-Item -ItemType Directory -Force -Path $path -Verbose
}

    #Init FTP
        $FTPServer = 'ftp://www.cerenicimo.fr/'
        $FTPUsername = 'signatures'
        $FTPPassword = 'Xw37ac4'
        $FTPSecurePassword = ConvertTo-SecureString -String $FTPPassword -asPlainText -Force
        $FTPCredential = New-Object System.Management.Automation.PSCredential($FTPUsername,$FTPSecurePassword)

    
    #Connection en FTP
        Set-FTPConnection -Credentials $FTPCredential -Server $FTPServer -Session admin -UsePassive 
        $Session = Get-FTPConnection -Session admin 
    
    #Téléchargement de la signature correspondant au local user

          #CERENICIMO        
            
                    Get-FTPItem -Path /signature/cerenicimo/$username.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite
            
        
          #CREDIFINN        

                    Get-FTPItem -Path /signature/credifinn/$username.cred.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite
            
      
          #VP2
            
                    Get-FTPItem -Path /signature/vp2/$username.vp2.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite
            
    
          #TECH        
                    Get-FTPItem -Path /signature/cerenicimo/$username.tech.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite


          #LB2S
  
                    Get-FTPItem -Path /signature/lb2s/$username.lb2s.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite  


          #CONSULTIM

                    Get-FTPItem -Path /signature/consultim/$username.csm.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite     
            

          #CEREFIN

                
                    Get-FTPItem -Path /signature/cerefin/$username.cerefin.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite         
            

          #PREMIUM

              
                    Get-FTPItem -Path /signature/premium/$username.premium.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite 
            

          #FEDERIMO
               
                    Get-FTPItem -Path /signature/federimo/$username.fede.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose  -Overwrite 
            

          #PROPERTIMO
               
                    Get-FTPItem -Path /signature/propertimo/$username.proper.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite
            

            #CONCIERGERIE | CREDIFINN
               
                    Get-FTPItem -Path /signature/credifinn/$username.conciergerie.htm -Session admin -LocalPath C:\Users\$username\AppData\Roaming\Microsoft\Signatures -Verbose -Overwrite
            
