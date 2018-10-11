//%attributes = {}
  //ACTpgs_SetObjectsCargosDocument

Case of 
	: (vbACT_CargosDesdeAviso)
		$line:=AL_GetLine (ALP_AvisosXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubir)
		Else 
			_O_ENABLE BUTTON:C192(bSubir)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_AIDAviso)))
			_O_DISABLE BUTTON:C193(bBajar)
		Else 
			_O_ENABLE BUTTON:C192(bBajar)
		End if 
		
	: (vbACT_CargosDesdeItems)
		$line:=AL_GetLine (ALP_ItemsXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirItem)
		Else 
			_O_ENABLE BUTTON:C192(bSubirItem)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_RefItem)))
			_O_DISABLE BUTTON:C193(bBajarItem)
		Else 
			_O_ENABLE BUTTON:C192(bBajarItem)
		End if 
		
	: (vbACT_CargosDesdeAlumnos)
		$line:=AL_GetLine (ALP_AlumnosXPagar)
		If (($line=0) | ($line=1))
			_O_DISABLE BUTTON:C193(bSubirCuenta)
		Else 
			_O_ENABLE BUTTON:C192(bSubirCuenta)
		End if 
		
		If (($line=0) | ($line=Size of array:C274(alACT_AIdsCtas)))
			_O_DISABLE BUTTON:C193(bBajarCuenta)
		Else 
			_O_ENABLE BUTTON:C192(bBajarCuenta)
		End if 
		
End case 

  //line:=ALP_CargosXPagar
$line:=AL_GetLine (ALP_CargosXPagar)
If (($line=0) | ($line=1))
	_O_DISABLE BUTTON:C193(bSubirC)
Else 
	_O_ENABLE BUTTON:C192(bSubirC)
End if 
If (($line=0) | ($line=Size of array:C274(adACT_CFechaEmision)))
	_O_DISABLE BUTTON:C193(bBajarC)
Else 
	_O_ENABLE BUTTON:C192(bBajarC)
End if 
If (USR_checkRights ("D";->[ACT_Cargos:173]))
	If ($line>0)
		_O_ENABLE BUTTON:C192(bDelCargos)
	Else 
		_O_DISABLE BUTTON:C193(bDelCargos)
	End if 
Else 
	_O_DISABLE BUTTON:C193(bDelCargos)
End if 