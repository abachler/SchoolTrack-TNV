//%attributes = {}
  //PV_ExecuteCommand


C_LONGINT:C283($1;$area;$2;$command;$3;$modifier)
$area:=$1
$command:=$2
$modifier:=$3
Case of 
	: ($command=1003)  //save
		QR_SaveReport 
		
	: ($command=1004)  //save as
		QR_SaveReportAs 
		
	Else 
		PV EXECUTE COMMAND:P13000:30 ($area;$command)
End case 