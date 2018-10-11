//%attributes = {}
  //dbu_UpdateFamily

C_LONGINT:C283($records)
$Process:=IT_UThermometer (1;0;__ ("Verificando y reparando familias..."))

  //MONO:24-06-2011 Elimino relaciones familiares que no apuntan a registros de alumnos ni de personas y tambien las que tienen ID de familia 0
READ ONLY:C145([Familia_RelacionesFamiliares:77])
ALL RECORDS:C47([Familia_RelacionesFamiliares:77])
ARRAY LONGINT:C221($al_rnrf;0)
C_LONGINT:C283($i)
LONGINT ARRAY FROM SELECTION:C647([Familia_RelacionesFamiliares:77];$al_rnrf;"")
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Personas:7])
READ WRITE:C146([Familia_RelacionesFamiliares:77])

For ($i;1;Size of array:C274($al_rnrf))
	GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$al_rnrf{$i})
	Case of 
		: ([Familia_RelacionesFamiliares:77]ID_Familia:2=0)
			DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
		: ([Familia_RelacionesFamiliares:77]ID_Alumno:1#0)
			$fik:=Find in field:C653([Alumnos:2]numero:1;[Familia_RelacionesFamiliares:77]ID_Alumno:1)
			If ($fik<0)
				DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
			End if 
		: ([Familia_RelacionesFamiliares:77]ID_Persona:3#0)
			$fik:=Find in field:C653([Personas:7]No:1;[Familia_RelacionesFamiliares:77]ID_Persona:3)
			If ($fik<0)
				DELETE RECORD:C58([Familia_RelacionesFamiliares:77])
			End if 
	End case 
End for 
KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])

  //***** 20110427 RCH Hay registros duplicados pero uno tiene el tipo de relacion correcto y el otro en 0.
  //cuando encuentro mas de un registro, borro los con tipo de relacion 0
ARRAY LONGINT:C221($alSTR_idApdo;0)
ARRAY LONGINT:C221($alSTR_idFamilia;0)
C_LONGINT:C283($i;$vl_records)

READ ONLY:C145([Familia_RelacionesFamiliares:77])

QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4=0;*)
QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#0)
SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;$alSTR_idApdo;[Familia_RelacionesFamiliares:77]ID_Familia:2;$alSTR_idFamilia)

For ($i;1;Size of array:C274($alSTR_idApdo))
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=$alSTR_idApdo{$i};*)
	QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2=$alSTR_idFamilia{$i})
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])>=2)
		$vl_records:=Records in selection:C76([Familia_RelacionesFamiliares:77])
		READ WRITE:C146([Familia_RelacionesFamiliares:77])
		QUERY SELECTION:C341([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]Tipo_Relación:4=0)
		If ($vl_records=Records in selection:C76([Familia_RelacionesFamiliares:77]))
			REDUCE SELECTION:C351([Familia_RelacionesFamiliares:77];$vl_records-1)  // por si hay registros duplicados con tipo de relacion 0. Con esto espero mantener 1...
		End if 
		DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])
		KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
	End if 
End for 
  //***** 20110427 RCH

  //***** 20110328 RCH
  //borra datos de padres y madres en familias asociados a personas que no existen
READ ONLY:C145([Familia:78])
QUERY:C277([Familia:78];[Familia:78]Madre_Número:6#0)
CREATE SET:C116([Familia:78];"familia1")
KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;"")
KRL_RelateSelection (->[Familia:78]Madre_Número:6;->[Personas:7]No:1;"")
CREATE SET:C116([Familia:78];"familia2")
DIFFERENCE:C122("familia1";"familia2";"familia1")
READ WRITE:C146([Familia:78])
USE SET:C118("familia1")
APPLY TO SELECTION:C70([Familia:78];[Familia:78]Madre_Número:6:=0)
APPLY TO SELECTION:C70([Familia:78];[Familia:78]Madre_Nombre:16:="")
KRL_UnloadReadOnly (->[Familia:78])

