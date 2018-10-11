//%attributes = {}
  //DIAG_VerificaMaterias


If (<>vtXS_CountryCode="cl")
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214)
	DISTINCT VALUES:C339([Asignaturas:18]Asignatura:3;aAsignaturas)
	QRY_QueryWithArray (->[xxSTR_Materias:20]Materia:2;->aAsignaturas)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando sectores y subsectores..."))
	While (Not:C34(End selection:C36([xxSTR_Materias:20])))
		If ([xxSTR_Materias:20]Area:12="")
			If (Find in array:C230(aDiagnosticErrors;7)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=7
			End if 
			$text:=[xxSTR_Materias:20]Materia:2+" [7]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
		End if 
		$records:=0
		SET QUERY DESTINATION:C396(3;$records)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3=[xxSTR_Materias:20]Materia:2;*)
		QUERY:C277([Asignaturas:18]; & [Asignaturas:18]Incluida_en_Actas:44=True:C214)
		SET QUERY DESTINATION:C396(0)
		
		If ([xxSTR_Materias:20]Abreviatura:8="")
			If (Find in array:C230(aDiagnosticErrors;10)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=10
			End if 
			$text:=[xxSTR_Materias:20]Materia:2+" [10]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxSTR_Materias:20])/Records in selection:C76([xxSTR_Materias:20]);__ ("Verificando sectores y subsectores..."))
		NEXT RECORD:C51([xxSTR_Materias:20])
	End while 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	QUERY:C277([Asignaturas:18];[Asignaturas:18]Asignatura:3="")
	KRL_DeleteSelection (->[Asignaturas:18])
	
	ALL RECORDS:C47([Asignaturas:18])
	CREATE SET:C116([Asignaturas:18];"All")
	ALL RECORDS:C47([xxSTR_Materias:20])
	KRL_RelateSelection (->[Asignaturas:18]Asignatura:3;->[xxSTR_Materias:20]Materia:2)
	CREATE SET:C116([Asignaturas:18];"related")
	DIFFERENCE:C122("All";"related";"All")
	USE SET:C118("All")
	CLEAR SET:C117("All")
	CLEAR SET:C117("related")
	SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$aSubject;[Asignaturas:18]Curso:5;$aClass)
	If (Size of array:C274($aSubject)>0)
		For ($i;1;Size of array:C274($aSubject))
			If (Find in array:C230(aDiagnosticErrors;21)=-1)
				INSERT IN ARRAY:C227(aDiagnosticErrors;Size of array:C274(aDiagnosticErrors)+1;1)
				aDiagnosticErrors{Size of array:C274(aDiagnosticErrors)}:=21
			End if 
			$text:=$aSubject{$i}+", "+$aClass{$i}+" [21]"+"\r"
			IO_SendPacket (vhDIAG_docRef;$text)
		End for 
	End if 
End if 

