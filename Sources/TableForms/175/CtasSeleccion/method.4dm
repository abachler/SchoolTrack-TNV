Case of 
	: (Form event:C388=On Load:K2:1)
		
		XS_SetInterface 
		C_PICTURE:C286(dummyPict)
		C_LONGINT:C283($RecNum)
		ARRAY PICTURE:C279(apACT_PrintItem;0)
		ARRAY BOOLEAN:C223(abACT_PrintItem;0)
		
		
		If (Table:C252(yBWR_currentTable)=Table:C252(->[Alumnos:2]))
			QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[ACT_CuentasCorrientes:175]ID_Apoderado:9;*)
			QUERY:C277([Alumnos:2]; | ;[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		Else 
			QUERY:C277([Alumnos:2];[Alumnos:2]Apoderado_Cuentas_Número:28=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
		End if 
		QUERY SELECTION:C341([Alumnos:2];[ACT_CuentasCorrientes:175]Estado:4=True:C214)  //20130830 ASM para cargar en el explorador las cuentas activas en ACT
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;at_CtasCorrientes;[Alumnos:2]numero:1;al_NumAlumno)
		AT_RedimArrays (Size of array:C274(at_CtasCorrientes);->apACT_PrintItem;->abACT_PrintItem)
		
		dummyBoolean:=False:C215
		GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";dummyPict)
		AT_Populate (->apACT_PrintItem;->dummyPict)
		AT_Populate (->abACT_PrintItem;->dummyBoolean)
		
		$el:=Find in array:C230(al_NumAlumno;[ACT_CuentasCorrientes:175]ID_Alumno:3)
		
		If ($el>0)
			dummyBoolean:=True:C214
			GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)
			apACT_PrintItem{$el}:=dummyPict
			abACT_PrintItem{$el}:=dummyBoolean
		End if 
		
		$err:=ALP_DefaultColSettings (xALP_cargaCtas;1;"apACT_PrintItem";"";30;"1")
		$err:=ALP_DefaultColSettings (xALP_cargaCtas;2;"at_CtasCorrientes";__ ("Cuentas Corrientes");290)
		ALP_SetDefaultAppareance (xALP_cargaCtas;9;1;6;1;8)
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
