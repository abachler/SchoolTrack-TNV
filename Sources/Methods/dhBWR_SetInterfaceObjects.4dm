//%attributes = {}
  //dhBWR_SetInterfaceObjects

  //xShell, Alberto Bachler
  //Metodo: dhBWR_SetInterfaceObjects
  //Por abachler
  //Creada el 10/02/2004, 08:42:47
  //Modificaciones:
If ("INSTRUCCIONES"="")
	  //llamado desde: BWR_SetInterfaceObjects
	  //utilizar para desviar el procesamiento estandar del evento en xShell
	  //En el Case of poner las instrucciones necesarias para procesar el evento para cada tabla en que se requiera
	  //Asignar True a $trapped si el evento es procesado
End if 

  //****DECLARACIONES****
C_BOOLEAN:C305($trapped;$0)

  //****INICIALIZACIONES****


  //****CUERPO****
Case of 
	: (vsBWR_CurrentModule="AdmissionTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				_O_DISABLE BUTTON:C193(bBWR_AddRecord)
				IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_ExcludeSelection)
				IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_SubSelection)
				$trapped:=True:C214
		End case 
		
	: (vsBWR_CurrentModule="AccountTrack")
		If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
			_O_ENABLE BUTTON:C192(bBWR_AddRecord)
		Else 
			_O_DISABLE BUTTON:C193(bBWR_AddRecord)
		End if 
		IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_ExcludeSelection)
		IT_SetButtonState ((Size of array:C274(abrSelect)>0);->bBWR_SubSelection)
		$trapped:=True:C214
	Else 
		$trapped:=False:C215
End case 
$0:=$trapped