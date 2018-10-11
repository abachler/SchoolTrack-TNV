  // [xShell_Reports].XS_ReportManager.seleccion1()
  // Por: Alberto Bachler K.: 12-08-14, 19:37:57
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_itemActual;$l_itemSeleccionado)


Case of 
	: (Form event:C388=On Clicked:K2:4)
		If ((<>lUSR_CurrentUserID>0) & (Not:C34(USR_IsGroupMember_by_GrpID (-15001;<>lUSR_CurrentUserID))))
			$t_filtro:=PREF_fGet (<>lUSR_CurrentUserID;"universoInformes";"todos")
		Else 
			$t_filtro:="todos"
		End if 
		
		$t_refMenu:=Create menu:C408
		MNU_Append ($t_refMenu;__ ("Públicos o creados por mí");"publicos")
		MNU_Append ($t_refMenu;"(-")
		MNU_Append ($t_refMenu;__ ("Todos");"todos")
		MNU_Append ($t_refMenu;__ ("Estándar");"estandar")
		MNU_Append ($t_refMenu;__ ("Creados en el colegio");"delColegio")
		MNU_Append ($t_refMenu;__ ("Creados por mí");"mios")
		MNU_Append ($t_refMenu;"(-")
		MNU_Append ($t_refMenu;__ ("Creados para el colegio");"estandarDelColegio")
		MNU_Append ($t_refMenu;__ ("Creados para otros colegios");"estandarOtrosColegios")
		
		For ($i;1;Count menu items:C405($t_refMenu))
			If (Get menu item parameter:C1003($t_refMenu;$i)=$t_filtro)
				SET MENU ITEM MARK:C208($t_refMenu;$i;Char:C90(18))
				$i:=Count menu items:C405($t_refMenu)+1
				$t_title:=Get menu item:C422($t_refMenu;$i)
			End if 
		End for 
		
		$t_filtro:=Dynamic pop up menu:C1006($t_refMenu;$t_filtro)
		
		If ($t_filtro#"")
			PREF_Set (<>lUSR_CurrentUserID;"universoInformes";$t_filtro)
			QR_BuildReportHList 
			QR_LoadSelectedReport 
			
		End if 
		
		
End case 

