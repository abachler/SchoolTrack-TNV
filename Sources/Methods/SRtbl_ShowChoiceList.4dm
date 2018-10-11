//%attributes = {}
  //SRtbl_ShowChoiceList

  //cuando se agregaba un llamado al método tbl_showchoiceList en el script de las propiedades de un informe, en compilado, se generaba un error.

ARRAY TEXT:C222(aQRtbl_Text6;0)
ARRAY TEXT:C222(aQRtbl_Text7;0)
ARRAY TEXT:C222(aQRtbl_Text8;0)
ARRAY TEXT:C222(aQRtbl_Text9;0)
ARRAY TEXT:C222(aQRtbl_Text10;0)
ARRAY REAL:C219(aQRtbl_Real6;0)
ARRAY REAL:C219(aQRtbl_Real7;0)
ARRAY REAL:C219(aQRtbl_Real8;0)
ARRAY REAL:C219(aQRtbl_Real9;0)
ARRAY REAL:C219(aQRtbl_Real10;0)
ARRAY POINTER:C280(<>aChoicePtrs;0)
C_LONGINT:C283($i;$j;$type;$hideCol;$colSort)
C_POINTER:C301($ptr;$object)
C_POINTER:C301(${6})
C_BOOLEAN:C305($multiLine)
C_TEXT:C284($title)
$hideCol:=$1
$title:=$2
$colSort:=$3
$object:=$4
$multiLine:=$5

For ($j;6;Count parameters:C259)
	$type:=Type:C295(${$j}->)
	Case of 
		: (($type=LongInt array:K8:19) | ($type=Integer array:K8:18) | ($type=Real array:K8:17))
			$ptr:=Get pointer:C304("aQRtbl_Real"+String:C10($j))
			For ($i;1;Size of array:C274(${$j}->))
				APPEND TO ARRAY:C911($ptr->;${$j}->{$i})
			End for 
		: (($type=String array:K8:15) | ($type=Text array:K8:16))
			$ptr:=Get pointer:C304("aQRtbl_Text"+String:C10($j))
			COPY ARRAY:C226(${$j}->;$ptr->)
	End case 
	APPEND TO ARRAY:C911(<>aChoicePtrs;$ptr)
End for 
TBL_ShowChoiceList ($hideCol;$title;$colSort;$object;$multiLine)