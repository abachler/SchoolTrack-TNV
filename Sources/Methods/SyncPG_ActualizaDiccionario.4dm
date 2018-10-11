//%attributes = {"executedOnServer":true}

  // SyncPG_ActualizaDiccionario()
  // Por: Alberto Bachler K.: 15-04-15, 17:35:08
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_ejecutar;$b_semaforoPuesto;$b_recargar_RefSincronizacion)
_O_C_INTEGER:C282($i_registros;$i)
C_LONGINT:C283($l_columnas;$l_recNum;$l_refFilas;$l_version_Mayor;$l_version_Revision)
C_TEXT:C284($t_nombreBDCondor;$t_nombreTabla;$t_declaracion;$t_ultimaCarga;$t_uuid;$t_version;$t_version_SinBuild)
C_TEXT:C284(<>t_nombreBDCondor)

C_TEXT:C284($t_valorActual)
C_TEXT:C284($t_nuevoValor)
C_LONGINT:C283($err)

ARRAY BOOLEAN:C223($ab_sincronizable;0)
ARRAY LONGINT:C221($al_campo4D;0)
ARRAY LONGINT:C221($al_RecNums;0)
ARRAY LONGINT:C221($al_STRefIdRegistro;0)
ARRAY LONGINT:C221($al_tabla4D;0)
ARRAY LONGINT:C221($al_tipo4D;0)
ARRAY TEXT:C222($at_columnaSQL;0)
ARRAY TEXT:C222($at_CondorRefID;0)
ARRAY TEXT:C222($at_dtsRemoto;0)
ARRAY TEXT:C222($at_localUUID;0)
ARRAY TEXT:C222($at_pKey;0)
ARRAY TEXT:C222($at_tablaAtributo;0)
ARRAY TEXT:C222($at_tablaSQL;0)
ARRAY TEXT:C222($at_tipoAtributo;0)
ARRAY TEXT:C222($at_tipoSQL;0)
ARRAY TEXT:C222($at_uuidRemoto;0)
ARRAY TEXT:C222($at_valorAtributo;0)

ARRAY BOOLEAN:C223($ab_transform;0)
ARRAY BOOLEAN:C223($ab_nuevoDic;0)

ARRAY TEXT:C222($aUUIDColegio;0)
ARRAY LONGINT:C221($aTablas;0)
ARRAY LONGINT:C221($aCampos;0)
ARRAY LONGINT:C221($aTipos4D;0)
ARRAY TEXT:C222($aUUIDsRegistros;0)
ARRAY TEXT:C222($aSTPKey;0)
ARRAY BOOLEAN:C223($aModificadoST;0)
ARRAY LONGINT:C221($aVersion;0)
ARRAY TEXT:C222($aDTS;0)
ARRAY TEXT:C222($aNuevoValor;0)
ARRAY TEXT:C222($aCondorTabla;0)
ARRAY TEXT:C222($aCondorColumna;0)
ARRAY TEXT:C222($aCondorTipoSQL;0)
ARRAY TEXT:C222($aCondorTablaAtributo;0)
ARRAY TEXT:C222($aCondorTipoAtributo;0)
ARRAY TEXT:C222($aCondorValorAtributo;0)
ARRAY BOOLEAN:C223($aModificadoCondor;0)
ARRAY TEXT:C222($aCondorPKey;0)
ARRAY TEXT:C222($aCondorNombreBD;0)

C_TEXT:C284(vt_nombreBD;vt_host4D;vt_usuario4D;vt_password4D)
C_BOOLEAN:C305(vb_sincronizar;<>b_sincronizar)
C_LONGINT:C283($vl_conexionPG)

C_OBJECT:C1216($answer;$emptyobject)

C_BLOB:C604($x_Blob)
C_TEXT:C284($t_codificacion)

