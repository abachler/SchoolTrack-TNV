  //[Asignaturas].Input.Variable3



If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	C_LONGINT:C283($n;$r)
	C_LONGINT:C283($asgID)
	
	$err:=AL_GetSelect (xALP_StdList;alLines)
	
	ARRAY LONGINT:C221(aIDStudent2Transfer;Size of array:C274(alLines))
	ARRAY LONGINT:C221(aRecNum2Transfer;Size of array:C274(alLines))  // studentes id to transfer
	ARRAY TEXT:C222($aStudentNames;Size of array:C274(alLines))
	For ($i;1;Size of array:C274(alLines))
		aRecNum2Transfer{$i}:=aNtaRecNum{alLines{$i}}
		aIDStudent2Transfer{$i}:=aNtaIDAlumno{alLines{$i}}
		$aStudentNames{$i}:=aNtaStdNme{alLines{$i}}
	End for 
	AL_UpdateArrays (xALP_StdList;0)
	
	SORT ARRAY:C229($aStudentNames;aIDStudent2Transfer;aRecNum2Transfer)
	
	$asgRecordNumber:=Record number:C243([Asignaturas:18])
	$saved:=AS_fSave 
	If ($saved>=0)
		KRL_ReloadAsReadOnly (->[Asignaturas:18])
		$id:=[Asignaturas:18]Numero:1
		$name:=[Asignaturas:18]denominacion_interna:16
		$nivel:=[Asignaturas:18]Numero_del_Nivel:6
		
		vl_SrcSubject:=[Asignaturas:18]Numero:1
		vb_NoTransfer:=False:C215
		
		AScsd_LeeReferencias (vl_SrcSubject)  //ABK 20110827
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1)
		CREATE SET:C116([Asignaturas:18];"consolidantes")
		
		
		OBJECT SET VISIBLE:C603(xALP_StdList;False:C215)
		
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$nivel;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Numero:1#$id)
		
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Seleccion:17=True:C214;*)
		QUERY SELECTION:C341([Asignaturas:18]; | ;[Asignaturas:18]Electiva:11=True:C214)
		
		  //las evaluaciones de una asignatura no pueden ser transferidas a sus asignaturas hijas
		CREATE SET:C116([Asignaturas:18];"HabilitadasParaTransferir")
		DIFFERENCE:C122("HabilitadasParaTransferir";"consolidantes";"HabilitadasParaTransferir")
		CLEAR SET:C117("consolidantes")
		
		  //consolidación anual
		USE SET:C118("HabilitadasParaTransferir")
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Consolidacion_PorPeriodo:58=False:C215)
		If (Records in selection:C76([Asignaturas:18])>0)
			QUERY SELECTION BY ATTRIBUTE:C1424([Asignaturas:18];[Asignaturas:18]Configuracion:63;"Anual.SourceID[]";<;0)
			CREATE SET:C116([Asignaturas:18];"ConsolidaAnualSubAsig")
			DIFFERENCE:C122("HabilitadasParaTransferir";"ConsolidaAnualSubAsig";"HabilitadasParaTransferir")
			CLEAR SET:C117("ConsolidaAnualSubAsig")
		End if 
		  //consolidación por periodo
		USE SET:C118("HabilitadasParaTransferir")
		QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Consolidacion_PorPeriodo:58=True:C214)
		If (Records in selection:C76([Asignaturas:18])>0)
			CREATE SET:C116([Asignaturas:18];"CPP")
			PERIODOS_LoadData ($nivel)
			For ($i_periodo;1;Size of array:C274(aiSTR_Periodos_Numero))
				$t_nodo:="P"+String:C10($i_periodo)
				USE SET:C118("CPP")
				QUERY SELECTION BY ATTRIBUTE:C1424([Asignaturas:18];[Asignaturas:18]Configuracion:63;$t_nodo+".SourceID[]";<;0)
				If (Records in selection:C76([Asignaturas:18])>0)
					CREATE SET:C116([Asignaturas:18];"ConsolidaAnualSubAsig")
					DIFFERENCE:C122("HabilitadasParaTransferir";"ConsolidaAnualSubAsig";"HabilitadasParaTransferir")
					CLEAR SET:C117("ConsolidaAnualSubAsig")
				End if 
			End for 
			CLEAR SET:C117("CPP")
		End if 
		USE SET:C118("HabilitadasParaTransferir")
		
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Asignatura:3;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;aPErepID;[Asignaturas:18]denominacion_interna:16;aPERep;[Asignaturas:18]Curso:5;aPERepGrp)
		
		
		If (Size of array:C274(aIDStudent2Transfer)=1)
			$wTitle:=__ ("Transferir ")+aNtaStdNme{alLines{1}}+__ (" a: ")
		Else 
			$wTitle:=__ ("Transferir ")+String:C10(Size of array:C274(alLines))+__ (" alumnos a: ")
		End if 
		WDW_OpenFormWindow (->[xxSTR_Niveles:6];"ReplaceSubjet";9;8;$wTitle)
		DIALOG:C40([xxSTR_Niveles:6];"ReplaceSubjet")
		CLOSE WINDOW:C154
		
		READ WRITE:C146([Asignaturas:18])
		GOTO RECORD:C242([Asignaturas:18];$asgRecordNumber)
		OBJECT SET VISIBLE:C603(xALP_StdList;True:C214)
		
		AS_LimpiaSintesisAsignatura ([Asignaturas:18]Numero:1)
		
		AS_LoadStudentList 
		
		AS_PropEval_Lectura 
		_O_DISABLE BUTTON:C193(Self:C308->)
	Else 
		BEEP:C151
	End if 
	
	ARRAY LONGINT:C221(aIDStudent2Transfer;0)
End if 