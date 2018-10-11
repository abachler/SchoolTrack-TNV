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
		
		SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;at_NivelDesdeInf;[xxSTR_Niveles:6]Nivel:1;at_NivelHastaInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelDesdeInf;[xxSTR_Niveles:6]NoNivel:5;al_NivelHastaInf)
		
		
		
		
		  // Modificado por: Alexis Bustamante (24-06-2016)
		
		  //se agrega codigo para que se agreguen los niveles ADT desistidos y retirados
		  //con numero de nivel -1004,-1005 ya que los alumnos de este nivel quedaban fuera de la seleccion
		  //en el informe especial ACTcc_InformePagados
		  //se agregaran los niveles solo si exsiten alumnos con dichos niveles
		  //Tikcet 163752 
		
		C_LONGINT:C283(vl_CantReg)
		vl_CantReg:=0
		
		  //ADT DESISTIDOS
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;vl_CantReg)
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=-1004)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (vl_CantReg=1)
			AT_Insert (1;1;->at_NivelDesdeInf;->at_NivelHastaInf;->al_NivelDesdeInf;->al_NivelHastaInf)
			at_NivelDesdeInf{1}:="ADT Desistidos"
			at_NivelHastaInf{1}:="ADT Desistidos"
			al_NivelDesdeInf{1}:=-1004
			al_NivelHastaInf{1}:=-1004
			vl_CantReg:=0
		End if 
		
		
		
		vl_CantReg:=0
		  //ADT RETIRADOS
		SET QUERY LIMIT:C395(1)
		SET QUERY DESTINATION:C396(Into variable:K19:4;vl_CantReg)
		QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=-1005)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If (vl_CantReg=1)
			AT_Insert (1;1;->at_NivelDesdeInf;->at_NivelHastaInf;->al_NivelDesdeInf;->al_NivelHastaInf)
			at_NivelDesdeInf{1}:="ADT Retirados"
			at_NivelHastaInf{1}:="ADT Retirados"
			al_NivelDesdeInf{1}:=-1005
			al_NivelHastaInf{1}:=-1005
			vl_CantReg:=0
		End if 
		
		  ////////////////////////////////////////////////////////////////////////////////////////////////////////
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
		
		ARRAY TEXT:C222(at_WhichPhoneInf;3)
		ARRAY POINTER:C280(aPtr_WhichPhoneInf;3)
		at_WhichPhoneInf{1}:=__ ("Teléfono Domicilio")
		at_WhichPhoneInf{2}:=__ ("Teléfono Profesional")
		at_WhichPhoneInf{3}:=__ ("Teléfono Móvil")
		aPtr_WhichPhoneInf{1}:=->[Personas:7]Telefono_domicilio:19
		aPtr_WhichPhoneInf{2}:=->[Personas:7]Telefono_profesional:29
		aPtr_WhichPhoneInf{3}:=->[Personas:7]Celular:24
		at_WhichPhoneInf:=1
		aPtr_WhichPhoneInf:=1
		cb_PrintPhone:=0
		cb_ProximoCurso:=0
		cb_ObsApdo:=0
		OBJECT SET VISIBLE:C603(*;"telefono";False:C215)
		
		_O_ARRAY STRING:C218(2;asACT_SinItemMark;0)
		ARRAY BOOLEAN:C223(abACT_PrintItem;0)
		ARRAY PICTURE:C279(apACT_PrintItem;0)
		ARRAY TEXT:C222(atACT_GlosasItem;0)
		ARRAY LONGINT:C221(alACT_IDsItems;0)
		ARRAY LONGINT:C221(aIDsSinItem;0)
		ARRAY TEXT:C222(atACT_GlosasSinItem;0)
		READ ONLY:C145([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215;*)
		QUERY:C277([xxACT_Items:179]; & ;[xxACT_Items:179]EsDescuento:6=False:C215)
		SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;alACT_IDsItems;[xxACT_Items:179]Glosa:2;atACT_GlosasItem)
		AT_RedimArrays (Size of array:C274(alACT_IDsItems);->asACT_SinItemMark)
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215;*)
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
		CREATE SET:C116([ACT_Cargos:173];"todos")
		QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->alACT_IDsItems;True:C214)
		CREATE SET:C116([ACT_Cargos:173];"conItem")
		DIFFERENCE:C122("todos";"conItem";"sinItem")
		USE SET:C118("sinItem")
		SET_ClearSets ("todos";"conItem";"sinItem")
		  //SELECTION TO ARRAY([ACT_Cargos]Ref_Item;aIDsSinItem;[ACT_Cargos]Glosa;atACT_GlosasSinItem)
		  //AT_DistinctsArrayValues (->aIDsSinItem)
		  //AT_DistinctsArrayValues (->atACT_GlosasSinItem)
		
		  //20130513 ASM se agrega código para solucionar problema en los tamaños de los arreglos.
		ARRAY TEXT:C222(atACT_GlosasSinItem;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_Item:16;aIDsSinItem)
		AT_DistinctsArrayValues (->aIDsSinItem)
		
		For ($i;1;Size of array:C274(aIDsSinItem))
			  //20130513 ASM se agrega código para solucionar problema en los tamaños de los arreglos.
			SET QUERY LIMIT:C395(1)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=aIDsSinItem{$i})
			APPEND TO ARRAY:C911(atACT_GlosasSinItem;[ACT_Cargos:173]Glosa:12)
			SET QUERY LIMIT:C395(0)
			
			AT_Insert (0;1;->alACT_IDsItems;->atACT_GlosasItem;->asACT_SinItemMark)
			alACT_IDsItems{Size of array:C274(alACT_IDsItems)}:=aIDsSinItem{$i}
			atACT_GlosasItem{Size of array:C274(atACT_GlosasItem)}:=atACT_GlosasSinItem{$i}
			asACT_SinItemMark{Size of array:C274(asACT_SinItemMark)}:="*"
		End for 
		AT_RedimArrays (Size of array:C274(atACT_GlosasItem);->abACT_PrintItem;->apACT_PrintItem)
		SORT ARRAY:C229(atACT_GlosasItem;alACT_IDsItems;apACT_PrintItem;abACT_PrintItem;asACT_SinItemMark;>)
		AT_Initialize (->aIDsSinItem;->atACT_GlosasSinItem)
		dummyBoolean:=True:C214
		C_PICTURE:C286(dummyPict)
		  //GET ICON RESOURCE(20010;dummyPict)
		GET PICTURE FROM LIBRARY:C565("XS_EntryAccept";dummyPict)  //20180420 RCH
		AT_Populate (->apACT_PrintItem;->dummyPict)
		AT_Populate (->abACT_PrintItem;->dummyBoolean)
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;1;"apACT_PrintItem";"";30;"1")
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;2;"asACT_SinItemMark";"";20)
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;3;"atACT_GlosasItem";"Glosa";290)
		$err:=ALP_DefaultColSettings (xALP_ItemsInforme;4;"alACT_IDsItems";"")
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
