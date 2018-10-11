//%attributes = {}
  //ACTpp_CargaArregloAnosHist

$tipo:=$1
$id_apoderado:=$2

ARRAY TEXT:C222(aYearsACT;0)
ARRAY LONGINT:C221($al_years;0)
ARRAY LONGINT:C221($al_months;0)
READ ONLY:C145([xxACT_Datos_de_Cierre:116])
ALL RECORDS:C47([xxACT_Datos_de_Cierre:116])
ORDER BY:C49([xxACT_Datos_de_Cierre:116];[xxACT_Datos_de_Cierre:116]Year:1;>;[xxACT_Datos_de_Cierre:116]Month:3;>)
SELECTION TO ARRAY:C260([xxACT_Datos_de_Cierre:116]Year:1;$al_years;[xxACT_Datos_de_Cierre:116]Month:3;$al_months)
For ($x;1;Size of array:C274($al_years))
	READ ONLY:C145([xxACT_ArchivosHistoricos:113])
	$key:=String:C10($al_years{$x};"0000")+"."+String:C10($al_months{$x};"00")+"."+$tipo+"."+String:C10($id_apoderado)+".@"
	KRL_FindAndLoadRecordByIndex (->[xxACT_ArchivosHistoricos:113]Referencia:8;->$key)
	If (Records in selection:C76([xxACT_ArchivosHistoricos:113])>0)
		APPEND TO ARRAY:C911(aYearsACT;String:C10($al_years{$x})+"-"+String:C10($al_months{$x}))
	End if 
End for 
AT_DistinctsArrayValues (->aYearsACT)
AT_Insert (1;1;->aYearsACT)
aYearsACT{1}:=__ ("Actual")
aYearsACT:=1

  //setea visibilidad de selección de años
If (Size of array:C274(aYearsACT)=1)
	OBJECT SET VISIBLE:C603(*;"aYearsACT@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"aYearsACT@";True:C214)
End if 