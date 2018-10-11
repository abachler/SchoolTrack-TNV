//%attributes = {}
  //AL_CiclosEscolares_Completo



  // 20110810 ABK
  //=======================================
  //    Modificación para 4D v12
  //    Utilización del comando SET LIST ITEM PARAMETER para asignar año, nivel y período a cada elemento de la lista
  //    lo que permite evitar utilizar una referencia de item compuesta de esos valores
  //    Mantuve sin embargo la generación de de la referencia por razones de compatibilidad de código con 4D 2004,
  //    lo que podría eliminarse cuando abandonemos 4D 2004
  //=======================================


C_LONGINT:C283(hl_CiclosEscolares_Completo;$idAlumno;$1;vl_referenciaCicloCompleto;$hl_Periodos)
C_TEXT:C284($text)
$idAlumno:=$1

atSTR_Periodos_Nombre:=0
HL_ClearList (hl_CiclosEscolares_Completo)
HL_ClearList ($hl_Periodos)

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;>;-1000;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6<1000)
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<;[Alumnos_SintesisAnual:210]NumeroNivel:6;<)
hl_CiclosEscolares_Completo:=New list:C375


If ([Alumnos:2]nivel_numero:29>-1000)
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
		If ([Alumnos_SintesisAnual:210]Año:2=<>gYear)
			If ([Alumnos:2]nivel_numero:29<1000)
				If (Count list items:C380(hl_CiclosEscolares_Completo)>0)
					APPEND TO LIST:C376(hl_CiclosEscolares_Completo;"-";-1)
					If (Application version:C493>="12@")
						  //comentar o retirar en 4D 2004
						SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Año";0)
						SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Nivel";0)
						SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Periodo";0)
					End if 
				End if 
				$nombreCiclo:=<>gNombreAgnoEscolar+": "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]Nivel:1)
				PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
				HL_ClearList ($hl_Periodos)
				
				If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
					$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+"0")
				Else 
					$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+"0")
				End if 
				APPEND TO LIST:C376(hl_CiclosEscolares_Completo;$nombreCiclo;$refCiclo)
				If (Application version:C493>="12@")
					  //comentar o retirar en 4D 2004
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Año";[Alumnos_SintesisAnual:210]Año:2)
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Nivel";[Alumnos_SintesisAnual:210]NumeroNivel:6)
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Periodo";0)
				End if 
				For ($iPeriodos;Size of array:C274(atSTR_Periodos_Nombre);1;-1)
					If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
						$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10($iPeriodos))
					Else 
						$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10($iPeriodos))
					End if 
					
					APPEND TO LIST:C376(hl_CiclosEscolares_Completo;"   "+$nombreCiclo+": "+atSTR_Periodos_Nombre{$iPeriodos};$refCiclo)
					If (Application version:C493>="12@")
						  //comentar o retirar en 4D 2004
						SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Año";[Alumnos_SintesisAnual:210]Año:2)
						SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Nivel";[Alumnos_SintesisAnual:210]NumeroNivel:6)
						SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Periodo";$iPeriodos)
					End if 
				End for 
			End if 
		Else 
			
			
			If (Count list items:C380(hl_CiclosEscolares_Completo)>0)
				APPEND TO LIST:C376(hl_CiclosEscolares_Completo;"-";-1)
				If (Application version:C493>="12@")
					  //comentar o retirar en 4D 2004
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Año";0)
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Nivel";0)
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Periodo";0)
				End if 
			End if 
			
			$keyNivelHistorico:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos_SintesisAnual:210]Año:2)
			If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
				$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+"0")
			Else 
				$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+"0")
			End if 
			$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->[Alumnos_SintesisAnual:210]Año:2;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
			$nombreCiclo:=$nombreAñoEscolar+": "+KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivelHistorico;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
			PERIODOS_LeeDatosHistoricos ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
			
			APPEND TO LIST:C376(hl_CiclosEscolares_Completo;$nombreCiclo;$refCiclo)
			If (Application version:C493>="12@")
				  //comentar o retirar en 4D 2004
				SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Año";[Alumnos_SintesisAnual:210]Año:2)
				SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Nivel";[Alumnos_SintesisAnual:210]NumeroNivel:6)
				SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Periodo";0)
			End if 
			For ($iPeriodos;Size of array:C274(atSTR_Periodos_Nombre);1;-1)
				If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
					$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10($iPeriodos))
				Else 
					$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10($iPeriodos))
				End if 
				APPEND TO LIST:C376(hl_CiclosEscolares_Completo;"   "+$nombreCiclo+": "+atSTR_Periodos_Nombre{$iPeriodos};$refCiclo)
				If (Application version:C493>="12@")
					  //comentar o retirar en 4D 2004
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Año";[Alumnos_SintesisAnual:210]Año:2)
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Nivel";[Alumnos_SintesisAnual:210]NumeroNivel:6)
					SET LIST ITEM PARAMETER:C986(hl_CiclosEscolares_Completo;0;"Periodo";$iPeriodos)
				End if 
			End for 
		End if 
	End for 
	
	
	If (Count list items:C380(hl_CiclosEscolares_Completo)>0)
		If (HL_FindInListByReference (hl_CiclosEscolares_Completo;vl_referenciaCicloCompleto)="")
			vl_referenciaCicloCompleto:=0
		End if 
		If (vl_referenciaCicloCompleto=0)
			Case of 
				: ([Alumnos:2]nivel_numero:29<=-1000)
					vl_referenciaCicloCompleto:=0
					
				: ([Alumnos:2]nivel_numero:29<1000)
					PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
					If (viSTR_PeriodoActual_Numero>0)
						If ([Alumnos:2]nivel_numero:29<0)
							vl_referenciaCicloCompleto:=-Num:C11(String:C10(<>gYear;"0000")+String:C10(Abs:C99([Alumnos:2]nivel_numero:29);"00")+"0")
							  //vl_referenciaCicloCompleto:=-Num(String(◊gYear;"0000")+String(Abs([Alumnos]Nivel_Número);"00")+String(viSTR_PeriodoActual_Numero))
						Else 
							vl_referenciaCicloCompleto:=Num:C11(String:C10(<>gYear;"0000")+String:C10([Alumnos:2]nivel_numero:29;"00")+"0")
						End if 
						SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares_Completo;vl_referenciaCicloCompleto)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares_Completo;1)
					End if 
					
					
				: ([Alumnos:2]nivel_numero:29>=1000)
					SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares_Completo;1)
					
			End case 
			
			
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares_Completo;vl_referenciaCicloCompleto)
		End if 
		
		GET LIST ITEM:C378(hl_CiclosEscolares_Completo;*;vl_referenciaCicloCompleto;$text)
		If (Application version:C493>="12@")
			  //comentar en 4D 2004
			GET LIST ITEM:C378(hl_CiclosEscolares_Completo;*;vl_referenciaCicloCompleto;$text)
			GET LIST ITEM PARAMETER:C985(hl_CiclosEscolares_Completo;*;"Año";vl_Year)
			GET LIST ITEM PARAMETER:C985(hl_CiclosEscolares_Completo;*;"Nivel";vl_NivelSeleccionado)
			GET LIST ITEM PARAMETER:C985(hl_CiclosEscolares_Completo;*;"Periodo";vl_periodoSeleccionado)
		Else 
			
			If (vl_referenciaCicloCompleto#0)
				If (vl_referenciaCicloCompleto>0)
					$stringRef:=String:C10(vl_referenciaCicloCompleto)
					vl_Year:=Num:C11(Substring:C12(String:C10(vl_referenciaCicloCompleto);1;4))
					vl_NivelSeleccionado:=Num:C11(Substring:C12(String:C10(vl_referenciaCicloCompleto);5;2))
					vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
					
				Else 
					$absoluteRef:=Abs:C99(vl_referenciaCicloCompleto)
					$stringRef:=String:C10($absoluteRef)
					vl_Year:=Num:C11(Substring:C12(String:C10($absoluteRef);1;4))
					vl_NivelSeleccionado:=-Num:C11(Substring:C12(String:C10($absoluteRef);5;2))
					vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
				End if 
			Else 
				vl_Year:=0
				vl_NivelSeleccionado:=0
				vl_periodoSeleccionado:=0
			End if 
		End if 
		
		
	Else 
		vl_Year:=0
		vl_NivelSeleccionado:=0
		vl_periodoSeleccionado:=0
	End if 
End if 
