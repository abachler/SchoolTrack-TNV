//%attributes = {}
  //AL_LoadBrothers

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procdure : AL_LoadBrothers
	  //Autor: Alberto Bachler
	  //Creada el 30/6/96 a 4:00 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripci—n:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripci—n:
End if 
C_TEXT:C284($tipoConexion)
C_LONGINT:C283($1;$recNum)
$recNum:=Record number:C243([Alumnos:2])
$id:=[Alumnos:2]numero:1
$FamID:=[Alumnos:2]Familia_Número:24
$ApdoCta:=[Alumnos:2]Apoderado_Cuentas_Número:28
If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
	If ($ApdoCta#0)
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29;>=;Nivel_AdmisionDirecta*1;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29;<;Nivel_Egresados*1;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Apoderado_Cuentas_Número:28=$ApdoCta;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$id)
	End if 
Else 
	If ($famID#0)
		QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=$famID;*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]numero:1#$id)
	End if 
End if 
ORDER BY:C49([Alumnos:2]nivel_numero:29;>)

SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aBthrName;[Alumnos:2]curso:20;aBthrCurso;[Alumnos:2]numero:1;aBthrID;[Alumnos:2]nivel_numero:29;$aNivel)
ARRAY LONGINT:C221(aBrotherNumber;Size of array:C274(aBthrID))
READ ONLY:C145([ACT_CuentasCorrientes:175])
For ($i;1;Size of array:C274(aBthrID))
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=aBthrID{$i})
	aBrotherNumber{$i}:=[ACT_CuentasCorrientes:175]Numero_Hijo:10
End for 
$thisone:=Find in array:C230(aBthrID;$id)
If ($thisone#-1)
	AT_Delete ($thisone;1;->aBthrName;->aBthrCurso;->aBthrID;->aBrotherNumber)
End if 
SORT ARRAY:C229(aBrotherNumber;aBthrName;aBthrCurso;aBthrID;>)
  //$needToBeSaved:=False
GOTO RECORD:C242([Alumnos:2];$recNum)
For ($i;1;Size of array:C274($aNivel))
	$enNivelRegular:=(Find in array:C230(<>al_NumeroNivelRegular;$aNivel{$i})>0)
	
	Case of 
		: ($enNivelRegular)
			$tipoConexion:="Hermano en el colegio"
			  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano en el colegio")
			  //If (Records in subselection([Alumnos]Conexiones)=0)
			  //CREATE SUBRECORD([Alumnos]Conexiones)
			  //[Alumnos]Conexiones'Conexion:="Hermano en el colegio"
			  //$needToBeSaved:=True
			  //End if 
		: ($aNivel{$i}>=Nivel_Egresados)
			$tipoConexion:="Hermano de ex alumno"
			  //QUERY SUBRECORDS([Alumnos]Conexiones;[Alumnos]Conexiones'Conexion="Hermano de ex alumno")
			  //If (Records in subselection([Alumnos]Conexiones)=0)
			  //CREATE SUBRECORD([Alumnos]Conexiones)
			  //[Alumnos]Conexiones'Conexion:="Hermano de ex alumno"
			  //[Alumnos]Hermano_ex_alumno:=True
			  //$needToBeSaved:=True
			  //End if 
	End case 
	If ($tipoConexion#"")
		QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72;*)
		QUERY:C277([Alumnos_Conexiones:212]; & ;[Alumnos_Conexiones:212]Conexion:1=$tipoConexion)
		
		If (Records in selection:C76([Alumnos_Conexiones:212])=0)
			READ WRITE:C146([Alumnos_Conexiones:212])
			CREATE RECORD:C68([Alumnos_Conexiones:212])
			[Alumnos_Conexiones:212]Alumno_AutoUUID:7:=[Alumnos:2]auto_uuid:72
			[Alumnos_Conexiones:212]Conexion:1:=$tipoConexion
			SAVE RECORD:C53([Alumnos_Conexiones:212])
			KRL_UnloadReadOnly (->[Alumnos_Conexiones:212])
		End if 
	End if 
End for 
  //If ($needToBeSaved)
  //SAVE RECORD([Alumnos])
  //End if 
