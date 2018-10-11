For ($i;Size of array:C274(atQRY_NombreVirtualCampo);1;-1)
	If ((atQRY_NombreVirtualCampo{$i}="") | (atQRY_Operador_Literal{$i}=""))
		AT_Delete ($i;1;->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral;->ayQRY_Campos;->atQRY_NombreInternoCampo;->alQRY_Operador_ID;->atQRY_Conector_Simbolo;->alQRY_numeroTabla;->alQRY_numeroCampo)
	End if 
End for 


atQRY_Conector_Literal:=Size of array:C274(atQRY_Conector_Literal)
atQRY_NombreVirtualCampo:=Size of array:C274(atQRY_NombreVirtualCampo)
atQRY_Operador_Literal:=Size of array:C274(atQRY_Operador_Literal)
atQRY_ValorLiteral:=Size of array:C274(atQRY_ValorLiteral)
bCurrentYearOnly:=0
OBJECT SET VISIBLE:C603(bCurrentYearOnly;False:C215)
$añoEspecificadoEnConsulta:=False:C215
If (Size of array:C274(ayQRY_Campos)>0)
	For ($i;1;Size of array:C274(ayQRY_Campos))
		Case of 
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Calificaciones:208])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Calificaciones:208]Año:3)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_ComplementoEvaluacion:209])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_ComplementoEvaluacion:209]Año:3)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_EvaluacionAprendizajes:203])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_EvaluacionAprendizajes:203]Año:77)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_SintesisAnual:210])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_SintesisAnual:210]Año:2)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Asignaturas_SintesisAnual:202])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Asignaturas_SintesisAnual:202]Año:3)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Cursos_SintesisAnual:63])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Cursos_SintesisAnual:63]Año:2)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Castigos:9])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Castigos:9]Año:5)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Anotaciones:11])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Anotaciones:11]Año:11)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Atrasos:55])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Atrasos:55]Año:6)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Inasistencias:10])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Inasistencias:10]Año:8)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Suspensiones:12])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Suspensiones:12]Año:1)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
			: ((Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Licencias:73])) & (Field:C253(ayQRY_Campos{$i})=Field:C253(->[Alumnos_Licencias:73]Año:9)))
				$añoEspecificadoenConsulta:=True:C214
				$i:=Size of array:C274(ayQRY_Campos)
		End case 
	End for 
	If (Not:C34($añoEspecificadoEnConsulta))
		For ($i;1;Size of array:C274(ayQRY_Campos))
			Case of 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Calificaciones:208]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_SintesisAnual:210]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Asignaturas_SintesisAnual:202]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Cursos_SintesisAnual:63]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Castigos:9]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Anotaciones:11]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Atrasos:55]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Inasistencias:10]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Suspensiones:12]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
				: (Table:C252(ayQRY_Campos{$i})=Table:C252(->[Alumnos_Licencias:73]))
					OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
					If (Not:C34(vb_ConsultaMultiAño))
						bCurrentYearOnly:=1
					End if 
			End case 
		End for 
	Else 
		bCurrentYearOnly:=0
		OBJECT SET VISIBLE:C603(bCurrentYearOnly;False:C215)
	End if 
Else 
	Case of 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Calificaciones:208]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_SintesisAnual:210]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Asignaturas_SintesisAnual:202]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Cursos_SintesisAnual:63]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Castigos:9]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Anotaciones:11]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Atrasos:55]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Inasistencias:10]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Suspensiones:12]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
		: (al_TablaRelacionada{at_NombreTablaRelacionada}=Table:C252(->[Alumnos_Licencias:73]))
			OBJECT SET VISIBLE:C603(bCurrentYearOnly;True:C214)
			If (Not:C34(vb_ConsultaMultiAño))
				bCurrentYearOnly:=1
			End if 
	End case 
End if 