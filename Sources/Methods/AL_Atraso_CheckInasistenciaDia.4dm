//%attributes = {}
  //AL_Atraso_CheckInasistenciaDia
  //Mono
C_LONGINT:C283($id_alumno;$1;$rn_inasistencia)
C_DATE:C307($vd_fecha;$2)
C_BOOLEAN:C305($0;$3;$vb_opc_eliminar;$4;$vb_display_msg)
C_TEXT:C284($nombre_alumno;$msg)
C_POINTER:C301($5;$ptr_msg)

$id_alumno:=$1
$vd_fecha:=$2
$vb_opc_eliminar:=$3  // opción de eliminar esta inasistencia si estamos consultando el ingreso de un atraso, depende de los permisos
$vb_display_msg:=$4
If (Count parameters:C259=5)
	$ptr_msg:=$5
End if 

READ ONLY:C145([Alumnos_Inasistencias:10])
QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$id_alumno)
QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$vd_fecha)

$rn_inasistencia:=Record number:C243([Alumnos_Inasistencias:10])

If ($rn_inasistencia>=0)
	
	$nombre_alumno:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$id_alumno;->[Alumnos:2]apellidos_y_nombres:40)
	
	If ($vb_opc_eliminar)
		
		$msg:=$nombre_alumno+__ (" ya está registrado como inasistente el "+String:C10($vd_fecha)+",esto será reemplazado por el atraso que está registrando.")
		
		KRL_DeleteRecord (->[Alumnos_Inasistencias:10];$rn_inasistencia)
		
		If (OK=1)
			LOG_RegisterEvt ("La inasistencia del alumno "+$nombre_alumno+" en la fecha "+String:C10($vd_fecha)+", fué eliminada para ingresar un atraso.")
			$vb_registrar_atraso:=True:C214
		Else 
			$vb_registrar_atraso:=False:C215
			$msg:=__ ("El registro de la inasistencia no pudo ser eliminado para reemplazarlo por el atraso, por favor intente nuevamente mas tarde.")
		End if 
		
	Else 
		
		$msg:=$nombre_alumno+__ (" ya está registrado como inasistente en esta fecha.")
		$vb_registrar_atraso:=False:C215
	End if 
	
Else 
	$vb_registrar_atraso:=True:C214
End if 

If (Not:C34(Is nil pointer:C315($ptr_msg)))
	$ptr_msg->:=$msg
End if 

If (($msg#"") & ($vb_display_msg))
	CD_Dlog (0;$msg)
End if 

$0:=$vb_registrar_atraso