//%attributes = {}
  //AL_CiclosEscolares

C_LONGINT:C283(hl_CiclosEscolares;$idAlumno;$1;vl_ReferenciaCiclo;$hl_Periodos)
C_TEXT:C284($text)
$idAlumno:=$1

HL_ClearList (hl_CiclosEscolares)
HL_ClearList ($hl_Periodos)

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;>;-1000;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6<1000)
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<;[Alumnos_SintesisAnual:210]NumeroNivel:6;<)
hl_CiclosEscolares:=New list:C375

If ([Alumnos:2]nivel_numero:29>-1000)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
		If ([Alumnos_SintesisAnual:210]Año:2=<>gYear)
			If (Count list items:C380(hl_CiclosEscolares)>0)
				APPEND TO LIST:C376(hl_CiclosEscolares;"-";-1)
			End if 
			If ([Alumnos:2]nivel_numero:29<1000)
				$nombreCiclo:=<>gNombreAgnoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]Nivel:1)
				PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
				For ($iPeriodos;Size of array:C274(atSTR_Periodos_Nombre);1;-1)
					If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
						$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10($iPeriodos))
					Else 
						$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10($iPeriodos))
					End if 
					
					APPEND TO LIST:C376(hl_CiclosEscolares;$nombreCiclo+": "+atSTR_Periodos_Nombre{$iPeriodos};$refCiclo)
				End for 
				
			End if 
		Else 
			If (Count list items:C380(hl_CiclosEscolares)>0)
				APPEND TO LIST:C376(hl_CiclosEscolares;"-";-1)
			End if 
			$keyNivelHistorico:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos_SintesisAnual:210]Año:2)
			$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00"))
			$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->[Alumnos_SintesisAnual:210]Año:2;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
			$nombreCiclo:=$nombreAñoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivelHistorico;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
			PERIODOS_LeeDatosHistoricos ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
			If (Size of array:C274(atSTR_Periodos_Nombre)>0)
				For ($iPeriodos;Size of array:C274(atSTR_Periodos_Nombre);1;-1)
					If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
						$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10($iPeriodos))
					Else 
						$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10($iPeriodos))
					End if 
					APPEND TO LIST:C376(hl_CiclosEscolares;$nombreCiclo+": "+atSTR_Periodos_Nombre{$iPeriodos};$refCiclo)
				End for 
			Else 
				If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
					$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10(1))
				Else 
					$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10(1))
				End if 
				APPEND TO LIST:C376(hl_CiclosEscolares;$nombreCiclo+" (solo final anual)";$refCiclo)
			End if 
		End if 
	End for 
	
	
	If (Count list items:C380(hl_CiclosEscolares)>0)
		If (HL_FindInListByReference (hl_CiclosEscolares;vl_referenciaCiclo)="")
			vl_referenciaCiclo:=0
		End if 
		If (vl_referenciaCiclo=0)
			Case of 
				: ([Alumnos:2]nivel_numero:29<=-1000)
					vl_referenciaCiclo:=0
					
				: ([Alumnos:2]nivel_numero:29<1000)
					PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
					If (viSTR_PeriodoActual_Numero>0)
						If ([Alumnos:2]nivel_numero:29<0)
							vl_referenciaCiclo:=-Num:C11(String:C10(<>gYear;"0000")+String:C10(Abs:C99([Alumnos:2]nivel_numero:29);"00")+String:C10(viSTR_PeriodoActual_Numero))
						Else 
							vl_referenciaCiclo:=Num:C11(String:C10(<>gYear;"0000")+String:C10([Alumnos:2]nivel_numero:29;"00")+String:C10(viSTR_PeriodoActual_Numero))
						End if 
						SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares;vl_referenciaCiclo)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares;1)
					End if 
					
					
				: ([Alumnos:2]nivel_numero:29>=1000)
					SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares;1)
					
			End case 
			
			
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares;vl_referenciaCiclo)
		End if 
		
		GET LIST ITEM:C378(hl_CiclosEscolares;*;vl_referenciaCiclo;$text)
		If (vl_referenciaCiclo#0)
			If (vl_referenciaCiclo>0)
				$stringRef:=String:C10(vl_referenciaCiclo)
				vl_Year:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo);1;4))
				vl_NivelSeleccionado:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo);5;2))
				vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
				
			Else 
				$absoluteRef:=Abs:C99(vl_referenciaCiclo)
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
		
	Else 
		vl_Year:=0
		vl_NivelSeleccionado:=0
		vl_periodoSeleccionado:=0
	End if 
	
End if 

  //AL_CiclosEscolares

C_LONGINT:C283(hl_CiclosEscolares;$idAlumno;$1;vl_ReferenciaCiclo;$hl_Periodos)
C_TEXT:C284($text)
$idAlumno:=$1

