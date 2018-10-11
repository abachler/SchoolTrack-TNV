//%attributes = {}
  //BBLdbu_EliminaLectoresDuplicado

C_LONGINT:C283($lastRelatedID)
C_LONGINT:C283($i;$j;$goodID)

$pId:=IT_UThermometer (1;0;__ ("Consolidando lectores duplicados..."))
BBLdbu_RebuildStatistics 
ARRAY LONGINT:C221(aDuplicateRelatedID;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6>0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6;>)
$lastRelatedID:=0
While (Not:C34(End selection:C36([BBL_Lectores:72])))
	If ([BBL_Lectores:72]Número_de_alumno:6=$lastRelatedID)
		If (Find in array:C230(aDuplicateRelatedID;$lastRelatedID)=-1)
			AT_Insert (0;1;->aDuplicateRelatedID)
			aDuplicateRelatedID{Size of array:C274(aDuplicateRelatedID)}:=[BBL_Lectores:72]Número_de_alumno:6
		End if 
	End if 
	$lastRelatedID:=[BBL_Lectores:72]Número_de_alumno:6
	NEXT RECORD:C51([BBL_Lectores:72])
End while 
For ($i;1;Size of array:C274(aDuplicateRelatedID))
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_alumno:6;=;aDuplicateRelatedID{$i})
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
End for 

ARRAY LONGINT:C221(aDuplicateRelatedID;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30>0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30;>)
$lastRelatedID:=0
While (Not:C34(End selection:C36([BBL_Lectores:72])))
	If ([BBL_Lectores:72]Número_de_Profesor:30=$lastRelatedID)
		If (Find in array:C230(aDuplicateRelatedID;$lastRelatedID)=-1)
			AT_Insert (0;1;->aDuplicateRelatedID)
			aDuplicateRelatedID{Size of array:C274(aDuplicateRelatedID)}:=[BBL_Lectores:72]Número_de_Profesor:30
		End if 
	End if 
	$lastRelatedID:=[BBL_Lectores:72]Número_de_Profesor:30
	NEXT RECORD:C51([BBL_Lectores:72])
End while 
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
End for 

ARRAY LONGINT:C221(aDuplicateRelatedID;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Persona:31>0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Persona:31;>)
$lastRelatedID:=0
While (Not:C34(End selection:C36([BBL_Lectores:72])))
	If ([BBL_Lectores:72]Número_de_Persona:31=$lastRelatedID)
		If (Find in array:C230(aDuplicateRelatedID;$lastRelatedID)=-1)
			AT_Insert (0;1;->aDuplicateRelatedID)
			aDuplicateRelatedID{Size of array:C274(aDuplicateRelatedID)}:=[BBL_Lectores:72]Número_de_Persona:31
		End if 
	End if 
	$lastRelatedID:=[BBL_Lectores:72]Número_de_Persona:31
	NEXT RECORD:C51([BBL_Lectores:72])
End while 
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
End for 

ARRAY TEXT:C222(aDuplicateRUT;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30=0;*)
QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_alumno:6=0;*)
QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_Persona:31=0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]NombreCompleto:3;>;[BBL_Lectores:72]RUT:7;>)
$lastRUT:=""
While (Not:C34(End selection:C36([BBL_Lectores:72])))
	If ([BBL_Lectores:72]RUT:7=$lastRUT)
		If (Find in array:C230(aDuplicateRUT;$lastRUT)=-1)
			AT_Insert (0;1;->aDuplicateRUT)
			aDuplicateRUT{Size of array:C274(aDuplicateRUT)}:=[BBL_Lectores:72]RUT:7
		End if 
	End if 
	$lastRUT:=[BBL_Lectores:72]RUT:7
	NEXT RECORD:C51([BBL_Lectores:72])
End while 
For ($i;1;Size of array:C274(aDuplicateRUT))
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]RUT:7;=;aDuplicateRUT{$i})
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
End for 

ARRAY TEXT:C222(aDuplicatedName;0)
QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30=0;*)
QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_alumno:6=0;*)
QUERY:C277([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_Persona:31=0)
ORDER BY:C49([BBL_Lectores:72];[BBL_Lectores:72]NombreCompleto:3;>)
$lastName:=""
While (Not:C34(End selection:C36([BBL_Lectores:72])))
	If ([BBL_Lectores:72]NombreCompleto:3=$lastName)
		If (Find in array:C230(aDuplicatedName;$lastName)=-1)
			AT_Insert (0;1;->aDuplicatedName)
			aDuplicatedName{Size of array:C274(aDuplicatedName)}:=[BBL_Lectores:72]NombreCompleto:3
		End if 
	End if 
	$lastName:=[BBL_Lectores:72]NombreCompleto:3
	NEXT RECORD:C51([BBL_Lectores:72])
End while 
For ($i;1;Size of array:C274(aDuplicatedName))
	QUERY:C277([BBL_Lectores:72];[BBL_Lectores:72]RUT:7;=;aDuplicatedName{$i})
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
End for 
BBLdbu_RebuildStatistics 
IT_UThermometer (-2;$pid)