READ ONLY:C145([Familia:78])
QUERY:C277([Familia:78];[Familia:78]Padre_Número:5#0)
CREATE SET:C116([Familia:78];"familia1")
KRL_RelateSelection (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;"")
KRL_RelateSelection (->[Familia:78]Padre_Número:5;->[Personas:7]No:1;"")
CREATE SET:C116([Familia:78];"familia2")
DIFFERENCE:C122("familia1";"familia2";"familia1")
READ WRITE:C146([Familia:78])
USE SET:C118("familia1")
APPLY TO SELECTION:C70([Familia:78];[Familia:78]Padre_Número:5:=0)
APPLY TO SELECTION:C70([Familia:78];[Familia:78]Padre_Nombre:15:="")
KRL_UnloadReadOnly (->[Familia:78])
SET_ClearSets ("familia1";"familia2")
  //***** 20110328

  //****** 20110328 RCH Hay casos en que los nombres de los padres en la familia no quedan correctamente almacenados...
ARRAY LONGINT:C221(aQR_Longint1;0)
C_LONGINT:C283($i)
READ ONLY:C145([Familia:78])
READ ONLY:C145([Familia_RelacionesFamiliares:77])

QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=0;*)
QUERY:C277([Familia:78]; | ;[Familia:78]Madre_Número:6=0)

LONGINT ARRAY FROM SELECTION:C647([Familia:78];aQR_Longint1;"")
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Actualizando nombres de padres en familia...")
For ($i;1;Size of array:C274(aQR_Longint1))
	READ WRITE:C146([Familia:78])
	GOTO RECORD:C242([Familia:78];aQR_Longint1{$i})
	QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
	If (Records in selection:C76([Familia_RelacionesFamiliares:77])>0)
		FIRST RECORD:C50([Familia_RelacionesFamiliares:77])
		While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
			Case of 
				: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=1)
					[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
					[Familia:78]Madre_Nombre:16:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Madre_Número:6;->[Personas:7]Apellidos_y_nombres:30)
					
				: ([Familia_RelacionesFamiliares:77]Tipo_Relación:4=2)
					[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
					[Familia:78]Padre_Nombre:15:=KRL_GetTextFieldData (->[Personas:7]No:1;->[Familia:78]Padre_Número:5;->[Personas:7]Apellidos_y_nombres:30)
			End case 
			NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
		End while 
		SAVE RECORD:C53([Familia:78])
	End if 
	KRL_UnloadReadOnly (->[Familia:78])
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aQR_Longint1))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
  //****** 20110328

READ WRITE:C146([Alumnos:2])
READ WRITE:C146([Familia:78])
READ WRITE:C146([Personas:7])
READ WRITE:C146([Familia_RelacionesFamiliares:77])

  //ALL RECORDS([Familia])
  //ARRAY INTEGER($zero;Records in selection([Familia]))
  //ARRAY TO SELECTION($zero;[Familia]Numero_de_Alumnos)

QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=0)
KRL_DeleteSelection (->[Familia_RelacionesFamiliares:77])

