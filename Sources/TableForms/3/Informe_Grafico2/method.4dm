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
	
	C_LONGINT:C283($i)
	
	vQR_longint1:=580
	vQR_longint2:=350
	
	C_BOOLEAN:C305($vb_rotar)
	
	
	If (Size of array:C274(aAvg)>27)
		For ($i;1;(Size of array:C274(aAvg)-27))
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
	
	If (Size of array:C274(aAvg)>0)
		ARRAY REAL:C219(aQR_Real99;0)
		For ($i;1;Size of array:C274(aAvg))
			APPEND TO ARRAY:C911(aQR_Real99;Num:C11(aAvg{$i};<>vs_AppDecimalSeparator))
		End for 
		
		
		
		
		
		  // Modificado por: Alexis Bustamante (29/09/2016) ticket 167136
		
		
		
		$o_opcGrafico:=OB_Create 
		OB_SET_Long ($o_opcGrafico;vQR_longint1;"ancho")
		OB_SET_Long ($o_opcGrafico;vQR_longint2;"alto")
		OB_SET_Long ($o_opcGrafico;30;"margenIzq")
		OB_SET_Long ($o_opcGrafico;20;"margenDer")
		OB_SET_Long ($o_opcGrafico;20;"margenArriba")
		OB_SET_Long ($o_opcGrafico;80;"margenAbajo")
		
		
		
		OB_SET ($o_opcGrafico;->aDest;"categorias")
		OB_SET_Text ($o_opcGrafico;String:C10(rGradesFrom);"ejeY_desde")
		OB_SET_Text ($o_opcGrafico;String:C10(rGradesTo);"ejeY_hasta")
		
		
		OB_SET_Text ($o_opcGrafico;"0.5";"leyendaPosX")
		OB_SET_Text ($o_opcGrafico;"0.9";"leyendaPosY")
		OB_SET_Text ($o_opcGrafico;"center";"leyendaAlignX")
		OB_SET_Text ($o_opcGrafico;"top";"leyendaAlignY")
		
		
		OB_SET_Long ($o_opcGrafico;90;"inclinacionX")
		OB_SET_Text ($o_opcGrafico;"SIDE_UP";"SetLabelSideX")
		$o_series:=OB_Create 
		OB_SET ($o_series;->aQR_Real99;"serie0")
		OB_SET ($o_opcGrafico;->$o_series;"series")
		
		$o_leyendas:=OB_Create 
		OB_SET_Text ($o_leyendas;"PROMEDIOS ALUMNOS DESTACADOS";"leyenda0")
		OB_SET ($o_opcGrafico;->$o_leyendas;"leyendas")
		
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
		
		vQR_picture1:=$img
		
	End if 
End if 