
#Ce scipt est rédigé par : SGT HALIDI et SGC KOZAK

#On définit les variables des serveurs DHCP (ESXi HAUT et BAS)

$DHCP1 = "SDBS4-MPMDWZ01V"
$DHCP2 = "SDBS4-MPMDWZ02V"

function Restart-DHCP {

    Invoke-Command -ComputerName $DHCP1 {Stop-Service Spooler}
    Write-Host "`n1. Arrêt du service Spooler ..." -ForegroundColor Green
    Remove-item -Path $env:windir\System32\spool\PRINTERS\*.* 
    Write-Host "2. Suppression des fichiers en file d'attente de l'imprimante dans $env:windir\System32\spool\PRINTERS\*.*" -ForegroundColor Green
    Start-Service Spooler -ErrorAction Ignore 
    Write-Host "3. Démarrage du service Spooler ..." -ForegroundColor Green

        if((Get-Service Spooler).Status -eq "Stopped"){

            Write-Host "!!! Erreur. Le service Spooler n'a pas démarré ou est stoppé, vérifier le service" -ForegroundColor Red

        }  

    Get-Service -Name Spooler

}

function Restart-DHCP2 {

    Invoke-Command -ComputerName $DHCP2 {Stop-Service Spooler}
    Write-Host "`n1. Arrêt du service Spooler ..." -ForegroundColor Green
    Remove-item -Path $env:windir\System32\spool\PRINTERS\*.* 
    Write-Host "2. Suppression des fichiers en file d'attente de l'imprimante dans $env:windir\System32\spool\PRINTERS\*.*" -ForegroundColor Green
    Start-Service Spooler -ErrorAction Ignore 
    Write-Host "3. Démarrage du service Spooler ..." -ForegroundColor Green

        if((Get-Service Spooler).Status -eq "Stopped"){

            Write-Host "!!! Erreur. Le service Spooler n'a pas démarré ou est stoppé, vérifier le service" -ForegroundColor Red

        }  

    Get-Service -Name Spooler
}
Write-Host "`nExplication du script"

do{
    
    Write-Host "`nChoisissez votre action :" `n
    Write-Host "A : Redemarrage du spooler d'impression sur le serveur IMP-DHCP" -ForegroundColor Green
    Write-Host "B : Redemarrage du spooler d'impression sur le serveur IMP-DHCP2" -ForegroundColor Green
    Write-Host "C : Redemarrage du spooler d'impression sur les 2 serveurs IMP-DHCP" -ForegroundColor Green
    Write-Host "D : Quitter le script" `n -ForegroundColor Red

    $Reponse = Read-Host "Choix" 


}while($Reponse -notmatch "^[a-d]{1}$")

if($Reponse -eq "a"){

    Restart-DHCP
}

if($Reponse -eq "b"){

    Restart-DHCP2
}


if($Reponse -eq "c"){
    
    Restart-DHCP
    Restart-DHCP2

}


else{

    Write-Host "`nFin du script"

}