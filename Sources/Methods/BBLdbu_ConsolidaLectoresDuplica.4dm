//%attributes = {}
  //BBLdbu_ConsolidaLectoresDuplica


C_LONGINT:C283($lastRelatedID)
C_LONGINT:C283($i;$j;$goodID)

READ WRITE:C146([BBL_Lectores:72])
ALL RECORDS:C47([BBL_Lectores:72])
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$aRecNums;"")

$hl:=Load list:C383("BBL_GruposLectores")

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando integridad de registros de Lectores"))
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([BBL_Lectores:72];$aRecNums{$i})
	If ([BBL_Lectores:72]RUT:7#"")
		QUERY:C277([Personas:7];[Personas:7]RUT:6=[BBL_Lectores:72]RUT:7)
		If (Records in selection:C76([Personas:7])=1)
			[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
			[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;3)
			[BBL_Lectores:72]Número_de_alumno:6:=[Personas:7]ID_ExAlumno:87
			[BBL_Lectores:72]Número_de_Profesor:30:=[Personas:7]ID_Profesor:78
			[BBL_Lectores:72]Seccion_o_curso:5:="Apoderados"
		Else 
			QUERY:C277([Alumnos:2];[Alumnos:2]RUT:5=[BBL_Lectores:72]RUT:7)
			If (Records in selection:C76([Alumnos:2])=1)
				[BBL_Lectores:72]Número_de_alumno:6:=[Alumnos:2]numero:1
				If ([Alumnos:2]nivel_numero:29<Nivel_Egresados)
					[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;1)
				Else 
					[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;4)
				End if 
				If ([Alumnos:2]nivel_numero:29<1000)
					[BBL_Lectores:72]Número_de_Profesor:30:=0
					[BBL_Lectores:72]Número_de_Persona:31:=0
				End if 
				[BBL_Lectores:72]Seccion_o_curso:5:=[Alumnos:2]curso:20
			Else 
				QUERY:C277([Profesores:4];[Profesores:4]RUT:27=[BBL_Lectores:72]RUT:7)
				If (Records in selection:C76([Profesores:4])=1)
					[BBL_Lectores:72]Número_de_Profesor:30:=[Profesores:4]Numero:1
					[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;2)
					[BBL_Lectores:72]Número_de_alumno:6:=[Profesores:4]ID_ExAlumno:69
					[BBL_Lectores:72]Número_de_Persona:31:=[Profesores:4]ID_Persona:65
					[BBL_Lectores:72]Seccion_o_curso:5:=[Profesores:4]Departamento:14
				Else 
					[BBL_Lectores:72]Número_de_Profesor:30:=0
					[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;8)
					[BBL_Lectores:72]Número_de_alumno:6:=0
					[BBL_Lectores:72]Número_de_Persona:31:=0
					[BBL_Lectores:72]Seccion_o_curso:5:=""
				End if 
			End if 
		End if 
	Else 
		QUERY:C277([Personas:7];[Personas:7]Apellidos_y_nombres:30=[BBL_Lectores:72]NombreCompleto:3)
		QUERY:C277([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40=[BBL_Lectores:72]NombreCompleto:3)
		QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28=[BBL_Lectores:72]NombreCompleto:3)
		Case of 
			: ((Records in selection:C76([Personas:7])=1) & (Records in selection:C76([Alumnos:2])=0) & (Records in selection:C76([Profesores:4])=0))
				[BBL_Lectores:72]Número_de_Persona:31:=[Personas:7]No:1
				[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;3)
				[BBL_Lectores:72]Número_de_alumno:6:=[Personas:7]ID_ExAlumno:87
				[BBL_Lectores:72]Número_de_Profesor:30:=[Personas:7]ID_Profesor:78
				[BBL_Lectores:72]Seccion_o_curso:5:="Apoderados"
			: ((Records in selection:C76([Alumnos:2])=1) & (Records in selection:C76([Personas:7])=0) & (Records in selection:C76([Profesores:4])=0))
				[BBL_Lectores:72]Número_de_alumno:6:=[Alumnos:2]numero:1
				If ([Alumnos:2]nivel_numero:29<Nivel_Egresados)
					[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;1)
				Else 
					[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;4)
				End if 
				[BBL_Lectores:72]Número_de_Profesor:30:=0
				[BBL_Lectores:72]Número_de_Persona:31:=0
				[BBL_Lectores:72]Seccion_o_curso:5:=[Alumnos:2]curso:20
			: ((Records in selection:C76([Profesores:4])=1) & (Records in selection:C76([Alumnos:2])=1) & (Records in selection:C76([Personas:7])=0))
				[BBL_Lectores:72]Número_de_Profesor:30:=[Profesores:4]Numero:1
				[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;2)
				[BBL_Lectores:72]Número_de_alumno:6:=[Profesores:4]ID_ExAlumno:69
				[BBL_Lectores:72]Número_de_Persona:31:=[Profesores:4]ID_Persona:65
				[BBL_Lectores:72]Seccion_o_curso:5:=[Profesores:4]Departamento:14
			: ((Records in selection:C76([Personas:7])>0) | (Records in selection:C76([Alumnos:2])>0) | (Records in selection:C76([Profesores:4])>0))
				  // sin cambios. No hay certeza de cual es el registro que puede estar relacionado
			Else 
				[BBL_Lectores:72]Número_de_Profesor:30:=0
				[BBL_Lectores:72]Grupo:2:=HL_FindInListByReference ($hl;8)
				[BBL_Lectores:72]Número_de_alumno:6:=0
				[BBL_Lectores:72]Número_de_Persona:31:=0
				[BBL_Lectores:72]Seccion_o_curso:5:=""
		End case 
	End if 
	SAVE RECORD:C53([BBL_Lectores:72])
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Verificando integridad de registros de Lectores"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
CLEAR LIST:C377($hl)

BBLdbu_RebuildStatistics 
ARRAY LONGINT:C221(aDuplicateRelatedID;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6>0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6;>)
$lastRelatedID:=0
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Detectando lectores Alumnos duplicados"))
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([BBL_Lectores:72];$aRecNums{$i})
	If ([BBL_Lectores:72]Número_de_alumno:6=$lastRelatedID)
		If (Find in array:C230(aDuplicateRelatedID;$lastRelatedID)=-1)
			AT_Insert (0;1;->aDuplicateRelatedID)
			aDuplicateRelatedID{Size of array:C274(aDuplicateRelatedID)}:=[BBL_Lectores:72]Número_de_alumno:6
		End if 
	End if 
	$lastRelatedID:=[BBL_Lectores:72]Número_de_alumno:6
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Detectando lectores Alumnos duplicados"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Consolidando lectores Alumnos duplicados"))
For ($i;1;Size of array:C274(aDuplicateRelatedID))
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6;=;aDuplicateRelatedID{$i})
	ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Total_de_préstamos:8;<;[BBL_Lectores:72]ID:1;>)
	CREATE SET:C116([BBL_Lectores:72];"duplicados")
	$goodID:=[BBL_Lectores:72]ID:1
	REMOVE FROM SET:C561([BBL_Lectores:72];"duplicados")
	If ([BBL_Lectores:72]Total_de_préstamos:8>0)
		USE SET:C118("duplicados")
		ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Total_de_préstamos:8;<)
		SELECTION TO ARRAY:C260([BBL_Lectores:72];aRecNums)
		For ($j;1;Size of array:C274(aRecNums))
			GOTO RECORD:C242([BBL_Lectores:72];aRecNums{$j})
			READ WRITE:C146([BBL_Prestamos:60])
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
			If (Records in selection:C76([BBL_Prestamos:60])>0)
				APPLY TO SELECTION:C70([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2:=$goodID)
			End if 
			READ WRITE:C146([BBL_Transacciones:59])
			QUERY:C277([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4=[BBL_Lectores:72]ID:1)
			If (Records in selection:C76([BBL_Transacciones:59])>0)
				APPLY TO SELECTION:C70([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4:=$goodID)
			End if 
		End for 
		USE SET:C118("duplicados")
		READ WRITE:C146([BBL_Lectores:72])
		DELETE SELECTION:C66([BBL_Lectores:72])
	Else 
		USE SET:C118("duplicados")
		READ WRITE:C146([BBL_Lectores:72])
		DELETE SELECTION:C66([BBL_Lectores:72])
	End if 
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aDuplicateRelatedID);__ ("Consolidando lectores Alumnos duplicados"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

ARRAY LONGINT:C221(aDuplicateRelatedID;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Persona:31>0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Persona:31;>)
$lastRelatedID:=0
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Detectando lectores Apoderados y otras Relaciones duplicados"))
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([BBL_Lectores:72];$aRecNums{$i})
	If ([BBL_Lectores:72]Número_de_Persona:31=$lastRelatedID)
		If (Find in array:C230(aDuplicateRelatedID;$lastRelatedID)=-1)
			AT_Insert (0;1;->aDuplicateRelatedID)
			aDuplicateRelatedID{Size of array:C274(aDuplicateRelatedID)}:=[BBL_Lectores:72]Número_de_Persona:31
		End if 
	End if 
	$lastRelatedID:=[BBL_Lectores:72]Número_de_Persona:31
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Detectando lectores Apoderados y otras Relaciones duplicados"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Consolidando lectores Apoderados y otras Relaciones duplicados"))
For ($i;1;Size of array:C274(aDuplicateRelatedID))
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Persona:31;=;aDuplicateRelatedID{$i})
	ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Total_de_préstamos:8;<;[BBL_Lectores:72]ID:1;>)
	CREATE SET:C116([BBL_Lectores:72];"duplicados")
	$goodID:=[BBL_Lectores:72]ID:1
	REMOVE FROM SET:C561([BBL_Lectores:72];"duplicados")
	If ([BBL_Lectores:72]Total_de_préstamos:8>0)
		USE SET:C118("duplicados")
		SELECTION TO ARRAY:C260([BBL_Lectores:72];aRecNums)
		For ($j;1;Size of array:C274(aRecNums))
			GOTO RECORD:C242([BBL_Lectores:72];aRecNums{$j})
			READ WRITE:C146([BBL_Prestamos:60])
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
			If (Records in selection:C76([BBL_Prestamos:60])>0)
				APPLY TO SELECTION:C70([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2:=$goodID)
			End if 
			READ WRITE:C146([BBL_Transacciones:59])
			QUERY:C277([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4=[BBL_Lectores:72]ID:1)
			If (Records in selection:C76([BBL_Transacciones:59])>0)
				APPLY TO SELECTION:C70([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4:=$goodID)
			End if 
		End for 
		USE SET:C118("duplicados")
		READ WRITE:C146([BBL_Lectores:72])
		DELETE SELECTION:C66([BBL_Lectores:72])
	Else 
		USE SET:C118("duplicados")
		READ WRITE:C146([BBL_Lectores:72])
		DELETE SELECTION:C66([BBL_Lectores:72])
	End if 
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aDuplicateRelatedID);__ ("Consolidando lectores Apoderados y otras relaciones duplicados"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

ARRAY LONGINT:C221(aDuplicateRelatedID;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30>0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30;>)
$lastRelatedID:=0
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([BBL_Lectores:72];$aRecNums;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Detectando lectores Docentes y Para-docentes duplicados"))
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([BBL_Lectores:72];$aRecNums{$i})
	If ([BBL_Lectores:72]Número_de_Profesor:30=$lastRelatedID)
		If (Find in array:C230(aDuplicateRelatedID;$lastRelatedID)=-1)
			AT_Insert (0;1;->aDuplicateRelatedID)
			aDuplicateRelatedID{Size of array:C274(aDuplicateRelatedID)}:=[BBL_Lectores:72]Número_de_Profesor:30
		End if 
	End if 
	$lastRelatedID:=[BBL_Lectores:72]Número_de_Profesor:30
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($aRecNums);__ ("Detectando lectores Docentes y para-docentes duplicados"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)

$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Consolidando lectores Docentes y Para-docentes duplicados"))
For ($i;1;Size of array:C274(aDuplicateRelatedID))
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30;=;aDuplicateRelatedID{$i})
	ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Total_de_préstamos:8;<;[BBL_Lectores:72]ID:1;>)
	CREATE SET:C116([BBL_Lectores:72];"duplicados")
	$goodID:=[BBL_Lectores:72]ID:1
	REMOVE FROM SET:C561([BBL_Lectores:72];"duplicados")
	If ([BBL_Lectores:72]Total_de_préstamos:8>0)
		USE SET:C118("duplicados")
		SELECTION TO ARRAY:C260([BBL_Lectores:72];aRecNums)
		For ($j;1;Size of array:C274(aRecNums))
			GOTO RECORD:C242([BBL_Lectores:72];aRecNums{$j})
			READ WRITE:C146([BBL_Prestamos:60])
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
			If (Records in selection:C76([BBL_Prestamos:60])>0)
				APPLY TO SELECTION:C70([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2:=$goodID)
			End if 
			READ WRITE:C146([BBL_Transacciones:59])
			QUERY:C277([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4=[BBL_Lectores:72]ID:1)
			If (Records in selection:C76([BBL_Transacciones:59])>0)
				APPLY TO SELECTION:C70([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4:=$goodID)
			End if 
		End for 
		USE SET:C118("duplicados")
		READ WRITE:C146([BBL_Lectores:72])
		DELETE SELECTION:C66([BBL_Lectores:72])
	Else 
		USE SET:C118("duplicados")
		READ WRITE:C146([BBL_Lectores:72])
		DELETE SELECTION:C66([BBL_Lectores:72])
	End if 
	If (Dec:C9($i/50)=0)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aDuplicateRelatedID);__ ("Consolidando lectores Docentes y para-docentes duplicados"))
	End if 
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)


BBLdbu_RebuildStatistics 