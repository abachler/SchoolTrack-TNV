//%attributes = {}
  //AL_PageFamily

IT_MODIFIERS 
vb_UpdateAddress:=False:C215
If (([Alumnos:2]Familia_Número:24=0) | (<>shift))
	[Alumnos:2]Familia_Número:24:=AL_SelectFmlia 
	SAVE RECORD:C53([Alumnos:2])
	If ([Alumnos:2]Familia_Número:24#0)
		$saved:=AL_fSave 
	End if 
End if 
If ([Alumnos:2]Familia_Número:24#0)
	$ReadOnlyState:=AL_LoadFamily 
	If ($readOnlyState)
		CD_Dlog (0;__ ("La ficha de la familia fue accesada en modo escritura por otro usuario o proceso. \rLa modificaciones que usted introduzca no podrán ser registradas."))
		UFLD_LoadFileTplt (->[Alumnos:2])
		AL_OnRecordLoad (1)
		$0:=0
	Else 
		If ([Alumnos:2]Direccion:12="")
			[Alumnos:2]Direccion:12:=[Familia:78]Dirección:7
			[Alumnos:2]Comuna:14:=[Familia:78]Comuna:8
			[Alumnos:2]Ciudad:15:=[Familia:78]Ciudad:9
			[Alumnos:2]Codigo_Postal:13:=[Familia:78]Codigo_postal:19
			[Alumnos:2]Región_o_estado:16:=[Familia:78]Region_o_estado:34
			$saved:=AL_fSave 
		End if 
		If ([Alumnos:2]Telefono:17="")
			[Alumnos:2]Telefono:17:=[Familia:78]Telefono:10
			$saved:=AL_fSave 
		End if 
		If ([Alumnos:2]Fax:69="")
			[Alumnos:2]Fax:69:=[Familia:78]Fax:20
			$saved:=AL_fSave 
		End if 
		If ((<>gGroupAL=False:C215) & ([Alumnos:2]Grupo:11="") & ([Familia:78]Grupo_Familia:4#""))
			[Alumnos:2]Grupo:11:=[Familia:78]Grupo_Familia:4
			$saved:=AL_fSave 
		End if 
		UFLD_LoadFileTplt (->[Familia:78])
		UFLD_LoadFields (->[Familia:78];->[Familia:78]Userfields:13;->[Familia]Userfields'Value;->xALP_FamUFields)
		$0:=1
	End if 
Else 
	$0:=0
End if 
vCustTipo:=""
vCustNombres:=""
vCustCel:=""
vCustCasa:=""
bCustodio:=0
READ ONLY:C145([Personas:7])
READ ONLY:C145([Familia_RelacionesFamiliares:77])
If ([Alumnos:2]ID_Custodio:99#0)
	$rn:=Find in field:C653([Personas:7]No:1;[Alumnos:2]ID_Custodio:99)
	If ($rn#-1)
		GOTO RECORD:C242([Personas:7];$rn)
		$rn:=Find in field:C653([Familia_RelacionesFamiliares:77]ID_Persona:3;[Personas:7]No:1)
		If ($rn#-1)
			GOTO RECORD:C242([Familia_RelacionesFamiliares:77];$rn)
			vCustTipo:=[Familia_RelacionesFamiliares:77]Parentesco:6
			vCustNombres:=[Personas:7]Apellidos_y_nombres:30
			vCustCel:=[Personas:7]Celular:24
			vCustCasa:=[Personas:7]Telefono_domicilio:19
			bCustodio:=1
		End if 
	End if 
End if 
OBJECT SET VISIBLE:C603(*;"cambiarcust@";([Alumnos:2]ID_Custodio:99#0))

If (USR_checkRights ("M";->[Familia:78])=False:C215)
	KRL_ReloadAsReadOnly (->[Familia:78])
	OBJECT SET ENTERABLE:C238(*;"@restringido";False:C215)
	_O_DISABLE BUTTON:C193(*;"@restringido")
	_O_ENABLE BUTTON:C192(hlTab_STR_alumnos)
Else 
	KRL_ReloadInReadWriteMode (->[Familia:78])
	OBJECT SET ENTERABLE:C238(*;"@restringido";True:C214)
	_O_ENABLE BUTTON:C192(*;"@restringido")
End if 
AL_OnActivate 