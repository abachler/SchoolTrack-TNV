//%attributes = {}
  // BBLcfg_NuevoTipoDocumento()
  // Por: Alberto Bachler: 17/09/13, 12:49:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_elemento;$l_proximoID;$l_ultimoIDMediaEnConfig;$l_ultimoIDMediaEnRegistros)
C_TEXT:C284($t_tipoDocumento)

ARRAY LONGINT:C221($al_IdMediaEnConfig;0)
If (False:C215)
	C_TEXT:C284(BBLcfg_NuevoTipoDocumento ;$1)
End if 

$l_elemento:=-1
If (Count parameters:C259=1)
	$t_tipoDocumento:=$1
	$l_elemento:=Find in array:C230(<>atBBL_Media;$t_TipoDocumento)
End if 

If (($t_tipoDocumento="") | ($l_elemento<0))
	ALL RECORDS:C47([BBL_Items:61])
	SCAN INDEX:C350([BBL_Items:61]ID_Media:48;1;<)
	$l_ultimoIDMediaEnRegistros:=[BBL_Items:61]ID_Media:48
	COPY ARRAY:C226(<>alBBL_IDMedia;$al_IdMediaEnConfig)
	$l_ultimoIDMediaEnConfig:=AT_Maximum (->$al_IdMediaEnConfig)
	$l_proximoID:=Choose:C955($l_ultimoIDMediaEnRegistros>$l_ultimoIDMediaEnConfig;$l_ultimoIDMediaEnRegistros;$l_ultimoIDMediaEnConfig)+1
	If ($l_proximoID=0)
		$l_proximoID:=1
	End if 
	If ($t_tipoDocumento="")
		$t_tipoDocumento:=__ ("Tipo Documento ")+String:C10($l_proximoID)
	End if 
	APPEND TO ARRAY:C911(<>atBBL_Media;$t_tipoDocumento)
	APPEND TO ARRAY:C911(<>asBBL_AbrevMedia;"REG")
	APPEND TO ARRAY:C911(<>alBBL_IDMedia;$l_proximoID)
	APPEND TO ARRAY:C911(al_NumeroRegistrosMediaTrack;0)
	BBLcfg_GuardaCambiosMedia 
End if 

