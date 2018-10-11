//%attributes = {}
  //ACTcfgbol_OpcionesMultiNum

  //método que realiza operaciones que se repiten en la configuración de docs tribs
C_TEXT:C284($accion;$1;$member;$name)
C_LONGINT:C283($i;$el;$j;$idUsr)
$accion:=$1
Case of 
	: (Count parameters:C259=2)
		$ptr1:=$2
	: (Count parameters:C259=3)
		$ptr1:=$2
		$ptr2:=$3
End case 

READ ONLY:C145([Cursos:3])

Case of 
	: ($accion="llenaPopUp@")
		If ($accion="llenaPopUpDesdeForm")
			For ($i;1;Size of array:C274(atACT_idNumeracion))
				atACT_idNumeracion{$i}:=""
			End for 
		End if 
		Case of 
			: (btnRBD=1)
				ALL RECORDS:C47([Cursos:3])
				SELECTION TO ARRAY:C260([Cursos:3]cl_RolBaseDatos:20;$ptr1->)
				AT_DistinctsArrayValues ($ptr1)
				REDUCE SELECTION:C351([Cursos:3];0)
			: (btnUsuario=1)
				AT_Initialize ($ptr1)
				ARRAY LONGINT:C221($al_idsGroupsWithAcces;0)
				USR_getGroupWithModuleAccess (->$al_idsGroupsWithAcces;"AccountTrack")
				For ($i;1;Size of array:C274($al_idsGroupsWithAcces))
					If ($al_idsGroupsWithAcces{$i}#-15001)
						USR_GetGroupMemberList ($al_idsGroupsWithAcces{$i})
						For ($j;1;Size of array:C274(<>aMembersID))
							$member:=Replace string:C233(<>aMembers{$j};"(";"")
							$member:=Replace string:C233($member;")";"")
							APPEND TO ARRAY:C911($ptr1->;$member+" | "+String:C10(<>aMembersID{$j}))
						End for 
					End if 
				End for 
				AT_DistinctsArrayValues ($ptr1)
		End case 
		ACTcfgbol_OpcionesMultiNum ("actualizaNomUsuarios")
		ACTcfgbol_OpcionesMultiNum ("actualizaAreaListTiposDoc")
	: ($accion="actualizaAreaListTiposDoc")
		AL_UpdateArrays (ALP_TiposdeDoc;0)
		xALPSet_ACT_TiposdeDoc 
		AL_UpdateArrays (ALP_TiposdeDoc;-2)
		
	: ($accion="actualizaNomUsuarios")
		If (btnUsuario=1)
			For ($i;1;Size of array:C274(atACT_idNumeracion))
				If (atACT_idNumeracion{$i}#"")
					$idUsr:=Num:C11(ST_GetWord (atACT_idNumeracion{$i};2;" | "))
					$name:=USR_GetUserName ($idUsr;1)
					atACT_idNumeracion{$i}:=$name+" | "+String:C10($idUsr)
				End if 
			End for 
		End if 
		
	: ($accion="SearchSameCat")
		ARRAY LONGINT:C221($al_cat;0)
		ARRAY LONGINT:C221($al_doc;0)
		ARRAY LONGINT:C221($al_tipo;0)
		ARRAY LONGINT:C221($al_afe;0)
		ARRAY LONGINT:C221($al_pos;0)
		atACT_Cats{0}:=atACT_Cats{$ptr2->}
		AT_SearchArray (->atACT_Cats;"=";->$al_cat)
		atACT_Tipo{0}:=atACT_Tipo{$ptr2->}
		AT_SearchArray (->atACT_Tipo;"=";->$al_tipo)
		atACT_NombreDoc{0}:=atACT_NombreDoc{$ptr2->}
		AT_SearchArray (->atACT_NombreDoc;"=";->$al_doc)
		abACT_Afecta{0}:=abACT_Afecta{$ptr2->}
		AT_SearchArray (->abACT_Afecta;"=";->$al_afe)
		AT_intersect (->$al_cat;->$al_doc;->$al_pos)
		COPY ARRAY:C226($al_pos;$al_cat)
		AT_intersect (->$al_cat;->$al_tipo;->$al_pos)
		AT_intersect (->$al_pos;->$al_afe;$ptr1)
		
	: ($accion="guardaVars")
		C_BOOLEAN:C305(vb_actBolGuardoVars)
		C_LONGINT:C283(vl_cataPdo;vl_idCta)
		vl_cataPdo:=$ptr1->
		vl_idCta:=$ptr2->
		vb_actBolGuardoVars:=True:C214
		
	: ($accion="validaNumBol")
		C_BOOLEAN:C305(vb_actBolGuardoVars)
		C_LONGINT:C283(cs_emitirCFDI)  // cuando se emiten documentos digitales no se validan las numeraciones
		C_REAL:C285($r_idRS)  //20140107 RCH
		If (cs_emitirCFDI=0)
			If (vb_actBolGuardoVars)
				If (cb_UtilizaMultiNum=1)
					
					  //20140107 RCH
					$r_idRS:=alACT_RazonSocial{vlACT_IndexAfecta1}
					If ($r_idRS=0)
						$r_idRS:=-1
					End if 
					
					  //20130816 RCH Para actualizar los arreglos.
					ACTcfg_LeeBlob ("ACT_DocsTributarios")
					
					ACTcfg_SearchCatDocsByIndex (vl_cataPdo;vl_idCta)
					READ ONLY:C145([ACT_Boletas:181])
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=vl_cataPdo;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Documento:13=alACT_IDDT{vlACT_IndexAfecta1};*)
					
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=$r_idRS;*)  //20140107 RCH
					
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=alACT_Proxima{vlACT_IndexAfecta1})
					If (Records in selection:C76([ACT_Boletas:181])>0)
						CD_Dlog (0;__ ("El próximo número de documento afecto a emitir ya existe en la base de datos. Revise la configuración antes de continuar."))
					End if 
					
					  //20140107 RCH
					$r_idRS:=alACT_RazonSocial{vlACT_IndexExenta1}
					If ($r_idRS=0)
						$r_idRS:=-1
					End if 
					
					QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Categoria:12=vl_cataPdo;*)
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_Documento:13=alACT_IDDT{vlACT_IndexExenta1};*)
					
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_RazonSocial:25=$r_idRS;*)  //20140107 RCH
					
					QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=alACT_Proxima{vlACT_IndexExenta1})
					If (Records in selection:C76([ACT_Boletas:181])>0)
						CD_Dlog (0;__ ("El próximo número de documento exento a emitir ya existe en la base de datos. Revise la configuración antes de continuar."))
					End if 
					
					ARRAY LONGINT:C221($al_posE;0)
					ARRAY LONGINT:C221($al_posA;0)
					ARRAY LONGINT:C221($al_pos2;0)
					ARRAY LONGINT:C221($al_result;0)
					alACT_Proxima{0}:=alACT_Proxima{vlACT_IndexExenta1}
					AT_SearchArray (->alACT_Proxima;"=";->$al_pos2)
					ACTcfgbol_OpcionesMultiNum ("SearchSameCat";->$al_posE;->vlACT_IndexExenta1)
					ACTcfgbol_OpcionesMultiNum ("SearchSameCat";->$al_posA;->vlACT_IndexAfecta1)
					AT_intersect (->$al_pos2;->$al_posE;->$al_result)
					$muestraMsg:=Size of array:C274($al_result)>1
					If (Not:C34($muestraMsg))
						AT_intersect (->$al_pos2;->$al_posA;->$al_result)
						$muestraMsg:=Size of array:C274($al_result)>1
					End if 
					If ($muestraMsg)
						If (cb_Sincroniza=0)  //si no sincroniza 
							If (Size of array:C274($al_result)>1)
								CD_Dlog (0;__ ("Revise la configuración antes de imprimir el próximo documento."))
							End if 
						End if 
					End if 
				End if 
			End if 
		End if 
		vb_actBolGuardoVars:=False:C215
End case 