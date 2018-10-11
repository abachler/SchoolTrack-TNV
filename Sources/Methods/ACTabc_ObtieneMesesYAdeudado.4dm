//%attributes = {}
  //ACTabc_ObtieneMesesYAdeudado

  //$set:=$1 set con avisos
  //$ptr1:=$2 año de los avisos
  //$ptr2:=$3 mes de los avisos
  //$ptr3:=$4 arreglo texto a utilizar en valores únicos
  //$ptr4:=$5 arreglo con montos a pagar por mes
  //$ptr5:=$6  campo a utilizar para cálculo
  //$ptr6:=$7 fecha UF
  //$ptr7:=$8 arreglo con fechas de emisión
  //$ptr8:=$9 arreglo con fechas de vencimiento
  //$ptr9:=$10 variable con número de decimales a aproximar (positivos) o truncar (valores negativos)

C_LONGINT:C283(vl_otrasMonedas)
C_TEXT:C284($vt_monedaOrg)
C_LONGINT:C283($i;$0)
C_POINTER:C301($2;$3;$4;$5;$6;$7;$8;$9;$10)
C_POINTER:C301($ptr1;$ptr2;$ptr3;$ptr4;$ptr5;$ptr6;$ptr7;$ptr8;$ptr9;$vQR_Pointer1)
C_REAL:C285($vr_montoAdeudado)
ARRAY LONGINT:C221($al_idsAvisos;0)
$set:=$1
$ptr1:=$2
$ptr2:=$3
$ptr3:=$4
$ptr4:=$5
$ptr5:=$6
$ptr6:=$7
$ptr7:=$8
$ptr8:=$9
If (Count parameters:C259>=10)
	$ptr9:=$10
End if 

SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Agno:7;$ptr1->;[ACT_Avisos_de_Cobranza:124]Mes:6;$ptr2->)

If (KRL_isSameField ($ptr5;->[ACT_Avisos_de_Cobranza:124]Monto_Neto:11))
	$vQR_Pointer1:=->[ACT_Cargos:173]Monto_Neto:5
Else 
	$vQR_Pointer1:=->[ACT_Cargos:173]Saldo:23
End if 
For ($i;1;Size of array:C274($ptr1->))
	APPEND TO ARRAY:C911($ptr3->;String:C10($ptr1->{$i};"0000")+String:C10($ptr2->{$i};"00"))
End for 
AT_DistinctsArrayValues ($ptr3)

AT_Initialize ($ptr1;$ptr2)
For ($i;1;Size of array:C274($ptr3->))
	APPEND TO ARRAY:C911($ptr1->;Num:C11(Substring:C12($ptr3->{$i};1;4)))
	APPEND TO ARRAY:C911($ptr2->;Num:C11(Substring:C12($ptr3->{$i};5;2)))
End for 

If (vl_otrasMonedas=1)
	$vt_monedaOrg:=<>vsACT_MonedaColegio
	<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
End if 

For ($i;1;Size of array:C274($ptr1->))
	USE SET:C118($set)
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Agno:7=$ptr1->{$i};*)
	QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=$ptr2->{$i})
	APPEND TO ARRAY:C911($ptr7->;[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
	APPEND TO ARRAY:C911($ptr8->;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
	SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAvisos)
	$vr_montoAdeudado:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMEmsion";->$al_idsAvisos;$vQR_Pointer1;$ptr6->)
	Case of 
		: (Is nil pointer:C315($ptr9))
			APPEND TO ARRAY:C911($ptr4->;Round:C94(Abs:C99($vr_montoAdeudado);2))
		Else 
			If ($ptr9->>0)
				APPEND TO ARRAY:C911(aQR_Real1;Round:C94(Abs:C99($vr_montoAdeudado);$ptr9->))
			Else 
				APPEND TO ARRAY:C911(aQR_Real1;Trunc:C95(Abs:C99($vr_montoAdeudado);$ptr9->))
			End if 
	End case 
End for 
If (vl_otrasMonedas=1)
	<>vsACT_MonedaColegio:=$vt_monedaOrg
End if 
$0:=Size of array:C274($ptr4->)