//%attributes = {}
  // MÉTODO: AL_PaginaIdentificacion
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 09:36:17
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_PaginaIdentificacion()
  // ----------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($nivelAdmissionDirecta)

If (False:C215)
	C_LONGINT:C283(AL_PaginaIdentificacion ;$0)
End if 

  // CODIGO PRINCIPAL
AL_SetConexionsALP 
vb_pictureWasModified:=False:C215

If ([Alumnos:2]numero:1=0)
	
	  //inicializaciones
	[Alumnos:2]Modificado_por:23:=<>tUSR_CurrentUser
	[Alumnos:2]nivel_numero:29:=Nivel_AdmisionDirecta
	[Alumnos:2]curso:20:="Adm"+String:C10(<>gYear)
	[Alumnos:2]Nivel_Nombre:34:="Admisión"
	[Alumnos:2]Nacionalidad:8:=LOC_GetNacionalidad 
	[Alumnos:2]Ciudad:15:=<>gCiudad
	UFLD_CreateFields (->[Alumnos:2];->[Alumnos:2]Userfields:54;->[Alumnos]Userfields'Value)
	vAge:=""
	sMatBus:=""
	vl_NoBus:=0
	If ((<>gGroupAL) & (<>gAutoGroup) & (Size of array:C274(<>aColor)>0))
		[Alumnos:2]Grupo:11:=<>aColor{MATH_RandomLongint (1;Size of array:C274(<>aColor))}
	End if 
	
	  //Propiedades de objetos
	If (<>vlSTR_UsarSoloUnApellido=1)
		OBJECT SET ENTERABLE:C238(*;"Champ8";False:C215)
	Else 
		OBJECT SET ENTERABLE:C238(*;"Champ8";True:C214)
	End if 
	vlSTR_PaginaFormAlumnos:=1
	If (<>viSTR_AsignarComunaDefecto=1)
		[Alumnos:2]Comuna:14:=<>gComuna
	End if 
	
	
	
Else 
	
	  // inicializaciones
	vAge:=DT_ReturnAgeLongString ([Alumnos:2]Fecha_de_nacimiento:7)
	RELATE ONE:C42([Alumnos:2]Patente_bus_escolar:37)
	vl_NoBus:=[Buses_escolares:57]Numero:10
	sMatBus:=[Alumnos:2]Patente_bus_escolar:37
	
	If (([Alumnos:2]Familia_Número:24#0) & (([Alumnos:2]Telefono:17="") | ([Alumnos:2]Fax:69="") | ([Alumnos:2]Direccion:12="")))
		KRL_FindAndLoadRecordByIndex (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24)
		If (([Alumnos:2]Direccion:12="") & ([Alumnos:2]Comuna:14="") & ([Alumnos:2]Ciudad:15=""))
			[Alumnos:2]Direccion:12:=[Familia:78]Dirección:7
			[Alumnos:2]Comuna:14:=[Familia:78]Comuna:8
			[Alumnos:2]Ciudad:15:=[Familia:78]Ciudad:9
			[Alumnos:2]Codigo_Postal:13:=[Familia:78]Codigo_postal:19
		End if 
		If ([Alumnos:2]Telefono:17="")
			[Alumnos:2]Telefono:17:=[Familia:78]Telefono:10
		End if 
		If ([Alumnos:2]Fax:69="")
			[Alumnos:2]Fax:69:=[Familia:78]Fax:20
		End if 
		If (KRL_FieldChanges (->[Alumnos:2]Direccion:12;->[Alumnos:2]Comuna:14;->[Alumnos:2]Ciudad:15;->[Alumnos:2]Codigo_Postal:13;->[Alumnos:2]Telefono:17;->[Alumnos:2]Fax:69))
			SAVE RECORD:C53([Alumnos:2])
		End if 
	End if 
	
	  // propiedades de objetos
	OBJECT SET ENTERABLE:C238(*;"Champ8";True:C214)
	If ([Alumnos:2]AlumnoADT:104)
		OBJECT SET VISIBLE:C603(*;"siAdmission@";True:C214)
	Else 
		OBJECT SET VISIBLE:C603(*;"siAdmission@";False:C215)
	End if 
	
	
End if 


AL_SetIdentificadorPrincipal 
UFLD_LoadFields (->[Alumnos:2];->[Alumnos:2]Userfields:54;->[Alumnos]Userfields'Value;->xALP_UFields)
xDOC_AutoLoadPictures (->[Alumnos:2]Fotografía:78)




  // propiedades de objetos
HIGHLIGHT TEXT:C210([Alumnos:2]Apellido_paterno:3;Length:C16([Alumnos:2]Apellido_paterno:3)+1;80)
OBJECT SET VISIBLE:C603(*;"fechaRetiro@";(([Alumnos:2]Fecha_de_retiro:42#!00-00-00!) | ([Alumnos:2]Status:50="Retirado@")))



IT_SetButtonState (USR_checkRights ("M";->[Alumnos:2]);->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos:2]);1;5)

If (USR_checkRights ("M";->[Alumnos:2])=False:C215)
	KRL_ReloadAsReadOnly (->[Alumnos:2])
	OBJECT SET ENTERABLE:C238(*;"@restringido";False:C215)
	_O_DISABLE BUTTON:C193(*;"@restringido")
	
Else 
	KRL_ReloadInReadWriteMode (->[Alumnos:2])
	OBJECT SET VISIBLE:C603(*;"muerte@";[Alumnos:2]Fallecido:97)
	OBJECT SET ENTERABLE:C238(*;"@restringido";True:C214)
	_O_ENABLE BUTTON:C192(*;"@restringido")
	IT_SetEnterable (Not:C34([Alumnos:2]Fallecido:97);0;->[Alumnos:2]Status:50;->[Alumnos:2]Motivo_de_retiro:43)
	IT_SetButtonState ((Not:C34([Alumnos:2]Fallecido:97));->bStatus)
End if 

OBJECT SET VISIBLE:C603(*;"tutor@";[Alumnos:2]Tutor_numero:36>0)

ACTcc_CampoMatriculado 

  //MONO Ticket 174967 Status Alumnos
C_POINTER:C301($y_status)
C_LONGINT:C283($fia)
$y_status:=OBJECT Get pointer:C1124(Object named:K67:5;"InputStatusAlumno")
$fia:=Find in array:C230(<>at_StatusAlumno;[Alumnos:2]Status:50)
If ($fia>0)
	$y_status->:=<>at_StatusAlumnoAlias{$fia}
Else 
	$y_status->:=""
End if 

$0:=1

