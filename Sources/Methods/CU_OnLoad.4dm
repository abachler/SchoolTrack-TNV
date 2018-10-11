//%attributes = {}
  //CU_OnLoad

XS_SetInterface 
CU_InitArrays 
vlSTR_PaginaFormCursos:=1
vl_Year:=<>gYear

If ((USR_checkRights ("M";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
	_O_ENABLE BUTTON:C192(*;"buttonCurso@")
Else 
	_O_DISABLE BUTTON:C193(*;"buttonCurso@")
End if 
OBJECT SET ENTERABLE:C238(vt_reprobadas;False:C215)
OBJECT SET ENTERABLE:C238(vt_conducta;False:C215)
vt_reprobadas:=""
vt_conducta:=""
OBJECT SET ENTERABLE:C238([Cursos:3]Nivel_Nombre:10;False:C215)

C_REAL:C285(hl_TipoEstablecimiento)
Case of 
	: (<>gCountryCode="cl")  //20180308 RCH No encontré en donde se cargaba la lista.
		hl_TipoEstablecimiento:=Load list:C383("cl_CodigosEnseñanza")
End case 