Case of 
	: (ALProEvt=1)
		aPersID:=AL_GetLine (xALP_Familia)
	: (ALProEvt=2)
		$saved:=ACTcc_fSave   //guarda el registro en caso de modificaciones ya que saldrá de de la memoria
		If ($saved>=0)
			$currentRecNum:=Record number:C243([ACT_CuentasCorrientes:175])  //conservamos el recnum del registro para volver a el al final
			aPersID:=AL_GetLine (xALP_Familia)
			AL_UpdateArrays (xAL_ccUF;0)
			If (IT_AltKeyIsDown )
				AL_MostrarApdo 
			Else 
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=aPersID{aPersID};*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]ID_Familia:2=[ACT_CuentasCorrientes:175]ID_Familia:2)
				  //QUERY([Familia_RelacionesFamiliares]; & ;[Familia_RelacionesFamiliares]Parentesco=aParentesco{aPersID}) `incidente 65555. Se deja igual que en ST
				WDW_OpenFormWindow (->[Familia_RelacionesFamiliares:77];"Input";6;4;__ ("Relaciones familiares"))
				KRL_ModifyRecord (->[Familia_RelacionesFamiliares:77];"Input")
				  //210131009 ASM Para marcar el campo hijo de funcionario cuando cambie el partentesco
				AL_MarcaCampoHijoFuncionario ([Familia_RelacionesFamiliares:77]ID_Persona:3)
				CLOSE WINDOW:C154
			End if 
			AT_Initialize (->aUFItmName;->aUFItmVal)
			UFLD_LoadFileTplt (->[ACT_CuentasCorrientes:175])
			UFLD_LoadFields (->[ACT_CuentasCorrientes:175];->[ACT_CuentasCorrientes:175]UserFields:26;->[ACT_CuentasCorrientes]UserFields'Value;->xAL_ccUF)
			AL_UpdateArrays (xAL_ccUF;-2)
			READ WRITE:C146([ACT_CuentasCorrientes:175])
			GOTO RECORD:C242([ACT_CuentasCorrientes:175];$currentRecNum)  //volvemos al registro
			READ ONLY:C145([Alumnos:2])
			RELATE ONE:C42([ACT_CuentasCorrientes:175]ID_Alumno:3)  //cargamos nuevamente los datos del alumno para recargar las relaciones familiares
			AL_UpdateArrays (xALP_Familia;0)
			AL_LoadFamRels 
			ACTcc_OnActivation 
			AL_UpdateArrays (xALP_Familia;-2)
			AL_SetLine (xALP_Familia;0)
		End if 
End case 
