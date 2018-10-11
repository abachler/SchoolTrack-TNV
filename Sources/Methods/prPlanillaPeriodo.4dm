//%attributes = {}
  // prPlanillaPeriodo()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 17:24:01
  // -----------------------------------------------------------
C_LONGINT:C283($i)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreDocumento;$t_nombreFormulario)

ARRAY LONGINT:C221($al_recNums;0)

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_expresionNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:="rep_PlanillaNotas"

PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)

CU_OpcionesImpresionPlanillas 
If (ok=1)
	
	If (<>shift)
		ORDER BY:C49([Cursos:3])
	Else 
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	End if 
	
	Case of 
		: (bExport=1)
			CUpr_ExportPlanilla (vPeriodo)
			
		: (bImprimir=1)
			QR_AjustesImpresion (Letter_Paysage)
			If (ok=1)
				vs_ConfigToUse:="Periodo"
				
				<>stopExec:=False:C215
				LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNums)
				vPageNumber:=0
				
				For ($i;1;Size of array:C274($al_recNums))
					KRL_GotoRecord ($y_tabla;$al_recNums{$i})
					vPageNumber:=vPageNumber+1
					CUpr_PlanillaPeriodo (vPeriodo)
					KRL_GotoRecord ($y_tabla;$al_recNums{$i})
					
					QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_expresionNombreDocumento)
					
					If (<>stopExec)
						$i:=Size of array:C274($al_recNums)
					End if 
					
				End for 
			End if 
	End case 
End if 

ACTAS_InitVars (0)

