  // CIM_Principal.webArea()
  // Por: Alberto Bachler Klein: 24-10-15, 10:49:12
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Begin URL Loading:K2:45)
		OBJECT SET VISIBLE:C603(*;"barra";True:C214)
		OBJECT GET COORDINATES:C663(*;"barra";$l_izquierda;$_arriba;$l_derecha;$l_abajo)
		IT_SetNamedObjectRect ("barra";$l_izquierda;$_arriba;$l_izquierda+1;$l_abajo)
		  //SET TIMER(20)
		
	: (Form event:C388=On End URL Loading:K2:47)
		SET TIMER:C645(0)
		OBJECT SET VISIBLE:C603(*;"barra";False:C215)
		
	: (Form event:C388=On URL Resource Loading:K2:46)
		If ((webArea_progress>0) & (webArea_progress<100))
			$l_ancho:=IT_Objeto_Ancho ("barraOriginal")
			$r_ratio:=webArea_progress/100
			OBJECT GET COORDINATES:C663(*;"barra";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			$l_derecha:=$l_ancho*$r_ratio
			IT_SetNamedObjectRect ("barra";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		End if 
End case 