//%attributes = {}
  //EXP_PlanillaAsistencia

WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SeleccionaMes";0;Palette form window:K39:9;__ ("Selección del mes"))
DIALOG:C40([xxSTR_Constants:1];"STR_SeleccionaMes")
CLOSE WINDOW:C154
If (ok=1)
	ARRAY LONGINT:C221(aLong1;0)
	ARRAY LONGINT:C221(aLong2;0)
	ARRAY TEXT:C222(aText1;0)
	$fileName:=<>atXS_MonthNames{vi_SelectedMonth}+" "+String:C10(<>gYear)
	$folderPath:=SYS_CarpetaAplicacion (CLG_DocumentosLocal_ST)+"Planillas de asistencia"+Folder separator:K24:12
	SYS_CreaCarpeta ($folderPath)
	
	$filePath:=$folderPath+$fileName
	  // crear un nuevo documento con el nombre del mes y el año seleccionado
	$ref:=Create document:C266($filePath;"TEXT")
	  // construir un arreglo con todos los cursos
	  // crear un arreglo paralelo al de cursos para recibir el total de inasistencias 
	  //del curso
	
	$dias:=0
	For ($day;1;31)  // repetir 31 veces  
		$date:=DT_GetDateFromDayMonthYear ($day;vi_SelectedMonth;<>gYear)
		If (DateIsValid ($date;0))
			$dias:=$dias+1
		End if 
	End for 
	
	$text:="Asistencia para el mes de "+<>atXS_MonthNames{vi_SelectedMonth}+" "+String:C10(<>gYear)+"\r"+"Dias habiles:"+"\t"+String:C10($dias)+("\r"*3)
	SEND PACKET:C103($ref;$text)
	
	
	  //ALL RECORDS([Cursos])
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>=0)
	ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;>;[Cursos:3]Curso:1;>)
	SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aText1)
	ARRAY LONGINT:C221(aLong1;Size of array:C274(aText1))
	ARRAY LONGINT:C221(aLong2;Size of array:C274(aText1))
	  //generar una linea con los encabezados de columnas (nombres de los cursos), 
	  //precedida por una columna de titulos de lineas
	$text:=""+"\t"+AT_array2text (->aText1;"\t")+"\r"
	  //enviar la linea al documento
	SEND PACKET:C103($ref;$text)
	  // calculo de la linea de matrícula total
	
	
	  // para cada curso (columna)
	  //   totalizar matricula (busqueda de alumnos activos en cada curso)
	  // enviar la linea al archivo
	$text:="Matricula del curso"
	For ($i;1;Size of array:C274(aText1))
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=aText1{$i};*)
		QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50="Activo")
		$records:=Records in selection:C76([Alumnos:2])
		aLong2{$i}:=$records
		$text:=$text+"\t"+String:C10($records)
	End for 
	$text:=$text+"\r"
	SEND PACKET:C103($ref;$text)
	  // generación de la tabla de asistencia para cada dia del mes
	
	$dias:=0
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando planilla de asistencia..."))
	For ($day;1;31)  // repetir 31 veces  
		$date:=DT_GetDateFromDayMonthYear ($day;vi_SelectedMonth;<>gYear)
		$text:="Dia "+String:C10($day)
		If (DateIsValid ($date;0))
			$dias:=$dias+1  // incrementar la variable total de dias de clase
			For ($i;1;Size of array:C274(aText1))  // para cada curso
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=aText1{$i};*)
				QUERY:C277([Alumnos:2]; & [Alumnos:2]Status:50="Activo")
				KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
				QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$date)
				$records:=Records in selection:C76([Alumnos_Inasistencias:10])
				$text:=$text+"\t"+String:C10($records)
				aLong1{$i}:=aLong1{$i}+$records  //totalizacion d e inasistencias para cada curso
			End for 
			$text:=$text+"\r"
			SEND PACKET:C103($ref;$text)  // envia la linea    
		Else 
			  //   si la fecha no es un dia de clases enviar guiones a cada celda    
			For ($i;1;Size of array:C274(aText1))
				$text:=$text+"\t"+"-"
			End for 
			$text:=$text+"\r"
			SEND PACKET:C103($ref;$text)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$day/31;__ ("Generando planilla de asistencia..."))
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	  // Crear la linea para los totales de inasistencias del mes (una columna por 
	  //curso)
	$text:="Total inasistencias "
	For ($i;1;Size of array:C274(aText1))
		$text:=$text+"\t"+String:C10(aLong1{$i})
	End for 
	$text:=$text+"\r"
	
	SEND PACKET:C103($ref;$text)
	
	
	  // Crear la linea para el porcentaje de inasistencias en cada curso
	$text:="Porcentaje de inasistencias "
	For ($i;1;Size of array:C274(aText1))
		$text:=$text+"\t"+String:C10(Round:C94(aLong1{$i}/(aLong2{$i}*$dias)*100;2);"##0,00")
	End for 
	$text:=$text+"\r"
	SEND PACKET:C103($ref;$text)
	
	CLOSE DOCUMENT:C267($ref)
	CD_Dlog (0;__ ("La exportación de la planilla de asistencia de ")+$fileName+__ (" ha concluido.\r\rLa encontrará en: \r")+$folderPath+__ ("\r\rLe recomendamos abrirla con Microsoft Excel."))
End if 




