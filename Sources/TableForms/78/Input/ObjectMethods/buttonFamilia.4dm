AL_UpdateArrays (xALP_Familia;0)
AL_UpdateArrays (xALP_FamUFields;0)
$saved:=FM_fSave 
If ($saved>=0)
	aStdFmID:=0
	vApID:=0
	aPersID:=0
	<>aParentesco:=0
	WDW_OpenFormWindow (->[Familia_RelacionesFamiliares:77];"Input";-1;4;__ ("Relaciones familiares"))
	FORM SET INPUT:C55([Familia_RelacionesFamiliares:77];"Input")
	ADD RECORD:C56([Familia_RelacionesFamiliares:77];*)
	CLOSE WINDOW:C154
	If (OK=1)
		If ([Familia:78]Dirección:7="")
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
		AL_UpdateArrays (xALP_Familia;-2)
		ALP_SetAlternateLigneColor (xALP_Familia;Size of array:C274(aParentesco))
		AL_SetLine (xALP_Familia;0)
	End if 
	FM_OnActivate 
End if 
AL_UpdateArrays (xALP_Familia;-2)
ALP_SetAlternateLigneColor (xALP_Familia;Size of array:C274(aParentesco))
AL_SetLine (xALP_Familia;0)
UFLD_LoadFileTplt (->[Familia:78])
UFLD_LoadFields (->[Familia:78];->[Familia:78]Userfields:13;->[Familia]Userfields'Value;->xALP_FamUFields)