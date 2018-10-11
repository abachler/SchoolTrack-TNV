C_LONGINT:C283(vlb_HeaderAsignatura;vlb_HeaderGrupo;vlb_HeaderID)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		
		_O_DISABLE BUTTON:C193(bTransferirConEvaluaciones)
		_O_DISABLE BUTTON:C193(bTransferirSinEvaluaciones)
		
		LISTBOX INSERT COLUMN:C829(*;"lb_Asignaturas";1;"Asignaturas";aPERep;"HeaderAsignatura";vlb_HeaderAsignatura)
		OBJECT SET TITLE:C194(*;"HeaderAsignatura";__ ("Asignaturas"))
		OBJECT SET FONT STYLE:C166(*;"HeaderAsignatura";1)
		OBJECT SET FONT SIZE:C165(*;"HeaderAsignatura";11)
		LISTBOX SET COLUMN WIDTH:C833(*;"Asignaturas";300)
		
		LISTBOX INSERT COLUMN:C829(*;"lb_Asignaturas";2;"Grupos";aPERepGrp;"HeaderGrupo";vlb_HeaderGrupo)
		OBJECT SET TITLE:C194(*;"HeaderGrupo";__ ("Curso o grupo"))
		OBJECT SET FONT STYLE:C166(*;"HeaderGrupo";1)
		OBJECT SET FONT SIZE:C165(*;"HeaderGrupo";11)
		LISTBOX SET COLUMN WIDTH:C833(*;"Grupos";120)
		OBJECT SET ENTERABLE:C238(*;"Grupos";False:C215)
		
		LISTBOX INSERT COLUMN:C829(*;"lb_Asignaturas";3;"ID";aPERepID;"HeaderID";vlb_HeaderID)
		OBJECT SET TITLE:C194(*;"HeaderID";"ID Asignatura")
		OBJECT SET FONT STYLE:C166(*;"HeaderID";1)
		OBJECT SET FONT SIZE:C165(*;"HeaderID";11)
		LISTBOX SET COLUMN WIDTH:C833(*;"ID";0)
		OBJECT SET ENTERABLE:C238(*;"ID";False:C215)
		
	: (Form event:C388=On Resize:K2:27)
		OBJECT GET COORDINATES:C663(lb_Asignaturas;$left;$top;$right;$bottom)
		$totalWidth:=$right-$left-15
		$colWidth:=$totalWidth-120
		LISTBOX SET COLUMN WIDTH:C833(*;"Asignaturas";$colWidth)
		
	: (Form event:C388=On Clicked:K2:4)
		If (aPERep=0)
			_O_DISABLE BUTTON:C193(bTransferirConEvaluaciones)
			_O_DISABLE BUTTON:C193(bTransferirSinEvaluaciones)
		Else 
			_O_ENABLE BUTTON:C192(bTransferirConEvaluaciones)
			_O_ENABLE BUTTON:C192(bTransferirSinEvaluaciones)
		End if 
		If (vb_NoTransfer)
			_O_DISABLE BUTTON:C193(bTransferirConEvaluaciones)
			_O_DISABLE BUTTON:C193(bTransferirSinEvaluaciones)
		End if 
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
