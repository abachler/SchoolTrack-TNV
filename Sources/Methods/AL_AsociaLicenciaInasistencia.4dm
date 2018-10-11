//%attributes = {}
  //AL_AsociaLicenciaInasistencia 

C_DATE:C307($d_desde;$d_hasta;$d_fecha)
C_LONGINT:C283($i;$id_alumno)
C_TEXT:C284($vt_accion)

ARRAY LONGINT:C221($al_RecNum;0)
$vt_accion:=$1
$id_alumno:=$2
$d_fecha:=$3

Case of 
	: ($vt_accion="AsociaLicencia")
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$id_alumno)
		SELECTION TO ARRAY:C260([Alumnos_Licencias:73];$al_RecNum)
		If (Records in selection:C76([Alumnos_Licencias:73])>0)
			For ($i;1;Size of array:C274($al_RecNum))
				GOTO RECORD:C242([Alumnos_Licencias:73];$al_RecNum{$i})
				$d_desde:=[Alumnos_Licencias:73]Desde:2
				$d_hasta:=[Alumnos_Licencias:73]Hasta:3
				While ($d_desde<=$d_hasta)
					If ($d_desde=$d_fecha)
						QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$id_alumno;*)
						QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$d_fecha;*)
						QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Licencia:5=0)
						If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
							KRL_ReloadInReadWriteMode (->[Alumnos_Inasistencias:10])
							[Alumnos_Inasistencias:10]Licencia:5:=[Alumnos_Licencias:73]ID:6
							[Alumnos_Inasistencias:10]Justificación:2:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
							[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Inasistencias:10]Observaciones:3
							[Alumnos_Inasistencias:10]Licencia:5:=[Alumnos_Licencias:73]ID:6
							SAVE RECORD:C53([Alumnos_Inasistencias:10])
							KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
						End if 
					End if 
					$d_desde:=$d_desde+1
				End while 
			End for 
		End if 
		
End case 

