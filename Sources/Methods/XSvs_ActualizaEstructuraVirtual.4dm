//%attributes = {"executedOnServer":true}
  // XSvs_ActualizaEstructuraVirtual()
  // Por: Alberto Bachler: 07/03/13, 16:43:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($1)

C_BOOLEAN:C305($b_campoInvisible;$b_ForzarActualizacionAlias;$b_indexado;$b_tablaEsInvisible;$b_unico)
C_LONGINT:C283($i;$l_campos;$l_CamposEnTabla;$l_IdProceso;$l_largoCampo;$l_numeroCampo;$l_numeroTabla;$l_recNum;$l_tablas)
C_LONGINT:C283($l_tipoCampo;$l_ultimaTabla)
C_TEXT:C284($t_refCampo;$t_referenciaCampo)

ARRAY INTEGER:C220($ai_numeroTablas;0)
If (False:C215)
	C_BOOLEAN:C305(XSvs_ActualizaEstructuraVirtual ;$1)
End if 

$ms:=Milliseconds:C459

$b_ForzarActualizacionAlias:=False:C215
If (Count parameters:C259=1)
	$b_ForzarActualizacionAlias:=$1
End if 

READ WRITE:C146([xShell_Tables:51])
READ WRITE:C146([xShell_Fields:52])


$l_IdProceso:=IT_Progress (1;0)
$l_ultimaTabla:=Get last table number:C254