HL_ClearList (hl_CiclosEscolares)
HL_ClearList ($hl_Periodos)

QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; | [Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;>;-1000;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6<1000)
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<;[Alumnos_SintesisAnual:210]NumeroNivel:6;<)
hl_CiclosEscolares:=New list:C375

If ([Alumnos:2]nivel_numero:29>-1000)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
		If ([Alumnos_SintesisAnual:210]Año:2=<>gYear)
			If (Count list items:C380(hl_CiclosEscolares)>0)
				APPEND TO LIST:C376(hl_CiclosEscolares;"-";-1)
			End if 
			If ([Alumnos:2]nivel_numero:29<1000)
				$nombreCiclo:=<>gNombreAgnoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]Nivel:1)
				PERIODOS_LoadData ([Alumnos_SintesisAnual:210]NumeroNivel:6)
				For ($iPeriodos;Size of array:C274(atSTR_Periodos_Nombre);1;-1)
					If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
						$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10($iPeriodos))
					Else 
						$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10($iPeriodos))
					End if 
					
					APPEND TO LIST:C376(hl_CiclosEscolares;$nombreCiclo+": "+atSTR_Periodos_Nombre{$iPeriodos};$refCiclo)
				End for 
				
			End if 
		Else 
			If (Count list items:C380(hl_CiclosEscolares)>0)
				APPEND TO LIST:C376(hl_CiclosEscolares;"-";-1)
			End if 
			$keyNivelHistorico:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos_SintesisAnual:210]Año:2)
			$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00"))
			$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->[Alumnos_SintesisAnual:210]Año:2;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
			$nombreCiclo:=$nombreAñoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivelHistorico;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
			PERIODOS_LeeDatosHistoricos ([Alumnos_SintesisAnual:210]NumeroNivel:6;[Alumnos_SintesisAnual:210]Año:2)
			If (Size of array:C274(atSTR_Periodos_Nombre)>0)
				For ($iPeriodos;Size of array:C274(atSTR_Periodos_Nombre);1;-1)
					If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
						$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10($iPeriodos))
					Else 
						$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10($iPeriodos))
					End if 
					APPEND TO LIST:C376(hl_CiclosEscolares;$nombreCiclo+": "+atSTR_Periodos_Nombre{$iPeriodos};$refCiclo)
				End for 
			Else 
				If ([Alumnos_SintesisAnual:210]NumeroNivel:6>0)
					$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00")+String:C10(1))
				Else 
					$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00")+String:C10(1))
				End if 
				APPEND TO LIST:C376(hl_CiclosEscolares;$nombreCiclo+" (solo final anual)";$refCiclo)
			End if 
		End if 
	End for 
	
	
	If (Count list items:C380(hl_CiclosEscolares)>0)
		If (HL_FindInListByReference (hl_CiclosEscolares;vl_referenciaCiclo)="")
			vl_referenciaCiclo:=0
		End if 
		If (vl_referenciaCiclo=0)
			Case of 
				: ([Alumnos:2]nivel_numero:29<=-1000)
					vl_referenciaCiclo:=0
					
				: ([Alumnos:2]nivel_numero:29<1000)
					PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
					If (viSTR_PeriodoActual_Numero>0)
						If ([Alumnos:2]nivel_numero:29<0)
							vl_referenciaCiclo:=-Num:C11(String:C10(<>gYear;"0000")+String:C10(Abs:C99([Alumnos:2]nivel_numero:29);"00")+String:C10(viSTR_PeriodoActual_Numero))
						Else 
							vl_referenciaCiclo:=Num:C11(String:C10(<>gYear;"0000")+String:C10([Alumnos:2]nivel_numero:29;"00")+String:C10(viSTR_PeriodoActual_Numero))
						End if 
						SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares;vl_referenciaCiclo)
					Else 
						SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares;1)
					End if 
					
					
				: ([Alumnos:2]nivel_numero:29>=1000)
					SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares;1)
					
			End case 
			
			
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares;vl_referenciaCiclo)
		End if 
		
		GET LIST ITEM:C378(hl_CiclosEscolares;*;vl_referenciaCiclo;$text)
		If (vl_referenciaCiclo#0)
			If (vl_referenciaCiclo>0)
				$stringRef:=String:C10(vl_referenciaCiclo)
				vl_Year:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo);1;4))
				vl_NivelSeleccionado:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo);5;2))
				vl_periodoSeleccionado:=Num:C11($stringRef[[Length:C16($stringRef)]])
				
			Else 
				$absoluteRef:=Abs:C99(vl_referenciaCiclo)
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
		
	Else 
		vl_Year:=0
		vl_NivelSeleccionado:=0
		vl_periodoSeleccionado:=0
	End if 
	
End if 

