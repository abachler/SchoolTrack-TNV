//%attributes = {}
  //PST_AsignExamsDate

_O_C_INTEGER:C282($hayCupos)
$hayCupos:=0
If (Count parameters:C259=1)
	$display:=$1
Else 
	$display:=True:C214
End if 
If (Semaphore:C143("Config_postulaciones"))
	CD_Dlog (0;__ ("Otro usuario está modificando la configuración del sistema.\rPor favor intente nuevamente esta operación en un momento más."))
Else 
	CLEAR SEMAPHORE:C144("Config_postulaciones")
	If (viPST_daysBeforeExam>0)
		$minDate:=Current date:C33(*)+viPST_daysBeforeExam
	Else 
		$minDate:=Current date:C33(*)
	End if 
	
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ADT_Candidatos:49]Candidato_numero:1)
	$maxAsist:=iPST_Sections*iPST_MaxPerSection
	QUERY:C277([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]Attendance:4<$maxAsist;*)
	QUERY:C277([ADT_SesionesDeExamenes:123]; & [ADT_SesionesDeExamenes:123]Date_Session:2>=$minDate)
	
	$continuarAsignacion:=True:C214
	Case of 
		: (([Alumnos:2]nivel_numero:29=Nivel_AdmissionTrack) & (viPST_DontAsigExamJF=1))
			QUERY SELECTION:C341([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ReservedPG:5=False:C215)
			If (Records in selection:C76([ADT_SesionesDeExamenes:123])=0)
				If ($display)
					CD_Dlog (0;__ ("Solo hay sesiones reservadas a los postulantes actualmente en Jardín Infantil.\r\rLa sesión de examen no será asignada."))
				End if 
				$continuarAsignacion:=False:C215
			End if 
		: (([Alumnos:2]nivel_numero:29=-3) & (viPST_DontAsigExamJF=1))
			QUERY SELECTION:C341([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]ReservedPG:5=True:C214)
			If (Records in selection:C76([ADT_SesionesDeExamenes:123])=0)
				If ($display)
					CD_Dlog (0;__ ("Los postulantes de Jardín infantil debieran ser asignados a sesiones reservadas para ellos, pero ninguna sesión ha sido configurada para este efecto. \r\rLa sesión de examen no será asignada."))
				End if 
				$continuarAsignacion:=False:C215
			End if 
	End case 
	
	
	
	For ($j;1;Size of array:C274(atPST_GroupName))
		If (atPST_GroupName{$j}=[ADT_Candidatos:49]Grupo:21)
			If (aiPST_Cupos{$j}>0)
				$hayCupos:=1
			Else 
				$hayCupos:=0
			End if 
		End if 
	End for 
	
	
	
	
	
	If ($continuarAsignacion)
		ORDER BY:C49([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]Date_Session:2;>;[ADT_SesionesDeExamenes:123]Attendance:4;<)
		SELECTION TO ARRAY:C260([ADT_SesionesDeExamenes:123]ID:1;$aSesionID)
		
		If (([ADT_Candidatos:49]ID_Exam:29=0) & (viPST_AutoAsigExam=1) & ([ADT_Candidatos:49]Grupo:21#"") & ($hayCupos=1))
			For ($i;1;Size of array:C274($aSesionID))
				Case of 
					: (iPST_DistributeBySex=0)
						QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21;*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Total:11<iPST_MaxPerSection;*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]ID_Sesion:12=$aSesionID{$i})
						ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Total:11;<)
						If (Records in selection:C76([ADT_Examenes:122])>0)
							[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
							SAVE RECORD:C53([ADT_Candidatos:49])
							$i:=Size of array:C274($aSesionID)
						End if 
					: ([Alumnos:2]Sexo:49="F")
						QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21;*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Total:11<iPST_MaxPerSection;*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Girls:9<(iPST_MaxPerSection/2);*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]ID_Sesion:12=$aSesionID{$i})
						ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Girls:9;<)
						If (Records in selection:C76([ADT_Examenes:122])>0)
							[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
							SAVE RECORD:C53([ADT_Candidatos:49])
							$i:=Size of array:C274($aSesionID)
						End if 
					: ([Alumnos:2]Sexo:49="M")
						QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21;*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Total:11<iPST_MaxPerSection;*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Boys:10<(iPST_MaxPerSection/2);*)
						QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]ID_Sesion:12=$aSesionID{$i})
						ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]SortOrder:13;>;[ADT_Examenes:122]Boys:10;<)
						If (Records in selection:C76([ADT_Examenes:122])>0)
							[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
							SAVE RECORD:C53([ADT_Candidatos:49])
							$i:=Size of array:C274($aSesionID)
						End if 
				End case 
				
				
				  //si no se pudo realizar en la primera tentativa
				If ([ADT_Candidatos:49]secs_Exam:24=0)
					Case of 
						: (iPST_DistributeBySex=0)
							QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21;*)
							QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Total:11<iPST_MaxPerSection;*)
							QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]ID_Sesion:12=$aSesionID{$i})
							ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Total:11;>)
							If (Records in selection:C76([ADT_Examenes:122])>0)
								[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
								SAVE RECORD:C53([ADT_Candidatos:49])
								$i:=Size of array:C274($aSesionID)
							End if 
							
						: ([Alumnos:2]Sexo:49="F")
							READ WRITE:C146([ADT_Examenes:122])
							QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21;*)
							QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Total:11<iPST_MaxPerSection;*)
							QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]ID_Sesion:12=$aSesionID{$i})
							ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Total:11;<)
							FIRST RECORD:C50([ADT_Examenes:122])
							If (Records in selection:C76([ADT_Examenes:122])>0)
								[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
								SAVE RECORD:C53([ADT_Candidatos:49])
								$i:=Size of array:C274($aSesionID)
							End if 
						: ([Alumnos:2]Sexo:49="M")
							QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21;*)
							QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]Total:11<iPST_MaxPerSection;*)
							QUERY:C277([ADT_Examenes:122]; & [ADT_Examenes:122]ID_Sesion:12=$aSesionID{$i})
							ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Total:11;<)
							If (Records in selection:C76([ADT_Examenes:122])>0)
								[ADT_Candidatos:49]ID_Exam:29:=[ADT_Examenes:122]ID:1
								SAVE RECORD:C53([ADT_Candidatos:49])
								$i:=Size of array:C274($aSesionID)
							End if 
					End case 
				End if 
			End for 
			
			  //No se pudo realizar la asignación  
			If ($display)
				If ($continuarAsignacion)
					If ([ADT_Candidatos:49]ID_Exam:29=0)
						QUERY:C277([ADT_Examenes:122];[ADT_Examenes:122]Group:6=[ADT_Candidatos:49]Grupo:21)
						ORDER BY:C49([ADT_Examenes:122];[ADT_Examenes:122]Date_Exam:2;>;[ADT_Examenes:122]Total:11;>)
						SELECTION TO ARRAY:C260([ADT_Examenes:122]Section:7;asPST_SelEXmSections;[ADT_Examenes:122]Date_Exam:2;adPST_SelEXmDate;[ADT_Examenes:122]Time_Exam:3;aLPST_SelEXmTime;[ADT_Examenes:122]Girls:9;aiPST_SelEXmGirls;[ADT_Examenes:122]Boys:10;aiPST_SelEXmBoys;[ADT_Examenes:122]Total:11;aiPST_SelEXmTotal;[ADT_Examenes:122]ID:1;aLPST_SelEXmID;[ADT_Examenes:122]Secs:8;aLPST_SelEXmSecs)
						WDW_OpenFormWindow (->[xxSTR_Constants:1];"PST_AddNewExamSesions";0;-Palette form window:K39:9;__ ("Asignación de Exámen"))
						DIALOG:C40([xxSTR_Constants:1];"PST_AddNewExamSesions")
						CLOSE WINDOW:C154
					End if 
					SAVE RECORD:C53([ADT_Candidatos:49])
				End if 
			End if 
		End if 
	End if 
	
End if 