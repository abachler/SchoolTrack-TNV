//%attributes = {}
  // ASrs_RegistraPresencia()
  // Por: Alberto Bachler: 02/07/13, 19:50:55
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_DATE:C307($d_fechaSesion)
C_LONGINT:C283($l_IdAlumno;$l_IdSesion;$l_Resultado)
C_TEXT:C284($t_curso;$t_nombreAlumno)

If (False:C215)
	C_LONGINT:C283(ASrs_RegistraPresencia ;$0)
	C_LONGINT:C283(ASrs_RegistraPresencia ;$1)
	C_LONGINT:C283(ASrs_RegistraPresencia ;$2)
End if 
$l_IdSesion:=Abs:C99($1)
$l_IdAlumno:=$2

KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$l_IdSesion;False:C215)
If ((OK=1) & ([Asignaturas_RegistroSesiones:168]Impartida:5))
	$d_fechaSesion:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_IdSesion;*)
	QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Alumno:2=$l_IdAlumno)
	If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
		$l_hora:=[Asignaturas_Inasistencias:125]Hora:8
		  // 20160506 ASM verifico si la inasistencia está asociada a una licencia antes de eliminar ticket 159011
		
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]ID:6=[Asignaturas_Inasistencias:125]ID_Licencia:9)
		If (Records in selection:C76([Alumnos_Licencias:73])>0)
			$t_licenciaTipo:=[Alumnos_Licencias:73]Tipo_licencia:4
			$t_mensaje:=__ ("La inasistencia está justificada con una licencia tipo: ")+$t_licenciaTipo+"\r\r"+__ ("¿Está seguro de eliminar la inasistencia?")
			$v_resp:=CD_Dlog (0;$t_mensaje;"";__ ("Continuar");__ ("Cancelar"))
			If ($v_resp=1)
				OK:=KRL_DeleteRecord (->[Asignaturas_Inasistencias:125])
			End if 
		Else 
			OK:=KRL_DeleteRecord (->[Asignaturas_Inasistencias:125])
		End if 
		
		If (OK=1)
			AL_InasistenciaDiariaPorHoras ($l_IdAlumno;$d_fechaSesion)
			$t_nombreAlumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_IdAlumno;->[Alumnos:2]apellidos_y_nombres:40)
			$t_curso:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_IdAlumno;->[Alumnos:2]curso:20)
			LOG_RegisterEvt ("Inasistencia por hora eliminada para: "+$t_nombreAlumno+", "+$t_curso+", "+String:C10($d_fechaSesion;System date long:K1:3)+", "+String:C10($l_hora)+__ ("ª hora"))
			$l_Resultado:=1
		End if 
	Else 
		$l_Resultado:=1
	End if 
End if 

$0:=$l_Resultado

