

C_POINTER:C301($srcObject;$l_columnaVar)
C_LONGINT:C283($srcElement;$srcProcess;$row;$l_columna)

Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (atMPA_EtapasArea=0)
			If (MPAcfg_Area_PosibleAñadirEtapa )
				MPAcfg_Area_AgregaEtapa 
				EDIT ITEM:C870(Self:C308->;atMPA_EtapasArea)
			Else 
				BEEP:C151
			End if 
		Else 
			EDIT ITEM:C870(Self:C308->;atMPA_EtapasArea)
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		LISTBOX GET CELL POSITION:C971(*;"lb_etapas";$l_columna;$row;$l_columnaVar)
		If (Contextual click:C713)
			
			If (MPAcfg_Area_PosibleAñadirEtapa )
				  // si ES posible añadir una etapa el item Añadir... " del menu contextual es activado
				$_itemAñadir:=__ ("Añadir Etapa de aprendizaje")
			Else 
				  // si NO ES posible añadir una etapa el item Añadir... " del menu contextual es inactivado
				$_itemAñadir:="("+__ ("Añadir Etapa de aprendizaje")
			End if 
			
			Case of 
				: (Size of array:C274(atMPA_EtapasArea)=1)
					$result:=Pop up menu:C542($_itemAñadir+__ (";Renombrar...;(-;(Eliminar");0)
				Else 
					$result:=Pop up menu:C542($_itemAñadir+__ (";Renombrar...;(-;Eliminar");0)
			End case 
			Case of 
				: ($result=1)
					MPAcfg_Area_AgregaEtapa 
				: ($result=2)
					EDIT ITEM:C870(atMPA_EtapasArea;$row)
				: ($result=4)
					LISTBOX GET CELL POSITION:C971(*;"lb_etapas";$l_columna;$row;$l_columnaVar)
					OK:=MPAcfg_Area_EliminaEtapa ([MPA_DefinicionAreas:186]ID:1;alMPA_NivelDesde{$row};alMPA_NivelHasta{$row})
			End case 
		Else 
			$oldNivelDesde:=alMPA_NivelDesde{$row}
			$oldNivelHasta:=alMPA_NivelHasta{$row}
			
			Case of 
				: (($l_columna=2) & ($row>0))
					$popUp:=""
					QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
					SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;$aNombreNivel;[xxSTR_Niveles:6]NoNivel:5;$aNumeroNivel)
					SORT ARRAY:C229($aNumeroNivel;$aNombreNivel;>)
					$text:=AT_array2text (->$aNombreNivel;";")
					$result:=Pop up menu:C542($text;0)
					If ($result>0)
						$nuevoNivel:=$aNumeroNivel{$result}
						$accept:=True:C214
						For ($i;1;Size of array:C274(atMPA_EtapasArea))
							If (($nuevoNivel>=alMPA_NivelDesde{$i}) & ($nuevoNivel<=alMPA_NivelHasta{$i}) & ($i#$row))
								  //If ($nuevoNivel>$oldNivelDesde)
								$accept:=False:C215
								$i:=Size of array:C274(atMPA_EtapasArea)+1
								CD_Dlog (0;__ ("El nivel académico seleccionado ya está asignado a otra etapa.\r\rNo es posible asignar un nivel a más de una etapa."))
							End if 
						End for 
						If ($accept)
							If ($nuevoNivel>alMPA_NivelHasta{$row})
								CD_Dlog (0;__ ("El nivel de término de la etapa no puede ser inferior al nivel de inicio."))
							Else 
								alMPA_NivelDesde{$row}:=$nuevoNivel
							End if 
						End if 
					End if 
					
					
				: (($l_columna=3) & ($row>0))
					$popUp:=""
					QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]EsNIvelActivo:30=True:C214)
					SELECTION TO ARRAY:C260([xxSTR_Niveles:6]Nivel:1;$aNombreNivel;[xxSTR_Niveles:6]NoNivel:5;$aNumeroNivel)
					SORT ARRAY:C229($aNumeroNivel;$aNombreNivel;>)
					$text:=AT_array2text (->$aNombreNivel;";")
					$result:=Pop up menu:C542($text;0)
					If ($result>0)
						$nuevoNivel:=$aNumeroNivel{$result}
						$accept:=True:C214
						For ($i;1;Size of array:C274(atMPA_EtapasArea))
							If (($nuevoNivel>=alMPA_NivelDesde{$i}) & ($nuevoNivel<=alMPA_NivelHasta{$i}) & ($i#$row))
								  //If (($nuevoNivel<$oldNivelHasta))
								$accept:=False:C215
								$i:=Size of array:C274(atMPA_EtapasArea)+1
								CD_Dlog (0;__ ("El nivel académico seleccionado ya está asignado a otra etapa.\r\rNo es posible asignar un nivel a más de una etapa."))
							End if 
						End for 
						
						If ($accept)
							If ($nuevoNivel<alMPA_NivelDesde{$row})
								CD_Dlog (0;__ ("El nivel de término de la etapa no puede ser inferior al nivel de inicio."))
							Else 
								alMPA_NivelHasta{$row}:=$nuevoNivel
							End if 
						End if 
					End if 
					
			End case 
			
			If (($oldNivelDesde#alMPA_NivelDesde{$row}) | ($oldNivelHasta#alMPA_NivelHasta{$row}))
				OK:=MPAcfg_Area_CambiaLimitesEtapa ([MPA_DefinicionAreas:186]ID:1;$oldNivelDesde;$oldNivelHasta;alMPA_NivelDesde{$row};alMPA_NivelHasta{$row})
				If (OK=0)
					alMPA_NivelDesde{$row}:=$oldNivelDesde
					alMPA_NivelHasta{$row}:=$oldNivelHasta
				End if 
			End if 
			
			
			$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;alMPA_NivelDesde{$row})
			If ($recNum>=0)
				GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
				atMPA_NivelDesde{$row}:="["+String:C10([xxSTR_Niveles:6]NoNivel:5)+"] "+[xxSTR_Niveles:6]Nivel:1
			End if 
			
			$recNum:=Find in field:C653([xxSTR_Niveles:6]NoNivel:5;alMPA_NivelHasta{$row})
			If ($recNum>=0)
				GOTO RECORD:C242([xxSTR_Niveles:6];$recNum)
				atMPA_NivelHasta{$row}:="["+String:C10([xxSTR_Niveles:6]NoNivel:5)+"] "+[xxSTR_Niveles:6]Nivel:1
			End if 
		End if 
		
	: (Form event:C388=On Header Click:K2:40)
		
		
	: (Form event:C388=On Data Change:K2:15)
		LISTBOX GET CELL POSITION:C971(lb_Etapas;$l_Columna;$l_Fila)
		$t_nombreElementoActual:=atMPA_EtapasArea{$l_Fila}
		
		If ($t_nombreElementoActual="")
			$t_nombreElementoActual:="Etapa "+String:C10($l_Fila)+" ("+String:C10(alMPA_NivelDesde{$l_Fila})+"º a "+String:C10(alMPA_NivelDesde{$l_Fila})+"º)"
			atMPA_EtapasArea{0}:=$t_nombreElementoActual
			atMPA_EtapasArea{$l_Fila}:=$t_nombreElementoActual
			CD_Dlog (0;__ ("Etapa sin nombre. Se le asignó el nombre: ")+"\""+$t_nombreElementoActual+"\".")
		End if 
		
		$l_numeroCopia:=0
		ARRAY LONGINT:C221($al_ElementosEncontrados;0)
		atMPA_EtapasArea{0}:=$t_nombreElementoActual
		AT_MultiArraySearch (False:C215;->$al_ElementosEncontrados;->atMPA_EtapasArea)
		While (Size of array:C274($al_ElementosEncontrados)>1)
			$l_numeroCopia:=$l_numeroCopia+1
			atMPA_EtapasArea{0}:=$t_nombreElementoActual+" "+String:C10($l_numeroCopia)
			atMPA_EtapasArea{$l_Fila}:=$t_nombreElementoActual+" "+String:C10($l_numeroCopia)
			ARRAY LONGINT:C221($al_ElementosEncontrados;0)
			AT_MultiArraySearch (False:C215;->$al_ElementosEncontrados;->atMPA_EtapasArea)
		End while 
		
		If ($l_numeroCopia>0)
			CD_Dlog (0;__ ("El nombre de una etapa debe ser único en cada area.\r\rLa etapa fue renombrada como ")+"\""+atMPA_EtapasArea{$l_Fila}+"\".")
		End if 
End case 
