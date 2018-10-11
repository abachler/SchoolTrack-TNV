//%attributes = {}
C_TEXT:C284($0)
C_POINTER:C301($y_Names;$y_Data;$1;$2)
C_LONGINT:C283($l_idApp)
C_TEXT:C284($t_autenticacion)

$y_Names:=$1
$y_Data:=$2

C_TEXT:C284($t_uuid1;$t_uuid2;$t_llave)
$t_uuid1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param1")
$t_uuid2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"param2")
$t_llave:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autentificacion")
If ($t_llave=XCRwa_GeneraLlave ($t_uuid1;$t_uuid2))
	
	C_TEXT:C284($t_uuidAs;$t_fechaInicio;$t_fechaFin)
	C_DATE:C307($d_fechaInicio;$d_fechaFin)
	C_TEXT:C284($t_year;$t_mes;$t_dia)
	C_LONGINT:C283($l_idUsuario;$l_idProfesor)
	C_LONGINT:C283($l_error)
	C_TEXT:C284($t_msg)
	C_OBJECT:C1216($ob)
	
	$t_fechaInicio:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fechainicio")
	$t_fechaFin:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fechafin")
	$t_uuidAs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidasignatura")
	$t_uuidUser:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuidusuario")
	
	$t_year:=Substring:C12($t_fechaInicio;1;4)
	$t_mes:=Substring:C12($t_fechaInicio;6;2)
	$t_dia:=Substring:C12($t_fechaInicio;9;2)
	$d_fechaInicio:=DT_GetDateFromDayMonthYear (Num:C11($t_dia);Num:C11($t_mes);Num:C11($t_year))
	
	$t_year:=Substring:C12($t_fechaFin;1;4)
	$t_mes:=Substring:C12($t_fechaFin;6;2)
	$t_dia:=Substring:C12($t_fechaFin;9;2)
	$d_fechaFin:=DT_GetDateFromDayMonthYear (Num:C11($t_dia);Num:C11($t_mes);Num:C11($t_year))
	
	READ ONLY:C145([Profesores:4])
	
	$rn_Asignatura:=Find in field:C653([Asignaturas:18]auto_uuid:12;$t_uuidAs)
	$l_idProfesor:=KRL_GetNumericFieldData (->[Profesores:4]Auto_UUID:41;->$t_uuidUser;->[Profesores:4]Numero:1)
	$l_idUsuario:=KRL_GetNumericFieldData (->[xShell_Users:47]NoEmployee:7;->$l_idProfesor;->[xShell_Users:47]No:1)
	
	  //validaciones
	If ($l_error=0)
		If ($rn<0)
			$l_error:=-1
		End if 
	End if 
	If ($l_error=0)
		If ($d_fechaInicio=!00-00-00!)
			$l_error:=-2
		End if 
	End if 
	If ($l_error=0)
		If ($d_fechaFin=!00-00-00!)
			$l_error:=-3
		End if 
	End if 
	If ($l_error=0)
		If ($d_fechaInicio>$d_fechaFin)
			$l_error:=-4
		End if 
	End if 
	If ($l_error=0)
		If ($l_idProfesor=0)
			$l_error:=-5
		End if 
	End if 
	
	If ($l_error=0)
		$0:=Calendario_ObtieneEventos ($rn_Asignatura;$d_fechaInicio;$d_fechaFin;$l_idUsuario;False:C215)
	Else 
		$ob:=OB_Create 
		$t_msg:=Choose:C955(Abs:C99($l_error+1);"Asignatura no encontrada";"Fecha inicio no válida";"Fecha fin no válida";"Fecha fin menor a fecha inicio";"Profesor no encontrado")
		OB SET:C1220($ob;"error_cod";$l_error)
		OB SET:C1220($ob;"error_mensaje";$t_msg)
		$0:=JSON Stringify:C1217($ob)
	End if 
	
Else 
	$0:=SERwa_GeneraRespuesta ("-100";"Acceso denegado a la API de servicios de SchoolTrack.")
End if 