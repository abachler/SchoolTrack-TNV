Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		b1:=0
		b2:=0
		b3:=1
		b4:=0
		b5:=0
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
		SORT ARRAY:C229(al_NivelDesdeInf;al_NivelHastaInf;at_NivelDesdeInf;at_NivelHastaInf;>)
		
		  //*************************** 
		
		at_NivelDesdeInf:=1
		at_NivelHastaInf:=Size of array:C274(at_NivelHastaInf)
		al_NivelDesdeInf:=1
		al_NivelHastaInf:=Size of array:C274(al_NivelHastaInf)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
