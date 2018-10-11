


If (Form event:C388=On Printing Detail:K2:18)
	
	CLEAR VARIABLE:C89(vQR_picture1)
	C_PICTURE:C286(vQR_picture1;$img)
	C_OBJECT:C1216($o_opcGrafico;$o_series;$o_leyendas)
	
	ARRAY TEXT:C222($etiquetasErr;0)
	ARRAY TEXT:C222($valoresErr;0)
	ARRAY TEXT:C222($camposEncHttp;0)
	ARRAY TEXT:C222($valoresEncHttp;0)
	
	C_TEXT:C284($parametros;$notas;$categorias;$ruta;$grafico;$stdOut)
	C_BOOLEAN:C305($okphp)
	C_LONGINT:C283($i;$estiloEvaluacionOficial)
	
	ARRAY TEXT:C222(aQR_text1;0)
	ARRAY TEXT:C222(aQR_text2;0)
	ARRAY REAL:C219(aQR_Real1;0)
	APPEND TO ARRAY:C911(aQR_text2;"PROM")
	
	QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=[Cursos:3]Curso:1)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
	KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
	
	$estiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]EvStyle_oficial:23)
	EVS_ReadStyleData ($estiloEvaluacionOficial)
	
	Case of 
		: (r0_Todas=1)
		: (r1_EnPromedioInterno=1)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]IncideEnPromedioInterno:64=True:C214)
		: (r2_EnPromedioOficial=1)
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Incide_en_promedio:27=True:C214)
			
		: (r3_madres=1)
			
			  // Modificado por: Alexis Bustamante (12/09/2016) //ticket 163507 
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Consolidacion_Madre_Id:7=0)
	End case 
	ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];aQR_longint1;"")
	C_LONGINT:C283($i)
	
	For ($i;1;Size of array:C274(aQR_longint1))
		GOTO RECORD:C242([Asignaturas:18];aQR_longint1{$i})
		APPEND TO ARRAY:C911(aQR_text1;[Asignaturas:18]Abreviación:26)
		QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]ID_Asignatura:2=[Asignaturas:18]Numero:1;*)
		QUERY:C277([Asignaturas_SintesisAnual:202]; & ;[Asignaturas_SintesisAnual:202]Año:3=<>gyear)
		If ([Asignaturas_SintesisAnual:202]PromedioOficial_Nota:21>0)
			APPEND TO ARRAY:C911(aQR_Real1;EV2_Real_a_Nota ([Asignaturas_SintesisAnual:202]PromedioOficial_Real:20;0;iGradesDecNO))
		Else 
			APPEND TO ARRAY:C911(aQR_Real1;0)
		End if 
	End for 
	
	vQR_longint1:=580
	vQR_longint2:=300
	
	C_BOOLEAN:C305($vb_rotar)
	
	If (Size of array:C274(aQR_longint1)>27)
		For ($i;1;(Size of array:C274(aQR_longint1)-27))
			vQR_longint1:=vQR_longint1+20
			vQR_longint2:=vQR_longint2+5
		End for 
		$vb_rotar:=True:C214
	End if 
	
	If ($vb_rotar)
		$vl_p1:=vQR_longint1
		$vl_p2:=vQR_longint2
		vQR_longint2:=$vl_p1
		vQR_longint2:=$vl_p2
	End if 
	
	If ((Size of array:C274(aQR_text1)>0) & (Size of array:C274(aQR_text2)>0) & (Size of array:C274(aQR_Real1)>0))
		
		
		  // Modificado por: Alexis Bustamante (31/08/2016) Ticket 167136
		
		
		$o_opcGrafico:=OB_Create 
		OB_SET_Long ($o_opcGrafico;vQR_longint1;"ancho")
		OB_SET_Long ($o_opcGrafico;vQR_longint2;"alto")
		OB_SET_Long ($o_opcGrafico;30;"margenIzq")
		OB_SET_Long ($o_opcGrafico;20;"margenDer")
		OB_SET_Long ($o_opcGrafico;20;"margenArriba")
		OB_SET_Long ($o_opcGrafico;50;"margenAbajo")
		
		
		
		OB_SET ($o_opcGrafico;->aQR_text1;"categorias")
		
		OB_SET_Text ($o_opcGrafico;String:C10(rGradesFrom);"ejeY_desde")
		OB_SET_Text ($o_opcGrafico;String:C10(rGradesTo);"ejeY_hasta")
		
		OB_SET_Long ($o_opcGrafico;90;"inclinacionX")
		$o_series:=OB_Create 
		OB_SET ($o_series;->aQR_Real1;"serie0")
		OB_SET ($o_opcGrafico;->$o_series;"series")
		
		
		$o_leyendas:=OB_Create 
		OB_SET_Text ($o_leyendas;"PROM";"leyenda0")
		OB_SET ($o_opcGrafico;->$o_leyendas;"leyendas")
		
		OB_SET_Text ($o_opcGrafico;"0.5";"leyendaPosX")
		OB_SET_Text ($o_opcGrafico;"0.9";"leyendaPosY")
		
		OB_SET_Text ($o_opcGrafico;"center";"leyendaAlignX")
		OB_SET_Text ($o_opcGrafico;"top";"leyendaAlignY")
		
		OB_SET_Text ($o_opcGrafico;"90";"inclinacionX")
		OB_SET_Text ($o_opcGrafico;"SIDE_UP";"SetLabelSideX")
		
		
		
		$parametros:=OB_Object2Json ($o_opcGrafico)
		
		  //ruta del script php
		$ruta:=Get 4D folder:C485(Current resources folder:K5:16)+"php_lib"+Folder separator:K24:12+"graficar.php"
		  //llamado
		$okphp:=PHP Execute:C1058($ruta;"graficar";$grafico;$parametros)
		  //consulta de respuesta (se pueden consultar errores de ejecución)
		PHP GET FULL RESPONSE:C1061($stdOut;$etiquetasErr;$valoresErr;$camposEncHttp;$valoresEncHttp)
		  //si la ejecución es exitosa recibimos un base64 de la imagen y la pasamos a una variable de imagen en 4D
		
		If ($okphp)
			C_BLOB:C604($xblob)
			BASE64 DECODE:C896($grafico;$xblob)
			BLOB TO PICTURE:C682($xblob;$img;".png")
		End if 
		
		If (Size of array:C274(aQR_Real1)>40)
			
			$refSvg:=SVG_New 
			$refGrafico:=SVG_New_embedded_image ($refSvg;$img)
			SVG_SET_TRANSFORM_ROTATE ($refGrafico;90;vQR_longint2;vQR_longint2)
			$img:=SVG_Export_to_picture ($refGrafico;0)
			SVG_CLEAR ($refGrafico)
			
		End if 
		vQR_Picture1:=$img
		
	End if 
	
End if 