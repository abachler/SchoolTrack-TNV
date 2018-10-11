Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		b1:=1
		b2:=0
		b3:=0
		cb_SoloCtasActivas:=1
		cb_Agrupar:=1
		viAño:=Year of:C25(Current date:C33(*))
		viAño2:=viAño
		IT_SetButtonState (True:C214;->bMes)
		IT_SetEnterable (True:C214;0;->viAño)
		vi_SelectedMonth:=Month of:C24(Current date:C33(*))
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vt_Mes:=aMeses{vi_SelectedMonth}
		IT_SetEnterable (False:C215;0;->vt_Fecha1;->vt_Fecha2;->viAño2)
		IT_SetButtonState (False:C215;->bCalendar1;->bCalendar2)
		vd_Fecha1:=Current date:C33(*)
		vt_Fecha1:=String:C10(vd_Fecha1;7)
		vd_Fecha2:=Current date:C33(*)
		vt_Fecha2:=String:C10(vd_Fecha2;7)
		
		
		  //******* Nuevo Código ******* 
		ARRAY TEXT:C222(at_NivelDesdeInf;0)
		ARRAY TEXT:C222(at_NivelHastaInf;0)
		ARRAY LONGINT:C221(al_NivelDesdeInf;0)
		ARRAY LONGINT:C221(al_NivelHastaInf;0)
		READ ONLY:C145([xxSTR_Niveles:6])
		ALL RECORDS:C47([xxSTR_Niveles:6])
		QUERY SELECTION:C341([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;at_NivelDesdeInf;[xxSTR_Niveles:6]Nivel:1;at_NivelHastaInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelDesdeInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelHastaInf)
		SORT ARRAY:C229(al_NivelDesdeInf;al_NivelHastaInf;at_NivelDesdeInf;at_NivelHastaInf;>)
		  //*************************** 
		  //******* Código descartado por cambios en Niveles `******* 
		  //COPY ARRAY(◊aNivel;at_NivelDesdeInf)
		  //COPY ARRAY(◊aNivel;at_NivelHastaInf)
		  //COPY ARRAY(◊aNivNo;al_NivelDesdeInf)
		  //COPY ARRAY(◊aNivNo;al_NivelHastaInf)
		  //AT_Insert (1;1;->at_NivelDesdeInf;->at_NivelHastaInf;->al_NivelDesdeInf;->al_NivelHastaInf)
		  //at_NivelDesdeInf{1}:="AdmissionTrack"
		  //at_NivelHastaInf{1}:="AdmissionTrack"
		  //al_NivelDesdeInf{1}:=-4
		  //al_NivelHastaInf{1}:=-4
		  //*************************** 
		at_NivelDesdeInf:=1
		at_NivelHastaInf:=Size of array:C274(at_NivelHastaInf)
		al_NivelDesdeInf:=1
		al_NivelHastaInf:=Size of array:C274(al_NivelHastaInf)
		  //***************************
		ARRAY BOOLEAN:C223(abACT_PrintItem;0)
		ARRAY PICTURE:C279(apACT_PrintItem;0)
		
		ARRAY TEXT:C222(at_anotaciones;0)
		
		  //inicializo con las primeras opciones por grupo
		c_opc1:=1
		D_opc_nivel:=1
		
		READ ONLY:C145([Alumnos_Anotaciones:11])
		
		ALL RECORDS:C47([Alumnos_Anotaciones:11])
		ORDER BY:C49([Alumnos_Anotaciones:11]Categoria:8;>)
		DISTINCT VALUES:C339([Alumnos_Anotaciones:11]Categoria:8;at_anotaciones)
		
		AT_RedimArrays (Size of array:C274(at_anotaciones);->abACT_PrintItem;->apACT_PrintItem)
		SORT ARRAY:C229(at_anotaciones;apACT_PrintItem;abACT_PrintItem;>)
		
		dummyBoolean:=True:C214
		C_PICTURE:C286(dummyPict)
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)
		
		AT_Populate (->apACT_PrintItem;->dummyPict)
		AT_Populate (->abACT_PrintItem;->dummyBoolean)
		
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;1;"apACT_PrintItem";"";30;"1")
		  //$err:=ALP_DefaultColSettings (xALP_ItemsInforme;2;"at_anota_signos";"";20)
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;2;"at_anotaciones";"Anotaciones";290)
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;3;"at_anotaciones";"";50)
		
		ALP_SetDefaultAppareance (xALP_ItemsInforme;9;1;6;1;8)
		AL_SetColOpts (xALP_ItemsInforme;1;1;1;1;0)
		AL_SetRowOpts (xALP_ItemsInforme;0;1;0;0;1;1)
		AL_SetCellOpts (xALP_ItemsInforme;0;1;1)
		AL_SetMiscOpts (xALP_ItemsInforme;1;0;"\\";0;1)
		AL_SetMainCalls (xALP_ItemsInforme;"";"")
		AL_SetScroll (xALP_ItemsInforme;0;-3)
		AL_SetEntryCtls (xALP_ItemsInforme;1;0)
		AL_SetEntryOpts (xALP_ItemsInforme;1;0;0;0;0;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_ItemsInforme;0;30;0)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 


