C_LONGINT:C283($size)
C_TEXT:C284($numeroFamilia)

Case of 
	: (ALProEvt=1)
		aPersID:=AL_GetLine (xALP_Familia)
	: (ALProEvt=2)
		
		$numeroFamilia:=[Familia:78]Telefono:10
		IT_MODIFIERS 
		READ WRITE:C146([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		aPersID:=AL_GetLine (xALP_Familia)
		$currentRecNum:=Record number:C243([Alumnos:2])  //conservamos el recnum del registro para volver a el al final
		$state:=Read only state:C362([Alumnos:2])
		If (<>Option)
			AL_UpdateArrays (xALP_FamUFields;0)
			AL_MostrarApdo 
		Else 
			AL_UpdateArrays (xALP_FamUFields;0)
			SAVE RECORD:C53([Familia:78])
			QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=aPersID{aPersID};*)
			QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Alumnos:2]Familia_Número:24)
			WDW_OpenFormWindow (->[Familia_RelacionesFamiliares:77];"Input";-1;4;__ ("Relaciones familiares"))
			
			  //20160310 ASM leo propiedades de emisión de avisos por si se realiza cambio de apoderado academico
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			
			KRL_ModifyRecord (->[Familia_RelacionesFamiliares:77];"Input")
			  //210131009 ASM Para marcar el campo hijo de funcionario cuando cambie el partentesco
			AL_MarcaCampoHijoFuncionario ([Familia_RelacionesFamiliares:77]ID_Persona:3)
			CLOSE WINDOW:C154
			  //QUERY([Familia];[Familia]Numero=[Alumnos]Familia_Número)
		End if 
		KRL_GotoRecord (->[Alumnos:2];$currentRecNum;Not:C34($state))
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		If (([Familia:78]Dirección:7="") & ([Familia:78]Comuna:8="") & ([Familia:78]Ciudad:9=""))
			[Familia:78]Dirección:7:=[Personas:7]Direccion:14
			[Familia:78]Comuna:8:=[Personas:7]Comuna:16
			[Familia:78]Ciudad:9:=[Personas:7]Ciudad:17
		End if 
		  //AL_UpdateArrays (xAL_FamUfields;0)
		UFLD_LoadFileTplt (->[Familia:78])
		UFLD_LoadFields (->[Familia:78];->[Familia:78]Userfields:13;->[Familia]Userfields'Value;->xALP_FamUFields)
		bBWR_Cancel:=0
		bClose:=0
		SAVE RECORD:C53([Familia:78])
		AL_UpdateArrays (xALP_Familia;0)
		LOAD RECORD:C52([Alumnos:2])
		AL_LoadFamRels 
		AL_OnActivate 
		AL_UpdateArrays (xALP_Familia;-2)
		AL_SetLine (xALP_Familia;0)
		UNLOAD RECORD:C212([Familia:78])
		READ WRITE:C146([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Numero:1=[Alumnos:2]Familia_Número:24)
		[Familia:78]Telefono:10:=$numeroFamilia
End case 