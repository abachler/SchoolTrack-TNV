//%attributes = {}
  // KRL_EsEventoEnInterfazUsuario()
  // Por: Alberto Bachler: 30/05/13, 15:33:09
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_EsVisible)
C_LONGINT:C283($l_estadoProceso;$l_IDProceso;$l_IdUnico;$l_OrigenProceso;$l_TiempoEnEjecucion)
C_TEXT:C284($t_nombreproceso)

ARRAY LONGINT:C221($al_TipoProcesosWeb;0)
If (False:C215)
	C_BOOLEAN:C305(KRL_EsEventoEnInterfazUsuario ;$0)
	C_LONGINT:C283(KRL_EsEventoEnInterfazUsuario ;$1)
End if 


$l_IDProceso:=Current process:C322
If (Count parameters:C259=1)
	$l_IDProceso:=$1
End if 

PROCESS PROPERTIES:C336($l_IDProceso;$t_nombreproceso;$l_estadoProceso;$l_TiempoEnEjecucion;$b_EsVisible;$l_IdUnico;$l_OrigenProceso)

$0:=($l_OrigenProceso=Other user process:K36:15)

