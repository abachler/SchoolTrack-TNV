  // [STR_Medicos].Input.boton()
  // Por: Alberto Bachler K.: 27-06-14, 15:53:42
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		Case of 
			: (OBJECT Get enabled:C1079(*;OBJECT Get name:C1087(Object current:K67:2)))
				IT_MuestraTip (__ ("Asignar el médico seleccionado al alumno"))
			: (Records in set:C195("seleccionMedico")=0)
				IT_MuestraTip (__ ("Asignar el médico seleccionado")+" "+__ ("(inactivo porque no hay médico seleccionado)"))
			Else 
				IT_MuestraTip (__ ("Eliminar el médico seleccionado")+" "+__ ("(inactivo porque el médico ya está asignado al alumno)"))
		End case 
		
	: (Form event:C388=On Clicked:K2:4)
		USE SET:C118("seleccionMedico")
		QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3=[STR_Medicos:89]Auto_UUID:6;*)
		QUERY:C277([xxSTR_Link_AlumnosMedicos:237]; & ;[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
		If (Records in selection:C76([xxSTR_Link_AlumnosMedicos:237])=0)
			CREATE RECORD:C68([xxSTR_Link_AlumnosMedicos:237])
			[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3:=[STR_Medicos:89]Auto_UUID:6
			[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2:=[Alumnos:2]auto_uuid:72
			SAVE RECORD:C53([xxSTR_Link_AlumnosMedicos:237])
		End if 
		KRL_UnloadReadOnly (->[xxSTR_Link_AlumnosMedicos:237])
		KRL_UnloadReadOnly (->[STR_Medicos:89])
		ACCEPT:C269
End case 

