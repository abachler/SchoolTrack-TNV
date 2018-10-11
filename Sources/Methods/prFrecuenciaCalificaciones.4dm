//%attributes = {}
  // prFrecuenciaCalificaciones()
  //
  //
  // creado por: Alberto Bachler Klein: 31-03-16, 16:24:05
  // -----------------------------------------------------------
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($i;$i_registros;$k;$l_paginas)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_configuracionEspecial;$t_destinoImpresion;$t_formulaNombreDocumento;$t_nombreFormulario;$t_nombreInforme)

ARRAY LONGINT:C221($al_recNums;0)



If (False:C215)
	C_TEXT:C284(prFrecuenciaCalificaciones ;$1)
	C_TEXT:C284(prFrecuenciaCalificaciones ;$2)
End if 

$t_destinoImpresion:=$1

If (Count parameters:C259=2)
	$t_formulaNombreDocumento:=$2
End if 

$y_tabla:=Table:C252([xShell_Reports:54]MainTable:3)
$t_nombreFormulario:="Frecuencias"
$t_nombreInforme:=[xShell_Reports:54]ReportName:26
$t_configuracionEspecial:=[xShell_Reports:54]SpecialParameter:18



USE NAMED SELECTION:C332("◊Editions")
If (<>shift)
	ORDER BY:C49([Cursos:3])
Else 
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
End if 
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNums)
  //FORM SET OUTPUT([Cursos];"Frecuencias")

yBWR_currentTable:=$y_tabla
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
CU_OpcionesImpresionPlanillas (True:C214;2)

If (ok=1)
	QR_AjustesImpresion (0;->[Cursos:3];"Frecuencias")
	If (ok=1)
		If (vPeriodo>Size of array:C274(atSTR_Periodos_Nombre))
			vPeriodo:=0
		End if 
		
		OK:=1
		For ($i;1;Size of array:C274($al_recNums))
			vPageNumber:=0
			KRL_GotoRecord (->[Cursos:3];$al_recNums{$i};False:C215)
			
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
			EV2_Calificaciones_SeleccionAL 
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incluida_en_Actas:44=True:C214;*)
			QUERY SELECTION:C341([Asignaturas:18]; & [Asignaturas:18]Incide_en_promedio:27=True:C214)
			$l_paginas:=Records in selection:C76([Asignaturas:18])/12
			
			If (Dec:C9($l_paginas)>0)
				vl_NumeroDePaginas:=Int:C8($l_paginas)+1
			Else 
				vl_NumeroDePaginas:=$l_paginas
			End if 
			<>stopExec:=False:C215
			For ($k;1;vl_NumeroDePaginas)
				vPageNumber:=vPageNumber+1
				KRL_GotoRecord (->[Cursos:3];$al_recNums{$i};False:C215)
				QR_ImprimeFormularioRegistro ($y_tabla;$t_nombreFormulario;$t_destinoImpresion;$t_formulaNombreDocumento)
				If (<>stopExec)
					$i_registros:=Size of array:C274($al_recNums)+1
				End if 
			End for 
			If (OK=0)
				$i:=Size of array:C274($al_recNums)
			End if 
		End for 
	End if 
End if 


