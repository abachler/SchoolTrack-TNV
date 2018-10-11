//%attributes = {}
  // dhQRY_esBusquedaPorAgno()
  // Por: Alberto Bachler: 09/03/13, 17:56:26
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_esConsultaPorAño)
C_LONGINT:C283($i;$l_numeroCampo;$l_numeroTabla)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_nombreVariable)

If (False:C215)
	C_BOOLEAN:C305(dhQRY_esBusquedaPorAgno ;$0)
End if 

$b_esConsultaPorAño:=False:C215
If (Size of array:C274(ayQRY_Campos)>0)
	For ($i;1;Size of array:C274(ayQRY_Campos))
		$y_tabla:=ayQRY_Campos{$i}
		RESOLVE POINTER:C394($y_tabla;$t_nombreVariable;$l_numeroTabla;$l_numeroCampo)
		If ($l_numeroTabla>0)
			Case of 
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Calificaciones:208])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Calificaciones:208]Año:3)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_ComplementoEvaluacion:209])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_ComplementoEvaluacion:209]Año:3)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_EvaluacionAprendizajes:203])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_EvaluacionAprendizajes:203]Año:77)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_SintesisAnual:210])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_SintesisAnual:210]Año:2)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Asignaturas_SintesisAnual:202])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Asignaturas_SintesisAnual:202]Año:3)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Cursos_SintesisAnual:63])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Cursos_SintesisAnual:63]Año:2)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Castigos:9])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Castigos:9]Año:5)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Anotaciones:11])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Anotaciones:11]Año:11)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Atrasos:55])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Atrasos:55]Año:6)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Inasistencias:10])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Inasistencias:10]Año:8)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Suspensiones:12])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Suspensiones:12]Año:1)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
				: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Licencias:73])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Licencias:73]Año:9)))
					$b_esConsultaPorAño:=True:C214
					$i:=Size of array:C274(ayQRY_Campos)
			End case 
		End if 
	End for 
End if 
$0:=$b_esConsultaPorAño