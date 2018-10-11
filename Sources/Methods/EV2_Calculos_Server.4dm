//%attributes = {"executedOnServer":true}
  // MÉTODO: EV2_Calculos_Server
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 05/04/12, 11:36:12
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_Calculos_Server()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$l_recordNumber)
C_LONGINT:C283($2;$l_Periodo)

If (False:C215)
	C_BOOLEAN:C305(EV2_Calculos_Server ;$0)
	C_LONGINT:C283(EV2_Calculos_Server ;$1)
	C_LONGINT:C283(EV2_Calculos_Server ;$2)
End if 


  // CODIGO PRINCIPAL
$l_recordNumber:=$1
$l_Periodo:=$2
$0:=EV2_Calculos ($l_recordNumber;$l_Periodo)


