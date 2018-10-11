If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Formule format : IncludedList
	  //Autor: Alberto Bachler
	  //Creada el 30/6/96 a 6:48 PM
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		WDW_SlideDrawer (->[Alumnos:2];"SetFamilia")
		vt_text1:=""
		_O_DISABLE BUTTON:C193(bSelect)
		If (vt_FamilyName#"")
			OBJECT SET TITLE:C194(bCreateFamily;__ ("Crear familia ")+Char:C90(34)+vt_FamilyName+Char:C90(34))
		Else 
			OBJECT SET VISIBLE:C603(bCreateFamily;False:C215)
		End if 
	: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Data Change:K2:15))
		If (aFamilia>0)
			_O_ENABLE BUTTON:C192(bSelect)
		Else 
			_O_DISABLE BUTTON:C193(bSelect)
		End if 
End case 
