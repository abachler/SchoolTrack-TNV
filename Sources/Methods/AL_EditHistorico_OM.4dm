//%attributes = {}
  // Método: AL_EditHistorico_OM
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 18/06/10, 12:49:03
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($method;$1;$parameters;$3)
C_POINTER:C301($objectPointer;$2)
C_LONGINT:C283($tableNum;$fieldNum)
_O_C_STRING:C293(255;$varName)
C_BOOLEAN:C305(vb_RecordWasModified)
C_LONGINT:C283($l_repitente)

  // Código principal
Case of 
	: (Count parameters:C259=1)
		$method:=$1
	: (Count parameters:C259=2)
		$method:=$1
		$ObjectPointer:=$2
	: (Count parameters:C259=3)
		$method:=$1
		$ObjectPointer:=$2
		$parameters:=$3
End case 

If (Not:C34(Is nil pointer:C315($objectPointer)))
	RESOLVE POINTER:C394($objectPointer;$varName;$tableNum;$fieldNum)
End if 

Case of 
	: ($method="")
		
		AL_EditHistorico_OM ("CreaTablaHistoricos")
		
		$title:=__ ("Históricos de ")+[Alumnos:2]Nombre_Común:30
		WDW_OpenFormWindow (->[Alumnos_Historico:25];"EdicionHistoricos";-1;8;$title)
		DIALOG:C40([Alumnos_Historico:25];"EdicionHistoricos")
		CLOSE WINDOW:C154
		
	: ($method="CreaTablaHistoricos")
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-Abs:C99([Alumnos:2]numero:1))
		ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<;[Alumnos_SintesisAnual:210]NumeroNivel:6;<)
		
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]Año:2;$aYears;[Alumnos_SintesisAnual:210]NumeroNivel:6;$aNumNivel;[Alumnos_SintesisAnual:210];al_RecNumsHistorico)
		ARRAY TEXT:C222(at_YearsName;Size of array:C274($aYears))
		ARRAY TEXT:C222(at_NivelesHistorico;Size of array:C274($aYears))
		For ($i;1;Size of array:C274($aYears))
			
			  //lectura del nombre del año escolar
			$year:=$aYears{$i}
			$yearName:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->$year;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
			If ($yearName#"")
				at_YearsName{$i}:=$yearName
			Else 
				$yearName:=String:C10($year)
				CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
				[xxSTR_DatosDeCierre:24]Year:1:=$year
				[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5:=String:C10([xxSTR_DatosDeCierre:24]Year:1)
				SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
				UNLOAD RECORD:C212([xxSTR_DatosDeCierre:24])
				at_YearsName{$i}:=$yearName
			End if 
			
			  //lectura del nombre de nivel historico
			$numNivel:=$aNumNivel{$i}
			$key:="0"+"."+String:C10($numNivel)+"."+String:C10($year)
			$nombreNivel:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$key;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
			If ($nombreNivel#"")
				at_NivelesHistorico{$i}:=$nombreNivel
			Else 
				at_NivelesHistorico{$i}:="Nivel "+String:C10($numNivel)+" (ERROR: Propiedades no definidas)"
			End if 
		End for 
		LISTBOX SELECT ROW:C912(lb_Historicos;1)
		
		
		
		
		
	: ($method="FormEvents")
		Case of 
			: (Form event:C388=On Load:K2:1)
				For ($i;1;Size of array:C274(lb_Historicos))
					lb_Historicos{$i}:=False:C215
				End for 
				vb_RecordWasModified:=False:C215
				If (Size of array:C274(lb_Historicos)>0)
					lb_Historicos{1}:=True:C214
					at_YearsName:=1
					at_NivelesHistorico:=1
					al_RecNumsHistorico:=1
					AL_EditHistorico_OM ("LeerRegistros")
				End if 
				_O_DISABLE BUTTON:C193(bGuardar)
				
			: (Form event:C388=On Data Change:K2:15)
				vb_RecordWasModified:=True:C214
				_O_ENABLE BUTTON:C192(bGuardar)
				
			Else 
				If (al_RecNumsHistorico>0)
					If (vb_RecordWasModified)
						_O_ENABLE BUTTON:C192(bGuardar)
					Else 
						_O_DISABLE BUTTON:C193(bGuardar)
					End if 
					_O_ENABLE BUTTON:C192(bDelHistorico)
				Else 
					UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
					UNLOAD RECORD:C212([Alumnos_Historico:25])
					_O_DISABLE BUTTON:C193(bGuardar)
					_O_DISABLE BUTTON:C193(bDelHistorico)
				End if 
		End case 
		
		
		
		
	: ($method="LeerRegistros")
		If (al_RecNumsHistorico>0)
			If (vb_RecordWasModified)
				$answer:=CD_Dlog (0;__ ("Usted modificó el registro histórico.\r\r¿Desea guardar las modificaciones registradas?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
				Case of 
					: ($answer=1)
						$changeRecord:=True:C214
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						SAVE RECORD:C53([Alumnos_Historico:25])
						
					: ($answer=2)
						$changeRecord:=True:C214
						
					: ($answer=3)
						$changeRecord:=False:C215
						
				End case 
			Else 
				$changeRecord:=True:C214
			End if 
			
			If ($changeRecord)
				vb_RecordWasModified:=False:C215
				KRL_GotoRecord (->[Alumnos_SintesisAnual:210];al_RecNumsHistorico{al_RecNumsHistorico};True:C214)
				$key:=String:C10([Alumnos:2]numero:1)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
				KRL_FindAndLoadRecordByIndex (->[Alumnos_Historico:25]Llave:42;->$key;True:C214)
				_O_DISABLE BUTTON:C193(bGuardar)
				
				Case of 
					: (<>vtXS_CountryCode="cl")
						If ([Alumnos:2]Situacion_final:33="P")
							r1_promovido:=1
							r2_Reprobado:=0
						Else 
							r1_promovido:=0
							r2_Reprobado:=1
						End if 
						
					: (<>vtXS_CountryCode="pe")
						If (([Alumnos:2]Situacion_final:33="A") | ([Alumnos:2]Situacion_final:33="RR"))
							r1_promovido:=1
							r2_Reprobado:=0
						End if 
						
					: (<>vtXS_CountryCode="co")
						If (([Alumnos:2]Situacion_final:33="P") | ([Alumnos:2]Situacion_final:33="RR"))
							$promovido:=True:C214
						End if 
						
					: (<>vtXS_CountryCode="ve")
						If ([Alumnos:2]Situacion_final:33="P")
							$promovido:=True:C214
						End if 
						
					: (<>vtXS_CountryCode="ar")
						If ([Alumnos:2]Situacion_final:33="P")
							$promovido:=True:C214
						End if 
						
					Else 
						If ([Alumnos:2]Situacion_final:33="P")
							$promovido:=True:C214
						End if 
				End case 
				
				
			Else 
				$el:=Find in array:C230(al_RecNumsHistorico;Record number:C243([Alumnos_SintesisAnual:210]))
				For ($i;1;Size of array:C274(lb_Historicos))
					lb_Historicos{$i}:=False:C215
				End for 
				at_NivelesHistorico:=$el
				al_RecNumsHistorico:=$el
				at_YearsName:=$el
				LISTBOX SELECT ROW:C912(lb_Historicos;$el)
			End if 
			_O_ENABLE BUTTON:C192(bDelHistorico)
		Else 
			UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
			UNLOAD RECORD:C212([Alumnos_Historico:25])
			_O_DISABLE BUTTON:C193(bGuardar)
			_O_DISABLE BUTTON:C193(bDelHistorico)
		End if 
		
		
		
		
	: ($method="GuardarRegistros")
		If (vb_RecordWasModified)
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			SAVE RECORD:C53([Alumnos_Historico:25])
		End if 
		
	: ($method="RevertirCambios")
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];Record number:C243([Alumnos_SintesisAnual:210]);True:C214)
		KRL_GotoRecord (->[Alumnos_Historico:25];Record number:C243([Alumnos_Historico:25]);True:C214)
		vb_RecordWasModified:=False:C215
		
		
	: ($method="ModificaPromedios")
		$fieldName:="[Alumnos_SintesisAnual]"+Field name:C257($objectPointer)
		$realPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Real"))
		$notaPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Nota"))
		$puntosPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Puntos"))
		$simboloPointer:=KRL_GetFieldPointerByName (Replace string:C233($fieldName;"_literal";"_Simbolo"))
		
		EVS_initialize 
		EVS_LeeEstiloEvalHistorico (vx_EstiloInterno)
		
		$realPointer->:=NTA_StringValue2Percent ($objectPointer->)
		$notaPointer->:=EV2_Real_a_Nota ($realPointer->)
		$puntosPointer->:=EV2_Real_a_Puntos ($realPointer->;0)
		$simboloPointer->:=EV2_Real_a_Simbolo ($realPointer->)
		
		vb_RecordWasModified:=True:C214
		
		
		
		
		
	: ($method="SetPromocion")
		
		If (Records in selection:C76([Alumnos_SintesisAnual:210])=0)
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
		End if 
		
		Case of 
			: ([Alumnos_SintesisAnual:210]Promovido:91)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
				QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;=;[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
				QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8;=;"P";*)
				QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]LlavePrincipal:5;#;[Alumnos_SintesisAnual:210]LlavePrincipal:5)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($found>0)
					CD_Dlog (0;[Alumnos:2]Nombre_Común:30+__ (" ya aprobó ")+at_NivelesHistorico{at_NivelesHistorico}+__ ("\r\rNo es posible aprobar el mismo nivel académico más de una vez."))
					[Alumnos_SintesisAnual:210]Promovido:91:=Old:C35([Alumnos_SintesisAnual:210]Promovido:91)
				Else 
					[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
					vb_RecordWasModified:=True:C214
				End if 
				
			: (Not:C34([Alumnos_SintesisAnual:210]Promovido:91))
				Case of 
					: (([Alumnos:2]nivel_numero:29-[Alumnos_SintesisAnual:210]NumeroNivel:6)=1)
						$keyNivel:=String:C10(0)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
						$nombreNivel:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
						CD_Dlog (0;[Alumnos:2]Nombre_Común:30+__ (" cursa actualmente el nivel académico superior al que intenta establecer como reprobado.\r\rNo es posible reprobarlo(a) en ")+$nombreNivel)
						[Alumnos_SintesisAnual:210]Promovido:91:=Old:C35([Alumnos_SintesisAnual:210]Promovido:91)
						
						
					: (([Alumnos:2]nivel_numero:29-[Alumnos_SintesisAnual:210]NumeroNivel:6)>1)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
						QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;=;([Alumnos_SintesisAnual:210]NumeroNivel:6+1);*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]LlavePrincipal:5;#;[Alumnos_SintesisAnual:210]LlavePrincipal:5)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						  //ASM ticket 139819
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_repitente)
						QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;=;[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]LlavePrincipal:5;#;[Alumnos_SintesisAnual:210]LlavePrincipal:5;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2;=;([Alumnos_SintesisAnual:210]Año:2+1))
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						
						  //If ($found>0)
						If ($found>0) & ($l_repitente=0)
							$keyNivel:=String:C10(0)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
							$nombreNivel:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
							CD_Dlog (0;[Alumnos:2]Nombre_Común:30+__ (" ya aprobó el nivel académico siguiente.\r\rNo es posible reprobarlo(a) en ")+$nombreNivel)
							[Alumnos_SintesisAnual:210]Promovido:91:=Old:C35([Alumnos_SintesisAnual:210]Promovido:91)
						Else 
							vb_RecordWasModified:=True:C214
						End if 
					Else 
						SET QUERY DESTINATION:C396(Into variable:K19:4;$found)
						QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6;=;[Alumnos_SintesisAnual:210]NumeroNivel:6;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Promovido:91;=;False:C215;*)
						QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]LlavePrincipal:5;#;[Alumnos_SintesisAnual:210]LlavePrincipal:5)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If ($found>0)
							$keyNivel:=String:C10(0)+"."+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6)+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
							$nombreNivel:=KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivel;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
							CD_Dlog (0;[Alumnos:2]Nombre_Común:30+__ (" ya aprobó ")+$nombreNivel+__ ("\r\rNo es posible aprobar el mismo nivel académico más de una vez."))
							[Alumnos_SintesisAnual:210]Promovido:91:=Old:C35([Alumnos_SintesisAnual:210]Promovido:91)
						Else 
							[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
							vb_RecordWasModified:=True:C214
						End if 
				End case 
		End case 
		
		Case of 
				  //20131104 ASM
				  //: (([Alumnos_SintesisAnual]Promovido) & (Old([Alumnos_SintesisAnual]Promovido)=False))
			: ([Alumnos_SintesisAnual:210]Promovido:91)
				Case of 
					: (<>vtXS_CountryCode="pe")
						[Alumnos_SintesisAnual:210]SituacionFinal:8:="A"
					: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ve") | (<>vtXS_CountryCode="ar"))
						[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
					Else 
						[Alumnos_SintesisAnual:210]SituacionFinal:8:="P"
				End case 
			Else 
				Case of 
					: (<>vtXS_CountryCode="pe")
						[Alumnos_SintesisAnual:210]SituacionFinal:8:="D"
					: ((<>vtXS_CountryCode="cl") | (<>vtXS_CountryCode="co") | (<>vtXS_CountryCode="ve") | (<>vtXS_CountryCode="ar"))
						[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
					Else 
						[Alumnos_SintesisAnual:210]SituacionFinal:8:="R"
				End case 
				
		End case 
		
		  //Mono: 17-08-11 desde la ficha del alumno pestaña historico no guardaba el cambio de aprobación
		If (vb_RecordWasModified)
			SAVE RECORD:C53([Alumnos_SintesisAnual:210])
		End if 
		
		
		
	: ($method="AñadirHistorico")
		
		If (al_RecNumsHistorico>0)
			If (vb_RecordWasModified)
				$answer:=CD_Dlog (0;__ ("Usted modificó el registro histórico.\r\r¿Desea guardar las modificaciones registradas?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
				Case of 
					: ($answer=1)
						$changeRecord:=True:C214
						SAVE RECORD:C53([Alumnos_SintesisAnual:210])
						SAVE RECORD:C53([Alumnos_Historico:25])
						
					: ($answer=2)
						$changeRecord:=True:C214
						vb_RecordWasModified:=False:C215
						
					: ($answer=3)
						$changeRecord:=False:C215
						
				End case 
				
			Else 
				$changeRecord:=True:C214
			End if 
		Else 
			$changeRecord:=True:C214
		End if 
		
		$currentRecNum:=Record number:C243([Alumnos_SintesisAnual:210])
		If ($changeRecord)
			WDW_OpenFormWindow (->[Alumnos_Historico:25];"NuevoHistorico";-1;8;__ ("Nuevo registro histórico"))
			DIALOG:C40([Alumnos_Historico:25];"NuevoHistorico")
			CLOSE WINDOW:C154
			
			If (OK=1)
				$currentRecNum:=Record number:C243([Alumnos_SintesisAnual:210])
			End if 
			AL_EditHistorico_OM ("CreaTablaHistoricos")
		End if 
		
		$selected:=Find in array:C230(al_RecNumsHistorico;$currentRecNum)
		at_YearsName:=$selected
		at_NivelesHistorico:=$selected
		al_RecNumsHistorico:=$selected
		LISTBOX SELECT ROW:C912(lb_Historicos;$selected)
		
		AL_EditHistorico_OM ("LeerRegistros")
		
		
	: ($method="EliminarHistórico")
		$answer:=CD_Dlog (0;__ ("¿Desea usted realmente eliminar los registros históricos de ")+[Alumnos:2]Nombre_Común:30+__ (" de ")+at_NivelesHistorico{at_NivelesHistorico}+__ (" en ")+at_YearsName{at_NivelesHistorico}+__ ("?");__ ("");__ ("No");__ ("Si. eliminar"))
		If ($answer=2)
			$answer:=CD_Dlog (0;__ ("La eliminación de registros históricos es irreversible.\r\r¿Está usted realmente seguro de querer eliminar este registro histórico y los registros de evaluación asociados?");__ ("");__ ("No");__ ("Si. Eliminar"))
			If ($answer=2)
				START TRANSACTION:C239
				$year:=[Alumnos_SintesisAnual:210]Año:2
				$niveles:=[Alumnos_SintesisAnual:210]NumeroNivel:6
				$l_IdAlumno:=Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4)
				$t_llaveHistorico:=String:C10(Abs:C99([Alumnos_SintesisAnual:210]ID_Alumno:4))+"."+String:C10([Alumnos_SintesisAnual:210]Año:2)
				$t_llaveCalificaciones:=KRL_MakeStringAccesKey (->[Alumnos_SintesisAnual:210]ID_Institucion:1;->[Alumnos_SintesisAnual:210]Año:2;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->$l_IdAlumno)
				OK:=KRL_DeleteRecord (->[Alumnos_SintesisAnual:210])
				If (OK=1)
					KRL_FindAndLoadRecordByIndex (->[Alumnos_Historico:25]Llave:42;->$t_llaveHistorico;True:C214)
					If (Records in selection:C76([Alumnos_Historico:25])=1)
						OK:=KRL_DeleteRecord (->[Alumnos_Historico:25])
					Else 
						OK:=1
					End if 
				End if 
				If (OK=1)
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Alumno:495=$t_llaveCalificaciones)
					OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208])
				End if 
				If (OK=1)
					QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55=$t_llaveCalificaciones)
					OK:=KRL_DeleteSelection (->[Alumnos_ComplementoEvaluacion:209])
				End if 
				
				If (OK=1)
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ("Registros históricos de "+[Alumnos:2]Nombre_Común:30+" para "+at_NivelesHistorico{at_NivelesHistorico}+" en "+at_YearsName{at_NivelesHistorico}+" eliminados.")
					AL_EditHistorico_OM ("CreaTablaHistoricos")
					If (Size of array:C274(at_NivelesHistorico)>0)
						at_YearsName:=1
						at_NivelesHistorico:=1
						al_RecNumsHistorico:=1
						LISTBOX SELECT ROW:C912(lb_Historicos;1)
						vb_RecordWasModified:=False:C215
						AL_EditHistorico_OM ("LeerRegistros")
					End if 
				Else 
					CD_Dlog (0;__ ("No fue posible eliminar este registro histórico. Por favor intente nuevamente más tarde"))
					CANCEL TRANSACTION:C241
				End if 
			End if 
		End if 
		
	: ($method="ClearMemory")
		AT_RedimArrays (0;->at_YearsName;->at_NivelesHistorico)
		vb_RecordWasModified:=False:C215
		
		
		
End case 



