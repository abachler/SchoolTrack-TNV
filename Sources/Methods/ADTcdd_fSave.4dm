//%attributes = {}
  //ADTcdd_fSave

C_BLOB:C604($blob)
_O_C_INTEGER:C282($referencia)
C_TIME:C306($doc)
C_BOOLEAN:C305(vb_ConnectionsModified)


$0:=0

  //If (USR_checkRights ("M";->[ADT_Candidatos]))

  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
If (USR_checkRights ("M";->[ADT_Candidatos:49]) | (vb_guardarCambios))
	
	  // **** 20131208 - ABK**** 
	  // Agrego estas lineas porque un registro nuevo pudo haber sido guardado al cambiar algunos atributos
	  // poniendo el alumno en solo lectura (por ejemplo, al cambiar el estado)
	If ((Read only state:C362([Alumnos:2])) | ([Alumnos:2]numero:1#[ADT_Candidatos:49]Candidato_numero:1))
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->[ADT_Candidatos:49]Candidato_numero:1;True:C214)
	End if 
	  // **** 20131208 -  ABK**** //
	
	
	GET LIST ITEM:C378(hl_motivos;*;$referencia;motivo)
	
	
	If (ADTcdd_esRegistroValido )
		GET LIST ITEM:C378(hl_motivos;*;$referencia;motivo)
		$updateGrupoFamilia:=False:C215
		If (<>gGroupAL)
			[Alumnos:2]Grupo:11:=vt_Grupo
		Else 
			[Familia:78]Grupo_Familia:4:=vt_Grupo
			$updateGrupoFamilia:=True:C214
		End if 
		  //ASM 20130929 Comenté la linea porque se estaba produciendo un problema al traspasar el registro desde contactos y prospectos.
		  //If ((Modified record([Alumnos])) | (Modified record([ADT_Candidatos])) | (vb_ConnectionsModified) | ((obligatorio=1) & (motivo#"")))
		
		If (vb_ConnectionsModified)
			AL_SaveConnexions 
		End if 
		
		  //grabar cambio de estado
		  // FRC Me aseguro de estar modificando el registro correcto 
		READ WRITE:C146([xxADT_LogCambioEstado:162])
		ADTcdd_CargaLogCambioEstado 
		REDUCE SELECTION:C351([xxADT_LogCambioEstado:162];1)
		FIRST RECORD:C50([xxADT_LogCambioEstado:162])
		[xxADT_LogCambioEstado:162]Motivo:8:=""
		If ((obligatorio>=0) & (motivo#""))
			[xxADT_LogCambioEstado:162]Motivo:8:=motivo
		End if 
		SAVE RECORD:C53([xxADT_LogCambioEstado:162])
		  //UNLOAD RECORD([xxADT_LogCambioEstado])
		READ ONLY:C145([xxADT_LogCambioEstado:162])
		
		  //If ((obligatorio=1) & (motivo#""))
		  //READ WRITE([xxADT_LogCambioEstado])
		  //[xxADT_LogCambioEstado]Motivo:=motivo
		  //SAVE RECORD([xxADT_LogCambioEstado])
		  //UNLOAD RECORD([xxADT_LogCambioEstado])
		  //End if 
		AL_ProcesaNombres 
		[Alumnos:2]Telefono:17:=[Familia:78]Telefono:10
		[Alumnos:2]Direccion:12:=[Familia:78]Dirección:7
		[Alumnos:2]Región_o_estado:16:=[Familia:78]Region_o_estado:34
		[Alumnos:2]Comuna:14:=[Familia:78]Comuna:8
		SAVE RECORD:C53([Alumnos:2])
		SAVE RECORD:C53([Familia:78])
		KRL_UnloadReadOnlyOnServer (->[Personas:7])  //MONO: problema de registro de persona bloqueado después de entrar al trigger de familia en el server.
		$idFlia:=[Familia:78]Numero:1
		$grupo:=[Familia:78]Grupo_Familia:4
		  //ADT_actualizaRelFamiliar ([Alumnos]Número) //20130729 ASM. se cargaba nuevamente el registro de alumnos
		ADT_actualizaRelFamiliar 
		SAVE RECORD:C53([ADT_Candidatos:49])
		$rnCdd:=Record number:C243([ADT_Candidatos:49])
		ADTcdd_UpdatePresentacionAsist 
		READ WRITE:C146([ADT_Candidatos:49])
		GOTO RECORD:C242([ADT_Candidatos:49];$rnCdd)
		ADTcdd_SaveMetaDataValues 
		ADTcdd_SaveEducacionAnterior 
		$0:=1
		If ($updateGrupoFamilia)
			$rn_alumno_candidato:=Record number:C243([Alumnos:2])
			READ WRITE:C146([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=$idFlia)
			ARRAY TEXT:C222($grupoFlia;Records in selection:C76([Alumnos:2]))
			AT_Populate (->$grupoFlia;->$grupo)
			KRL_Array2Selection (->$grupoFlia;->[Alumnos:2]Grupo:11)
			GOTO RECORD:C242([Alumnos:2];$rn_alumno_candidato)
		End if 
		If ((vbBWR_IsNewRecord) & (In transaction:C397))
			VALIDATE TRANSACTION:C240
		End if 
	Else 
		$0:=-1
	End if 
End if 