If (Sync_Activar )
	READ WRITE:C146([sync_diccionario:285])
	ALL RECORDS:C47([sync_diccionario:285])
	ORDER BY:C49([sync_diccionario:285];[sync_diccionario:285]dts:11;<)
	$t_ultimaCarga:=[sync_diccionario:285]dts:11
	If ($t_ultimaCarga="")
		$t_ultimaCarga:="2000-01-01T00:00:00Z"  //solo para primera vez!!!
	End if 
	$cUUID:=Util_MakeUUIDCanonical (<>GUUID)
	$answer:=SYNC_APICall ("actualizadiccionario";HTTP GET method:K71:1;$emptyobject;$cUUID;$t_ultimaCarga)
	If (Not:C34(SYNC_CHECKERROR ($answer)))
		<>b_sincronizar:=OB Get:C1224($answer;"sincronizar";Is boolean:K8:9)
		<>t_nombreBDCondor:=OB Get:C1224($answer;"nombrebd")
		ARRAY OBJECT:C1221($a_rows;0)
		OB GET ARRAY:C1229($answer;"rows";$a_rows)
		AT_RedimArrays (Size of array:C274($a_rows);->$at_uuidRemoto;->$at_pKey;->$at_tablaSQL;->$at_columnaSQL;\
			->$at_tipoSQL;->$at_tablaAtributo;->$at_tipoAtributo;->$al_tabla4D;->$al_campo4D;->$al_tipo4D;\
			->$at_dtsRemoto;->$ab_sincronizable;->$at_CondorRefID;->$al_STRefIdRegistro;->$at_valorAtributo;\
			->$ab_nuevoDic;->$ab_transform)
		For ($i;1;Size of array:C274($a_rows))
			$at_uuidRemoto{$i}:=OB Get:C1224($a_rows{$i};"autouuid")
			$at_pKey{$i}:=OB Get:C1224($a_rows{$i};"pkey")
			$at_tablaSQL{$i}:=OB Get:C1224($a_rows{$i};"condor_tabla")
			$at_columnaSQL{$i}:=OB Get:C1224($a_rows{$i};"condor_columna")
			$at_tipoSQL{$i}:=OB Get:C1224($a_rows{$i};"condor_tiposql")
			$at_tablaAtributo{$i}:=OB Get:C1224($a_rows{$i};"condor_tablaatributo")
			$at_tipoAtributo{$i}:=OB Get:C1224($a_rows{$i};"condor_tipoatributo")
			$al_tabla4D{$i}:=OB Get:C1224($a_rows{$i};"st_tabla";Is longint:K8:6)
			$al_campo4D{$i}:=OB Get:C1224($a_rows{$i};"st_campo";Is longint:K8:6)
			$al_tipo4D{$i}:=OB Get:C1224($a_rows{$i};"st_tipo4d";Is longint:K8:6)
			$at_dtsRemoto{$i}:=OB Get:C1224($a_rows{$i};"dts")
			$ab_sincronizable{$i}:=OB Get:C1224($a_rows{$i};"sincronizable";Is boolean:K8:9)
			$at_CondorRefID{$i}:=OB Get:C1224($a_rows{$i};"condor_columnaidregistro")
			$al_STRefIdRegistro{$i}:=OB Get:C1224($a_rows{$i};"st_refcampoidregistro";Is longint:K8:6)
			$at_valorAtributo{$i}:=OB Get:C1224($a_rows{$i};"condor_valoratributo")
			$ab_transform{$i}:=OB Get:C1224($a_rows{$i};"transform_value";Is boolean:K8:9)
		End for 
		
		If (Size of array:C274($at_uuidRemoto)>0)
			For ($i;1;Size of array:C274($at_uuidRemoto))
				$t_uuid:=$at_uuidRemoto{$i}
				$l_recNum:=KRL_FindAndLoadRecordByIndex (->[sync_diccionario:285]Auto_uuid:1;->$t_uuid;True:C214)
				$crear:=($l_recNum=No current record:K29:2)
				If ($crear)
					CREATE RECORD:C68([sync_diccionario:285])
					[sync_diccionario:285]Auto_uuid:1:=$at_uuidRemoto{$i}
					$b_recargar_RefSincronizacion:=True:C214
					If ($al_campo4D{$i}>0)
						$ab_nuevoDic{$i}:=True:C214
					End if 
				End if 
				[sync_diccionario:285]pKey:13:=$at_pKey{$i}
				[sync_diccionario:285]condor_tabla:2:=$at_tablaSQL{$i}
				[sync_diccionario:285]condor_columna:3:=$at_columnaSQL{$i}
				[sync_diccionario:285]condor_tipoSQL:4:=$at_tipoSQL{$i}
				[sync_diccionario:285]condor_tablaAtributo:5:=$at_tablaAtributo{$i}
				[sync_diccionario:285]condor_tipoAtributo:6:=$at_tipoAtributo{$i}
				[sync_diccionario:285]condor_nombreAtributo:7:=$at_valorAtributo{$i}
				[sync_diccionario:285]st_tabla:8:=$al_tabla4D{$i}
				[sync_diccionario:285]st_campo:9:=$al_campo4D{$i}
				[sync_diccionario:285]st_tipo4D:10:=$al_tipo4D{$i}
				[sync_diccionario:285]dts:11:=$at_dtsRemoto{$i}
				If ([sync_diccionario:285]sincronizable:12#$ab_sincronizable{$i})
					$b_recargar_RefSincronizacion:=True:C214
				End if 
				[sync_diccionario:285]sincronizable:12:=$ab_sincronizable{$i}
				[sync_diccionario:285]st_RefCampoIdRegistro:15:=$al_STRefIdRegistro{$i}
				[sync_diccionario:285]condor_columnaIdRegistro:14:=$at_CondorRefID{$i}
				SAVE RECORD:C53([sync_diccionario:285])
			End for 
			KRL_UnloadReadOnly (->[sync_diccionario:285])
		End if 
		$answer:=SYNC_APICall ("obtieneuuiddiccionario")
		If (Not:C34(SYNC_CHECKERROR ($answer)))
			ARRAY OBJECT:C1221($at_uuidRemoto2;0)
			OB GET ARRAY:C1229($answer;"data";$at_uuidRemoto2)
			AT_ResizeArrays (->$at_uuidRemoto;Size of array:C274($at_uuidRemoto2))
			For ($i;1;Size of array:C274($at_uuidRemoto2))
				$at_uuidRemoto{$i}:=OB Get:C1224($at_uuidRemoto2{$i};"autouuid")
				$at_uuidRemoto{$i}:=Util_MakeUUIDNonCanonical ($at_uuidRemoto{$i})
			End for 
			ALL RECORDS:C47([sync_diccionario:285])
			SELECTION TO ARRAY:C260([sync_diccionario:285];$al_RecNums;[sync_diccionario:285]Auto_uuid:1;$at_localUUID)
			For ($i_registros;1;Size of array:C274($al_RecNums))
				If (Find in array:C230($at_uuidRemoto;$at_localUUID{$i_registros})=-1)
					KRL_DeleteRecord (->[sync_diccionario:285];$al_RecNums{$i_registros})
					$b_recargar_RefSincronizacion:=True:C214
				End if 
			End for 
			KRL_UnloadReadOnly (->[sync_diccionario:285])
			If ($b_recargar_RefSincronizacion)
				Sync_LeeRefSincronizacion 
			End if 
		Else 
			Sync_LogEvento ("Condor -> ST";"Actualización de diccionario fallida. ERROR API: "+OB Get:C1224($answer;"MSG");"";0;"";0;"")
		End if 
	Else 
		Sync_LogEvento ("Condor -> ST";"Actualización de diccionario fallida. ERROR API: "+OB Get:C1224($answer;"MSG");"";0;"";0;"")
	End if 
End if 