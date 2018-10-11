  // [Profesores].Input.lb_Titulos
  // Por: Alberto Bachler: 27/04/13, 06:36:09
  //  ---------------------------------------------

Case of 
	: ((Form event:C388=On Clicked:K2:4) & (USR_checkRights ("M";->[Profesores:4])))
		If (LB_GetSelectedRows (->lb_Titulos)>0)
			_O_ENABLE BUTTON:C192(bEliminarTitulo)
		Else 
			at_TitulosProfesores:=0
			_O_DISABLE BUTTON:C193(bEliminarTitulo)
		End if 
		
	: ((Form event:C388=On Double Clicked:K2:5) & (at_TitulosProfesores#0))
		WDW_Open (354;107;1;Movable form dialog box:K39:8;"Títulos";"Wdw_CloseDdlog")
		QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5;=;[Profesores:4]Numero:1;*)
		QUERY:C277([Profesores_Titulos:216]; & ;[Profesores_Titulos:216]Titulo:1=at_TitulosProfesores{at_TitulosProfesores})
		KRL_ModifyRecord (->[Profesores_Titulos:216];"Input")
		CLOSE WINDOW:C154
		ARRAY TEXT:C222(at_TitulosProfesores;0)
		QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5=[Profesores:4]Numero:1)
		SELECTION TO ARRAY:C260([Profesores_Titulos:216]Titulo:1;at_TitulosProfesores)
		at_TitulosProfesores:=0
End case 

