If (Form event:C388=On Printing Detail:K2:18)
	
	CLEAR VARIABLE:C89(vQR_picture1)
	C_PICTURE:C286(vQR_picture1;$img)
	
	ARRAY TEXT:C222($etiquetasErr;0)
	ARRAY TEXT:C222($valoresErr;0)
	ARRAY TEXT:C222($camposEncHttp;0)
	ARRAY TEXT:C222($valoresEncHttp;0)
	
	C_TEXT:C284($parametros;$notas;$categorias;$ruta;$grafico;$stdOut)
	
	
	C_BOOLEAN:C305($okphp)
	
	vQR_longint1:=580
	vQR_longint2:=300
	
	C_BOOLEAN:C305($vb_rotar)
	
	If (Size of array:C274(aPD)>15)
		For ($i;1;(Size of array:C274(aPD)-15))
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
	
	
	
	
	
	If (Size of array:C274(aPD)>0)
		
		  //ARRAY TEXT($at_pos;0)
		  //ARRAY TEXT($at_neg;0)
		  //ARRAY TEXT($at_md;0)
		  //ARRAY TEXT($at_susp;0)
		
		
		
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //TICKET 179869
		
		
		ARRAY LONGINT:C221($at_pos;0)
		ARRAY LONGINT:C221($at_neg;0)
		ARRAY LONGINT:C221($at_md;0)
		ARRAY LONGINT:C221($at_susp;0)
		
		
		ARRAY TEXT:C222(aQR_text50;0)
		
		
		APPEND TO ARRAY:C911(aQR_text50;"#2E64FE")  //positivas Azul
		APPEND TO ARRAY:C911(aQR_text50;"#FE2E2E")  //Negativas Rojo
		APPEND TO ARRAY:C911(aQR_text50;"#F7FE2E")  //Amarillo
		APPEND TO ARRAY:C911(aQR_text50;"#58FA58")  //verde
		
		
		  //CU_Informe
		  //
		  //For ($i;1;Size of array(aPD1))
		  //APPEND TO ARRAY($at_pos;String(aPD1{$i}))
		  //End for 
		  //For ($i;1;Size of array(aPD2))
		  //APPEND TO ARRAY($at_neg;String(aPD2{$i}))
		  //End for 
		  //For ($i;1;Size of array(aPD3))
		  //APPEND TO ARRAY($at_md;String(aPD3{$i}))
		  //End for 
		  //For ($i;1;Size of array(aPD))
		  //APPEND TO ARRAY(aQR_text1;String(aPD{$i}))
		  //End for 
		
		For ($i;1;Size of array:C274(aPD1))
			APPEND TO ARRAY:C911($at_pos;aPD1{$i})
		End for 
		For ($i;1;Size of array:C274(aPD2))
			APPEND TO ARRAY:C911($at_neg;aPD2{$i})
		End for 
		For ($i;1;Size of array:C274(aPD3))
			APPEND TO ARRAY:C911($at_md;aPD3{$i})
		End for 
		For ($i;1;Size of array:C274(aPD4))
			APPEND TO ARRAY:C911($at_susp;aPD4{$i})
		End for 
		
		
		C_OBJECT:C1216($ob_raiz;$ob_series;$ob_leyendas)
		C_LONGINT:C283($l_margenIzq;$l_margenDer;$l_margenarriba;$l_margenabajo;$l_tamañoLetraBarra;$l_TamañoLetraX)
		C_BOOLEAN:C305($b_mostrarbarra)
		C_TEXT:C284($t_leyendaPosX;$t_leyendaPosY;$t_leyendaAlignX;$t_inclinacionX;$t_anotpos;$t_anotNeg;$t_Medidas;$t_suspen)
		
		
		
		
		$ob_raiz:=OB_Create 
		$ob_series:=OB_Create 
		$ob_leyendas:=OB_Create 
		
		$l_margenIzq:=30
		$l_margenDer:=20
		$l_margenarriba:=10
		$l_margenabajo:=255
		$b_mostrarbarra:=False:C215
		$l_tamañoLetraBarra:=4
		$l_TamañoLetraX:=7
		$t_leyendaPosX:="0.5"
		$t_leyendaPosY:="0.9"
		$t_leyendaAlignX:="center"
		$t_leyendaAlignY:="bottom"
		$t_inclinacionX:="90"
		
		$t_anotpos:="ANOT. +"
		$t_anotNeg:="ANOT. -"
		$t_Medidas:="Medidas Disciplinarias"
		$t_suspen:="Suspensiones"
		
		OB_SET ($ob_raiz;->vQR_longint1;"ancho")
		OB_SET ($ob_raiz;->vQR_longint2;"alto")
		OB_SET ($ob_raiz;->$l_margenIzq;"margenIzq")
		OB_SET ($ob_raiz;->$l_margenDer;"margenDer")
		
		OB_SET ($ob_raiz;->$l_margenarriba;"margenArriba")
		OB_SET ($ob_raiz;->$l_margenabajo;"margenAbajo")
		
		OB_SET ($ob_raiz;->$b_mostrarbarra;"MostrarValorbarra")
		
		
		
		OB_SET ($ob_raiz;->aQR_text50;"Colores")
		OB_SET ($ob_raiz;->aPD;"categorias")
		
		OB_SET ($ob_series;->$at_pos;"serie0")
		OB_SET ($ob_series;->$at_neg;"serie1")
		OB_SET ($ob_series;->$at_md;"serie2")
		OB_SET ($ob_series;->$at_susp;"serie3")
		OB_SET ($ob_raiz;->$ob_series;"series")
		
		OB_SET ($ob_raiz;->$l_tamañoLetraBarra;"TamañoLetraBarra")
		OB_SET ($ob_raiz;->$l_TamañoLetraX;"TamañoLetraX")
		
		OB_SET ($ob_leyendas;->$t_anotpos;"leyenda0")
		OB_SET ($ob_leyendas;->$t_anotNeg;"leyenda1")
		OB_SET ($ob_leyendas;->$t_Medidas;"leyenda2")
		OB_SET ($ob_leyendas;->$t_suspen;"leyenda3")
		OB_SET ($ob_raiz;->$ob_leyendas;"leyendas")
		
		OB_SET ($ob_raiz;->$t_leyendaPosX;"leyendaPosX")
		OB_SET ($ob_raiz;->$t_leyendaPosY;"leyendaPosY")
		OB_SET ($ob_raiz;->$t_leyendaAlignX;"leyendaAlignX")
		OB_SET ($ob_raiz;->$t_leyendaAlignY;"leyendaAlignY")
		OB_SET ($ob_raiz;->$t_inclinacionX;"inclinacionX")
		
		$parametros:=OB_Object2Json ($ob_raiz)
		
		
		  // Modificado por: Alexis Bustamante (31/08/2016) Ticket 167136
		  //$t_principal:=JSON New 
		  //$node:=JSON Append long ($t_principal;"ancho";vQR_longint1)
		  //$node:=JSON Append long ($t_principal;"alto";vQR_longint2)
		  //$node:=JSON Append long ($t_principal;"margenIzq";30)
		  //$node:=JSON Append long ($t_principal;"margenDer";20)
		
		
		  //modificado estaba en 20
		  //$node:=JSON Append long ($t_principal;"margenArriba";10)
		  //$node:=JSON Append bool ($t_principal;"MostrarValorbarra";False)
		  //$node:=JSON Append bool ($t_principal;"MostrarValorbarra";Num(False))
		
		  //modifcado estaba en 70
		  //$node:=JSON Append long ($t_principal;"margenAbajo";255)
		  //$node:=JSON Append text array ($t_principal;"categorias";aPD)
		
		  //$t_series:=JSON Append node ($t_principal;"series")
		  //$t_legend:=JSON Append node ($t_principal;"leyendas")
		  //$node:=JSON Append text array ($t_principal;"Colores";aQR_text50)
		
		  //  //lo agregue recien
		  //$node:=JSON Append long ($t_principal;"TamañoLetraBarra";4)
		  //$node:=JSON Append long ($t_principal;"TamañoLetraX";7)
		
		  //$node:=JSON Append long array ($t_series;"serie0";$at_pos)
		  //$node:=JSON Append long array ($t_series;"serie1";$at_neg)
		  //$node:=JSON Append text array ($t_series;"serie2";$at_md)
		  //$node:=JSON Append long array ($t_series;"serie3";$at_susp)
		
		
		  //$node:=JSON Append text ($t_legend;"leyenda0";"ANOT. +")
		  //$node:=JSON Append text ($t_legend;"leyenda1";"ANOT. -")
		  //$node:=JSON Append text ($t_legend;"leyenda2";"Medidas Disciplinarias")
		  //$node:=JSON Append text ($t_legend;"leyenda3";"Suspensiones")
		
		  //$node:=JSON Append text ($t_principal;"leyendaPosX";"0.5")
		  //$node:=JSON Append text ($t_principal;"leyendaPosY";"0.9")
		  //$node:=JSON Append text ($t_principal;"leyendaAlignX";"center")
		  //$node:=JSON Append text ($t_principal;"leyendaAlignY";"bottom")
		
		  //$node:=JSON Append text ($t_principal;"inclinacionX";"90")
		  //$node:=JSON Append text ($t_principal;"SetLabelSideX";"SIDE_UP")
		
		  //$parametros:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($t_principal)
		
		
		
		
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