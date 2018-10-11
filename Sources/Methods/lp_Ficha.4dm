//%attributes = {}
  //lp_Ficha

Case of 
	: (Form event:C388=On Header:K2:17)
		
	: (_O_During:C30)
		tPblSalud:=""
		bapAc1:=0
		bapCta1:=0
		sFather:=""
		sRut1:=""
		sEmp1:=""
		sProf1:=""
		sTel1:=""
		sCargo1:=""
		sAdr1:=""
		bapAc2:=0
		bapCta2:=0
		smother:=""
		sRut2:=""
		sEmp2:=""
		sProf2:=""
		sTel2:=""
		sCargo2:=""
		sAdr2:=""
		bapAc3:=0
		bapCta3:=0
		sApdoAc:=""
		sRut3:=""
		sEmp3:=""
		sProf3:=""
		sTel3:=""
		sCargo3:=""
		sAdr3:=""
		bapAc4:=0
		bapCta4:=0
		sApdoCta:=""
		sRut4:=""
		sEmp4:=""
		sProf4:=""
		sTel4:=""
		sCargo4:=""
		sAdr4:=""
		sparent1:=""
		sparent2:=""
		sTelDom1:=""
		sTelDom2:=""
		sTelDom3:=""
		sTelDom4:=""
		sFechaNac1:=""
		sFechaNac2:=""
		sFechaNac3:=""
		sFechaNac4:=""
		sCelular1:=""
		sCelular2:=""
		sCelular3:=""
		sCelular4:=""
		sEmail1:=""
		sEmail2:=""
		sEmail3:=""
		sEmail4:=""
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Padre_Número:5)
		If (Records in selection:C76([Personas:7])#0)
			sFather:=[Personas:7]Apellidos_y_nombres:30
			sRut1:=[Personas:7]RUT:6
			sEmp1:=[Personas:7]Empresa:20
			sProf1:=[Personas:7]Profesion:13
			sTel1:=[Personas:7]Telefono_profesional:29
			sCargo1:=[Personas:7]Cargo:21
			sAdr1:=[Personas:7]Direccion:14+", "+[Personas:7]Comuna:16
			sTelDom1:=[Personas:7]Telefono_domicilio:19
			sCelular1:=[Personas:7]Celular:24
			sEmail1:=[Personas:7]eMail:34
			If ([Personas:7]Fecha_de_nacimiento:5#!00-00-00!)
				sFechaNac1:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
			End if 
			If ([Familia:78]Padre_Número:5=[Alumnos:2]Apoderado_académico_Número:27)
				bapAc1:=1
			End if 
			If ([Familia:78]Padre_Número:5=[Alumnos:2]Apoderado_Cuentas_Número:28)
				bapCta1:=1
			End if 
		End if 
		
		QUERY:C277([Personas:7];[Personas:7]No:1=[Familia:78]Madre_Número:6)
		If (Records in selection:C76([Personas:7])#0)
			sMother:=[Personas:7]Apellidos_y_nombres:30
			sRut2:=[Personas:7]RUT:6
			sEmp2:=[Personas:7]Empresa:20
			sProf2:=[Personas:7]Profesion:13
			sTel2:=[Personas:7]Telefono_profesional:29
			sCargo2:=[Personas:7]Cargo:21
			sAdr2:=[Personas:7]Direccion:14+", "+[Personas:7]Comuna:16
			sTelDom2:=[Personas:7]Telefono_domicilio:19
			sCelular2:=[Personas:7]Celular:24
			sEmail2:=[Personas:7]eMail:34
			If ([Personas:7]Fecha_de_nacimiento:5#!00-00-00!)
				sFechaNac2:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
			End if 
			If ([Familia:78]Madre_Número:6=[Alumnos:2]Apoderado_académico_Número:27)
				bapAc2:=1
			End if 
			If ([Familia:78]Madre_Número:6=[Alumnos:2]Apoderado_Cuentas_Número:28)
				bapCta2:=1
			End if 
		End if 
		
		
		If (([Alumnos:2]Apoderado_académico_Número:27#[Familia:78]Madre_Número:6) & ([Alumnos:2]Apoderado_académico_Número:27#[Familia:78]Padre_Número:5))
			QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_académico_Número:27)
			If (Records in selection:C76([Personas:7])#0)
				sApdoAc:=[Personas:7]Apellidos_y_nombres:30
				sRut3:=[Personas:7]RUT:6
				sEmp3:=[Personas:7]Empresa:20
				sProf3:=[Personas:7]Profesion:13
				sTel3:=[Personas:7]Telefono_profesional:29
				sCargo3:=[Personas:7]Cargo:21
				sAdr3:=[Personas:7]Direccion:14+", "+[Personas:7]Comuna:16
				sTelDom3:=[Personas:7]Telefono_domicilio:19
				sCelular3:=[Personas:7]Celular:24
				sEmail3:=[Personas:7]eMail:34
				If ([Personas:7]Fecha_de_nacimiento:5#!00-00-00!)
					sFechaNac3:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
				End if 
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
				If ([Familia_RelacionesFamiliares:77]Tipo_Relación:4>0)
					sparent1:=<>aParentesco{[Familia_RelacionesFamiliares:77]Tipo_Relación:4}
				End if 
			End if 
		End if 
		
		
		If (([Alumnos:2]Apoderado_Cuentas_Número:28#[Familia:78]Madre_Número:6) & ([Alumnos:2]Apoderado_Cuentas_Número:28#[Familia:78]Padre_Número:5))
			QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
			If (Records in selection:C76([Personas:7])#0)
				sApdoCta:=[Personas:7]Apellidos_y_nombres:30
				sRut4:=[Personas:7]RUT:6
				sEmp4:=[Personas:7]Empresa:20
				sProf4:=[Personas:7]Profesion:13
				sTel4:=[Personas:7]Telefono_profesional:29
				sCargo4:=[Personas:7]Cargo:21
				sAdr4:=[Personas:7]Direccion:14+", "+[Personas:7]Comuna:16
				sTelDom4:=[Personas:7]Telefono_domicilio:19
				sCelular4:=[Personas:7]Celular:24
				sEmail4:=[Personas:7]eMail:34
				If ([Personas:7]Fecha_de_nacimiento:5#!00-00-00!)
					sFechaNac4:=String:C10([Personas:7]Fecha_de_nacimiento:5;7)
				End if 
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Persona:3=[Personas:7]No:1)
				If ([Familia_RelacionesFamiliares:77]Tipo_Relación:4>0)
					sparent2:=<>aParentesco{[Familia_RelacionesFamiliares:77]Tipo_Relación:4}
				End if 
			End if 
		End if 
		RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
		QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
		sEmergencyContact:=[Alumnos_FichaMedica:13]Urgencia_Contacto:4
		sEmergencyPhone:=[Alumnos_FichaMedica:13]Urgencia_Fonos:5
		
		
End case 