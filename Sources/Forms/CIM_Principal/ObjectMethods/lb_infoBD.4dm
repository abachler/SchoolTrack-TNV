  // CIM_Principal.lb_infoBD()
  // Por: Alberto Bachler K.: 04-11-14, 04:31:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Header Click:K2:40)
		If (Contextual click:C713)
			$l_choice:=Pop up menu:C542(__ ("Fragmentación;Tamaño de las tablas;Tamaño promedio por registro;Más pequeño;Más grande"))
			$y_tamañoTabla:=OBJECT Get pointer:C1124(Object named:K67:5;"infoBD_tamañoTabla")
			
			Case of 
				: (($l_choice>0) & ($l_choice<=1))
					CIM_INFO_FormatTableInfo ($l_choice-1)
				: ($l_choice>1)
					If (AT_GetSumArray ($y_tamañoTabla)=0)
						OK:=CD_Dlog (0;__ ("Obtener este tipo de información requiere un análisis detallado a nivel de registros.\r\rEsta operación puede tomar tiempo en completarse y afectar el rendimiento del servidor mientras se ejecuta.\r\r¿Desea ejecutarla ahora?");"";__ ("No");__ ("Continuar"))
						If (OK=2)
							CIM_INFO_FormatTableInfo ($l_choice-1)
						End if 
					Else 
						CIM_INFO_FormatTableInfo ($l_choice-1)
					End if 
			End case 
		End if 
		
		
End case 