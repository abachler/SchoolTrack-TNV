//%attributes = {}
  // Método: AL_CiclosEscolares_Historico
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/06/10, 08:25:02
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
C_LONGINT:C283(hl_CiclosEscolares_Historico;$idAlumno;$1;vl_referenciaCiclo_Histórico;$hl_Periodos)
C_TEXT:C284($text)
$idAlumno:=$1

HL_ClearList (hl_CiclosEscolares_Historico)
QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;-[Alumnos:2]numero:1;*)
QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2#0)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6;>;-1003;*)
QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6<1000)
ORDER BY:C49([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;<;[Alumnos_SintesisAnual:210]NumeroNivel:6;<)
$lastYear:=[Alumnos_SintesisAnual:210]Año:2


hl_CiclosEscolares_Historico:=New list:C375

If (([Alumnos:2]nivel_numero:29>-1000) | (Records in selection:C76([Alumnos_SintesisAnual:210])>0))
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Alumnos_SintesisAnual:210];$aRecNums;"")
	For ($i;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Alumnos_SintesisAnual:210];$aRecNums{$i})
		If ([Alumnos_SintesisAnual:210]Año:2#$lastYear)
			APPEND TO LIST:C376(hl_CiclosEscolares_Historico;"-";0)
		End if 
		$keyNivelHistorico:=KRL_MakeStringAccesKey (-><>gInstitucion;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[Alumnos_SintesisAnual:210]Año:2)
		If ([Alumnos_SintesisAnual:210]NumeroNivel:6<0)
			$refCiclo:=-Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10(Abs:C99([Alumnos_SintesisAnual:210]NumeroNivel:6);"00"))
		Else 
			$refCiclo:=Num:C11(String:C10([Alumnos_SintesisAnual:210]Año:2;"0000")+String:C10([Alumnos_SintesisAnual:210]NumeroNivel:6;"00"))
		End if 
		  //MONO Ticket 184433 historico de nivel pero del mismo año
		If ([Alumnos_SintesisAnual:210]Año:2=<>gyear)
			$nombreCiclo:=<>gNombreAgnoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos_SintesisAnual:210]NumeroNivel:6;->[xxSTR_Niveles:6]Nivel:1)
		Else 
			$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->[Alumnos_SintesisAnual:210]Año:2;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
			$nombreCiclo:=$nombreAñoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles:191]LlavePrimaria:11;->$keyNivelHistorico;->[xxSTR_HistoricoNiveles:191]NombreInterno:5)
		End if 
		  //$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre]Year;->[Alumnos_SintesisAnual]Año;->[xxSTR_DatosDeCierre]NombreAgnoEscolar)
		  //$nombreCiclo:=$nombreAñoEscolar+" - "+KRL_GetTextFieldData (->[xxSTR_HistoricoNiveles]LlavePrimaria;->$keyNivelHistorico;->[xxSTR_HistoricoNiveles]NombreInterno)
		
		APPEND TO LIST:C376(hl_CiclosEscolares_Historico;$nombreCiclo;$refCiclo)
	End for 
	
	
	If (Count list items:C380(hl_CiclosEscolares_Historico)>0)
		If (HL_FindInListByReference (hl_CiclosEscolares_Historico;vl_referenciaCiclo_Histórico)="")
			vl_referenciaCiclo_Histórico:=0
		End if 
		If (vl_referenciaCiclo_Histórico=0)
			SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares_Historico;1)
		Else 
			SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares_Historico;vl_referenciaCiclo_Histórico)
		End if 
		
		GET LIST ITEM:C378(hl_CiclosEscolares_Historico;*;vl_referenciaCiclo_Histórico;$text)
		If (vl_referenciaCiclo_Histórico#0)
			If (vl_referenciaCiclo_Histórico>0)
				$stringRef:=String:C10(vl_referenciaCiclo_Histórico)
				vl_Year_Historico:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo_Histórico);1;4))
				vl_NivelSeleccionado_Historico:=Num:C11(Substring:C12(String:C10(vl_referenciaCiclo_Histórico);5;2))
				
			Else 
				$absoluteRef:=Abs:C99(vl_referenciaCiclo_Histórico)
				$stringRef:=String:C10($absoluteRef)
				vl_Year_Historico:=Num:C11(Substring:C12(String:C10($absoluteRef);1;4))
				vl_NivelSeleccionado_Historico:=-Num:C11(Substring:C12($stringRef;5;2))
			End if 
			
			
		Else 
			vl_Year_Historico:=0
			vl_NivelSeleccionado_Historico:=0
		End if 
		
	Else 
		vl_Year_Historico:=0
		vl_NivelSeleccionado_Historico:=0
	End if 
	
End if 




