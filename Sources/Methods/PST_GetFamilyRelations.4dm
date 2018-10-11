//%attributes = {}
  //PST_GetFamilyRelations

vsPST_LinkedFamilyName:=""
vsPST_aPaternoMOTHER:=""
vsPST_aMaternoMOTHER:=""
vsPST_NombresMOTHER:=""
vdPST_fNacMOTHER:=!00-00-00!
vsPST_ProfesionMOTHER:=""
vsPST_TelPersMOTHER:=""
vsPST_TelProMOTHER:=""
vsPST_TelCelMOTHER:=""
vsPST_TelCelFather:=""
vsPST_aPaternoFather:=""
vsPST_aMaternoFather:=""
vsPST_NombresFather:=""
vdPST_fNacFather:=!00-00-00!
vsPST_ProfesionFather:=""
vsPST_TelPersFather:=""
vsPST_TelProFather:=""
viPST_FATHERRecNum:=-1
viPST_MOTHERRecNum:=-1
vi_FmySmnu:=0
viPST_MotherAC:=0
viPST_MotherAA:=0
vtPST_MotherNacionalidad:=""
viPST_FatherAC:=0
viPST_FatherAA:=0
vtPST_FatherNacionalidad:=""
vsPST_RUTMOTHER:=""
vsPST_IDN2MOTHER:=""
vsPST_IDN3MOTHER:=""
vsPST_PasMOTHER:=""
vsPST_CodMOTHER:=""
vsPST_RUTFATHER:=""
vsPST_IDN2FATHER:=""
vsPST_IDN3FATHER:=""
vsPST_PasFATHER:=""
vsPST_CodFATHER:=""
If (vlPST_LinkedFamilyRec>=0)
	READ WRITE:C146([Familia:78])
	GOTO RECORD:C242([Familia:78];vlPST_LinkedFamilyRec)
	vlPST_LinkedFamilyRec:=Record number:C243([Familia:78])
	vsPST_LinkedFamilyName:=[Familia:78]Nombre_de_la_familia:3
	READ ONLY:C145([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
	vsPST_aPaternoMOTHER:=[Personas:7]Apellido_paterno:3
	vsPST_aMaternoMOTHER:=[Personas:7]Apellido_materno:4
	vsPST_NombresMOTHER:=[Personas:7]Nombres:2
	vdPST_fNacMOTHER:=[Personas:7]Fecha_de_nacimiento:5
	vsPST_ProfesionMOTHER:=[Personas:7]Profesion:13
	vsPST_TelPersMOTHER:=[Personas:7]Telefono_domicilio:19
	vsPST_TelProMOTHER:=[Personas:7]Telefono_profesional:29
	vsPST_TelCelMOTHER:=[Personas:7]Celular:24
	viPST_exMOTHER:=Num:C11([Personas:7]Es_ExAlumno:12)
	viPST_MotherRecNum:=Record number:C243([Personas:7])
	If ([Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
		viPST_MotherAC:=1
		viPST_FatherAC:=0
	End if 
	If ([Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1)
		viPST_MotherAA:=1
		viPST_FatherAA:=0
	End if 
	vsPST_RUTMOTHER:=[Personas:7]RUT:6
	vsPST_IDN2MOTHER:=[Personas:7]IDNacional_2:37
	vsPST_IDN3MOTHER:=[Personas:7]IDNacional_3:38
	vsPST_PasMOTHER:=[Personas:7]Pasaporte:59
	vsPST_CodMOTHER:=[Personas:7]Codigo_interno:22
	vtPST_MotherNacionalidad:=[Personas:7]Nacionalidad:7
	vlPST_IDMOTHER:=[Personas:7]No:1
	UNLOAD RECORD:C212([Personas:7])
	QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
	vsPST_aPaternoFather:=[Personas:7]Apellido_paterno:3
	vsPST_aMaternoFather:=[Personas:7]Apellido_materno:4
	vsPST_NombresFather:=[Personas:7]Nombres:2
	vdPST_fNacFather:=[Personas:7]Fecha_de_nacimiento:5
	vsPST_ProfesionFather:=[Personas:7]Profesion:13
	vsPST_TelPersFather:=[Personas:7]Telefono_domicilio:19
	vsPST_TelProFather:=[Personas:7]Telefono_profesional:29
	vsPST_TelCelFather:=[Personas:7]Celular:24
	viPST_exFATHER:=Num:C11([Personas:7]Es_ExAlumno:12)
	viPST_FatherRecNum:=Record number:C243([Personas:7])
	If ([Alumnos:2]Apoderado_Cuentas_Número:28=[Personas:7]No:1)
		viPST_MotherAC:=0
		viPST_FatherAC:=1
	End if 
	If ([Alumnos:2]Apoderado_académico_Número:27=[Personas:7]No:1)
		viPST_MotherAA:=0
		viPST_FatherAA:=1
	End if 
	vsPST_RUTFATHER:=[Personas:7]RUT:6
	vsPST_IDN2FATHER:=[Personas:7]IDNacional_2:37
	vsPST_IDN3FATHER:=[Personas:7]IDNacional_3:38
	vsPST_PasFATHER:=[Personas:7]Pasaporte:59
	vsPST_CodFATHER:=[Personas:7]Codigo_interno:22
	vtPST_FatherNacionalidad:=[Personas:7]Nacionalidad:7
	vlPST_IDFATHER:=[Personas:7]No:1
	vi_FmySmnu:=0
	UNLOAD RECORD:C212([Personas:7])
	$recNum:=Selected record number:C246([Alumnos:2])
	[ADT_Candidatos:49]Padre_nombre:33:=[Familia:78]Padre_Nombre:15
	[ADT_Candidatos:49]Madre_nombre:34:=[Familia:78]Madre_Nombre:16
	OBJECT SET ENTERABLE:C238(*;"mother@";True:C214)
	OBJECT SET ENTERABLE:C238(*;"father@";True:C214)
	
	  //MONO si hay familia no permitir los cambios de nombres de los padres ya que genera otra persona y ha generado perdidas de deudas en ACT.
	If (vsPST_aPaternoMOTHER#"")
		OBJECT SET ENTERABLE:C238(*;"mother1";False:C215)
	End if 
	If (vsPST_aMaternoMOTHER#"")
		OBJECT SET ENTERABLE:C238(*;"mother2";False:C215)
	End if 
	If (vsPST_NombresMOTHER#"")
		OBJECT SET ENTERABLE:C238(*;"mother3";False:C215)
	End if 
	
	If (vsPST_aPaternoFather#"")
		OBJECT SET ENTERABLE:C238(*;"father1";False:C215)
	End if 
	If (vsPST_aMaternoFather#"")
		OBJECT SET ENTERABLE:C238(*;"father2";False:C215)
	End if 
	If (vsPST_NombresFather#"")
		OBJECT SET ENTERABLE:C238(*;"father3";False:C215)
	End if 
	
	OBJECT SET VISIBLE:C603(*;"popmother@";True:C214)
	OBJECT SET VISIBLE:C603(*;"popfather@";True:C214)
	IT_SetButtonState ((viPST_FatherRecNum>0);->viPST_exFATHER;->bDetailFATHER;->bDelFather;->viPST_FatherAC;->viPST_FatherAA)
	IT_SetButtonState ((viPST_MOTHERRecNum>0);->viPST_exMOTHER;->bDetailMOTHER;->bDelMother;->viPST_MotherAC;->viPST_MotherAA)
	IT_SetButtonState (True:C214;->bDelFamily)
Else 
	REDUCE SELECTION:C351([Familia:78];0)
	OBJECT SET ENTERABLE:C238(*;"mother@";False:C215)
	OBJECT SET ENTERABLE:C238(*;"father@";False:C215)
	OBJECT SET VISIBLE:C603(*;"popmother@";False:C215)
	OBJECT SET VISIBLE:C603(*;"popfather@";False:C215)
	IT_SetButtonState (False:C215;->viPST_exMOTHER;->bDetailMother;->viPST_exFATHER;->bDetailFATHER;->bDelFather;->bDelMother;->bDelFamily;->viPST_FatherAC;->viPST_MotherAC;->viPST_FatherAA;->viPST_MotherAA)
End if 
If (vtPST_MotherNacionalidad="")
	Case of 
		: (<>vtXS_CountryCode="cl")
			vtPST_MotherNacionalidad:="Chilena"
		: (<>vtXS_CountryCode="co")
			vtPST_MotherNacionalidad:="Colombiana"
	End case 
End if 
If (vtPST_FatherNacionalidad="")
	Case of 
		: (<>vtXS_CountryCode="cl")
			vtPST_FatherNacionalidad:="Chilena"
		: (<>vtXS_CountryCode="co")
			vtPST_FatherNacionalidad:="Colombiana"
	End case 
End if 
AL_UpdateArrays (xALP_Connexions;0)
ARRAY TEXT:C222(at_Connexions;0)
ARRAY TEXT:C222(at_auto_uuid_a_eliminar;0)
ARRAY BOOLEAN:C223(ab_conexionnueva;0)
ARRAY TEXT:C222(at_auto_uuid;0)
QUERY:C277([Alumnos_Conexiones:212];[Alumnos_Conexiones:212]Alumno_AutoUUID:7=[Alumnos:2]auto_uuid:72)
SELECTION TO ARRAY:C260([Alumnos_Conexiones:212]Conexion:1;at_Connexions;[Alumnos_Conexiones:212]Auto_UUID:6;at_auto_uuid)
ARRAY BOOLEAN:C223(ab_conexionnueva;Size of array:C274(at_Connexions))
  //ALL SUBRECORDS([Alumnos]Conexiones)
  //SF_Subtable2Array (->[Alumnos]Conexiones;->[Alumnos]Conexiones'Conexion;->at_Connexions)
AL_UpdateArrays (xALP_Connexions;-2)