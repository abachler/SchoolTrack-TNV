//%attributes = {}
TRACE:C157
C_LONGINT:C283($idAlumno;$1)
C_TEXT:C284($t_estatusNuevo;$2)
C_OBJECT:C1216($obj;$dialog)

$idAlumno:=$1
$t_estatusNuevo:=$2

$fia:=Find in array:C230(<>at_StatusAlumnoAlias;$t_estatusNuevo)
$t_estatusNuevo:=<>at_StatusAlumno{$fia}

If (KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;->$idAlumno;False:C215)>-1)
	$t_estatusActual:=[Alumnos:2]Status:50
	Case of 
		: ($t_estatusNuevo="Promovido anticipadamente")
			If ($t_estatusActual="Retirado@")
				$0:=SERwa_GeneraRespuesta ("-3";"Un alumno retirado no puede ser promovido anticipadamente.")
			Else 
				OB SET:C1220($obj;"error";"-7")
				OB SET:C1220($obj;"mensaje";"Solicitar fecha de promoción")
				OB SET:C1220($dialog;"titulo";"¿A contar de que fecha realizar la promoción anticipada?")
				OB SET:C1220($obj;"dialogo";$dialog)
				$0:=JSON Stringify:C1217($obj)
			End if 
		: (($t_estatusActual="Retirado@") & ($t_estatusNuevo="Retirado@"))
			  //desplegar dialogo retiros con datos precargados...
			OB SET:C1220($obj;"error";"-8")
			OB SET:C1220($obj;"mensaje";"Diálogo de retiro en blanco")
			OB SET:C1220($dialog;"fecharetiro";SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_de_retiro:42))
			OB SET:C1220($dialog;"cursoretiro";[Alumnos:2]Curso_alRetirarse:83)
			OB SET:C1220($dialog;"retiradotemporal";Num:C11([Alumnos:2]Status:50="Retirado temporalmente"))
			OB SET:C1220($dialog;"ocultonominas";Num:C11([Alumnos:2]ocultoEnNominas:89))
			OB SET:C1220($dialog;"colegiodestino";[Alumnos:2]Colegio_destino:102)
			OB SET:C1220($dialog;"forzarmotivoretiro";<>viSTR_ForzarMotivoRetiro)
			OB SET:C1220($dialog;"motivoretiro";[Alumnos:2]Motivo_de_retiro:43)
			OB SET:C1220($obj;"dialogo";$dialog)
			$0:=OB_Object2Json ($obj)
		: ($t_estatusActual=$t_estatusNuevo)
			$0:=SERwa_GeneraRespuesta ("-5";"Nada que hacer. Terminar ejecución")
		: (($t_estatusActual#"Retirado@") & ($t_estatusNuevo#"Retirado@") & ([Alumnos:2]nivel_numero:29=Nivel_Retirados))
			$0:=SERwa_GeneraRespuesta ("-4";[Alumnos:2]apellidos_y_nombres:40+" está en el grupo de alumnos retirados. Para activarlo debe utilizar la herramienta de reorganización de cursos.")
		: ((($t_estatusActual="Activo") | ($t_estatusActual="En Tramite") | ($t_estatusActual="Oyente")) & (($t_estatusNuevo="Activo") | ($t_estatusNuevo="En Tramite") | ($t_estatusNuevo="Oyente")))  //PROBADO
			KRL_ReloadInReadWriteMode (->[Alumnos:2])
			[Alumnos:2]Status:50:=$t_estatusNuevo
			SAVE RECORD:C53([Alumnos:2])
			If (ok=1)
				$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
			Else 
				$0:=SERwa_GeneraRespuesta ("-1";"Cambio fallido")
			End if 
			LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_estatusActual+" a "+$t_estatusNuevo)
			KRL_UnloadReadOnly (->[Alumnos:2])
		: ($t_estatusNuevo="Egresado")
			OB SET:C1220($obj;"error";"-6")
			OB SET:C1220($obj;"mensaje";"Solicitar año egreso")
			OB SET:C1220($dialog;"mensaje";"Por favor ingrese el año de egreso")
			OB SET:C1220($dialog;"desde";1492)
			OB SET:C1220($dialog;"hasta";<>GYEAR)
			OB SET:C1220($obj;"dialogo";$dialog)
			$0:=JSON Stringify:C1217($obj)
		: (($t_estatusActual="Promovido anticipadamente") & ($t_estatusNuevo="Activo"))  //PROBADO
			KRL_ReloadInReadWriteMode (->[Alumnos:2])
			[Alumnos:2]Fecha_de_retiro:42:=!00-00-00!
			[Alumnos:2]Status:50:=$t_estatusNuevo
			SAVE RECORD:C53([Alumnos:2])
			If (ok=1)
				$0:=SERwa_GeneraRespuesta ("0";"Cambio exitoso")
			Else 
				$0:=SERwa_GeneraRespuesta ("-1";"Cambio fallido")
			End if 
			AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
			LOG_RegisterEvt ("Estado de alumno "+[Alumnos:2]apellidos_y_nombres:40+" modificado de "+$t_estatusActual+" a "+$t_estatusNuevo)
			KRL_UnloadReadOnly (->[Alumnos:2])
		: ($t_estatusNuevo#"")
			  //desplegar dialogo de retiro en blanco
			OB SET:C1220($obj;"error";"-8")
			OB SET:C1220($obj;"mensaje";"Diálogo de retiro en blanco")
			OB SET:C1220($dialog;"fecharetiro";SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_de_retiro:42))
			OB SET:C1220($dialog;"cursoretiro";[Alumnos:2]Curso_alRetirarse:83)
			OB SET:C1220($dialog;"retiradotemporal";Num:C11([Alumnos:2]Status:50="Retirado temporalmente"))
			OB SET:C1220($dialog;"ocultonominas";Num:C11([Alumnos:2]ocultoEnNominas:89))
			OB SET:C1220($dialog;"colegiodestino";[Alumnos:2]Colegio_destino:102)
			OB SET:C1220($dialog;"forzarmotivoretiro";<>viSTR_ForzarMotivoRetiro)
			OB SET:C1220($dialog;"motivoretiro";[Alumnos:2]Motivo_de_retiro:43)
			OB SET:C1220($obj;"dialogo";$dialog)
			$0:=OB_Object2Json ($obj)
	End case 
Else 
	$0:=SERwa_GeneraRespuesta ("-2";"Alumno no encontrado.")
End if 
