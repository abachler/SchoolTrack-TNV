//%attributes = {}
  //DT_StrDateIsOK

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : DT_strDateIsOK
	  //Autor: Alberto Bachler
	  //Creada el 20/6/96 a 11:23 AM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_TEXT:C284($1)
C_BOOLEAN:C305($2;$alert)
C_DATE:C307($d)
C_LONGINT:C283($j;$m;$a)
$d:=Date:C102($1)
$j:=Day of:C23($d)
$m:=Month of:C24($d)
$a:=Year of:C25($d)
If (Count parameters:C259=2)
	$alert:=$2
Else 
	$alert:=True:C214
End if 
Case of 
	: ($a<=0)
		If ($alert)
			CD_Dlog (0;__ ("Fecha incorrecta."))
		End if 
		$0:=dt_GetNullDateString 
	: ($m<1) | ($m>12)
		If ($alert)
			CD_Dlog (0;__ ("Fecha incorrecta."))
		End if 
		$0:=dt_GetNullDateString 
	Else 
		If (($j<1) | ($j>DT_GetLastDay ($m;$a)))
			If ($alert)
				CD_Dlog (0;__ ("Fecha incorrecta."))
			End if 
			$0:=dt_GetNullDateString 
		Else 
			$0:=String:C10($d)
		End if 
End case 