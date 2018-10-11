//%attributes = {}
$anteriores:=$1
$profID:=$2
$userID:=$3
  //$anteriores:=1
PERIODOS_Init 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
READ ONLY:C145([Asignaturas_RegistroSesiones:168])
If ($anteriores=0)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=vdSTR_Periodos_InicioEjercicio;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=vdSTR_Periodos_FinEjercicio)
Else 
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<vdSTR_Periodos_InicioEjercicio)
End if 
ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;>;[Asignaturas_RegistroSesiones:168]hasData:8;>;[Asignaturas_RegistroSesiones:168]Hora:4;>)
SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168]ID_Asignatura:2;$al_IdAsigs;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;$aDate;[Asignaturas_RegistroSesiones:168]Hora:4;$aHora;[Asignaturas_RegistroSesiones:168];$aSesionRecNum;[Asignaturas_RegistroSesiones:168]hasData:8;$aHasData;[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10;$al_profAs;[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11;$at_profAs)

  ///ticket 156742 
  //ARRAY TEXT($atSTRas_Pintar;0)
ARRAY TEXT:C222($atSTK_SesionFecha;0)
ARRAY DATE:C224($adSTK_SesionFecha;0)
ARRAY LONGINT:C221($aiSTK_SesionHoras;0)
ARRAY LONGINT:C221($alSTK_SesionRecNum;0)
ARRAY TEXT:C222($atSTK_SesionProf;0)
ARRAY LONGINT:C221($alSTK_SesionProfID;0)
ARRAY BOOLEAN:C223($abSTK_hasData;0)
$lastDate:=!00-00-00!
$lastHour:=0
$lastProf:=0
$horas:=0
$hasData:=False:C215
$size:=0
For ($i;1;Size of array:C274($aDate))
	If (($lastDate=$aDate{$i}) & ($lastProf=$al_profAs{$i}))
		$horas:=$horas+1
		$aiSTK_SesionHoras{$size}:=$horas
		If ($aHasData{$i})
			$alSTK_SesionRecNum{$size}:=$aSesionRecNum{$i}
		End if 
	Else 
		$horas:=1
		$size:=$size+1
		AT_Insert ($size;1;->$adSTK_SesionFecha;->$atSTK_SesionFecha;->$aiSTK_SesionHoras;->$alSTK_SesionRecNum;->$atSTK_SesionProf;->$alSTK_SesionProfID;->$abSTK_hasData)
		$atSTK_SesionFecha{$size}:=STWA2_MakeDate4JS ($aDate{$i})
		$adSTK_SesionFecha{$size}:=$aDate{$i}
		$aiSTK_SesionHoras{$size}:=$horas
		$alSTK_SesionRecNum{$size}:=$aSesionRecNum{$i}
		If ($al_profAs{$i}=0)
			$idAsig:=$al_IdAsigs{$i}
			$al_profAs{$i}:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$idAsig;->[Asignaturas:18]profesor_numero:4)
		End if 
		$atSTK_SesionProf{$size}:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->$al_profAs{$i};->[Profesores:4]Nombre_comun:21)
		If ($atSTK_SesionProf{$size}="")
			$atSTK_SesionProf{$size}:=$at_profAs{$i}
		End if 
		$alSTK_SesionProfID{$size}:=$al_profAs{$i}
	End if 
	$lastDate:=$aDate{$i}
	$lastProf:=$al_profAs{$i}
