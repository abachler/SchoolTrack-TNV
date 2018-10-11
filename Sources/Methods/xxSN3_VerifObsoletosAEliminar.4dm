//%attributes = {}
C_LONGINT:C283($0;$aeliminar)
C_LONGINT:C283($1;$tipoDato)
C_POINTER:C301($2)

$tipoDato:=$1

READ ONLY:C145([xxSN3_RegistrosXEnviar:143])

QUERY:C277([xxSN3_RegistrosXEnviar:143];[xxSN3_RegistrosXEnviar:143]accion:3=SNT_Accion_Eliminar;*)
QUERY:C277([xxSN3_RegistrosXEnviar:143]; & ;[xxSN3_RegistrosXEnviar:143]tipoDato:1=$tipoDato)

ARRAY LONGINT:C221($eliminados;0)
ARRAY LONGINT:C221($activoseliminados;0)
ARRAY LONGINT:C221($rneliminados;0)
SELECTION TO ARRAY:C260([xxSN3_RegistrosXEnviar:143]ID:2;$eliminados)
LONGINT ARRAY FROM SELECTION:C647([xxSN3_RegistrosXEnviar:143];$rneliminados;"")

$aeliminar:=0

For ($i;1;Size of array:C274($eliminados))
	KRL_GotoRecord (->[xxSN3_RegistrosXEnviar:143];$rneliminados{$i};False:C215)
	$rn:=Find in field:C653($2->;$eliminados{$i})
	If ($rn#-1)
		Case of 
			: ($tipoDato=5006)
				KRL_GotoRecord (->[ACT_Boletas:181];$rn;False:C215)
				If (Not:C34([ACT_Boletas:181]Nula:15))
					APPEND TO ARRAY:C911(rneliminadosxeliminar;$rneliminados{$i})
					$aeliminar:=$aeliminar+1
				End if 
			: ($tipoDato=SN3_EventosAgenda)
				KRL_GotoRecord (->[Asignaturas_Eventos:170];$rn;False:C215)
				If (([Asignaturas_Eventos:170]Publicar:5) & (Not:C34([Asignaturas_Eventos:170]Privado:9)))
					APPEND TO ARRAY:C911(rneliminadosxeliminar;$rneliminados{$i})
					$aeliminar:=$aeliminar+1
				End if 
			: ($tipoDato=SN3_Calificaciones)
				KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215)
				If (([Alumnos_Calificaciones:208]ID_Alumno:6>=0) & ([Alumnos_Calificaciones:208]ID_Asignatura:5>=0))
					APPEND TO ARRAY:C911(rneliminadosxeliminar;$rneliminados{$i})
					$aeliminar:=$aeliminar+1
					SN3_ManejaReferencias ("actualizar";SN3_Asignaturas;[Alumnos_Calificaciones:208]ID_Asignatura:5;SNT_Accion_Actualizar)
					SN3_ManejaReferencias ("actualizar";SN3_Alumnos;[Alumnos_Calificaciones:208]ID_Alumno:6;SNT_Accion_Actualizar)
				End if 
			: ($tipoDato=SN3_MT_Prestamos)
				KRL_GotoRecord (->[BBL_Prestamos:60];$rn;False:C215)
				If ([BBL_Prestamos:60]Número_de_lector:2>=0)
					APPEND TO ARRAY:C911(rneliminadosxeliminar;$rneliminados{$i})
					$aeliminar:=$aeliminar+1
				End if 
			: ($tipoDato=SN3_Alumnos)
				KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
				If ((([Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta) & ([Alumnos:2]nivel_numero:29<Nivel_Egresados)) & ([Alumnos:2]Status:50#"Ret@"))
					APPEND TO ARRAY:C911(rneliminadosxeliminar;$rneliminados{$i})
					$aeliminar:=$aeliminar+1
				End if 
			Else 
				APPEND TO ARRAY:C911(rneliminadosxeliminar;$rneliminados{$i})
				$aeliminar:=$aeliminar+1
		End case 
	End if 
End for 
$0:=$aeliminar