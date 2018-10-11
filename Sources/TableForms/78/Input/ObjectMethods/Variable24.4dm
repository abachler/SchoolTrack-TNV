C_LONGINT:C283($size)
If (_O_During:C30)
	Case of 
		: (ALProEvt=1)
			aPersID:=AL_GetLine (xALP_Familia)
		: (ALProEvt=2)
			aPersID:=AL_GetLine (xALP_Familia)
			If (Windows Alt down:C563 | Macintosh option down:C545)
				AL_UpdateArrays (xALP_FamUFields;0)
				AL_UpdateArrays (xALP_Familia;0)
				PUSH RECORD:C176([Familia_RelacionesFamiliares:77])
				AL_MostrarApdo 
				POP RECORD:C177([Familia_RelacionesFamiliares:77])
			Else 
				AL_UpdateArrays (xALP_FamUFields;0)
				AL_UpdateArrays (xALP_Familia;0)
				QUERY:C277([Familia_RelacionesFamiliares:77];[Familia_RelacionesFamiliares:77]ID_Persona:3=aPersID{aPersID};*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & [Familia_RelacionesFamiliares:77]ID_Familia:2=[Familia:78]Numero:1;*)
				QUERY:C277([Familia_RelacionesFamiliares:77]; & ;[Familia_RelacionesFamiliares:77]Parentesco:6=aParentesco{aPersID})
				WDW_OpenFormWindow (->[Familia_RelacionesFamiliares:77];"Input";7;4;__ ("Relaciones Familiares");"wdw_closeDlog")
				KRL_ModifyRecord (->[Familia_RelacionesFamiliares:77];"Input")
				  //20131009 ASM Para marcar el campo cuando se cambie el parentesco 
				AL_MarcaCampoHijoFuncionario ([Familia_RelacionesFamiliares:77]ID_Persona:3;Record number:C243([Familia:78]))
				CLOSE WINDOW:C154
			End if 
			UFLD_LoadFileTplt (->[Familia:78])
			UFLD_LoadFields (->[Familia:78];->[Familia:78]Userfields:13;->[Familia]Userfields'Value;->xALP_FamUFields)
			If (([Familia:78]Dirección:7="") & ([Familia:78]Comuna:8="") & ([Familia:78]Ciudad:9=""))
				[Familia:78]Dirección:7:=[Personas:7]Direccion:14
				[Familia:78]Comuna:8:=[Personas:7]Comuna:16
				[Familia:78]Ciudad:9:=[Personas:7]Ciudad:17
			End if 
			If ([Familia:78]Telefono:10="")
				[Familia:78]Telefono:10:=[Personas:7]Telefono_domicilio:19
			End if 
			bBWR_Cancel:=0
			bClose:=0
			FM_LoadRelation 
			FM_OnActivate 
			AL_UpdateArrays (xALP_Familia;-2)
			AL_SetLine (xALP_Familia;0)
	End case 
End if 

