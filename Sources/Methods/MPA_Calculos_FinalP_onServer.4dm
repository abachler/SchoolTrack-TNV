//%attributes = {"executedOnServer":true}
  // MÉTODO: MPA_Calculos_FinalP_onServer
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/01/12, 19:35:44
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_FinalP_onServer()
  // ----------------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($l_ID_Alumno;$l_ID_Asignatura;$l_periodo)

If (False:C215)
	C_LONGINT:C283(MPA_Calculos_FinalP_onServer ;$1)
	C_LONGINT:C283(MPA_Calculos_FinalP_onServer ;$2)
	C_LONGINT:C283(MPA_Calculos_FinalP_onServer ;$3)
End if 




  // CODIGO PRINCIPAL
$l_ID_Asignatura:=$1
$l_ID_Alumno:=$2
$l_periodo:=$3

MPA_Calculos_FinalPeriodo ($l_ID_Asignatura;$l_ID_Alumno;$l_periodo)