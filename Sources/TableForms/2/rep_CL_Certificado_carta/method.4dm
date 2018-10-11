If (Form event:C388=On Printing Detail:K2:18)
	sc_newALCertif 
	If ((<>icrtfYear=<>gYear) | (<>icrtfYear=0))
		Case of 
			: ((<>gYear>=2002))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos:2]nivel_numero:29<=5) | ([Alumnos:2]nivel_numero:29=9)) & (<>iCrtfYear=1999))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos:2]nivel_numero:29<=6) | ([Alumnos:2]nivel_numero:29=9) | ([Alumnos:2]nivel_numero:29=10)) & (<>iCrtfYear=2000))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos:2]nivel_numero:29<=7) | ([Alumnos:2]nivel_numero:29=9) | ([Alumnos:2]nivel_numero:29=10) | ([Alumnos:2]nivel_numero:29=11)) & (<>iCrtfYear=2001))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"Ol@";True:C214)
				OBJECT SET VISIBLE:C603(*;"New@";False:C215)
		End case 
	Else 
		Case of 
			: ((<>iCrtfYear>=2002))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos_Historico:25]Nivel:11<=5) | ([Alumnos_Historico:25]Nivel:11=9)) & (<>iCrtfYear=1999))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos_Historico:25]Nivel:11<=6) | ([Alumnos_Historico:25]Nivel:11=9) | ([Alumnos_Historico:25]Nivel:11=10)) & (<>iCrtfYear=2000))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos_Historico:25]Nivel:11<=7) | ([Alumnos_Historico:25]Nivel:11=9) | ([Alumnos_Historico:25]Nivel:11=10) | ([Alumnos_Historico:25]Nivel:11=11)) & (<>iCrtfYear=2001))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			: ((([Alumnos_Historico:25]Nivel:11=8) | ([Alumnos_Historico:25]Nivel:11=12)) | (<>iCrtfYear<=2001))
				OBJECT SET VISIBLE:C603(*;"Ol@";True:C214)
				OBJECT SET VISIBLE:C603(*;"New@";False:C215)
			: ((<>gYear>=2002))
				OBJECT SET VISIBLE:C603(*;"Ol@";False:C215)
				OBJECT SET VISIBLE:C603(*;"New@";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"Ol@";True:C214)
				OBJECT SET VISIBLE:C603(*;"New@";False:C215)
		End case 
	End if 
	
	Case of 
		: ([Cursos:3]cl_RolBaseDatos:20#"")
			$rol:=Substring:C12([Cursos:3]cl_RolBaseDatos:20;1;Length:C16([Cursos:3]cl_RolBaseDatos:20)-1)+"-"+[Cursos:3]cl_RolBaseDatos:20[[Length:C16([Cursos:3]cl_RolBaseDatos:20)]]
		: ([Cursos:3]cl_RolBaseDatos:20="")
			$rol:=Substring:C12(<>gRolBD;1;Length:C16(<>gRolBD)-1)+"-"+<>gRolBD[[Length:C16(<>gRolBD)]]
	End case 
	vCert4:=Replace string:C233(vCert4;"<RBD>";"Rol Base de Datos "+$rol)
	
	If (vi_PEStart=0)
		OBJECT SET VISIBLE:C603(*;"Old_mencionElectivos";False:C215)
		OBJECT SET VISIBLE:C603(*;"New_mencionElectivos";False:C215)
	End if 
	
	
	vCertDate:=<>gComuna+", "+DT_SpecialDate2String (Current date:C33)
	
	
	
	If (vi_ImprimeObsActas=1)
		If (<>iCrtfYear=<>gYear)
			sObs:="Observaciones: "+[Alumnos:2]Observaciones_en_Acta:58
		Else 
			sObs:="Observaciones: "+[Alumnos_Historico:25]ObservacionesActas:22
		End if 
	Else 
		sObs:=""
	End if 
	
	If (vi_PrintHeadName=1)
		ACTAS_FirmaProfesorJefe 
	End if 
	
	ACTAS_FirmaDirector 
End if 
