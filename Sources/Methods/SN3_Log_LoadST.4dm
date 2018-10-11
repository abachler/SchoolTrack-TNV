//%attributes = {}
  //SN3_Log_LoadST

C_DATE:C307($date;$1)
Case of 
	: (Count parameters:C259=1)
		$date:=$1
		$cb_Log_VerErrores:=0
		$cb_Log_VerInfo:=0
		$cb_Log_VerGeneracion:=0
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=2)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=0
		$cb_Log_VerGeneracion:=0
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=3)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=$3
		$cb_Log_VerGeneracion:=0
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=4)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=$3
		$cb_Log_VerGeneracion:=$4
		$cb_Log_VerEnvios:=0
	: (Count parameters:C259=5)
		$date:=$1
		$cb_Log_VerErrores:=$2
		$cb_Log_VerInfo:=$3
		$cb_Log_VerGeneracion:=$4
		$cb_Log_VerEnvios:=$5
End case 

ARRAY DATE:C224(SN3_Log_Fecha;0)
ARRAY LONGINT:C221(SN3_Log_Hora;0)
ARRAY TEXT:C222(SN3_Log_Descripcion;0)
ARRAY LONGINT:C221(SN3_Log_Colores;0)
ARRAY LONGINT:C221(SN3_Log_Estilos;0)
_O_ARRAY STRING:C218(14;$dts;0)
ARRAY LONGINT:C221(SN3_Log_Tipo;0)
ARRAY TEXT:C222(SN3_Log_DescError;0)
ARRAY TEXT:C222(SN3_Log_Maquina;0)
READ ONLY:C145([xxSN3_Log:160])
If ($date=!00-00-00!)
	ALL RECORDS:C47([xxSN3_Log:160])
Else 
	$dateStr:=String:C10(Year of:C25($date);"0000")+String:C10(Month of:C24($date);"00")+String:C10(Day of:C23($date);"00")
	QUERY:C277([xxSN3_Log:160];[xxSN3_Log:160]dts:4=$dateStr+"@")
End if 
$queryIniciado:=False:C215
If ($cb_Log_VerErrores=1)
	QUERY SELECTION:C341([xxSN3_Log:160];[xxSN3_Log:160]tipoEvento:1=SN3_Log_Error;*)
	$queryIniciado:=True:C214
End if 
If ($cb_Log_VerInfo=1)
	If ($queryIniciado)
		QUERY SELECTION:C341([xxSN3_Log:160]; | ;[xxSN3_Log:160]tipoEvento:1=SN3_Log_Info;*)
	Else 
		QUERY SELECTION:C341([xxSN3_Log:160];[xxSN3_Log:160]tipoEvento:1=SN3_Log_Info;*)
		$queryIniciado:=True:C214
	End if 
End if 
If ($cb_Log_VerGeneracion=1)
	If ($queryIniciado)
		QUERY SELECTION:C341([xxSN3_Log:160]; | ;[xxSN3_Log:160]tipoEvento:1=SN3_Log_FileGeneration;*)
	Else 
		QUERY SELECTION:C341([xxSN3_Log:160];[xxSN3_Log:160]tipoEvento:1=SN3_Log_FileGeneration;*)
		$queryIniciado:=True:C214
	End if 
End if 
If ($cb_Log_VerEnvios=1)
	If ($queryIniciado)
		QUERY SELECTION:C341([xxSN3_Log:160]; | ;[xxSN3_Log:160]tipoEvento:1=SN3_Log_FileSent;*)
	Else 
		QUERY SELECTION:C341([xxSN3_Log:160];[xxSN3_Log:160]tipoEvento:1=SN3_Log_FileSent;*)
		$queryIniciado:=True:C214
	End if 
End if 
If ($queryIniciado)
	QUERY SELECTION:C341([xxSN3_Log:160])
Else 
	REDUCE SELECTION:C351([xxSN3_Log:160];0)
End if 
ORDER BY:C49([xxSN3_Log:160];[xxSN3_Log:160]dts:4;<)
SELECTION TO ARRAY:C260([xxSN3_Log:160]dts:4;$dts;[xxSN3_Log:160]tipoEvento:1;SN3_Log_Tipo;[xxSN3_Log:160]evento:2;SN3_Log_Descripcion;[xxSN3_Log:160]descripcionError:5;SN3_Log_DescError;[xxSN3_Log:160]maquina:6;SN3_Log_Maquina)
For ($i;1;Size of array:C274($dts))
	APPEND TO ARRAY:C911(SN3_Log_Fecha;DTS_GetDate ($dts{$i}))
	APPEND TO ARRAY:C911(SN3_Log_Hora;DTS_GetTime ($dts{$i}))
	Case of 
		: (SN3_Log_Tipo{$i}=SN3_Log_Error)
			APPEND TO ARRAY:C911(SN3_Log_Colores;0x00FF0000)
			APPEND TO ARRAY:C911(SN3_Log_Estilos;Bold:K14:2)
		: (SN3_Log_Tipo{$i}=SN3_Log_FileGeneration)
			APPEND TO ARRAY:C911(SN3_Log_Colores;0x0AAA)
			APPEND TO ARRAY:C911(SN3_Log_Estilos;Plain:K14:1)
		: (SN3_Log_Tipo{$i}=SN3_Log_FileSent)
			APPEND TO ARRAY:C911(SN3_Log_Colores;0x00FF)
			APPEND TO ARRAY:C911(SN3_Log_Estilos;Plain:K14:1)
		: (SN3_Log_Tipo{$i}=SN3_Log_Info)
			APPEND TO ARRAY:C911(SN3_Log_Colores;0xBB00)
			APPEND TO ARRAY:C911(SN3_Log_Estilos;Italic:K14:3)
	End case 
End for 
vFechaHeader:=0
vHoraHeader:=0
vEventoHeader:=0
vLastLinea:=-1
If ($date=!00-00-00!)
	vt_Log_Msg:=String:C10(Size of array:C274(SN3_Log_Tipo))+__ (" entradas de ")+String:C10(Records in table:C83([xxSN3_Log:160]))+__ (" existentes.")
Else 
	vt_Log_Msg:=String:C10(Size of array:C274(SN3_Log_Tipo))+__ (" entradas del ")+String:C10($date;Internal date short:K1:7)+__ (" de ")+String:C10(Records in table:C83([xxSN3_Log:160]))+__ (" existentes.")
End if 
IT_SetButtonState ((Size of array:C274(SN3_Log_Tipo)>0);->b_Log_Print;->b_Log_Save)


