
echo "done by sabarish";


$hos=hostname;

$cho=1;
while ($cho -ne 0)
{

$cho=Read-Host("enter the choice \n 1.referesh polices 2.restart services 3.change host name  \n 0. for exit");

if ($cho -eq 3)
{$a=Read-Host("enter 0 or 1 for current or remote machine "); # used for checking wheather to run for remote or curent machine


if($a -eq 0)
{
$hos=hostname;

}
else
{
$hos=Read-Host("enter the hostname");

}
}

elseif( $cho -eq 1)
{
$CompName=$hos;
$WMIPath = "\\" + $CompName + "\root\ccm:SMS_Client" 
$SMSwmi = [wmiclass] $WMIPath 

echo "done"
$cho="y";
echo " running actions in configuration manager ";

echo " refreshing configration manager action  ";
$list_polices=@("{00000000-0000-0000-0000-000000000121}",
"{00000000-0000-0000-0000-000000000003}",
"{00000000-0000-0000-0000-000000000010}",
"{00000000-0000-0000-0000-000000000001}"
"{00000000-0000-0000-0000-000000000011}",
"{00000000-0000-0000-0000-000000000021}",
"{00000000-0000-0000-0000-000000000002}",
"{00000000-0000-0000-0000-000000000031}",
"{00000000-0000-0000-0000-000000000108}",
"{00000000-0000-0000-0000-000000000113}",
"{00000000-0000-0000-0000-000000000032}"
);       
foreach ( $i in $list_polices)
{

[Void]$SMSwmi.TriggerSchedule($i)
}
 }

 elseif($cho -eq 2)
 {
(Get-WmiObject win32_service -ComputerName "$hos" -Filter "name='NomadBranch'").stopService()

(Get-WmiObject win32_service -ComputerName "$hos" -Filter "name='NomadBranch'").startService()

(Get-WmiObject win32_service -ComputerName "$hos" -Filter "name='ShoppingAgent'").stopService()

(Get-WmiObject win32_service -ComputerName "$hos" -Filter "name='ShoppingAgent'").startService()


(Get-WmiObject win32_service -ComputerName "$hos" -Filter "name='CcmExec'").stopService()

(Get-WmiObject win32_service -ComputerName "$hos" -Filter "name='CcmExec'").startService()
Start-Sleep -s 10;


if( (Get-Service "NomadBranch" )[0].Status -ne "Running")
{
echo (Get-Service "NomadBranch" )[0].Status;
Get-Service "NomadBranch" -ComputerName "$hos" | Restart-Service -Force -Verbose
}
else
{echo " not Nomanbranch";

}


if( (Get-Service "ShoppingAgent" )[0].Status -ne "Running")
{
echo (Get-Service "ShoppingAgent" )[0].Status;
Get-Service "ShoppingAgent" -ComputerName "$hos" | Restart-Service -Force -Verbose
}
else
{echo "not ShoppingAgent";

}
if( (Get-Service "CcmExec" )[0].Status -ne "Running")
{
echo (Get-Service "CcmExec" )[0].Status;
Get-Service "CcmExec" -ComputerName "$hos" | Restart-Service -Force -Verbose
}
else
{echo "not restarting ccmexec";

}





Start-Sleep -s 10;

Get-Service "NomadBranch"

Get-Service "ShoppingAgent"
Get-Service "CcmExec"
} 
}
