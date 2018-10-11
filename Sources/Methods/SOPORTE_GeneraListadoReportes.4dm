//%attributes = {}
  //SOPORTE_GeneraListadoReportes

  //2016-11-07 RCH. Método usado por QA para exporta una lista de los reportes más generados en la base de datos.
C_TEXT:C284($t_tipo)
C_LONGINT:C283($l_existe;$l_proc;$l_resp;$l_indice)

ARRAY TEXT:C222(aQR_Text1;0)
ARRAY TEXT:C222(aQR_Text2;0)
ARRAY TEXT:C222(aQR_Text3;0)
ARRAY TEXT:C222(aQR_Text4;0)
ARRAY LONGINT:C221(aQR_longint1;0)
ARRAY LONGINT:C221(aQR_longint2;0)
ARRAY TEXT:C222(aQR_text10;0)  //fecha ultima modificacion informe
ARRAY TEXT:C222(aQR_Text5;0)  //tipo codigo
ARRAY TEXT:C222(aQR_Text6;0)  //tipo descripcion
C_DATE:C307(vQR_Date1)

APPEND TO ARRAY:C911(aQR_Text5;"gSR2")
APPEND TO ARRAY:C911(aQR_Text5;"4DSE")
APPEND TO ARRAY:C911(aQR_Text5;"4DFO")
APPEND TO ARRAY:C911(aQR_Text5;"4DET")
APPEND TO ARRAY:C911(aQR_Text5;"4DWR")

APPEND TO ARRAY:C911(aQR_Text6;"Super Report")
APPEND TO ARRAY:C911(aQR_Text6;"Columnas")
APPEND TO ARRAY:C911(aQR_Text6;"Formularios")
APPEND TO ARRAY:C911(aQR_Text6;"Etiquetas")
APPEND TO ARRAY:C911(aQR_Text6;"Write")

vQR_Long2:=5  //se muestran solo los que han sido impresos 5 o más veces
vQR_Date1:=Add to date:C393(Current date:C33(*);-1;0;0)

$l_resp:=CD_Dlog (0;"Se buscarán los informes impresos más de "+String:C10(vQR_Long2)+" veces desde el "+String:C10(vQR_Date1)+" en adelante. Si desea modificar el número, cambie el valor de la variable vQR_Long2 en este script. Si desea cambiar la fecha, haga lo propio con la varibable vQR_Date1."+"\r\r"+"¿Desea continuar?";"";"Si";"No")

If ($l_resp=1)
	
	$l_proc:=IT_UThermometer (1;0;"Buscando información...")
	
	  //busco eventos de impresion
	READ ONLY:C145([xShell_UserEvents:282])
	QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]Event:6=UE_PrintReport)
	
	QUERY SELECTION:C341([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3>=DTS_MakeFromDateTime (vQR_Date1))
	
	SELECTION TO ARRAY:C260([xShell_UserEvents:282]Parameters:7;aQR_Text1;[xShell_UserEvents:282]Module:4;aQR_Text2;[xShell_UserEvents:282]TabNum:5;aQR_longint1)
	For ($l_indice;1;Size of array:C274(aQR_Text1))
		APPEND TO ARRAY:C911(aQR_Text4;aQR_Text2{$l_indice}+"|"+String:C10(aQR_longint1{$l_indice})+"|"+aQR_Text1{$l_indice}+"")
	End for 
	
	  //creo arreglo llave cada registro
	COPY ARRAY:C226(aQR_Text4;aQR_Text3)
	
	  //obtengo valores únicos
	AT_DistinctsArrayValues (->aQR_Text3)
	
	  //cuento las veces que fue impreso el reporte
	For ($l_indice;1;Size of array:C274(aQR_Text3))
		APPEND TO ARRAY:C911(aQR_longint2;Count in array:C907(aQR_Text4;aQR_Text3{$l_indice}))
	End for 
	
	  //obtengo los datos para mostrar
	AT_Initialize (->aQR_Text1;->aQR_Text2;->aQR_text10;->aQR_longint1)
	
	For ($l_indice;1;Size of array:C274(aQR_Text3))
		APPEND TO ARRAY:C911(aQR_longint1;Num:C11(ST_GetWord (aQR_Text3{$l_indice};2;"|")))  //tabla
		APPEND TO ARRAY:C911(aQR_Text2;ST_GetWord (aQR_Text3{$l_indice};1;"|"))  //modulo
		APPEND TO ARRAY:C911(aQR_Text1;ST_GetWord (aQR_Text3{$l_indice};3;"|"))  //parameters
		$t_tipo:=ST_GetWord (aQR_Text1{Size of array:C274(aQR_text1)};1;";")
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26=$t_tipo)
		
		QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]Modulo:41=aQR_Text2{Size of array:C274(aQR_Text2)})
		APPEND TO ARRAY:C911(aQR_text10;[xShell_Reports:54]timestampISO_modificacion:35)  // ABK - 
	End for 
	
	  //ordeno por módulo, tabla y cantidad de veces impreso  
	AT_MultiLevelSort (">><>>";->aQR_Text2;->aQR_longint1;->aQR_longint2;->aQR_Text1;->aQR_text10)
	
	  //genero variable que será pegada en el portapapeles
	vQR_Text1:="Módulo"+"\t"+"Tabla"+"\t"+"Tipo"+"\t"+"Informe"+"\t"+"Impresiones"+"fecha última modificación"+"\t"+"Impresiones, fecha última impresión"+"\r"
	For ($l_indice;1;Size of array:C274(aQR_Text3))
		If (aQR_longint2{$l_indice}>=vQR_Long2)
			$t_tipo:=ST_GetWord (aQR_Text1{$l_indice};2;";")
			$l_existe:=Find in array:C230(aQR_Text5;$t_tipo)
			
			If ($l_existe#-1)
				$t_tipo:=aQR_Text6{$l_existe}
			End if 
			
			READ ONLY:C145([xShell_UserEvents:282])
			QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]Event:6=UE_PrintReport;*)
			QUERY:C277([xShell_UserEvents:282]; & ;[xShell_UserEvents:282]DTS:3>=DTS_MakeFromDateTime (vQR_Date1);*)
			QUERY:C277([xShell_UserEvents:282]; & ;[xShell_UserEvents:282]Parameters:7=aQR_Text1{$l_indice})
			ORDER BY:C49([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3;<)
			
			vQR_Text1:=vQR_Text1+aQR_Text2{$l_indice}+"\t"+XSvs_nombreTablaLocal_Numero (aQR_longint1{$l_indice})+"\t"+$t_tipo+"\t"+ST_GetWord (aQR_Text1{$l_indice};1;";")+"\t"+String:C10(aQR_longint2{$l_indice})+"\t"+aQR_text10{$l_indice}+"\t"+[xShell_UserEvents:282]DTS:3+"\r"
		End if 
	End for 
	IT_UThermometer (-2;$l_proc)
	
	  //copio al portapapeles y muestro el mensaje
	SET TEXT TO PASTEBOARD:C523(vQR_Text1)
	CD_Dlog (0;"Resultado copiado al portapapeles.")
	
	QR_DeclareGenericArrays 
	vQR_Text1:=""
End if 