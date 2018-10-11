  // ----------------------------------------------------
  // Método: [ADT_Candidatos].Documentacion.documentos
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
C_LONGINT:C283($l_abajo;$l_altoEncabezado;$l_altoFilas;$l_arriba;$l_botonMouse;$l_derecha;$l_fila;$l_izquierda;$l_mouseX;$l_mouseY)
C_TEXT:C284($t_texto)

Case of 
	: (Form event:C388=On Mouse Move:K2:35)
		$l_altoEncabezado:=LISTBOX Get headers height:C1144(lbDocumentos;lk pixels:K53:22)
		$l_altoFilas:=LISTBOX Get rows height:C836(lbDocumentos)
		OBJECT GET COORDINATES:C663(Self:C308->;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		GET MOUSE:C468($l_mouseX;$l_mouseY;$l_botonMouse)
		If ($l_mouseY>($l_arriba+$l_altoEncabezado))
			$l_mouseY:=$l_mouseY-$l_arriba-$l_altoEncabezado
			$l_fila:=Mod:C98($l_mouseY;$l_altoFilas)
			$l_fila:=($l_mouseY-$l_fila)/$l_altoFilas
			Case of 
				: (($l_mouseX>603) & ($l_mouseX<623))
					If ($l_fila<=(Size of array:C274(abADT_DElectronico)-1))
						If (abADT_DElectronico{$l_fila+1})
							If (IT_AltKeyIsDown )
								API Create Tip ("Seleccionar nuevo archivo";603;($l_fila*$l_altoFilas)+$l_arriba+$l_altoEncabezado;623;($l_fila*$l_altoFilas)+$l_altoFilas+$l_arriba+$l_altoEncabezado)
							Else 
								$t_texto:="Abrir archivo. Si usted modifica el archivo debe seleccionarlo nuevamente."
								API Create Tip ($t_texto;603;($l_fila*$l_altoFilas)+$l_arriba+$l_altoEncabezado;623;($l_fila*$l_altoFilas)+$l_altoFilas+$l_arriba+$l_altoEncabezado)
							End if 
						Else 
							API Create Tip ("Seleccionar nuevo archivo";603;($l_fila*$l_altoFilas)+$l_arriba+$l_altoEncabezado;623;($l_fila*$l_altoFilas)+$l_altoFilas+$l_arriba+$l_altoEncabezado)
						End if 
					End if 
				: (($l_mouseX>623) & ($l_mouseX<643))
					If ($l_fila<=(Size of array:C274(abADT_DElectronico)-1))
						If (abADT_DElectronico{$l_fila+1})
							API Create Tip ("Mostrar archivo en disco";623;($l_fila*$l_altoFilas)+$l_arriba+$l_altoEncabezado;643;($l_fila*$l_altoFilas)+$l_altoFilas+$l_arriba+$l_altoEncabezado)
						End if 
					End if 
				: (($l_mouseX>643) & ($l_mouseX<663))
					If ($l_fila<=(Size of array:C274(abADT_DElectronico)-1))
						If (abADT_DElectronico{$l_fila+1})
							API Create Tip ("Eliminar archivo asociado";643;($l_fila*$l_altoFilas)+$l_arriba+$l_altoEncabezado;663;($l_fila*$l_altoFilas)+$l_altoFilas+$l_arriba+$l_altoEncabezado)
						End if 
					End if 
			End case 
		End if 
End case 