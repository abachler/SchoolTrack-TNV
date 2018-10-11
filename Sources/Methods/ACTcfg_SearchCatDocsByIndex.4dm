//%attributes = {}
  //ACTcfg_SearchCatDocsByIndex

C_LONGINT:C283($id_categoria;$id_ctaCte;$i;$index;$id_RazonSocial)
C_TEXT:C284($vt_identificador)
C_BOOLEAN:C305($vb_buscaRef)

$id_categoria:=$1
If (Count parameters:C259>=2)
	$id_ctaCte:=$2
End if 
If (Count parameters:C259>=3)
	$id_RazonSocial:=$3
End if 
ACTcfg_SearchCatDocs ($id_categoria)

ARRAY LONGINT:C221($al_posIdsCatM;0)
ARRAY LONGINT:C221($al_posIdentificadores;0)
ARRAY LONGINT:C221($al_resultPos;0)
alACT_IDCat{0}:=$id_categoria
AT_SearchArray (->alACT_IDCat;"=";->$al_posIdsCatM)
If (cb_UtilizaMultiNum=1)
	Case of 
		: ((btnRBD=1) & ($id_ctaCte>0))
			READ ONLY:C145([Alumnos:2])
			READ ONLY:C145([Cursos:3])
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$id_ctaCte)
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
			$vt_identificador:=[Cursos:3]cl_RolBaseDatos:20
		: (btnUsuario=1)
			ACTcfgbol_OpcionesMultiNum ("actualizaNomUsuarios")
			$idUsuarioConectado:=USR_GetUserID 
			$nombreUsuarioConectado:=USR_GetUserName ($idUsuarioConectado;1)
			$vt_identificador:=$nombreUsuarioConectado+" | "+String:C10($idUsuarioConectado)
	End case 
	ACTcfgbol_OpcionesMultiNum ("guardaVars";->$id_categoria;->$id_ctaCte)
	atACT_idNumeracion{0}:=$vt_identificador
	AT_SearchArray (->atACT_idNumeracion;"=";->$al_posIdentificadores)
	AT_intersect (->$al_posIdsCatM;->$al_posIdentificadores;->$al_resultPos)
	
	If (cs_MultiRazones=1)
		AT_Initialize (->$al_posIdsCatM)
		COPY ARRAY:C226($al_resultPos;$al_posIdsCatM)
	End if 
	$vb_buscaRef:=True:C214
End if 
  //If ((cs_MultiRazones=1) & ($id_RazonSocial#0))
If ((cs_MultiRazones=1) & ($id_RazonSocial>0))  //20101006 Cuando habia id -1 no encontraba la categoria...
	alACT_RazonSocial{0}:=$id_RazonSocial
	AT_SearchArray (->alACT_RazonSocial;"=";->$al_posIdentificadores)
	AT_intersect (->$al_posIdsCatM;->$al_posIdentificadores;->$al_resultPos)
	$vb_buscaRef:=True:C214
End if 

If ($vb_buscaRef)
	For ($i;1;Size of array:C274($al_resultPos))
		$index:=$al_resultPos{$i}
		  //20120920 RCH Se lee lo configurado... se comenta caso mx
		  //Case of 
		  //: (<>gCountryCode="mx")
		  //If (aiACT_Tipo{$index}=1) & (Not(abACT_Afecta{$index}) & (Find in array(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
		  //vbACT_Exenta1:=True
		  //vlACT_IndexExenta1:=$index
		  //End if 
		  //Else 
		Case of 
			: (aiACT_Tipo{$index}=1) & (abACT_Afecta{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Afecta1:=True:C214
				vlACT_IndexAfecta1:=$index
				
			: (aiACT_Tipo{$index}=2) & (abACT_Afecta{$index} & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Afecta2:=True:C214
				vlACT_IndexAfecta2:=$index
				
			: (aiACT_Tipo{$index}=1) & (Not:C34(abACT_Afecta{$index}) & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Exenta1:=True:C214
				vlACT_IndexExenta1:=$index
				
			: (aiACT_Tipo{$index}=2) & (Not:C34(abACT_Afecta{$index}) & (Find in array:C230(atACT_ModelosDoc;atACT_ModeloDoc{$index})#-1))
				vbACT_Exenta2:=True:C214
				vlACT_IndexExenta2:=$index
				
		End case 
		  //End case 
	End for 
End if 

  //20120420 RCH Se pasa codigo a metodo
ACTcfg_AsignaCatElect ($id_RazonSocial)