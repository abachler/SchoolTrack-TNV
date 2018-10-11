If (False:C215)
	  //============================== IDENTIFICACION ==============================
	
	  // Script xAL_Tables
	
	  //Autor: Alberto Bachler
	
	  //Creada el 22/8/96 a 8:05 AM
	
	  //============================== DESCRIPCION ==============================
	
	  //Package:
	
	  //Descripción:
	
	  //Sintaxis:
	
	  //============================== MODIFICACIONES ==============================
	
	  //Fecha: 
	
	  //Autor:
	
	  //Descripción:
	
End if 
If ((alProEvt=1) | (alProevt=2) | (alProEvt=-2))
	$rslt:=AL_GetSelect (xALP_Tables;aLines)
	Case of 
		: ($rslt#1)
			CD_Dlog (0;__ ("No hay suficiente memoria para conservar la selección."))
		: (Size of array:C274(aLines)=1)
			_O_ENABLE BUTTON:C192(bEdit)
			_O_ENABLE BUTTON:C192(bInfos)
			_O_ENABLE BUTTON:C192(bDel)
		: (Size of array:C274(aLines)>1)
			_O_DISABLE BUTTON:C193(bEdit)
			_O_ENABLE BUTTON:C192(bDel)
			_O_DISABLE BUTTON:C193(bInfos)
		: (Size of array:C274(aLines)=0)
			_O_DISABLE BUTTON:C193(bEdit)
			_O_DISABLE BUTTON:C193(bDel)
			_O_DISABLE BUTTON:C193(bInfos)
	End case 
	If (alProEvt=2)
		TBL_EditValue 
	End if 
End if 