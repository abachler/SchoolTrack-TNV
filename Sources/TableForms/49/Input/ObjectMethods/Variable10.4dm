If (ADTcdd_esRegistroValido )
	ARRAY LONGINT:C221(aADT_IDsPersonas;1)
	SAVE RECORD:C53([Alumnos:2])
	SAVE RECORD:C53([ADT_Candidatos:49])
	SAVE RECORD:C53([Familia:78])
	$rn:=Record number:C243([Alumnos:2])
	PST_UpdateParents ("Mother")
	AL_UpdateArrays (xALP_UFields;0)
	  //conservamos el metodo y parametros de navegación actuales (Explorador SchoolTrack)
	
	$vlBWR_BrowsingMethod:=vlBWR_BrowsingMethod
	$yBWR_currentTable:=yBWR_currentTable
	$vyBWR_CustonFieldRefPointer:=vyBWR_CustonFieldRefPointer
	$vyBWR_CustomArrayPointer:=vyBWR_CustomArrayPointer
	
	  //cambiamos el metodo de navegación para que esta se haga sobre la base de los arreglos del area
	yBWR_currentTable:=->[Personas:7]
	vyBWR_CustomArrayPointer:=->aADT_IDsPersonas
	aADT_IDsPersonas:=1
	vyBWR_CustonFieldRefPointer:=->[Personas:7]No:1
	vlBWR_BrowsingMethod:=BWR Array Browsing
	
	GOTO RECORD:C242([Personas:7];viPST_MotherRecNum)
	aADT_IDsPersonas{1}:=[Personas:7]No:1
	
	WDW_OpenFormWindow (->[Personas:7];"Input";0;4;__ ("Detalles de la Madre");"wdw_CloseDlog")
	KRL_ModifyRecord (->[Personas:7];"Input")
	CLOSE WINDOW:C154
	UNLOAD RECORD:C212([Personas:7])
	
	  //reestablecemos el metodo de navegación previo
	vlBWR_BrowsingMethod:=$vlBWR_BrowsingMethod
	yBWR_currentTable:=$yBWR_currentTable
	vyBWR_CustonFieldRefPointer:=$vyBWR_CustonFieldRefPointer
	vyBWR_CustomArrayPointer:=$vyBWR_CustomArrayPointer
	BWR_SetInputFormButtons 
	AT_Initialize (->aADT_IDsPersonas)
	KRL_GotoRecord (->[Alumnos:2];$rn;True:C214)
	PST_GetFamilyRelations 
	UFLD_LoadFileTplt (->[ADT_Candidatos:49])
	UFLD_LoadFields (->[ADT_Candidatos:49];->[ADT_Candidatos:49]UserFields:42;->[ADT_Candidatos]UserFields'Value;->xALP_UFields)
	xALSet_AreasCamposUsuario (xALP_UFields)
End if 