$l_iteracionCampos:=0
For ($l_numeroTabla;1;$l_ultimaTabla)
	If (Is table number valid:C999($l_numeroTabla))
		
		  //actualización de la tabla
		$l_IdProceso:=IT_Progress (0;$l_IdProceso;$l_numeroTabla/$l_ultimaTabla;__ ("Actualizando estructura virtual\rTabla: ")+Table name:C256($l_numeroTabla);0;"")
		GET TABLE PROPERTIES:C687($l_numeroTabla;$b_tablaEsInvisible)
		
		
		If ((Not:C34($b_tablaEsInvisible)) & (Table name:C256($l_numeroTabla)#"zz@") & (Table name:C256($l_numeroTabla)#"xShell@") & (Table name:C256($l_numeroTabla)#"xx@"))
			$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_Tables:51]NumeroDeTabla:5;->$l_numeroTabla;True:C214)
			If ($l_recNum<0)
				CREATE RECORD:C68([xShell_Tables:51])
			End if 
			[xShell_Tables:51]NombreDeTabla:1:=Table name:C256($l_numeroTabla)
			[xShell_Tables:51]NumeroDeTabla:5:=$l_numeroTabla
			[xShell_Tables:51]Invisible:10:=Num:C11($b_tablaEsInvisible)
			If (($b_ForzarActualizacionAlias) | (KRL_FieldChanges (->[xShell_Tables:51]NombreDeTabla:1;->[xShell_Tables:51]Invisible:10;->[xShell_Tables:51]NumeroDeTabla:5)))
				SAVE RECORD:C53([xShell_Tables:51])
				XSvs_ActualizaLocalizacionTabla (Record number:C243([xShell_Tables:51]))
			End if 
			
			  // actualización de campos de la tabla
			$l_CamposEnTabla:=Get last field number:C255($l_numeroTabla)
			For ($l_numeroCampo;1;$l_CamposEnTabla)
				If (Is field number valid:C1000($l_numeroTabla;$l_numeroCampo))
					$l_IdProceso:=IT_Progress (0;$l_IdProceso;$l_numeroTabla/$l_ultimaTabla;__ ("Actualizando estructura virtual\rTabla: ")+Table name:C256($l_numeroTabla);$l_numeroCampo/$l_CamposEnTabla;Field name:C257($l_numeroTabla;$l_numeroCampo))
					If (XSvs_esCampoValidoEnEditores (Field:C253($l_numeroTabla;$l_numeroCampo)))
						$t_referenciaCampo:=KRL_MakeStringAccesKey (->$l_numeroTabla;->$l_numeroCampo)
						$l_recNum:=KRL_FindAndLoadRecordByIndex (->[xShell_Fields:52]ReferenciaTablaCampo:7;->$t_referenciaCampo;True:C214)
						If ($l_recNum<0)
							CREATE RECORD:C68([xShell_Fields:52])
						End if 
						GET FIELD PROPERTIES:C258($l_numeroTabla;$l_numeroCampo;$l_tipoCampo;$l_largoCampo;$b_indexado;$b_unico;$b_campoInvisible)
						[xShell_Fields:52]NumeroTabla:1:=$l_numeroTabla
						[xShell_Fields:52]NumeroCampo:2:=$l_numeroCampo
						[xShell_Fields:52]NombreCampo:3:=Field name:C257($l_numeroTabla;$l_numeroCampo)
						[xShell_Fields:52]EsCampoIndexado:6:=$b_indexado
						If ((KRL_RegistroFueModificado (->[xShell_Fields:52])) | ($b_ForzarActualizacionAlias))
							SAVE RECORD:C53([xShell_Fields:52])
							XSvs_ActualizaLocalizacionCampo (Record number:C243([xShell_Fields:52]))
						End if 
					Else 
						$t_refCampo:=KRL_MakeStringAccesKey (->$l_numeroTabla;->$l_numeroCampo)
						QUERY:C277([xShell_Fields:52];[xShell_Fields:52]ReferenciaTablaCampo:7=$t_refCampo)
						KRL_DeleteSelection (->[xShell_Fields:52])
						QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]Referencia_tablaCampo:1=$t_refCampo)
						KRL_DeleteSelection (->[xShell_FieldAlias:198])
					End if 
				End if 
			End for 
			KRL_UnloadReadOnly (->[xShell_Fields:52])
			
		Else 
			  // la tabla no debe ser incluida en los editores, elimino todos los registros asociados
			QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1;=;$l_numeroTabla)
			KRL_DeleteSelection (->[xShell_Fields:52])
			QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=$l_numeroTabla)
			KRL_DeleteSelection (->[xShell_Tables_RelatedFiles:243])
			QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$l_numeroTabla)
			KRL_DeleteSelection (->[xShell_Tables:51])
			QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]TableRef:1;=;String:C10($l_numeroTabla)+".@")
			KRL_DeleteSelection (->[xShell_TableAlias:199])
			QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]FieldRef:5;=;String:C10($l_numeroTabla)+".@")
			KRL_DeleteSelection (->[xShell_FieldAlias:198])
		End if 
		
	Else 
		  // la tabla fue eliminada, elimino todos los registros asociados
		QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1;=;$l_numeroTabla)
		KRL_DeleteSelection (->[xShell_Fields:52])
		QUERY:C277([xShell_Tables_RelatedFiles:243];[xShell_Tables_RelatedFiles:243]OrigenRelacion_NumeroTabla:11=$l_numeroTabla)
		KRL_DeleteSelection (->[xShell_Tables_RelatedFiles:243])
		QUERY:C277([xShell_Tables:51];[xShell_Tables:51]NumeroDeTabla:5=$l_numeroTabla)
		KRL_DeleteSelection (->[xShell_Tables:51])
		QUERY:C277([xShell_TableAlias:199];[xShell_TableAlias:199]TableRef:1;=;String:C10($l_numeroTabla)+".@")
		KRL_DeleteSelection (->[xShell_TableAlias:199])
		QUERY:C277([xShell_FieldAlias:198];[xShell_FieldAlias:198]FieldRef:5;=;String:C10($l_numeroTabla)+".@")
		KRL_DeleteSelection (->[xShell_FieldAlias:198])
	End if 
End for 


$l_IdProceso:=IT_Progress (-1;$l_IdProceso)
KRL_UnloadReadOnly (->[xShell_Tables:51])
KRL_UnloadReadOnly (->[xShell_Fields:52])
KRL_UnloadReadOnly (->[xShell_Tables_RelatedFiles:243])

XSvs_GeneraRegistroRelaciones 
XSvs_LimpiaRelacionesObsoletas 


XSvs_LimpiaLocalizacionObsoleta 


XSvs_GeneraArchivos 


$ms:=Milliseconds:C459-$ms
  //ALERT("Generación Estructura Virtual y localizaciones: "+String($ms))