//%attributes = {}
  // prSintesisAnual()
  //
  //
  // creado por: Alberto Bachler Klein: 30-03-16, 18:40:36
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_unaTareaImpresion)
C_LONGINT:C283($i)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)

If (False:C215)
	C_TEXT:C284(prSintesisAnual ;$1)
	C_TEXT:C284(prSintesisAnual ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17

BRING TO FRONT:C326(Current process:C322)
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)



iOrden:=CD_Dlog (0;__ ("La lista de alumnos puede ser ordenada por número de lista o alfabéticamente\r¿Que ordenamiento dese a utilizar?");__ ("");__ ("Alfabético");__ ("Nº de lista");__ ("Cancelar"))

If (iOrden#3)
	QR_AjustesImpresion (Letter_Portrait)
	
	If (ok=1)
		<>stopExec:=False:C215
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
		OK:=1
		For ($i;1;Size of array:C274($al_recNums))
			KRL_GotoRecord (->[Cursos:3];$al_recNums{$i};False:C215)
			RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
			sProf:=[Profesores:4]Nombre_comun:21
			sCurso:=[Cursos:3]Curso:1
			sTitle:="Sintesis Anual de Inasistencia"
			QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento;$b_unaTareaImpresion)
			If (<>stopExec)
				$i:=Size of array:C274($al_recNums)+1
			End if 
		End for 
		
	End if 
End if 