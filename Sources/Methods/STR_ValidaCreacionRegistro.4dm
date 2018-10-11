//%attributes = {}
  //STR_ValidaCreacionRegistro
C_BOOLEAN:C305($0;$b_error)
C_POINTER:C301($y_puntero;$y_punteroDatoUnico;$y_datoNoValido)
$t_tipo:=$1
$y_puntero:=$2
$y_punteroDatoUnico:=$3
$y_datoNoValido:=$4

Case of 
	: ($t_tipo="Alumnos")
		  //AL_fSave
		  //IOstr_ProcessStudentRecord
		Case of 
			: ((<>al_IDNational_Mandatory{1} ?? 1) & ([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8=LOC_GetNacionalidad ) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados))
				$b_error:=True:C214
				$y_puntero->:=<>at_IDNacional_Names{1}
				
			: ((<>al_IDNational_Mandatory{1} ?? 2) & ([Alumnos:2]IDNacional_2:71="") & ([Alumnos:2]Nacionalidad:8=LOC_GetNacionalidad ) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados))
				$b_error:=True:C214
				$y_puntero->:=<>at_IDNacional_Names{2}
				
			: ((<>al_IDNational_Mandatory{1} ?? 3) & ([Alumnos:2]IDNacional_3:70="") & ([Alumnos:2]Nacionalidad:8=LOC_GetNacionalidad ) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados))
				$b_error:=True:C214
				$y_puntero->:=<>at_IDNacional_Names{3}
				
			: ([Alumnos:2]Apellido_paterno:3="")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Alumnos:2]Apellido_paterno:3)
				
			: ([Alumnos:2]Nombres:2="")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Alumnos:2]Nombres:2)
				
			: ([Alumnos:2]Sexo:49="")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Alumnos:2]Sexo:49)
				
			: (([Alumnos:2]RUT:5#"") & (KRL_RecordExists (->[Alumnos:2]RUT:5)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=<>at_IDNacional_Names{1}
				
			: (([Alumnos:2]IDNacional_2:71#"") & (KRL_RecordExists (->[Alumnos:2]IDNacional_2:71)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=<>at_IDNacional_Names{2}
				
			: (([Alumnos:2]IDNacional_3:70#"") & (KRL_RecordExists (->[Alumnos:2]IDNacional_3:70)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=<>at_IDNacional_Names{3}
				
			: (([Alumnos:2]NoPasaporte:87#"") & (KRL_RecordExists (->[Alumnos:2]NoPasaporte:87)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=XSvs_nombreCampoLocal_puntero (->[Alumnos:2]NoPasaporte:87)
				  //: (Not(([Alumnos]Sexo="F") | ([Alumnos]Sexo="M"))) // 20181008 Patricio Aliaga Ticket N° 204363
			: (Not:C34((ST_ExactlyEqual ([Alumnos:2]Sexo:49;"F")=1) | (ST_ExactlyEqual ([Alumnos:2]Sexo:49;"M")=1)))
				$b_error:=True:C214
				$y_datoNoValido->:=XSvs_nombreCampoLocal_puntero (->[Alumnos:2]Sexo:49)
			: (([Alumnos:2]RUT:5#"") & (<>vtXS_CountryCode="cl") & (CTRY_CL_VerifRUT ([Alumnos:2]RUT:5;False:C215)=""))
				$b_error:=True:C214
				$y_datoNoValido->:=<>at_IDNacional_Names{1}
				
		End case 
		
	: ($t_tipo="Personas")
		  //PP_fSave
		  //IOstr_ProcessParentRecord
		Case of 
			: ((<>al_IDNational_Mandatory{3} ?? 1) & ([Personas:7]RUT:6="") & ([Personas:7]Nacionalidad:7=LOC_GetNacionalidad ))
				$b_error:=True:C214
				$y_puntero->:=<>at_IDNacional_Names{1}
				
			: ((<>al_IDNational_Mandatory{3} ?? 2) & ([Personas:7]IDNacional_2:37="") & ([Personas:7]Nacionalidad:7=LOC_GetNacionalidad ))
				$b_error:=True:C214
				$y_puntero->:=<>at_IDNacional_Names{2}
				
			: ((<>al_IDNational_Mandatory{3} ?? 3) & ([Personas:7]IDNacional_3:38="") & ([Personas:7]Nacionalidad:7=LOC_GetNacionalidad ))
				$b_error:=True:C214
				$y_puntero->:=<>at_IDNacional_Names{3}
				
			: ([Personas:7]Apellido_paterno:3="")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Personas:7]Apellido_paterno:3)
				
			: ([Personas:7]Nombres:2="")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Personas:7]Nombres:2)
				
			: (([Personas:7]RUT:6#"") & (KRL_RecordExists (->[Personas:7]RUT:6)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=<>at_IDNacional_Names{1}
				
			: (([Personas:7]IDNacional_2:37#"") & (KRL_RecordExists (->[Personas:7]IDNacional_2:37)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=<>at_IDNacional_Names{2}
				
			: (([Personas:7]IDNacional_3:38#"") & (KRL_RecordExists (->[Personas:7]IDNacional_3:38)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=<>at_IDNacional_Names{3}
				
			: (([Personas:7]Pasaporte:59#"") & (KRL_RecordExists (->[Personas:7]Pasaporte:59)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=XSvs_nombreCampoLocal_puntero (->[Personas:7]Pasaporte:59)
				
			: ((([Personas:7]Sexo:8#"")) & (Not:C34(([Personas:7]Sexo:8="F") | ([Personas:7]Sexo:8="M"))))
				$b_error:=True:C214
				$y_datoNoValido->:=XSvs_nombreCampoLocal_puntero (->[Personas:7]Sexo:8)
				
			: (([Personas:7]RUT:6#"") & (<>vtXS_CountryCode="cl") & (CTRY_CL_VerifRUT ([Personas:7]RUT:6;False:C215)=""))
				$b_error:=True:C214
				$y_datoNoValido->:=<>at_IDNacional_Names{1}
				
		End case 
		
	: ($t_tipo="Familias")
		  //FM_fSave
		  //IOstr_ProcessFamilyRecord
		Case of 
			: ([Familia:78]Nombre_de_la_familia:3="")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Familia:78]Nombre_de_la_familia:3)
				
			: ([Familia:78]Nombre_de_la_familia:3=" ")
				$b_error:=True:C214
				$y_puntero->:=XSvs_nombreCampoLocal_puntero (->[Familia:78]Nombre_de_la_familia:3)
				
			: (([Familia:78]Codigo_interno:14#"") & (KRL_RecordExists (->[Familia:78]Codigo_interno:14)))
				$b_error:=True:C214
				$y_punteroDatoUnico->:=XSvs_nombreCampoLocal_puntero (->[Familia:78]Codigo_interno:14)
				
		End case 
		
		
End case 

$0:=$b_error