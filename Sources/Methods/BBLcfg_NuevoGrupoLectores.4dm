//%attributes = {}
  // BBLcfg_NuevoGrupoLectores()
  // Por: Alberto Bachler: 17/09/13, 12:49:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_elemento;$l_proximoID;$l_ultimoIDGrupoEnConfig;$l_ultimoIDGrupoEnLectores)
C_TEXT:C284($t_grupoLectores)

ARRAY LONGINT:C221($al_IdGrupoEnConfig;0)
If (False:C215)
	C_TEXT:C284(BBLcfg_NuevoGrupoLectores ;$1)
End if 

$l_elemento:=-1
If (Count parameters:C259=1)
	$t_grupoLectores:=$1
	$l_elemento:=Find in array:C230(<>atBBL_GruposLectores;$t_grupoLectores)
End if 

If (($t_grupoLectores="") | ($l_elemento<0))
	ALL RECORDS:C47([BBL_Lectores:72])
	SCAN INDEX:C350([BBL_Lectores:72]ID_GrupoLectores:37;1;<)
	$l_ultimoIDGrupoEnLectores:=[BBL_Lectores:72]ID_GrupoLectores:37
	COPY ARRAY:C226(<>alBBL_GruposLectores;$al_IdGrupoEnConfig)
	$l_ultimoIDGrupoEnConfig:=AT_Maximum (->$al_IdGrupoEnConfig)
	$l_proximoID:=Choose:C955($l_ultimoIDGrupoEnLectores>$l_ultimoIDGrupoEnConfig;$l_ultimoIDGrupoEnLectores;$l_ultimoIDGrupoEnConfig)+1
	If ($l_proximoID=0)
		$l_proximoID:=1
	End if 
	If ($t_grupoLectores="")
		$t_grupoLectores:=__ ("Grupo Lectores ")+String:C10($l_proximoID)
	End if 
	APPEND TO ARRAY:C911(<>atBBL_GruposLectores;$t_grupoLectores)
	APPEND TO ARRAY:C911(<>asBBL_AbrevGruposLectores;"LEC")
	APPEND TO ARRAY:C911(<>alBBL_GruposLectores;$l_proximoID)
	APPEND TO ARRAY:C911(al_NumeroLectoresMediaTrack;0)
	BBLcfg_GuardaCambiosGruposLect 
End if 
