//%attributes = {}
  // prObservacionesAsignaturas()
  // 
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 18:31:13
  // -----------------------------------------------------------

C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)

If (False:C215)
	C_TEXT:C284(prVisitasEnf ;$1)
	C_TEXT:C284(prVisitasEnf ;$2)
End if 

If (Count parameters:C259=2)
	$t_destinoImpresion:=$1
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:="rep_PLPform"


If (Records in selection:C76([Alumnos:2])>0)
	If (<>shift)
		ORDER BY:C49([Alumnos:2])
	Else 
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
	End if 
	
	QR_AjustesImpresion (Letter_Portrait)
	
	If (ok=1)
		LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)
		<>stopExec:=False:C215
		For ($i;1;Size of array:C274($al_recNums))
			KRL_GotoRecord (->[Alumnos:2];$al_recNums{$i};False:C215)
			sTitle:="Observaciones en asignaturas"
			sSubTitle:=[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20
			
			QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
			If (<>stopExec)
				$i:=Size of array:C274($al_recNums)+1
			End if 
			
		End for 
	End if 
Else 
	CD_Dlog (0;__ ("No hay nada para imprimir.");__ (""))
End if 