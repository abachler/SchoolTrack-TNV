//%attributes = {}
  // BBLcfg_CambioGrupoLectores()
  // Por: Alberto Bachler: 17/09/13, 12:44:23
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_TEXT:C284($2)

_O_C_INTEGER:C282($i_registros)
C_LONGINT:C283($l_IdGrupoLector;$l_IDProgreso)
C_TEXT:C284($t_mensajeProgreso;$t_nombreGrupoLector)

ARRAY LONGINT:C221($al_RecNums;0)
If (False:C215)
	C_LONGINT:C283(BBLcfg_CambioGrupoLectores ;$1)
	C_TEXT:C284(BBLcfg_CambioGrupoLectores ;$2)
End if 


$l_IdGrupoLector:=$1
$t_nombreGrupoLector:=$2
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$al_RecNums;"")
$t_mensajeProgreso:=__ ("Cambiando tipo de documento...")
$l_IDProgreso:=IT_Progress (1;$l_IDProgreso;0;$t_mensajeProgreso)
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([BBL_Lectores:72])
	GOTO RECORD:C242([BBL_Lectores:72];$al_RecNums{$i_registros})
	[BBL_Lectores:72]ID_GrupoLectores:37:=$l_IdGrupoLector
	[BBL_Lectores:72]Grupo:2:=$t_nombreGrupoLector
	SAVE RECORD:C53([BBL_Lectores:72])
	$l_IDProgreso:=IT_Progress (0;$l_IDProgreso;$i_registros/Size of array:C274($al_RecNums);$t_mensajeProgreso+"\r"+[BBL_Lectores:72]NombreCompleto:3)
End for 
$l_IDProgreso:=IT_Progress (-1;$l_IDProgreso)
KRL_UnloadReadOnly (->[BBL_Lectores:72])

