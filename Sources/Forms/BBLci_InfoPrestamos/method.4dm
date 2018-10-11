  // BBLci_InfoRegistros()
  // Por: Alberto Bachler: 24/10/13, 10:26:43
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"fondo";0x00FFFFFF;0x00FFFFFF)
		OBJECT SET RGB COLORS:C628(*;"SubFormulario";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
		OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
		GOTO SELECTED RECORD:C245([BBL_Prestamos:60];0)
		GOTO SELECTED RECORD:C245([BBL_Registros:66];0)
		  //OBJECT SET RGB COLORS(*;"fondo";0x00EDEDED;0x00EDEDED)
		WDW_AjustaPosicionVentana 
		IT_LeeGeometriaObjetos 
		
		Case of 
			: (Application version:C493>="1400")
				EXECUTE FORMULA:C63("OBJECT SET SUBFORM(*;\"Subformulario\";vy_tablaSubformulario->;\"\";vt_nombreSubFormulario)")
			: (vt_nombreSubFormulario="ListaPrestamos_Lector")
				FORM GOTO PAGE:C247(1)
			: (vt_nombreSubFormulario="ListaPrestamos_Items")
				OBJECT SET RGB COLORS:C628(*;"SubFormulario1";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
				FORM GOTO PAGE:C247(4)
			: (vt_nombreSubFormulario="ListaRegistrosEnConsola")
				OBJECT SET RGB COLORS:C628(*;"SubFormulario2";<>vl_ColorBarra_Borde;<>vl_ColorBarra_Fondo)
				FORM GOTO PAGE:C247(5)
		End case 
		
		
	: (Form event:C388=On Selection Change:K2:29)
		If (vt_nombreSubFormulario#"ListaRegistrosEnConsola")
			RELATE ONE:C42([BBL_Prestamos:60]Número_de_lector:2)
			Case of 
				: (([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!) & ([BBL_Prestamos:60]Hasta:4<Current date:C33(*)))
					OBJECT SET VISIBLE:C603(*;"accion@";True:C214)
					OBJECT SET VISIBLE:C603(*;"accion_mail";[BBL_Lectores:72]eMail:41#"")
				: ([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
					OBJECT SET VISIBLE:C603(*;"accion@";True:C214)
					OBJECT SET VISIBLE:C603(*;"accion_mail";[BBL_Lectores:72]eMail:41#"")
				Else 
					OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
			End case 
			GOTO SELECTED RECORD:C245([BBL_Prestamos:60];0)
		Else 
			GOTO SELECTED RECORD:C245([BBL_Registros:66];0)
		End if 
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
	: (Form event:C388=On Double Clicked:K2:5)
		ACCEPT:C269
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
	: (Form event:C388=On Unload:K2:2)
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		FORM GOTO PAGE:C247(2)
End case 
