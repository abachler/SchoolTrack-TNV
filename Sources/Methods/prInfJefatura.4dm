//%attributes = {}
  // prInfJefatura()
  //
  //
  // creado por: Alberto Bachler Klein: 28-03-16, 11:43:06
  // -----------------------------------------------------------
  // Modificado por: Saul Ponce (20/06/2016) Ticket N° 151460
  // Incorporé el control 'vb_exportar' en el formulario '[Cursos]SetInforme' para generar la exportación de los arrays (sin gráficos)
  // Todo lo referente a exportación fue incorporado en este ticket
  // Modificado por: Patricio Aliaga (08/06/2017) Ticket N° 182255
  // Se agrega filtro, para excluir las asignaturas que no tiene un profesor asignado.

C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($x_preferencias)
C_BOOLEAN:C305($b_tareaImpresionIniciada;$b_usarConfigPorOmision;$vb_generar)
C_LONGINT:C283($i;$el)
C_TEXT:C284($t_destinoImpresion;$t_expresionNombreDocumento;$t_expresionNombreArchivo)

ARRAY LONGINT:C221($al_recNums;0)

If (False:C215)
	C_TEXT:C284(prInfJefatura ;$1)
	C_TEXT:C284(prInfJefatura ;$2)
End if 

C_LONGINT:C283(r0_Todas;r1_EnPromedioInterno;r1_EnPromedioOficial;r3_Madres)
r0_Todas:=0
r1_EnPromedioInterno:=1
r2_EnPromedioOficial:=0
  // Modificado por: Alexis Bustamante (12/09/2016)
R3_Madres:=0
vlEVS_DefaultStyleID:=-5
ARRAY REAL:C219(aReel2;0)
ARRAY REAL:C219(aReel1;0)
ARRAY TEXT:C222(aAbsNames;0)
ARRAY TEXT:C222(aEmptyText;0)
ARRAY INTEGER:C220(aiCU_DispersionRango;8)
ARRAY TEXT:C222(atCU_DispersionFrom;0)
ARRAY TEXT:C222(atCU_DispersionTo;0)
ARRAY REAL:C219(arCU_DispersionFrom;0)
ARRAY REAL:C219(arCU_DispersionTo;0)
ARRAY TEXT:C222(atCU_DispersionFrom;8)
ARRAY TEXT:C222(atCU_DispersionTo;8)
ARRAY REAL:C219(arCU_DispersionFrom;8)
ARRAY REAL:C219(arCU_DispersionTo;8)

$t_destinoImpresion:=$1
$t_expresionNombreArchivo:=$2
$b_usarConfigPorOmision:=True:C214  //MONO 205952

  // getting blob preferences
$x_preferencias:=PREF_fGetBlob (0;"DispersionNotasEnInformeJefatura";$x_preferencias)
If (BLOB size:C605($x_preferencias)>0)
	BLOB_Blob2Vars (->$x_preferencias;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->R3_Madres;->vl_sinprofesor)
	$b_usarConfigPorOmision:=True:C214
	For ($i;1;Size of array:C274(arCU_DispersionTo))
		If (arCU_DispersionTo{$i}#0)
			$b_usarConfigPorOmision:=False:C215
			$i:=Size of array:C274(arCU_DispersionTo)+1
		End if 
	End for 
End if 

If ($b_usarConfigPorOmision)  //MONO 205952
	CU_DefaultJefaturaRepSettings 
End if 


  //ABC//20180330
ARRAY TEXT:C222(aEvStyleType;0)
APPEND TO ARRAY:C911(aEvStyleType;"Segun estilo de evaluación oficial del nivel")
APPEND TO ARRAY:C911(aEvStyleType;"Segun estilo de evaluación oficial interno del nivel")

  // MOD Ticket N° 209201 Patricio Aliaga 20180705
$el:=Find in array:C230(aEvStyleID;vi_SelectedStyle)
  //aEvStyleName:=vi_SelectedStyle
aEvStyleName:=$el
aEvStyleType:=vi_StyleType
EVS_ReadStyleData (aEvStyleID{aEvStyleName})
sAvgSup:=NTA_PercentValue2StringValue (rAvgSupPercent;iEvaluationMode)
sAvgInf:=NTA_PercentValue2StringValue (rAvgInfPercent;iEvaluationMode)
sAvgMin:=NTA_PercentValue2StringValue (rAvgMinPercent;iEvaluationMode)
sAvgMinAsignatura:=NTA_PercentValue2StringValue (rAvgMinAsignaturaPercent;iEvaluationMode)

For ($i;1;8)
	atCU_DispersionFrom{$i}:=NTA_PercentValue2StringValue (arCU_DispersionFrom{$i};iEvaluationMode)
	atCU_DispersionTo{$i}:=NTA_PercentValue2StringValue (arCU_Dispersionto{$i};iEvaluationMode)
End for 



  //dispalying print setup
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Profesores:4])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])

