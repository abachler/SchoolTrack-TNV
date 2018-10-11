//%attributes = {}
  // KRL_IsWebProcess()
  // Por: Alberto Bachler: 24/05/13, 11:48:41
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
	C_BOOLEAN:C305(KRL_IsWebProcess ;$0)
	C_LONGINT:C283(KRL_IsWebProcess ;$1)
End if 

$l_IDProceso:=Current process:C322
If (Count parameters:C259=1)
	$l_IDProceso:=$1
End if 

PROCESS PROPERTIES:C336($l_IDProceso;$t_nombreproceso;$l_estadoProceso;$l_TiempoEnEjecucion;$b_EsVisible;$l_IdUnico;$l_OrigenProceso)

APPEND TO ARRAY:C911($al_TipoProcesosWeb;Web server process:K36:18)
APPEND TO ARRAY:C911($al_TipoProcesosWeb;Web process on 4D remote:K36:17)
APPEND TO ARRAY:C911($al_TipoProcesosWeb;_o_Web process with context:K36:16)
APPEND TO ARRAY:C911($al_TipoProcesosWeb;Web process with no context:K36:8)

$0:=(Find in array:C230($al_TipoProcesosWeb;$l_OrigenProceso)>0)