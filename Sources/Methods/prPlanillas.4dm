//%attributes = {}
  // prPlanillas()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 20:18:52
  // -----------------------------------------------------------
C_LONGINT:C283($i)
C_TEXT:C284($t_destinoImpresion;$t_nombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_expresionNombreDocumento:=$2
End if 


MESSAGES OFF:C175
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_ImpresionPlanillas";0;Movable form dialog box:K39:8;__ ("Selección del período"))
DIALOG:C40([xxSTR_Constants:1];"STR_ImpresionPlanillas")
CLOSE WINDOW:C154
If (ok=1)
	
	If (b2=1)
		$t_nombreFormulario:="PlanillaG"
	Else 
		$t_nombreFormulario:="PlanillaP"
		vPeriodo:=atSTR_Periodos_Nombre
	End if 
	<>stopExec:=False:C215
	
	
	If (OK=1)
		If (<>shift)
			ORDER BY:C49([Asignaturas:18])
		Else 
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Curso:5;>;[Asignaturas:18]denominacion_interna:16;>)
		End if 
		QR_AjustesImpresion (Letter_Portrait)
		
		If (ok=1)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$al_recNums)
			OK:=1
			<>stopExec:=False:C215
			For ($i;1;Size of array:C274($al_recNums))
				KRL_GotoRecord (->[Asignaturas:18];$al_recNums{$i})
				QR_ImprimeFormularioRegistro (->[Asignaturas:18];$t_nombreFormulario;$t_destinoImpresion;$t_expresionNombreDocumento)
				If (<>stopExec)
					$i:=Size of array:C274($al_recNums)
				End if 
			End for 
		End if 
		AS_InitReport 
	End if 
End if 