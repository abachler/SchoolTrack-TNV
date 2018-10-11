//%attributes = {}
  //PST_SetConnexions

C_LONGINT:C283($1;$recNum)
SAVE RECORD:C53([Alumnos:2])
COPY NAMED SELECTION:C331([Alumnos:2];"mySel")

$recNum:=Record number:C243([Alumnos:2])
$brothersInSchool:=0
$brothersOldStudents:=0
$needToBeSaved:=False:C215
If ($recNum>=0)
	$id:=[Alumnos:2]numero:1
	$FamID:=[Alumnos:2]Familia_Número:24
	If ($FamID#0)
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=$famID;*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]numero:1#$id)
		ORDER BY:C49([Alumnos:2]nivel_numero:29;>)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aBthrName;[Alumnos:2]curso:20;aBthrCurso;[Alumnos:2]numero:1;aBthrID;[Alumnos:2]nivel_numero:29;$aNivel)
		
		GOTO RECORD:C242([Alumnos:2];$recNum)
		For ($i;1;Size of array:C274($aNivel))
			Case of 
				: (($aNivel{$i}>=-1) & ($aNivel{$i}<=12))
					$brothersInSchool:=$brothersInSchool+1
					  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
					  //If (Records in subselection([Alumnos]Conexiones)=0)
					  //CREATE SUBRECORD([Alumnos]Conexiones)
					  //[Alumnos]Conexiones'Conexion:="Hermano en el colegio"
					  //[Alumnos]Hermano_en_Colegio:=True
					  //$needToBeSaved:=True
					  //End if 
					
					QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
					QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano en el colegio")
					
					If (Records in selection:C76([Alumnos_Conexiones:212])=0)
						READ WRITE:C146([Alumnos_Conexiones:212])
						CREATE RECORD:C68([Alumnos_Conexiones:212])
						[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
						[Alumnos_Conexiones:212]Conexion:1:="Hermano en el colegio"
						SAVE RECORD:C53([Alumnos_Conexiones:212])
						KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
					End if 
					
				: ($aNivel{$i}>12)
					$brothersOldStudents:=$brothersOldStudents+1
					  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano de ex alumno")
					  //If (Records in subselection([Alumnos]Conexiones)=0)
					  //CREATE SUBRECORD([Alumnos]Conexiones)
					  //[Alumnos]Conexiones'Conexion:="Hermano de ex alumno"
					  //[Alumnos]Hermano_ex_alumno:=True
					  //$needToBeSaved:=True
					  //End if 
					QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
					QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano de ex alumno")
					
					If (Records in selection:C76([Alumnos_Conexiones:212])=0)
						READ WRITE:C146([Alumnos_Conexiones:212])
						CREATE RECORD:C68([Alumnos_Conexiones:212])
						[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
						[Alumnos_Conexiones:212]Conexion:1:="Hermano de ex alumno"
						SAVE RECORD:C53([Alumnos_Conexiones:212])
						KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
					End if 
					
			End case 
		End for 
	End if 
	
	If ($brothersInSchool=0)
		  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
		  //While (Records in subselection([Alumnos]Conexiones)>0)
		  //DELETE SUBRECORD([Alumnos]Conexiones)
		  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
		  //$needToBeSaved:=True
		  //End while 
		READ WRITE:C146([Alumnos_Conexiones:212])
		QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
		QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano en el colegio")
		DELETE SELECTION:C66([Alumnos_Conexiones:212])
		KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
		$needToBeSaved:=True:C214
		[Alumnos:2]Hermano_en_Colegio:64:=False:C215
	End if 
	If ($brothersOldStudents=0)
		  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano de ex alumno")
		  //While (Records in subselection([Alumnos]Conexiones)>0)
		  //DELETE SUBRECORD([Alumnos]Conexiones)
		  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano de ex alumno")
		  //$needToBeSaved:=True
		  //End while 
		READ WRITE:C146([Alumnos_Conexiones:212])
		QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
		QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hermano de ex alumno")
		DELETE SELECTION:C66([Alumnos_Conexiones:212])
		KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
		$needToBeSaved:=True:C214
		[Alumnos:2]Hermano_ex_alumno:65:=False:C215
	End if 
End if 

If ($needToBeSaved)
	SAVE RECORD:C53([Alumnos:2])
End if 

If ((viPST_exMOTHER=1) | (viPST_exFATHER=1))
	  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hijo de ex alumno")
	  //If (Records in subselection([Alumnos]Conexiones)=0)
	  //CREATE SUBRECORD([Alumnos]Conexiones)
	  //[Alumnos]Conexiones'Conexion:="Hijo de ex alumno"
	  //[Alumnos]Hijo_ex_Alumno:=True
	  //SAVE RECORD([Alumnos])
	  //End if 
	
	QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
	QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hijo de ex alumno")
	If (Records in selection:C76([Alumnos_Conexiones:212])=0)
		READ WRITE:C146([Alumnos_Conexiones:212])
		CREATE RECORD:C68([Alumnos_Conexiones:212])
		[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
		[Alumnos_Conexiones:212]Conexion:1:="Hijo de ex alumno"
		SAVE RECORD:C53([Alumnos_Conexiones:212])
		KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
	End if 
	
Else 
	
	  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hijo de ex alumno")
	  //While (Records in subselection([Alumnos]Conexiones)>0)
	  //DELETE SUBRECORD([Alumnos]Conexiones)
	  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hijo de ex alumno")
	  //End while 
	READ WRITE:C146([Alumnos_Conexiones:212])
	QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
	QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1="Hijo de ex alumno")
	DELETE SELECTION:C66([Alumnos_Conexiones:212])
	KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
	
	[Alumnos:2]Hijo_ex_Alumno:66:=False:C215
	SAVE RECORD:C53([Alumnos:2])
	
End if 

USE NAMED SELECTION:C332("MySel")
CLEAR NAMED SELECTION:C333("mySel")

AL_UpdateArrays (xALP_Connexions;0)

ARRAY TEXT:C222(at_auto_uuid_a_eliminar;0)
ARRAY BOOLEAN:C223(ab_conexionnueva;0)
ARRAY TEXT:C222(at_auto_uuid;0)
ARRAY TEXT:C222(at_Connexions;0)
  //ALL SUBRECORDS([Alumnos]Conexiones)
  //SF_Subtable2Array (->[Alumnos]Conexiones;->[Alumnos]Conexiones'Conexion;->at_Connexions)
READ ONLY:C145([Alumnos_Conexiones:212])
QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;at_Connexions;[Alumnos_Conexiones:212]Auto_UUID:6;at_auto_uuid)
ARRAY BOOLEAN:C223(ab_conexionnueva;Size of array:C274(at_Connexions))
AL_UpdateArrays (xALP_Connexions;-2)
AL_SetLine (xALP_Connexions;0)
_O_DISABLE BUTTON:C193(bDelConnexion)
vb_ConnectionsModified:=True:C214