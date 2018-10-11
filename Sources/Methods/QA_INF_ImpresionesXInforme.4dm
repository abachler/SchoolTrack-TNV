//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 22-07-14, 13:15:28
  // ----------------------------------------------------
  // Método: QA_INF_ImpresionesXInforme
  // Descripción
  // Método que copia al portapapeles la cantidad de veces que fue impreso un informe.
  //
  // Parámetros
  // ----------------------------------------------------

  //CAMBIOS
  //20150303 RCH Se agregan opciones para agregar filtros. 11.9.13581 o superior

C_TEXT:C284($t_tipo;$t_filtro;$t_parametro1)
C_LONGINT:C283($l_existe;$l_proc;$l_resp;$l_indice)
ARRAY TEXT:C222($atACT_filtrosAceptados;0)
C_BOOLEAN:C305($b_continuar)
C_LONGINT:C283($1)
C_TEXT:C284($2;$3)

ARRAY TEXT:C222(aQR_Text1;0)
ARRAY TEXT:C222(aQR_Text2;0)
ARRAY TEXT:C222(aQR_Text3;0)
ARRAY TEXT:C222(aQR_Text4;0)
ARRAY LONGINT:C221(aQR_longint1;0)
ARRAY LONGINT:C221(aQR_longint2;0)

ARRAY TEXT:C222(aQR_Text5;0)  //tipo codigo
ARRAY TEXT:C222(aQR_Text6;0)  //tipo descripcion

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

APPEND TO ARRAY:C911($atACT_filtrosAceptados;"")
APPEND TO ARRAY:C911($atACT_filtrosAceptados;"duranteultimoaño")
APPEND TO ARRAY:C911($atACT_filtrosAceptados;"desdedts")

If (Count parameters:C259>=1)
	vQR_Long2:=$1
End if 

If (Count parameters:C259>=2)
	$t_filtro:=$2
End if 

If (Count parameters:C259>=3)
	$t_parametro1:=$3
End if 

  //validaciones de entrada
If (vQR_Long2=0)
	vQR_Long2:=5  //se muestran solo los que han sido impresos 5 o más veces
End if 

$b_continuar:=True:C214
If (Count parameters:C259>1)
	If (Find in array:C230($atACT_filtrosAceptados;$2)=-1)
		CD_Dlog (0;"Filtro no aceptado")
		$b_continuar:=False:C215
	End if 
	
	If (($t_filtro="desdedts") & ($t_parametro1=""))
		CD_Dlog (0;"Cuando el filtro es "+ST_Qte ($t_filtro)+" se debe indicar un tercer parámetro tipo AAAAMMDD")
		$b_continuar:=False:C215
	End if 
	
End if 


If ($b_continuar)
	$l_resp:=CD_Dlog (0;"Se buscarán los informes impresos más de "+String:C10(vQR_Long2)+" veces. Si desea modificar este número, pase como primer parámetro el valor que desea utilizar."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
	
	If ($l_resp=1)
		
		$l_proc:=IT_UThermometer (1;0;"Buscando información…")
		
		  //busco eventos de impresion
		READ ONLY:C145([xShell_UserEvents:282])
		QUERY:C277([xShell_UserEvents:282];[xShell_UserEvents:282]Event:6=UE_PrintReport)
		
		Case of 
			: ($t_filtro="")  //comportamiento por defecto
				
				
			: ($t_filtro="duranteultimoaño")  //20150303 RCH
				C_TEXT:C284($t_dts)
				C_DATE:C307($d_fecha)
				$d_fecha:=Current date:C33(*)
				$d_fecha:=Add to date:C393($d_fecha;-1;0;0)
				$t_dts:=DTS_MakeFromDateTime ($d_fecha)
				QUERY SELECTION:C341([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3>=$t_dts)
				
			: ($t_filtro="desdedts")  //20150303 RCH
				C_TEXT:C284($t_dts)
				$t_dts:=$t_parametro1
				QUERY SELECTION:C341([xShell_UserEvents:282];[xShell_UserEvents:282]DTS:3>=$t_dts)
		End case 
		
		SELECTION TO ARRAY:C260([xShell_UserEvents:282]Parameters:7;aQR_Text1;[xShell_UserEvents:282]Module:4;aQR_Text2;[xShell_UserEvents:282]TabNum:5;aQR_longint1)
		For ($l_indice;1;Size of array:C274(aQR_Text1))
			APPEND TO ARRAY:C911(aQR_Text4;aQR_Text2{$l_indice}+"|"+String:C10(aQR_longint1{$l_indice})+"|"+aQR_Text1{$l_indice})
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
		AT_Initialize (->aQR_Text1;->aQR_Text2;->aQR_longint1)
		For ($l_indice;1;Size of array:C274(aQR_Text3))
			APPEND TO ARRAY:C911(aQR_longint1;Num:C11(ST_GetWord (aQR_Text3{$l_indice};2;"|")))  //tabla
			APPEND TO ARRAY:C911(aQR_Text2;ST_GetWord (aQR_Text3{$l_indice};1;"|"))  //modulo
			APPEND TO ARRAY:C911(aQR_Text1;ST_GetWord (aQR_Text3{$l_indice};3;"|"))  //parameters
		End for 
		
		  //ordeno por módulo, tabla y cantidad de veces impreso
		AT_MultiLevelSort (">><>";->aQR_Text2;->aQR_longint1;->aQR_longint2;->aQR_Text1)
		
		  //genero variable que será pegada en el portapapeles
		vQR_Text1:="Filtro: "+$t_filtro+Choose:C955($t_parametro1#"";", parámetro 2: "+$t_parametro1;"")+"\r"
		vQR_Text1:=vQR_Text1+"Módulo"+"\t"+"Tabla"+"\t"+"Tipo"+"\t"+"Informe"+"\t"+"Impresiones"+"\r"
		For ($l_indice;1;Size of array:C274(aQR_Text3))
			If (aQR_longint2{$l_indice}>=vQR_Long2)
				$t_tipo:=ST_GetWord (aQR_Text1{$l_indice};2;";")
				$l_existe:=Find in array:C230(aQR_Text5;$t_tipo)
				vQR_Text1:=vQR_Text1+aQR_Text2{$l_indice}+"\t"+XSvs_nombreTablaLocal_Numero (aQR_longint1{$l_indice})+"\t"+Choose:C955($l_existe=-1;$t_tipo;aQR_Text6{$l_existe})+"\t"+ST_GetWord (aQR_Text1{$l_indice};1;";")+"\t"+String:C10(aQR_longint2{$l_indice})+"\r"
			End if 
		End for 
		IT_UThermometer (-2;$l_proc)
		
		  //copio al portapapeles y muestro el mensaje
		SET TEXT TO PASTEBOARD:C523(vQR_Text1)
		CD_Dlog (0;"Resultado copiado al portapapeles.")
		
		QR_DeclareGenericArrays 
		vQR_Text1:=""
	End if 
End if 