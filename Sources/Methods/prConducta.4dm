//%attributes = {}
  // prConducta()
  //
  //
  // creado por: Alberto Bachler Klein: 30-03-16, 19:21:46
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)





If (False:C215)
	C_TEXT:C284(prConducta ;$1)
	C_TEXT:C284(prConducta ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:=[xShell_Reports:54]FormName:17

BRING TO FRONT:C326(Current process:C322)
LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNums)


MESSAGES OFF:C175
$l_modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)
If ($l_modoRegistroInasistencia#3)
	PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
	
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_ImpresionPlanillas";0;Movable form dialog box:K39:8;__ ("Selección del período"))
	DIALOG:C40([xxSTR_Constants:1];"STR_ImpresionPlanillas")
	CLOSE WINDOW:C154
Else 
	b2:=1
	b1:=0
End if 
Case of 
	: (b1=1)
		vt_PLConfigMessage:=String:C10(atSTR_Periodos_Nombre)
	: (b2=1)
		vt_PLConfigMessage:="año"
End case 


If (<>shift)
	ORDER BY:C49([Cursos:3])
Else 
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
End if 

QR_AjustesImpresion (Letter_Portrait)

If (ok=1)
	<>stopExec:=False:C215
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	For ($i;1;Size of array:C274($al_recNums))
		KRL_GotoRecord (->[Cursos:3];$al_recNums{$i};False:C215)
		RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
		sProf:=[Profesores:4]Nombre_comun:21
		sCurso:=[Cursos:3]Curso:1
		sTitle:="Sintesis Anual de Inasistencia"
		QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
		If (<>stopExec)
			$i:=Size of array:C274($al_recNums)+1
		End if 
	End for 
	
End if 