End for 
SORT ARRAY:C229($adSTK_SesionFecha;$atSTK_SesionFecha;$aiSTK_SesionHoras;$alSTK_SesionRecNum;$atSTK_SesionProf;$alSTK_SesionProfID;<)
$ingresables:=0
If (Size of array:C274($alSTK_sesionRecNum)>0)
	$line:=1
	KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$alSTK_sesionRecNum{$line};False:C215)
	$vtSesion_Contenidos:=Replace string:C233([Asignaturas_RegistroSesiones:168]Contenidos:6;Char:C90(34);"'")
	$vtSesion_Actividades:=Replace string:C233([Asignaturas_RegistroSesiones:168]Actividades:7;Char:C90(34);"'")
	$vtSesion_Observacion:=Replace string:C233([Asignaturas_RegistroSesiones:168]Observacion:12;Char:C90(34);"'")
	
	  // 20160609 ASM Ticket 163095 para enviar las inasistencias
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
	SELECTION TO ARRAY:C260([Asignaturas_Inasistencias:125]ID_Alumno:2;$al_IdAlumnos)
	QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$al_IdAlumnos)
	SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$at_NombresAusentes)
	SORT ARRAY:C229($at_NombresAusentes;>)
	vt_alumnosAusentes:=AT_array2text (->$at_NombresAusentes;"\r")
	
	If ($anteriores=0)
		If (($profID=[Asignaturas:18]profesor_numero:4) | ($profID=[Asignaturas:18]profesor_firmante_numero:33) | ($userID<0) | (USR_IsGroupMember_by_GrpID (-15001;$userID)) | (USR_checkRights ("A";->[Asignaturas_RegistroSesiones:168];$userID)))
			$ingresables:=1
		Else 
			$ingresables:=0
		End if 
	Else 
		$ingresables:=0
	End if 
Else 
	$vtSesion_Contenidos:=""
	$vtSesion_Actividades:=""
End if 

ARRAY TEXT:C222($at_nombreProf;0)
ARRAY TEXT:C222($at_NombreComun;0)
ARRAY LONGINT:C221($al_idProf;0)
READ ONLY:C145([Profesores:4])
QUERY:C277([Profesores:4];[Profesores:4]Es_docente:76=True:C214)
SELECTION TO ARRAY:C260([Profesores:4]Numero:1;$al_idProf;[Profesores:4]Apellidos_y_nombres:28;$at_nombreProf;[Profesores:4]Nombre_comun:21;$at_NombreComun)
SORT ARRAY:C229($at_nombreProf;$at_NombreComun;$al_idProf;>)


  ///
  //ticket 156742 JVP 08042016

  //For ($x;1;Size of array($alSTK_SesionRecNum))
  //KRL_GotoRecord (->[Asignaturas_RegistroSesiones];$alSTK_SesionRecNum{$x};False)
  //If ([Asignaturas_RegistroSesiones]Contenidos#"")
  //APPEND TO ARRAY($atSTRas_Pintar;"true")
  //Else 
  //APPEND TO ARRAY($atSTRas_Pintar;"false")
  //End if 
  //
  //End for 

  //20160607 ticket 156742 ASM cambio en la funcionalidad
For ($i;1;Size of array:C274($alSTK_SesionRecNum))
	KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$alSTK_SesionRecNum{$i};False:C215)
	$abSTK_hasData{$i}:=[Asignaturas_RegistroSesiones:168]hasData:8
End for 

C_BOOLEAN:C305($b_ingresable)
$b_ingresable:=($ingresables=1)

C_OBJECT:C1216($ob_raiz)
$ob_raiz:=OB_Create 
OB_SET ($ob_raiz;->$atSTK_SesionFecha;"fechas")
OB_SET ($ob_raiz;->$aiSTK_SesionHoras;"horas")
OB_SET ($ob_raiz;->$alSTK_SesionRecNum;"rns")
OB_SET ($ob_raiz;->$atSTK_SesionProf;"profesores")
OB_SET ($ob_raiz;->$alSTK_SesionProfID;"profID")
OB_SET ($ob_raiz;->$vtSesion_Contenidos;"contenidos")
OB_SET ($ob_raiz;->$vtSesion_Actividades;"actividades")
OB_SET ($ob_raiz;->$vtSesion_Observacion;"observaciones")
OB_SET ($ob_raiz;->$b_ingresable;"ingresables")
OB_SET ($ob_raiz;->$at_nombreProf;"profdisponibles")
OB_SET ($ob_raiz;->$at_NombreComun;"profdisponiblescomun")
OB_SET ($ob_raiz;->$al_idProf;"profdisponiblesid")
OB_SET ($ob_raiz;->$abSTK_hasData;"hasdata")
OB_SET ($ob_raiz;->vt_alumnosAusentes;"alumnoaunsentes")
$text:=OB_Object2Json ($ob_raiz)
$0:=$text

