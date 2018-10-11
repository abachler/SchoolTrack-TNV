//%attributes = {}
  //ACTlc_ObtieneIndex
  //***** MANEJO MULTINUMERACION PARA LETRAS*****
C_LONGINT:C283($0)

C_LONGINT:C283($l_indice)
C_REAL:C285($id_categoria;$idUsuarioConectado)
C_TEXT:C284($nombreUsuarioConectado;$vt_identificador)

ARRAY LONGINT:C221($al_posDefPorDefecto;0)
ARRAY LONGINT:C221($al_posIdentificadores;0)
ARRAY LONGINT:C221($al_posIdsCatM;0)
ARRAY LONGINT:C221($al_resultPos;0)
ARRAY LONGINT:C221($DA_Return;0)
If (False:C215)
	C_LONGINT:C283(ACTlc_ObtieneIndex ;$0)
End if 

$id_categoria:=$1
ACTcfg_SearchCatDocs ($id_categoria)

alACT_IDCat{0}:=$id_categoria
AT_SearchArray (->alACT_IDCat;"=";->$al_posIdsCatM)
If (btnUsuario=1)
	ACTcfgbol_OpcionesMultiNum ("actualizaNomUsuarios")
	$idUsuarioConectado:=USR_GetUserID 
	$nombreUsuarioConectado:=USR_GetUserName ($idUsuarioConectado;1)
	$vt_identificador:=$nombreUsuarioConectado+" | "+String:C10($idUsuarioConectado)
	atACT_idNumeracion{0}:=$vt_identificador
	AT_SearchArray (->atACT_idNumeracion;"=";->$al_posIdentificadores)
	AT_intersect (->$al_posIdsCatM;->$al_posIdentificadores;->$al_resultPos)
Else 
	COPY ARRAY:C226($al_posIdsCatM;$al_resultPos)
End if 

If (Size of array:C274($al_resultPos)=1)  //Fue encontrada una definicion para el usuario.
	COPY ARRAY:C226($al_resultPos;$DA_Return)
Else   //se busca la definicion por defecto
	abACT_DocPorDefecto{0}:=True:C214
	AT_SearchArray (->abACT_DocPorDefecto;"=";->$al_posDefPorDefecto)
	AT_intersect (->$al_posIdsCatM;->$al_posDefPorDefecto;->$DA_Return)
End if 

If (Size of array:C274($DA_Return)=1)
	$l_indice:=$DA_Return{1}
End if 

$0:=$l_indice
  //***** MANEJO MULTINUMERACION *****