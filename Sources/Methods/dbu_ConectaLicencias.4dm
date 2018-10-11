//%attributes = {}
  // dbu_ConectaLicencias()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 26/12/12, 11:12:22
  // ---------------------------------------------
C_LONGINT:C283($i;$j;$l_IDprocesoProgreso)

ARRAY DATE:C224($ad_FinLicencia;0)
ARRAY DATE:C224($ad_InicioLicencia;0)
ARRAY LONGINT:C221($al_RecNumsInasistencias;0)
ARRAY LONGINT:C221($al_IdLicencia;0)
ARRAY TEXT:C222($aTipoLicencia;0)

  // CÓDIGO
ALL RECORDS:C47([Alumnos_Inasistencias:10])
LONGINT ARRAY FROM SELECTION:C647([Alumnos_Inasistencias:10];$al_RecNumsInasistencias;"")
$l_IDprocesoProgreso:=IT_Progress (1;0;0;"Relacionando Inasistencias y Licencias...")
For ($i;1;Size of array:C274($al_RecNumsInasistencias))
	READ WRITE:C146([Alumnos_Inasistencias:10])
	KRL_GotoRecord (->[Alumnos_Inasistencias:10];$al_RecNumsInasistencias{$i};True:C214)
	If (OK=0)
		ALERT:C41("RecordNumber perdido")
	Else 
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos_Inasistencias:10]Alumno_Numero:4)
		QUERY SELECTION:C341([Alumnos_Licencias:73];[Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{1};*)
		QUERY SELECTION:C341([Alumnos_Licencias:73]; | [Alumnos_Licencias:73]Tipo_licencia:4=<>aLicencias{2})
		SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_InicioLicencia;[Alumnos_Licencias:73]Hasta:3;$ad_FinLicencia;[Alumnos_Licencias:73]ID:6;$al_IdLicencia;[Alumnos_Licencias:73]Tipo_licencia:4;$aTipoLicencia)
		[Alumnos_Inasistencias:10]Justificación:2:=""
		[Alumnos_Inasistencias:10]Licencia:5:=0
		For ($j;1;Size of array:C274($ad_InicioLicencia))
			If (([Alumnos_Inasistencias:10]Fecha:1>=$ad_InicioLicencia{$j}) & ([Alumnos_Inasistencias:10]Fecha:1<=$ad_FinLicencia{$j}))
				[Alumnos_Inasistencias:10]Licencia:5:=$al_IdLicencia{$j}
				[Alumnos_Inasistencias:10]Justificación:2:=$aTipoLicencia{$j}+" Nº "+String:C10($al_IdLicencia{$j})
				$j:=Size of array:C274($ad_InicioLicencia)
			End if 
		End for 
		SAVE RECORD:C53([Alumnos_Inasistencias:10])
	End if 
	$l_IDprocesoProgreso:=IT_Progress (0;$l_IDprocesoProgreso;$i/Size of array:C274($al_RecNumsInasistencias);"Relacionando Inasistencias y Licencias...")
End for 
$l_IDprocesoProgreso:=IT_Progress (-1;$l_IDprocesoProgreso)
UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
READ ONLY:C145([Alumnos_Inasistencias:10])