ALL RECORDS:C47([Familia:78])
While (Not:C34(End selection:C36([Familia:78])))
	$nombrefamilia:=ST_GetCleanString ([Familia:78]Nombre_de_la_familia:3)
	If (([Familia:78]Madre_Número:6#0) | ([Familia:78]Padre_Número:5#0))
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
		$apPaternoMadre:=[Personas:7]Apellido_paterno:3
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
		$apPaternoPadre:=[Personas:7]Apellido_paterno:3
		If (($apPaternoPadre+$apPaternoMadre)#"")
			If ($nombrefamilia="")
				[Familia:78]Nombre_de_la_familia:3:=ST_ClearSpaces ($apPaternoPadre+" "+$apPaternoMadre)
			End if 
		Else 
			[Familia:78]Nombre_de_la_familia:3:=""
		End if 
		If ($apPaternoMadre#"")
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Familia:78]Madre_Número:6;*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
			If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Madre_Número:6
				[Familia_RelacionesFamiliares:77]Parentesco:6:="Madre"
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
			End if 
		End if 
		If ($apPaternoPadre#"")
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=[Familia:78]Padre_Número:5;*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1)
			If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
				CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
				[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Familia:78]Padre_Número:5
				[Familia_RelacionesFamiliares:77]Parentesco:6:="Padre"
				[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
				[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
				SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
			End if 
		End if 
	End if 
	
	If ($nombrefamilia="")
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
		[Familia:78]Nombre_de_la_familia:3:=ST_ClearSpaces ([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
	End if 
	
	If ($nombrefamilia#[Familia:78]Nombre_de_la_familia:3)
		[Familia:78]Nombre_de_la_familia:3:=ST_ClearSpaces ([Familia:78]Nombre_de_la_familia:3)
		SAVE RECORD:C53([Familia:78])
	End if 
	NEXT RECORD:C51([Familia:78])
End while 

QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3="";*)
QUERY:C277([Familia:78]; | [Familia:78]Nombre_de_la_familia:3=" ")
KRL_DeleteSelection (->[Familia:78];False:C215)

ALL RECORDS:C47([Alumnos:2])
While (Not:C34(End selection:C36([Alumnos:2])))
	$fName:=ST_ClearSpaces ([Alumnos:2]Apellido_paterno:3+" "+[Alumnos:2]Apellido_materno:4)
	QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
	If (Records in selection:C76([Familia:78])=0)
		QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=$fName)
		Case of 
			: (Records in selection:C76([Familia:78])>1)
				QUERY SELECTION:C341([Familia:78];[Familia:78]Dirección:7=[Alumnos:2]Direccion:12)
			: (Records in selection:C76([Familia:78])=0)
				If ([Alumnos:2]Apoderado_académico_Número:27#0)
					QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Alumnos:2]Apoderado_académico_Número:27)
				End if 
		End case 
		If (Records in selection:C76([Familia:78])=0)
			CREATE RECORD:C68([Familia:78])
			[Familia:78]Numero:1:=SQ_SeqNumber (->[Familia:78]Numero:1)
			[Familia:78]Nombre_de_la_familia:3:=$fName
			[Familia:78]Dirección:7:=[Alumnos:2]Direccion:12
			[Familia:78]Comuna:8:=[Alumnos:2]Comuna:14
			[Familia:78]Ciudad:9:=[Alumnos:2]Ciudad:15
			[Familia:78]Telefono:10:=[Alumnos:2]Telefono:17
			SAVE RECORD:C53([Familia:78])
		End if 
		If (Records in selection:C76([Familia:78])=1)
			[Alumnos:2]Familia_Número:24:=[Familia:78]Numero:1
			If ([Familia:78]Madre_Número:6#0)
				QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
				If ([Familia:78]Madre_Nombre:16#[Personas:7]Apellidos_y_nombres:30)
					[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
					SAVE RECORD:C53([Familia:78])
				End if 
			End if 
			If ([Familia:78]Padre_Número:5#0)
				QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
				If ([Familia:78]Padre_Nombre:15#[Personas:7]Apellidos_y_nombres:30)
					[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
					SAVE RECORD:C53([Familia:78])
				End if 
			End if 
		End if 
	End if 
	If ([Alumnos:2]Familia_Número:24#Old:C35([Alumnos:2]Familia_Número:24))
		SAVE RECORD:C53([Alumnos:2])
	End if 
	NEXT RECORD:C51([Alumnos:2])
End while 


CREATE EMPTY SET:C140([Familia_RelacionesFamiliares:77];"X")
ALL RECORDS:C47([Familia_RelacionesFamiliares:77])
While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
	QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
	If (Records in selection:C76([Familia:78])=0)
		QUERY:C277([Familia:78];[Familia:78]Padre_Número:5=[Familia_RelacionesFamiliares:77]ID_Persona:3;*)
		QUERY:C277([Familia:78]; | [Familia:78]Madre_Número:6=[Familia_RelacionesFamiliares:77]ID_Persona:3)
		If (Records in selection:C76([Familia:78])=0)
			QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
			If (Records in selection:C76([Familia:78])=1)
				QUERY:C277([Familia:78];[Familia:78]Nombre_de_la_familia:3=([Personas:7]Apellido_paterno:3+"@");*)
				QUERY:C277([Familia:78]; & [Familia:78]Dirección:7=[Personas:7]Direccion:14)
			End if 
		End if 
		If (Records in selection:C76([Familia:78])=1)
			[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Familia:78]Numero:1
			SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		Else 
			ADD TO SET:C119([Familia_RelacionesFamiliares:77];"X")
		End if 
	End if 
	NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
End while 

USE SET:C118("X")
READ WRITE:C146([Familia_RelacionesFamiliares:77])
DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])

QUERY:C277([Familia:78];[Familia:78]Madre_Número:6;=;0;*)
QUERY:C277([Familia:78]; | ;[Familia:78]Padre_Número:5;=;0)
KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Familia_RelacionesFamiliares:77];$aRecNums;"")
For ($I;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$aRecNums{$i})
	QUERY:C277([Personas:7];[Personas:7]No:1=[Familia_RelacionesFamiliares:77]ID_Persona:3)
	Case of 
		: (([Familia_RelacionesFamiliares:77]Tipo_Relación:4=1) | ([Familia_RelacionesFamiliares:77]Parentesco:6="Madre"))
			QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
			If ([Familia:78]Madre_Número:6#[Familia_RelacionesFamiliares:77]ID_Persona:3)
				[Familia:78]Madre_Número:6:=[Familia_RelacionesFamiliares:77]ID_Persona:3
				[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
				SAVE RECORD:C53([Familia:78])
			End if 
		: (([Familia_RelacionesFamiliares:77]Tipo_Relación:4=2) | ([Familia_RelacionesFamiliares:77]Parentesco:6="Padre"))
			QUERY:C277([Familia:78];[Familia:78]Numero:1=[Familia_RelacionesFamiliares:77]ID_Familia:2)
			If ([Familia:78]Padre_Número:5#[Familia_RelacionesFamiliares:77]ID_Persona:3)
				[Familia:78]Padre_Número:5:=[Familia_RelacionesFamiliares:77]ID_Persona:3
				[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
				SAVE RECORD:C53([Familia:78])
			End if 
	End case 
End for 


CREATE EMPTY SET:C140([Familia_RelacionesFamiliares:77];"X")
ALL RECORDS:C47([Familia_RelacionesFamiliares:77])
$lastRelationRef:=""
ORDER BY:C49([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2;>;[Familia_RelacionesFamiliares:77]ID_Persona:3;>;[Familia_RelacionesFamiliares:77]Tipo_Relación:4;>;[Familia_RelacionesFamiliares:77]Parentesco:6;>)
While (Not:C34(End selection:C36([Familia_RelacionesFamiliares:77])))
	$currentRelationRef:=String:C10([Familia_RelacionesFamiliares:77]ID_Familia:2)+"."+String:C10([Familia_RelacionesFamiliares:77]ID_Persona:3)+"."+String:C10([Familia_RelacionesFamiliares:77]Tipo_Relación:4)+"."+[Familia_RelacionesFamiliares:77]Parentesco:6
	If ($currentRelationRef=$lastRelationRef)
		ADD TO SET:C119([Familia_RelacionesFamiliares:77];"X")
	End if 
	$lastRelationRef:=$currentRelationRef
	NEXT RECORD:C51([Familia_RelacionesFamiliares:77])
End while 
USE SET:C118("X")
READ WRITE:C146([Familia_RelacionesFamiliares:77])
DELETE SELECTION:C66([Familia_RelacionesFamiliares:77])

IT_UThermometer (-2;$Process)
dbu_CountFamilyStudents 

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Familia:78])
READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia_RelacionesFamiliares:77])