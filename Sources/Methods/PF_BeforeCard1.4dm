//%attributes = {}
  //PF_BeforeCard1

SET WINDOW TITLE:C213(__ ("Profesores"))
If ([Profesores:4]Numero:1=0)
	[Profesores:4]Numero:1:=SQ_SeqNumber (->[Profesores:4]Numero:1)
	[Profesores:4]Categoria:20:=1
	[Profesores:4]Nacionalidad:7:=LOC_GetNacionalidad 
	[Profesores:4]Ciudad:11:=<>gCiudad
Else 
	_O_DISABLE BUTTON:C193(bDelAs)
	HIGHLIGHT TEXT:C210([Profesores:4]Apellido_paterno:3;Length:C16([Profesores:4]Apellido_paterno:3)+1;80)
End if 

$y_asignaturasAutorizadas:=OBJECT Get pointer:C1124(Object named:K67:5;"asignaturasAutorizadas")
AT_Initialize ($y_asignaturasAutorizadas)
SF_Subtable2Array (->[Profesores:4]Asignaturas:13;->[Profesores]Asignaturas'Asignatura;$y_asignaturasAutorizadas)

xALSet_AreasCamposUsuario (xALP_pfUF)
UFLD_LoadFields (->[Profesores:4];->[Profesores:4]Userfields:31;->[Profesores]Userfields'Value;->xALP_pfUF)


If ([Profesores:4]Es_Tutor:34)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;True:C214;1;0)
Else 
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;False:C215;1;0)
End if 


  //opciones según pais
PF_SetIdentificadorPrincipal 
xDOC_AutoLoadPictures (->[Profesores:4]Fotografia:59)
AutorizadoTodasAsg:=[Profesores:4]AutorizadoTodaAsignatura:9