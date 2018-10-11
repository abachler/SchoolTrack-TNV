//%attributes = {}
  //AL_AtrasoValidacion
  //Mono

C_TEXT:C284($msg)
C_DATE:C307($fecha;$1;$fecha_ingreso_alu)
C_LONGINT:C283($id_alumno;$2)
C_BOOLEAN:C305($0;$vb_atraso_interhora;$3;$vb_display_msg;$4)

$fecha:=$1
$id_alumno:=$2
$vb_atraso_interhora:=$3

If (Count parameters:C259>3)
	$vb_display_msg:=$4
Else 
	$vb_display_msg:=True:C214
End if 

$fecha_ingreso_alu:=KRL_GetDateFieldData (->[Alumnos:2]numero:1;->$id_alumno;->[Alumnos:2]Fecha_de_Ingreso:41)

If ($vb_atraso_interhora)
	
	If ($fecha_ingreso_alu<=$fecha)
		$0:=True:C214
	Else 
		$0:=False:C215
	End if 
	
Else 
	
	If (($fecha_ingreso_alu=!00-00-00!) | ($fecha_ingreso_alu<=$fecha))
		
		READ ONLY:C145([Alumnos_Atrasos:55])
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$id_alumno)
		QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
		QUERY SELECTION:C341([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
		
		Case of 
			: (Records in selection:C76([Alumnos_Atrasos:55])=0)
				$0:=True:C214
			: (Records in selection:C76([Alumnos_Atrasos:55])>0)
				If (<>gAllowMultipleLates=1)
					$0:=True:C214
				Else 
					$msg:=KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$id_alumno;->[Alumnos:2]apellidos_y_nombres:40)+__ (" ya tiene registrado un atraso al inicio de jornada en esta fecha.")
					$0:=False:C215
				End if 
		End case 
		
	Else 
		
		$0:=False:C215
		$msg:=__ ("No es posible ingresar un atraso anterior a la fecha de ingreso del alumno.")
		
	End if 
	
End if 

If (($msg#"") & ($vb_display_msg))
	CD_Dlog (0;$msg)
End if 
