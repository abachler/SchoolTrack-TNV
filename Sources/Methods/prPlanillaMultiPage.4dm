//%attributes = {}
  // prPlanillaMultiPage()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 16:46:15
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($b_seleccionarPeriodo;$b_tareaImpresionIniciada)
C_LONGINT:C283($i;$l_paginas)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario;$t_rutaPDF)

ARRAY LONGINT:C221($al_recNums;0)



If (False:C215)
	C_TEXT:C284(prPlanillaMultiPage ;$1)
	C_TEXT:C284(prPlanillaMultiPage ;$2)
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
	
	
	
	
	Case of 
		: (bExport=1)
			CUpr_ExportPlanilla 
			
		: (bImprimir=1)
			QR_AjustesImpresion (Letter_Paysage)
			
			If (ok=1)
				<>stopExec:=False:C215
				vs_ConfigToUse:="MultiPage"
				vs_Periodo:=""
				
				
				If (<>shift)
					ORDER BY:C49([Cursos:3])
				Else 
					ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
				End if 
				LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNums)
				
				<>stopExec:=False:C215
				For ($i;1;Size of array:C274($al_recNums))
					KRL_GotoRecord (->[Cursos:3];$al_recNums{$i})
					CUpr_PlanillaMultiPagina 
					KRL_GotoRecord (->[Cursos:3];$al_recNums{$i})
					OK:=1
					
					If (($t_destinoImpresion="pdf") & ($t_formulaNombreDocumento#""))
						EXECUTE FORMULA:C63("vt_nombreDoc:="+$t_formulaNombreDocumento)
						vt_nombreDoc:=Choose:C955(vt_nombreDoc#"@.pdf";vt_nombreDoc+".pdf";vt_nombreDoc)
						$t_rutaPDF:=vt_rutaCarpetaPDF+vt_nombreDoc
						SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaPdf)
						SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
						OPEN PRINTING JOB:C995
						$b_tareaImpresionIniciada:=True:C214
					End if 
					
					For ($l_paginas;1;vr_pages)
						vPageNumber:=vPageNumber+1
						vs_pages:=String:C10(vPageNumber)+" de "+String:C10(vr_pages)
						QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento;$b_tareaImpresionIniciada)
						
						vi_lastCol:=6*$l_paginas
					End for 
					
					
					If (<>stopExec)
						$i:=Size of array:C274($al_recNums)
					End if 
					
					
					If ($b_tareaImpresionIniciada)
						PAGE BREAK:C6
						CLOSE PRINTING JOB:C996
					End if 
					
					
					
				End for 
			End if 
	End case 
	
End if 

ACTAS_InitVars (0)