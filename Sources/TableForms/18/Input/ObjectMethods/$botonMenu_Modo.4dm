  // [Asignaturas].Input.$botonMenu_Modo()
  // Por: Alberto Bachler K.: 03-02-14, 18:34:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_noOcultarNotaOficial)
C_LONGINT:C283($i;$l_colorConFoco;$l_ColorSinFoco;$l_itemSeleccionado)
C_TEXT:C284($t_item;$t_itemsPopup)

$l_colorConFoco:=0x0000
$l_ColorSinFoco:=0x0000 | (120 << 16) | (120 << 8) | 120

AL_ExitCell (xALP_ASNotas)


Case of 
		
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET RGB COLORS:C628(*;OBJECT Get name:C1087(Object current:K67:2);$l_colorConFoco;Background color none:K23:10)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET RGB COLORS:C628(*;OBJECT Get name:C1087(Object current:K67:2);$l_ColorSinFoco;Background color none:K23:10)
		
		
	: (Form event:C388=On Clicked:K2:4)
		
		$b_mostrarNotaOficial:=(AT_IsEqual (->aNtaF;->aNtaOF)=0) & ([Asignaturas:18]Incide_en_promedio:27)
		
		If (vb_NotaOficialVisible)
			If ($b_mostrarNotaOficial)
				$t_itemsPopup:=__ ("Notas;Puntos;Porcentaje;Simbolos;(-;Ocultar Nota Oficial")
			Else 
				$t_itemsPopup:=__ ("Notas;Puntos;Porcentaje;Simbolos;(-;(Ocultar Nota Oficial")
			End if 
		Else 
			If ($b_mostrarNotaOficial)
				$t_itemsPopup:=__ ("Notas;Puntos;Porcentaje;Simbolos;(-;Mostrar Nota Oficial")
			Else 
				$t_itemsPopup:=__ ("Notas;Puntos;Porcentaje;Simbolos;(-;(Mostrar Nota Oficial")
			End if 
		End if 
		
		$t_item:=ST_GetWord ($t_itemsPopup;vi_lastGradeView;";")
		$t_itemsPopup:=Replace string:C233($t_itemsPopup;$t_item;"!"+Char:C90(18)+$t_item)
		$l_itemSeleccionado:=Pop up menu:C542($t_itemsPopup)
		If ($l_itemSeleccionado>0)
			If ($l_itemSeleccionado=6)
				AS_ShowHideNotaOficial 
			Else 
				NTA_ModeConversion (vi_lastGradeView;$l_itemSeleccionado)
				AS_ConfiguraAreaCalificaciones 
			End if 
		End if 
		AS_OpcionesPaginaEvaluacion 
End case 