  // BBLci_Consola()
  // Por: Alberto Bachler: 25/10/13, 12:16:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT SET RGB COLORS:C628(*;"fondoBoton@";0x00A0A0A0;0x00E4E8EE)
		OBJECT SET RGB COLORS:C628(*;"modo@";0x00687D8E;0x00DDEEFB)
		OBJECT SET RGB COLORS:C628(*;"separadorBarra@";0x00E4F2FC;0x00E4F2FC)
		OBJECT SET RGB COLORS:C628(*;"@marco@";0x00A0A0A0;0x00E4E8EE)
		
		OBJECT SET TITLE:C194(*;"modo1";__ ("Préstamo"))
		OBJECT SET TITLE:C194(*;"modo2";__ ("Devolución/Inv."))
		OBJECT SET TITLE:C194(*;"modo3";__ ("Renovación"))
		OBJECT SET TITLE:C194(*;"modo4";__ ("Reserva"))
		OBJECT SET TITLE:C194(*;"modo5";__ ("Multa"))
		OBJECT SET TITLE:C194(*;"modo6";__ ("Pago"))
		OBJECT SET TITLE:C194(*;"modo7";__ ("Buscar Item"))
		OBJECT SET TITLE:C194(*;"modo8";__ ("Buscar Lector"))
		
		OBJECT SET RGB COLORS:C628(*;"infoLector@";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
		
		
		vl_ModoConsola:=1
		BBLci_estableceModo (vl_ModoConsola)
		BBLci_InformacionesLector ("set")
		BBLci_InformacionesItem ("set")
		
		BBLci_PreferenciasConsola ("Leer")  //MONO Ticket 204231
		
		OBJECT SET RGB COLORS:C628(*;"rectángulo";0x00A0A0A0;0x00FBFBFF)
		OBJECT SET RGB COLORS:C628(*;"lector@";0x00A0A0A0;0x00FBFBFF)
		OBJECT SET RGB COLORS:C628(*;"item@";0x00A0A0A0;0x00FBFBFF)
		OBJECT SET RGB COLORS:C628(*;"lector.rectangulo@";0x00FBFBFF;0x00FBFBFF)
		OBJECT SET RGB COLORS:C628(*;"item.rectangulo";0x00FBFBFF;0x00FBFBFF)
		OBJECT SET RGB COLORS:C628(*;"fondoBusqueda";0x00CDE3F1;0x00FFFFFF)
		OBJECT SET RGB COLORS:C628(*;"lb_log@";0;0x00FBFBFF)
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		If (Macintosh option down:C545 | Windows Alt down:C563)
			CANCEL:C270
			<>lBBL_CircPcsID:=0
		Else 
			vt_InstruccionConsola_BBL:=""
			REDUCE SELECTION:C351([BBL_Prestamos:60];0)
			REDUCE SELECTION:C351([BBL_Items:61];0)
			REDUCE SELECTION:C351([BBL_Registros:66];0)
			REDUCE SELECTION:C351([BBL_Lectores:72];0)
			HIDE PROCESS:C324(<>lBBL_CircPcsID)
			PAUSE PROCESS:C319(<>lBBL_CircPcsID)
		End if 
		
		BBLci_PreferenciasConsola ("Liberar")  //MONO Ticket 204231
		
		
	: (Form event:C388=On Unload:K2:2)
		KRL_UnloadReadOnly (->[xxBBL_Logs:41])
		RELEASE MENU:C978(vt_RefMenuModoBusqueda)
		
		
	: (Form event:C388=On Outside Call:K2:11)
		If (Not:C34(<>bMediaTrackIsRunning))
			  //CANCEL TRANSACTION
			CANCEL:C270
		End if 
	: (Form event:C388=On Resize:K2:27)
		
End case 






