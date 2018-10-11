//%attributes = {}
  //PST_UpdateParents

READ WRITE:C146([Personas:7])
If (Read only state:C362([Familia:78]))  //mono 28-09-2011 si lo recarga innecesariamente pierde lo han ingresado via formulario si no se ha guardado 
	KRL_ReloadInReadWriteMode (->[Familia:78])
End if 

Case of 
	: ($1="Mother")
		
		If (viPST_MotherRecNum>=0)
			GOTO RECORD:C242([Personas:7];viPST_MotherRecNum)
		Else 
			CREATE RECORD:C68([Personas:7])
			[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
		End if 
		
		[Personas:7]Apellido_paterno:3:=vsPST_aPaternoMOTHER
		[Personas:7]Apellido_materno:4:=vsPST_aMaternoMOTHER
		[Personas:7]Nombres:2:=vsPST_NombresMOTHER
		[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
		[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
		[Personas:7]Fecha_de_nacimiento:5:=vdPST_fNacMOTHER
		[Personas:7]Profesion:13:=vsPST_ProfesionMOTHER
		[Personas:7]Telefono_domicilio:19:=vsPST_TelPersMOTHER
		[Personas:7]Telefono_profesional:29:=vsPST_TelProMOTHER
		[Personas:7]Celular:24:=vsPST_TelCelMOTHER
		[Personas:7]Es_ExAlumno:12:=(viPST_exMOTHER=1)
		[Personas:7]RUT:6:=vsPST_RUTMOTHER
		[Personas:7]IDNacional_2:37:=vsPST_IDN2MOTHER
		[Personas:7]IDNacional_3:38:=vsPST_IDN3MOTHER
		[Personas:7]Pasaporte:59:=vsPST_PasMOTHER
		[Personas:7]Codigo_interno:22:=vsPST_CodMOTHER
		[Familia:78]Madre_Número:6:=[Personas:7]No:1
		[Familia:78]Madre_Nombre:16:=[Personas:7]Apellidos_y_nombres:30
		If ([Familia:78]Es_Postulante:18)
			[Personas:7]Temp_postulante:33:=True:C214
		End if 
		SAVE RECORD:C53([Personas:7])
		viPST_MotherRecNum:=Record number:C243([Personas:7])
		KRL_UnloadReadOnly (->[Personas:7])
		SAVE RECORD:C53([Familia:78])
		
		[ADT_Candidatos:49]Familia_numero:30:=[Familia:78]Numero:1
		[ADT_Candidatos:49]Madre_numero:32:=[Familia:78]Madre_Número:6
		[ADT_Candidatos:49]Madre_nombre:34:=[Familia:78]Madre_Nombre:16
		
		READ WRITE:C146([Familia_RelacionesFamiliares:77])
		GOTO RECORD:C242([Personas:7];viPST_MotherRecNum)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]Tipo_Relación:4=1;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#[Personas:7]No:1)
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=0
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
		
		READ WRITE:C146([Familia_RelacionesFamiliares:77])
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
		If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
			CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
			[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Alumnos:2]Familia_Número:24
			[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
		End if 
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=1
		[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{1}
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		UNLOAD RECORD:C212([Familia_RelacionesFamiliares:77])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		
	: ($1="Father")
		
		If (viPST_FATHERRecNum>=0)
			GOTO RECORD:C242([Personas:7];viPST_FATHERRecNum)
		Else 
			CREATE RECORD:C68([Personas:7])
			[Personas:7]No:1:=SQ_SeqNumber (->[Personas:7]No:1)
		End if 
		
		[Personas:7]Apellido_paterno:3:=vsPST_aPaternoFATHER
		[Personas:7]Apellido_materno:4:=vsPST_aMaternoFATHER
		[Personas:7]Nombres:2:=vsPST_NombresFATHER
		[Personas:7]Apellidos_y_nombres:30:=Replace string:C233([Personas:7]Apellido_paterno:3+" "+[Personas:7]Apellido_materno:4+" "+[Personas:7]Nombres:2;"  ";" ")
		[Personas:7]Apellidos_y_nombres:30:=ST_Format (->[Personas:7]Apellidos_y_nombres:30)
		[Personas:7]Fecha_de_nacimiento:5:=vdPST_fNacFATHER
		[Personas:7]Profesion:13:=vsPST_ProfesionFATHER
		[Personas:7]Telefono_domicilio:19:=vsPST_TelPersFATHER
		[Personas:7]Telefono_profesional:29:=vsPST_TelProFATHER
		[Personas:7]Celular:24:=vsPST_TelCelFATHER
		[Personas:7]Es_ExAlumno:12:=(viPST_exFATHER=1)
		[Personas:7]RUT:6:=vsPST_RUTFATHER
		[Personas:7]IDNacional_2:37:=vsPST_IDN2FATHER
		[Personas:7]IDNacional_3:38:=vsPST_IDN3FATHER
		[Personas:7]Pasaporte:59:=vsPST_PasFATHER
		[Personas:7]Codigo_interno:22:=vsPST_CodFATHER
		[Familia:78]Padre_Número:5:=[Personas:7]No:1
		[Familia:78]Padre_Nombre:15:=[Personas:7]Apellidos_y_nombres:30
		If ([Familia:78]Es_Postulante:18)
			[Personas:7]Temp_postulante:33:=True:C214
		End if 
		SAVE RECORD:C53([Personas:7])
		viPST_FATHERRecNum:=Record number:C243([Personas:7])
		KRL_UnloadReadOnly (->[Personas:7])
		
		SAVE RECORD:C53([Familia:78])
		
		If ([Familia:78]Es_Postulante:18)
			[ADT_Candidatos:49]Es_familia_nueva:27:=True:C214
		End if 
		[ADT_Candidatos:49]Familia_numero:30:=[Familia:78]Numero:1
		[ADT_Candidatos:49]Padre_numero:31:=[Familia:78]Padre_Número:5
		[ADT_Candidatos:49]Padre_nombre:33:=[Familia:78]Padre_Nombre:15
		
		READ WRITE:C146([Familia_RelacionesFamiliares:77])
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]Tipo_Relación:4=2;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3#[Personas:7]No:1)
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=0
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		
		KRL_UnloadReadOnly (->[Familia_RelacionesFamiliares:77])
		READ WRITE:C146([Familia_RelacionesFamiliares:77])
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
		QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
		If (Records in selection:C76([Familia_RelacionesFamiliares:77])=0)
			CREATE RECORD:C68([Familia_RelacionesFamiliares:77])
			[Familia_RelacionesFamiliares:77]ID_Familia:2:=[Alumnos:2]Familia_Número:24
			[Familia_RelacionesFamiliares:77]ID_Persona:3:=[Personas:7]No:1
		End if 
		[Familia_RelacionesFamiliares:77]Tipo_Relación:4:=2
		[Familia_RelacionesFamiliares:77]Parentesco:6:=<>aParentesco{2}
		SAVE RECORD:C53([Familia_RelacionesFamiliares:77])
		UNLOAD RECORD:C212([Familia_RelacionesFamiliares:77])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		
End case 
KRL_ReloadAsReadOnly (->[Personas:7])