//%attributes = {}
  // MÉTODO: MPA_Calculos_EJE_onServer
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/01/12, 19:28:22
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // MPA_Calculos_EJE_onServer()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_REAL:C285($5)
C_REAL:C285($6)

C_BOOLEAN:C305($b_promedioModificado)
C_LONGINT:C283($l_IdEstiloEvaluacion;$l_periodo;$l_recNum;$l_tipoEvaluacion)
C_REAL:C285($r_escalaMaximo;$r_escalaMinimo)

If (False:C215)
	C_BOOLEAN:C305(MPA_Calculos_EJE_onServer ;$0)
	C_LONGINT:C283(MPA_Calculos_EJE_onServer ;$1)
	C_LONGINT:C283(MPA_Calculos_EJE_onServer ;$2)
	C_LONGINT:C283(MPA_Calculos_EJE_onServer ;$3)
	C_LONGINT:C283(MPA_Calculos_EJE_onServer ;$4)
	C_REAL:C285(MPA_Calculos_EJE_onServer ;$5)
	C_REAL:C285(MPA_Calculos_EJE_onServer ;$6)
End if 




  // CODIGO PRINCIPAL
$l_recNum:=$1

If (Count parameters:C259>1)
	$l_periodo:=$2
	$l_tipoEvaluacion:=$3
	$l_IdEstiloEvaluacion:=$4
	$r_escalaMinimo:=$5
	$r_escalaMaximo:=$6
End if 

If ($l_recNum=-1)
	EVS_initialize 
	PERIODOS_Init 
Else 
	$b_promedioModificado:=MPA_Calculos_Eje ($l_recNum;$l_periodo;$l_tipoEvaluacion;$l_IdEstiloEvaluacion;$r_escalaMinimo;$r_escalaMaximo)
End if 