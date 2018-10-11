//%attributes = {}
  // ALP_SetDefaultAppareance()
  // Por: Alberto Bachler K.: 23-12-13, 19:38:53
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
C_LONGINT:C283($6)
C_LONGINT:C283($7)
C_LONGINT:C283($8)

C_LONGINT:C283($l_referenciaArea;$l_justificacionColumna;$l_error;$l_tamañoFuente;$l_lineasPie;$l_espacioPie;$l_justificacionEncabezado;$l_lineasEncabezado;$l_espacioEncabezado;$i)
C_LONGINT:C283($l_lineasFilas;$l_espacioFilas)
C_TEXT:C284($t_formato)

ARRAY TEXT:C222($aArrays;0)



If (False:C215)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$1)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$2)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$3)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$4)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$5)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$6)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$7)
	C_LONGINT:C283(ALP_SetDefaultAppareance ;$8)
End if 
ARRAY TEXT:C222($aArrays;0)
C_LONGINT:C283($1;$2;$l_tamañoFuente;$3;$l_lineasFilas;$l_lineasEncabezado;$l_espacioFilas;$l_espacioEncabezado;$4;$5;$6)

$l_referenciaArea:=$1
$l_lineasFilas:=1
$l_espacioFilas:=8
$l_lineasEncabezado:=2
$l_espacioEncabezado:=4
$l_lineasPie:=3
$l_espacioPie:=4
Case of 
	: (Count parameters:C259=8)
		$l_espacioPie:=$8
		$l_lineasPie:=$7
		$l_espacioEncabezado:=$6
		$l_lineasEncabezado:=$5
		$l_espacioFilas:=$4
		$l_lineasFilas:=$3
		$l_tamañoFuente:=$2
	: (Count parameters:C259=7)
		$l_lineasPie:=$7
		$l_espacioEncabezado:=$6
		$l_lineasEncabezado:=$5
		$l_espacioFilas:=$4
		$l_lineasFilas:=$3
		$l_tamañoFuente:=$2
	: (Count parameters:C259=6)
		$l_espacioEncabezado:=$6
		$l_lineasEncabezado:=$5
		$l_espacioFilas:=$4
		$l_lineasFilas:=$3
		$l_tamañoFuente:=$2
	: (Count parameters:C259=5)
		$l_lineasEncabezado:=$5
		$l_espacioFilas:=$4
		$l_lineasFilas:=$3
		$l_tamañoFuente:=$2
	: (Count parameters:C259=4)
		$l_espacioFilas:=$4
		$l_lineasFilas:=$3
		$l_tamañoFuente:=$2
	: (Count parameters:C259=3)
		$l_lineasFilas:=$3
		$l_tamañoFuente:=$2
	: (Count parameters:C259=2)
		$l_tamañoFuente:=$2
	Else 
		$l_tamañoFuente:=9
End case 

If ($l_tamañoFuente=0)
	$l_tamañoFuente:=9
End if 
If ($l_lineasFilas=0)
	$l_lineasFilas:=1
End if 
If ($l_espacioFilas=0)
	$l_espacioFilas:=4
End if 
If ($l_lineasEncabezado=0)
	$l_lineasEncabezado:=1
End if 
If ($l_espacioEncabezado=0)
	$l_espacioEncabezado:=4
End if 
$l_error:=AL_GetArrayNames ($l_referenciaArea;$aArrays)
For ($i;1;Size of array:C274($aArrays))
	AL_GetFormat ($l_referenciaArea;$i;$t_formato;$l_justificacionColumna;$l_justificacionEncabezado)
	AL_SetFormat ($l_referenciaArea;$i;$t_formato;$l_justificacionColumna;2)
	AL_GetFormat ($l_referenciaArea;$i;$t_formato;$l_justificacionColumna;$l_justificacionEncabezado)
End for 
AL_SetHdrStyle ($l_referenciaArea;0;"Tahoma";$l_tamañoFuente;1)
AL_SetFtrStyle ($l_referenciaArea;0;"Tahoma";$l_tamañoFuente;0)
AL_SetStyle ($l_referenciaArea;0;"Tahoma";$l_tamañoFuente;0)
AL_SetForeColor ($l_referenciaArea;0;"Black";0;"Black";0;"Black";0)
AL_SetBackColor ($l_referenciaArea;0;"White";0;"White";0;"White";0)
AL_SetHeight ($l_referenciaArea;$l_lineasEncabezado;$l_espacioEncabezado;$l_lineasFilas;$l_espacioFilas;$l_lineasPie;$l_espacioPie)
AL_SetDividers ($l_referenciaArea;"Black";"Light Gray";0;"Black";"Light Gray")
AL_SetMiscOpts ($l_referenciaArea;0;0;"\\";0;1)
AL_SetMiscColor ($l_referenciaArea;0;"White";0)
AL_SetMiscColor ($l_referenciaArea;1;"White";0)
AL_SetMiscColor ($l_referenciaArea;2;"White";0)
AL_SetMiscColor ($l_referenciaArea;3;"White";0)

ALP_SetInterface ($l_referenciaArea)
