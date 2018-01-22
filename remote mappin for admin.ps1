

echo "done  by sabarish"

$user = Read-Host "enter the user name";
$pass = Read-Host "Enter the password"-AsSecureString;
$drive="D:";
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($pass)
$pass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
$ip="active";
while(1 ){

$ip=Read-Host "Enter the ip address,hostname or serial number ,unmap driveletter  for unmaping no for exit";
if($ip -ne ""){
if($ip -eq "no")
{break;
}

if($ip.StartsWith("unmap"))
{


$dri = $ip[6]
if($dri -ieq "C" -or $dri -ieq "D" -or $dri -ieq "H")
{
echo ("These are retricted drives ")\
continue
}

try{

$drive= $dri+":";

$net.RemoveNetworkDrive($drive,$true)
echo ("removing the drive ");
}
catch{
try {
Net use $drive /delete
}
catch{
echo ("no drive  found ")
}
}



continue;
}

if($ip.startswith("SGH","CurrentCultureIgnoreCase") -or $ip.startswith("CNU","CurrentCultureIgnoreCase")  -or $ip.startswith("5CG","CurrentCultureIgnoreCase")) 
{
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
$scriptPath=$scriptPath+"/HPAM Export_11_10_20175.csv"

$a = Import-Csv $scriptPath  | where { $ip -match $_."Serial number (Asset)" }  

if($a -ne $NULL)
{
echo "searching in serialnumber";
$a= ($a[0].'Cfg item tag')
$a=$a
$ip=$a.trim()
echo "\\$ip\c$"
}
else{

echo "serial number not found in the list"
continue
}

}

if(!(test-path D:))
{
$drive="D:";
}
elseif(!(test-path E:))
{
$drive="E:";
}

elseif(!(test-path F:))
{
$drive="F:";
}


elseif(!(test-path G:))
{
$drive="G:";
}
if(!(test-path H:))
{  
$drive="H:";
}

if(!(test-path I:))
{
$drive="I:";
}


elseif(!(test-path J:))
{
$drive="J:";
}

elseif(!(test-path K:))
{
$drive="K:";
}


elseif(!(test-path L:))
{
$drive="L:";
}


elseif(!(test-path M:))
{
$drive="M:";
}


elseif(!(test-path N:))
{
$drive="N:";
}

elseif(!(test-path O:))
{
$drive="O:";
}

elseif(!(test-path P:))
{
$drive="P:";
}
elseif(!(test-path Q:))
{
$drive="Q:";
}
elseif(!(test-path R:))
{
$drive="R:";
}
elseif(!(test-path S:))
{
$drive="S:";
}
elseif(!(test-path T:))
{
$drive="T:";
}
elseif(!(test-path U:))
{
$drive="U:";
}
elseif(!(test-path A:))
{
$drive="A:";

}
elseif(!(test-path B:))
{
$drive="B:";

}
elseif(!(test-path V:))
{
$drive="V:";

}
elseif(!(test-path W:))
{
$drive="W:";

}
elseif(!(test-path X:))
{
$drive="X:";

}
elseif(!(test-path Y:))
{
$drive="Y:";

}
elseif(!(test-path Z:))
{
$drive="Z:";

}


try{
if(Test-Connection $ip -Quiet)
{$net= new-object -ComObject WScript.Network
$net.MapNetworkDrive("$drive","\\$ip\c$",$false,"$user","$pass");
echo ("the drive has been mapped to drive "+$drive );
} 
else{
echo ("no system is  available  with the respective address ")
}

}catch [System.Net.NetworkInformation.PingException] {
echo( "test" )

}

catch [System.UnauthorizedAccessException]{
echo("your not authroised to access the drive  ")


}

catch{

echo($Error[0].Exception.GetType())
echo($Error[0].Exception.Message.ToString())
}
}
else{
echo ( "please provide a valid input ");
}
}


