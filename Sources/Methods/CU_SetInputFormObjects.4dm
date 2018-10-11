//%attributes = {}
  //CU_SetInputFormObjects

If (([Cursos:3]cl_CodigoTipoEnseñanza:21>=410) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=861))
	OBJECT SET ENTERABLE:C238(*;"especialidadTP@";True:C214)
	OBJECT SET VISIBLE:C603(*;"especialidadTP@";True:C214)
Else 
	OBJECT SET ENTERABLE:C238(*;"especialidadTP@";False:C215)
	OBJECT SET VISIBLE:C603(*;"especialidadTP@";False:C215)
	[Cursos:3]cl_CodigoEspecialidadTP:29:=0
	[Cursos:3]cl_EspecialidadTP:28:=""
	[Cursos:3]cl_SectorEconomicoTP:27:=""
	[Cursos:3]cl_RamaTP:26:=""
End if 

Case of 
	: ([Cursos:3]cl_CodigoTipoEnseñanza:21=10)  // parvularia
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
		Case of 
			: (([Cursos:3]Nivel_Numero:7=-3) & (([Cursos:3]cl_CodigoNivelEspecial:36="") | ([Cursos:3]cl_CodigoNivelEspecial:36#"1") | ([Cursos:3]cl_CodigoNivelEspecial:36#"2") | ([Cursos:3]cl_CodigoNivelEspecial:36#"3")))
				[Cursos:3]cl_CodigoNivelEspecial:36:="3"
			: ([Cursos:3]Nivel_Numero:7=-2)
				[Cursos:3]cl_CodigoNivelEspecial:36:="4"
			: ([Cursos:3]Nivel_Numero:7=-1)
				[Cursos:3]cl_CodigoNivelEspecial:36:="5"
		End case 
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=160) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=163))  // basica comuna adultos o básica escuelas carceles
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21>=211) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=216))  // Deficiencia auditiva, mental, visual, alteraciones del lenguaje
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: ([Cursos:3]cl_CodigoTipoEnseñanza:21=361)  // media HC Adultos Decreto 12
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=460) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=461))  // TP Comercial adultos y decreto 152
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=560) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=561))  // TP Industrial adultos y decreto 152
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=660) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=661))  // TP Técnica adultos y decreto 152
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=760) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=761))  // TP Agrícola adultos y decreto 152
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=860) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=861))  // TP Marítima adultos y decreto 152
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";True:C214)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;True:C214)
		
	: (([Cursos:3]cl_CodigoTipoEnseñanza:21=310) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=410) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=510) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=610) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=710) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=810) | ([Cursos:3]cl_CodigoTipoEnseñanza:21=910))  // media HC niños y jovenes EM Técnica
		[Cursos:3]cl_CodigoNivelEspecial:36:=String:C10([Cursos:3]Nivel_Numero:7-8)
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";False:C215)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;False:C215)
	Else 
		[Cursos:3]cl_CodigoNivelEspecial:36:=String:C10([Cursos:3]Nivel_Numero:7)
		OBJECT SET ENTERABLE:C238(*;"CodigoNivelEspecial";False:C215)
		OBJECT SET ENTERABLE:C238([Cursos:3]Nombre_Oficial_Nivel:14;False:C215)
End case 

  //HL_ClearList (hl_TipoEstablecimiento)
  //hl_TipoEstablecimiento:=Load list("cl_CodigosEnseñanza")
If (Is a list:C621(hl_TipoEstablecimiento))  //20180315 RCH
	If ([Cursos:3]cl_CodigoTipoEnseñanza:21=0)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEstablecimiento;-1)
	Else 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_TipoEstablecimiento;[Cursos:3]cl_CodigoTipoEnseñanza:21)
	End if 
End if 
SELECT LIST ITEMS BY REFERENCE:C630(hl_jornada;[Cursos:3]Jornada:32)
If (Not:C34(USR_IsGroupMember_by_GrpID (-15001)))
	OBJECT SET VISIBLE:C603(*;"lock2Admin";True:C214)
	OBJECT SET ENTERABLE:C238(*;"lock2admin@";False:C215)
Else 
	OBJECT SET VISIBLE:C603(*;"lock2Admin";False:C215)
	OBJECT SET ENTERABLE:C238(*;"lock2admin@";True:C214)
End if 