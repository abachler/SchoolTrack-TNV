//%attributes = {}
  // prCdctaPers()
  // 
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 17:19:03
  // -----------------------------------------------------------



C_TEXT:C284($1)
C_TEXT:C284($2)

C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)
ARRAY LONGINT:C221($al_recNums;0)

If (False:C215)
	C_TEXT:C284(prFichas ;$1)
	C_TEXT:C284(prFichas ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17

BRING TO FRONT:C326(Current process:C322)
  //USE NAMED SELECTION("◊Editions")
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)


Case of 
	: (vt_PLConfigMessage="Inasistencias")
		sTitle:="Informe Personal de Inasistencias"
	: (vt_PLConfigMessage="Atrasos")
		sTitle:="Informe Personal de Atrasos"
	: (vt_PLConfigMessage="Anotaciones")
		sTitle:="Informe Personal de Anotaciones"
	: (vt_PLConfigMessage="Castigos")
		sTitle:="Informe Personal de Castigos"
	: (vt_PLConfigMessage="Suspensiones")
		sTitle:="Informe Personal de Suspensiones"
End case 

If (<>shift)
	ORDER BY:C49([Alumnos:2])
Else 
	ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
End if 


QR_AjustesImpresion (Letter_Portrait)
If (ok=1)
	<>stopExec:=False:C215
	For ($i;1;Size of array:C274($al_recNums))
		KRL_GotoRecord (->[Alumnos:2];$al_recNums{$i};False:C215)
		sSubtitle:=[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20
		QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
		If (<>stopExec)
			$i:=Size of array:C274($al_recNums)+1
		End if 
	End for 
End if 