FORM SET OUTPUT:C54([Cursos:3];"Informe")

  //USE NAMED SELECTION("◊Editions")
WDW_OpenFormWindow (->[Cursos:3];"SetInforme";0;Movable form dialog box:K39:8;__ ("Opciones de informe de jefatura de curso"))
DIALOG:C40([Cursos:3];"SetInforme")
CLOSE WINDOW:C154
If (ok=1)
	For ($i;1;8)
		arCU_DispersionFrom{$i}:=NTA_StringValue2Percent (Replace string:C233(atCU_DispersionFrom{$i};".";",");0;iEvaluationMode)
		arCU_DispersionTo{$i}:=NTA_StringValue2Percent (Replace string:C233(atCU_DispersionTo{$i};".";",");0;iEvaluationMode)
	End for 
	
	  // MOD Ticket N° 209201 Patricio Aliaga 20180705
	  //vi_SelectedStyle:=aEvStyleName
	vi_StyleType:=aEvStyleType
	BLOB_Variables2Blob (->$x_preferencias;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)
	PREF_SetBlob (0;"DispersionNotasEnInformeJefatura";$x_preferencias)
	
	
	
	If (Not:C34(vb_exportar))
		QR_AjustesImpresion (0;->[Cursos:3];"Informe")
	Else 
		
		If (vb_exportar)
			C_BOOLEAN:C305($vb_generar)
			C_LONGINT:C283($vl_bookRef;$vl_listo)
			C_TEXT:C284($vt_folder;$vt_fileName;$vt_ruta)
			
			$vb_generar:=False:C215
			$vl_listo:=0
			$vt_folder:=xfGetDirName ("Destino del (los) archivo(s).")
			
			If (ok=1)
				If (SYS_IsWindows )
					USE CHARACTER SET:C205("windows-1252";0)
				Else 
					USE CHARACTER SET:C205("MacRoman";0)
				End if 
				
				If ($vt_folder#"")
					$vb_generar:=True:C214
					$vt_ruta:=$vt_folder
				Else 
					$vb_generar:=False:C215
				End if 
			Else 
				$vt_folder:=""
				$vb_generar:=False:C215
			End if 
		End if 
	End if 
	
	If (ok=1)
		MESSAGES OFF:C175
		sPeriod:="(al "+String:C10(Current date:C33;4)+")"
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
		LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$al_recNums)
		
		
		<>stopExec:=False:C215
		For ($i;1;Size of array:C274($al_recNums))
			If (OK=0)
				$i:=Size of array:C274($al_recNums)+1
			Else 
				GOTO RECORD:C242([Cursos:3];$al_recNums{$i})
				
				If ($t_destinoImpresion="pdf")
					$t_rutaPDF:=vt_rutaCarpetaPDF+QR_EvaluaNombreDocumento ($t_expresionNombreArchivo;$t_destinoImpresion)
					SET PRINT OPTION:C733(Destination option:K47:7;3;$t_rutaPdf)
					SET PRINT OPTION:C733(Hide printing progress option:K47:12;1)
					OPEN PRINTING JOB:C995
					$b_tareaImpresionIniciada:=True:C214
				End if 
				
				If (vb_exportar)
					$vt_fileName:=$vt_folder+"Informe_Jefatura_"+[Cursos:3]Curso:1+"_"+DTS_MakeFromDateTime +".xls"
					SYS_CreateFolder (SYS_GetParentNme ($vt_fileName))
					$vl_bookRef:=XLS Create (3)
				End if 
				
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
				If (Not:C34(Shift down:C543))
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89#True:C214)
				End if 
				CREATE SET:C116([Alumnos:2];"class")
				USE SET:C118("class")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
				ifemales:=Records in selection:C76([Alumnos:2])
				USE SET:C118("class")
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
				imales:=Records in selection:C76([Alumnos:2])
				CU_Informe 
				
				GOTO RECORD:C242([Cursos:3];$al_recNums{$i})
				
				
				
				
				If (Not:C34(vb_exportar))
					QR_ImprimeFormularioRegistro (->[Cursos:3];"informe";$t_destinoImpresion;$t_expresionNombreDocumento;$b_tareaImpresionIniciada)
				Else 
					  // exportar hoja 1
					$vl_fila:=1
					$vl_col:=1
					XLS Set sheet name ($vl_bookRef;1;"Primera Página")
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;ST_Uppercase (<>GCUSTOM))
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"INFORME JEFATURA CURSO "+[Cursos:3]Curso:1)
					sProf:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Cursos:3]Numero_del_profesor_jefe:2;->[Profesores:4]Apellidos_y_nombres:28)
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;sProf)
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;sPeriod)
					$vl_fila:=$vl_fila+2
					
					$vl_col:=1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Matrícula")
					$vl_col:=1+$vl_col
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;String:C10(ifemales+imales)+" alumnos")
					$vl_col:=1+$vl_col
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;String:C10(ifemales)+" mujeres")
					$vl_col:=1+$vl_col
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;String:C10(imales)+" hombres")
					$vl_fila:=$vl_fila+2
					$vl_col:=1
					
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"I. Asistencia")
					$vl_col:=1+$vl_col
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Días de clase a la fecha ")
					$vl_col:=1+$vl_col
					XLS Set long value ($vl_bookRef;1;$vl_fila;$vl_col;viSTR_Calendario_DiasAHoy)
					$vl_fila:=1+$vl_fila
					$vl_col:=1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Alumnos con asistencia inferior al mínimo autorizado: ")
					$vl_col:=1+$vl_col
					XLS Set long value ($vl_bookRef;1;$vl_fila;$vl_col;iInasist)
					$vl_fila:=$vl_fila+2
					$vl_col:=1
					
					$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)
					
					Case of 
						: (($modoRegistroAsistencia=1) | ($modoRegistroAsistencia=3))
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Alumno")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Inasist.")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"% a la fecha")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"% / días año")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Observaciones")
							$vl_col:=1+$vl_col
							
						: (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4))
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Alumno")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Horas reales")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Horas Ausencia")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"% asistencia.")
							$vl_col:=1+$vl_col
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Observaciones")
							$vl_col:=1+$vl_col
					End case 
					
					$vl_fila:=1+$vl_fila
					SORT ARRAY:C229(aAbsNames;aInt1;aReel1;aReel2;aEmptyText;>)
					For ($z;1;Size of array:C274(aAbsNames))
						$vl_col:=1
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aAbsNames{$z})
						$vl_col:=1+$vl_col
						XLS Set long value ($vl_bookRef;1;$vl_fila;$vl_col;aInt1{$z})
						$vl_col:=1+$vl_col
						XLS Set real value ($vl_bookRef;1;$vl_fila;$vl_col;aReel1{$z})
						$vl_col:=1+$vl_col
						XLS Set real value ($vl_bookRef;1;$vl_fila;$vl_col;aReel2{$z})
						$vl_col:=1+$vl_col
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aEmptyText{$z})
						$vl_fila:=$vl_fila+1
					End for 
					$vl_fila:=$vl_fila+2
					$vl_col:=1
					
					
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"II. Dispersión de calificaciones")
					$vl_col:=1
					$vl_fila:=1+$vl_fila
					arCU_DispersionTo{0}:=-10
					ARRAY LONGINT:C221($al_considerar;0)
					AT_SearchArray (->arCU_DispersionTo;"#";->$al_considerar)
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Asignatura")
					$vl_col:=$vl_col+1
					For ($x;1;Size of array:C274($al_considerar))
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"<="+atCU_DispersionTo{$x})
						$vl_col:=$vl_col+1
					End for 
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Pend.")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Exim.")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Sin Ev.")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Total")
					$vl_col:=1
					$vl_fila:=$vl_fila+2
					For ($z;1;Size of array:C274(aAsig))
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aAsig{$z})
						C_POINTER:C301($y_dispersion)
						For ($x;1;Size of array:C274($al_considerar))
							$vl_col:=$vl_col+1
							$y_dispersion:=Get pointer:C304("aDisp"+String:C10($x))
							XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;$y_dispersion->{$z})
						End for 
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aPend{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aExim{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aNoEval{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;1;$vl_fila;$vl_col;aTotal{$z})
						$vl_fila:=$vl_fila+1
						$vl_col:=1
					End for 
					$vl_fila:=$vl_fila+2
					$vl_col:=1
					
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"III. Alumnos con notas pendientes o no evaluados")
					$vl_col:=1
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Alumno")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;"Asignaturas pendientes o no evaluadas")
					SORT ARRAY:C229(aPendStd;aPendAsg;>)
					For ($z;1;Size of array:C274(aPendStd))
						$vl_fila:=1+$vl_fila
						$vl_col:=1
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aPendStd{$z})
						$vl_col:=1+$vl_col
						XLS Set text value ($vl_bookRef;1;$vl_fila;$vl_col;aPendAsg{$z})
					End for 
				End if 
				If (vb_graficos)
					QR_ImprimeFormularioRegistro (->[Cursos:3];"Informe_Grafico";$t_destinoImpresion;$t_expresionNombreDocumento;$b_tareaImpresionIniciada)
				End if 
				
				
				
				
				If (Not:C34(vb_exportar))
					QR_ImprimeFormularioRegistro (->[Cursos:3];"Informe2";$t_destinoImpresion;$t_expresionNombreDocumento;$b_tareaImpresionIniciada)
				Else 
					  //exportar hoja 2
					$vl_fila:=1
					$vl_col:=1
					XLS Set sheet name ($vl_bookRef;2;"Segunda Página")
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;ST_Uppercase (<>GCUSTOM))
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"INFORME JEFATURA CURSO "+[Cursos:3]Curso:1)
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;sPeriod)
					$vl_fila:=$vl_fila+2
					
					
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"IV. Rendimiento")
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"1. Alumnos Destacados")
					$vl_col:=1
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"Alumno")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"Promedio")
					  //SORT ARRAY(aDest;aAvg;>)
					SORT ARRAY:C229(aAvg;aDest;<)  //ABC 195110
					For ($z;1;Size of array:C274(aDest))
						$vl_col:=1
						$vl_fila:=$vl_fila+1
						XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;aDest{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;aAvg{$z})
					End for 
					
					$vl_col:=1
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"2. Alumnos con rendimiento insuficiente")
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"Alumno")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"Promedio General")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;"Promedios Insuficientes")
					
					  //SORT ARRAY(aAvgInsuf;aInsuf;aAsgInsuf;>)
					MULTI SORT ARRAY:C718(aAvgInsuf;<;aInsuf;aAsgInsuf)  //ABC 195110
					For ($z;1;Size of array:C274(aInsuf))
						$vl_col:=1
						$vl_fila:=$vl_fila+1
						XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;aInsuf{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;aAvgInsuf{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;2;$vl_fila;$vl_col;aAsgInsuf{$z})
					End for 
				End if 
				If (vb_graficos)
					QR_ImprimeFormularioRegistro (->[Cursos:3];"Informe_Grafico2";$t_destinoImpresion;$t_expresionNombreDocumento;$b_tareaImpresionIniciada)
				End if 
				
				
				If (Not:C34(vb_exportar))
					QR_ImprimeFormularioRegistro (->[Cursos:3];"Informe3";$t_destinoImpresion;$t_expresionNombreDocumento;$b_tareaImpresionIniciada)
				Else 
					$vl_fila:=1
					$vl_col:=1
					XLS Set sheet name ($vl_bookRef;3;"Tercera Página")
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;ST_Uppercase (<>GCUSTOM))
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"INFORME JEFATURA CURSO "+[Cursos:3]Curso:1)
					$vl_fila:=$vl_fila+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;sPeriod)
					$vl_fila:=$vl_fila+2
					
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"V. Disciplina")
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"1. Alumnos Destacados desde el punto de vista conductual")
					$vl_col:=1
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Alumno")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Anot. +")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Anot. -")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Castigos")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Suspensiones")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Condicionalidad")
					
					SORT ARRAY:C229(aDD1;aDD;aDD2;aDD3;aDD4;aDD5;>)
					For ($z;1;Size of array:C274(aDD))
						$vl_col:=1
						$vl_fila:=$vl_fila+1
						XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;aDD{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aDD1{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aDD2{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aDD3{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aDD4{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;aDD5{$z})
					End for 
					
					$vl_col:=1
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"2. Alumnos con problemas disciplinarios")
					$vl_fila:=$vl_fila+2
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Alumno")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Anot.+")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Anot.-")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Castigos")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Suspensiones")
					$vl_col:=$vl_col+1
					XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;"Condicionalidad")
					
					SORT ARRAY:C229(aPD1;aPD;aPD2;aPD3;aPD4;aPD5;>)
					For ($z;1;Size of array:C274(aPD))
						$vl_col:=1
						$vl_fila:=$vl_fila+1
						XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;aPD{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aPD1{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aPD2{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aPD3{$z})
						$vl_col:=$vl_col+1
						XLS Set long value ($vl_bookRef;3;$vl_fila;$vl_col;aPD4{$z})
						$vl_col:=$vl_col+1
						XLS Set text value ($vl_bookRef;3;$vl_fila;$vl_col;aPD5{$z})
					End for 
					
				End if 
				If (vb_graficos)
					QR_ImprimeFormularioRegistro (->[Cursos:3];"Informe_Grafico3";$t_destinoImpresion;$t_expresionNombreDocumento;$b_tareaImpresionIniciada)
				End if 
				
				
				
				$vl_listo:=XLS Save as ($vl_bookRef;$vt_fileName)
				XLS CLOSE ($vl_bookRef)
			End if 
			
			If ($b_tareaImpresionIniciada)
				PAGE BREAK:C6
				CLOSE PRINTING JOB:C996
			End if 
			
			If (<>stopExec)
				$i:=Size of array:C274($al_recNums)+1
			End if 
		End for 
		
		
		If ($vb_generar)
			$vl_listo:=XLS Save as ($vl_bookRef;$vt_fileName)
			If ($vl_listo=0)
				XLS CLOSE ($vl_bookRef)
				USE CHARACTER SET:C205(*;0)
				CD_Dlog (0;"La exportación de (los) archivo(s) finalizó."+"\r\r"+"Encontrará el archivo de texto en: "+"\r"+$vt_ruta+"\r\r"+"Recomendamos utilizar planillas de cálculo para trabajar con el archivo.")
				If (ok=0)
					EM_ErrorManager ("Install")
					EM_ErrorManager ("SetMode";"")
					SHOW ON DISK:C922($vt_fileName)
					EM_ErrorManager ("Clear")
				End if 
			Else 
				CD_Dlog (0;"Ocurrió un problema al generar el archivo de texto. Revise que no esté abierto con otra aplicación o inténtelo más tarde.")
			End if 
			
		End if 
		
		  //resseting  environnement and cleaning memory
		FORM SET OUTPUT:C54([Cursos:3];"Output")
		ARRAY REAL:C219(aReel2;0)
		ARRAY REAL:C219(aReel1;0)
		ARRAY TEXT:C222(aAbsNames;0)
		ARRAY TEXT:C222(aEmptyText;0)
		CLEAR SET:C117("Notas")
		CLEAR SET:C117("NotasA")
		CLEAR SET:C117("NotasB")
		CLEAR SET:C117("Conducta")
		ARRAY TEXT:C222(aDisp1;0)
		ARRAY TEXT:C222(aDisp2;0)
		ARRAY TEXT:C222(aDisp3;0)
		ARRAY TEXT:C222(aDisp4;0)
		ARRAY TEXT:C222(aPend;0)
		ARRAY TEXT:C222(aExim;0)
		ARRAY INTEGER:C220(aTotal;0)
		ARRAY TEXT:C222(aDest;0)
		ARRAY TEXT:C222(aAvg;0)
		ARRAY TEXT:C222(aInsuf;0)
		ARRAY TEXT:C222(aAsgInsuf;0)
		ARRAY TEXT:C222(aAvgInsuf;0)
		ARRAY TEXT:C222(aPendStd;0)
		ARRAY TEXT:C222(aPendAsg;0)
		ARRAY TEXT:C222(aDD;0)
		ARRAY INTEGER:C220(aDD1;0)  //anotaciones positivas
		ARRAY INTEGER:C220(aDD2;0)  //anotaciones negativas
		ARRAY INTEGER:C220(aDD3;0)  //castigos
		ARRAY INTEGER:C220(aDD4;0)  //suspensiones
		ARRAY TEXT:C222(aDD5;0)  //Condicionalidad
		ARRAY TEXT:C222(aPD;0)
		ARRAY INTEGER:C220(aPD1;0)  //anotaciones positivas
		ARRAY INTEGER:C220(aPD2;0)  //anotaciones negativas
		ARRAY INTEGER:C220(aPD3;0)  //castigos
		ARRAY INTEGER:C220(aPD4;0)  //suspensiones
		ARRAY TEXT:C222(aPD5;0)  //Condicionalidad
	End if 
End if 