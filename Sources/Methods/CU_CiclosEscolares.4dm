//%attributes = {}
  // Método: CU_CiclosEscolares
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 24/08/10, 19:51:27
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_LONGINT:C283(hl_CiclosEscolares;$idAlumno;vl_referenciaCiclo;$hl_Periodos)
C_TEXT:C284($text)

  // Código principal

C_LONGINT:C283(hl_CiclosEscolares;$idAlumno;$1;vl_referenciaCiclo;$hl_Periodos)
C_TEXT:C284($text)

HL_ClearList (hl_CiclosEscolares)
hl_CiclosEscolares:=New list:C375

APPEND TO LIST:C376(hl_CiclosEscolares;<>gNombreAgnoEscolar;<>gYear)
APPEND TO LIST:C376(hl_CiclosEscolares;"-";0)

QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5;=;[Cursos:3]Curso:1;*)
QUERY:C277([Cursos_SintesisAnual:63]; & [Cursos_SintesisAnual:63]Año:2;<;<>gYear)
ORDER BY:C49([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2;<)
$lastYear:=[Cursos_SintesisAnual:63]Año:2

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	GOTO RECORD:C242([Cursos_SintesisAnual:63];$aRecNums{$i})
	$refCiclo:=[Cursos_SintesisAnual:63]Año:2
	$nombreAñoEscolar:=KRL_GetTextFieldData (->[xxSTR_DatosDeCierre:24]Year:1;->[Cursos_SintesisAnual:63]Año:2;->[xxSTR_DatosDeCierre:24]NombreAgnoEscolar:5)
	APPEND TO LIST:C376(hl_CiclosEscolares;$nombreAñoEscolar;$refCiclo)
	
End for 

  //MONO: por ahora matener el registro actual en seleccion, para la visualización en el browser
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Curso:5;=;[Cursos:3]Curso:1;*)
QUERY:C277([Cursos_SintesisAnual:63]; & [Cursos_SintesisAnual:63]Año:2;=;<>gYear)

If (Count list items:C380(hl_CiclosEscolares)>0)
	If (HL_FindInListByReference (hl_CiclosEscolares;vl_referenciaCiclo)="")
		vl_referenciaCiclo:=0
	End if 
	If (vl_Year=0)
		SELECT LIST ITEMS BY POSITION:C381(hl_CiclosEscolares;1)
	Else 
		SELECT LIST ITEMS BY REFERENCE:C630(hl_CiclosEscolares;vl_Year)
	End if 
	
	GET LIST ITEM:C378(hl_CiclosEscolares;*;vl_referenciaCiclo;$text)
	If (vl_referenciaCiclo#0)
		vl_Year:=vl_referenciaCiclo
		
	Else 
		vl_Year:=0
	End if 
	
Else 
	vl_Year:=0
End if 



