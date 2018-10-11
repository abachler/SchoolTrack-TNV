If (USR_checkRights ("M";->[Familia:78]))
	$saved:=ACTcc_fSave   //guarda el registro en caso de modificaciones ya que saldrá de de la memoria
	If ($saved>=0)
		$currentRecNum:=Record number:C243([ACT_CuentasCorrientes:175])  //conservamos el recnum del registro para volver a el al final
		aStdFmID:=0
		vApID:=0
		aPersId:=0
		<>aParentesco:=0
		SAVE RECORD:C53([Familia:78])
		READ WRITE:C146([Familia:78])
		$familyRecNum:=Record number:C243([Familia:78])
		AL_UpdateArrays (xALP_Familia;0)
		AL_UpdateArrays (xAL_ccUF;0)
		ARRAY LONGINT:C221(al_IdPersona;0)
		QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
		SELECTION TO ARRAY:C260([Familia_RelacionesFamiliares:77]ID_Persona:3;al_IdPersona)
		WDW_OpenFormWindow (->[Familia_RelacionesFamiliares:77];"Input";-1;4;__ ("Relaciones familiares"))
		FORM SET INPUT:C55([Familia_RelacionesFamiliares:77];"Input")
		ADD RECORD:C56([Familia_RelacionesFamiliares:77];*)
		CLOSE WINDOW:C154
		READ WRITE:C146([ACT_CuentasCorrientes:175])
		GOTO RECORD:C242([ACT_CuentasCorrientes:175];$currentRecNum)  //volvemos al registro
		READ ONLY:C145([Alumnos:2])
		RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)  //cargamos nuevamente los datos del alumno para recargar las relaciones familiares
		AT_Initialize (->al_IdPersona)
		AL_LoadFamRels 
		AL_UpdateArrays (xALP_Familia;-2)
		AL_SetLine (xALP_Familia;0)
		UFLD_LoadFileTplt (->[ACT_CuentasCorrientes:175])
		UFLD_LoadFields (->[ACT_CuentasCorrientes:175];->[ACT_CuentasCorrientes:175]UserFields:26;->[ACT_CuentasCorrientes]UserFields'Value;->xAL_ccUF)
		AL_UpdateArrays (xAL_ccUF;-2)
	Else 
		$ignore:=CD_Dlog (0;__ ("Usted no dispone de los privilegios suficientes para realizar esta operación."))
	End if 
End if 