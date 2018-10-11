//%attributes = {}
  // prPlanillaOnePage()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 17:23:08
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)



If (False:C215)
	C_TEXT:C284(prPlanillaOnePage ;$1)
	C_TEXT:C284(prPlanillaOnePage ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:="rep_PlanillaNotas"


$b_seleccionarPeriodo:=False:C215
CU_OpcionesImpresionPlanillas ($b_seleccionarPeriodo)
If (ok=1)
	vs_ConfigToUse:="OnePage"
	If (<>shift)
		ORDER BY:C49([Cursos:3])
	Else 
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	End if 
	
	Case of 
		: (bExport=1)
			CUpr_ExportPlanilla 
			
			
		: (bImprimir=1)
			QR_AjustesImpresion (Letter_Paysage)
			
			<>stopExec:=False:C215
			LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNums)
			vPageNumber:=0
			
			For ($i;1;Size of array:C274($al_recNums))
				KRL_GotoRecord ($y_tabla;$al_recNums{$i})
				CUpr_PlanillaOnePage 
				vPageNumber:=vPageNumber+1
				KRL_GotoRecord ($y_tabla;$al_recNums{$i})
				
				QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				
				If (<>stopExec)
					$i:=Size of array:C274($al_recNums)
				End if 
				
			End for 
	End case 
End if 

ACTAS_InitVars (0)