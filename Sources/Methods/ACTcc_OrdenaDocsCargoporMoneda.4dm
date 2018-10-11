//%attributes = {}
  //ACTcc_OrdenaDocsCargoporMoneda

C_POINTER:C301(ArregloMoneda)
ARRAY TEXT:C222(atACT_Monedas;0)
ARRAY LONGINT:C221(al_IdsCuentas;0)
$i_Apoderados:=$1
$month:=$2
$year:=$3
  //20120718 ASM Para solucionar el problema de emision de cuentas distintas con el mismo apoderado ticket 111078
If (Count parameters:C259=4)
	$ptr1:=$4
	COPY ARRAY:C226($ptr1->;al_IdsCuentas)
End if 

QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Apoderado:12=al_IDApoderados{$i_Apoderados};*)
QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]ID_Tercero:24=0;*)
QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Mes:13=$month;*)
QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]Año:14=$year;*)
QUERY:C277([ACT_Documentos_de_Cargo:174]; & ;[ACT_Documentos_de_Cargo:174]FechaEmision:21=!00-00-00!)

If (Size of array:C274(al_IdsCuentas)#0)
	QRY_QueryWithArray (->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;->al_IdsCuentas;True:C214)
End if 

$arregloMonedaPtr:=Bash_Get_Array_By_Type (Is longint:K8:6)
ARRAY POINTER:C280(apACT_ArreglosMonedas;0)
APPEND TO ARRAY:C911(apACT_ArreglosMonedas;$arregloMonedaPtr)
SELECTION TO ARRAY:C260([ACT_Documentos_de_Cargo:174];$arregloMonedaPtr->)

$0:=1
AT_Initialize (->atACT_Monedas)

