//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 09/02/17, 15:56:55
  // ----------------------------------------------------
  // Método: PIC_generaimagenHebreo
  // Descripción
  // este metodo es solo para imprimir un texto en hebreo en una imagen para que se pueda visualizar de manera correcta en un informe
  //actualmente al imprimir en un informe un texto o un campo(en superReport, PrintList, AreaList)se muestra de manera invertida
  //por ese motivo se tuvo que crear este metodo para que se puedan visualizar pero en una imagen
  //


  // Modificado por: Alexis Bustamante,Adrián Sepúlveda  (17-02-2017)

  // Parámetros
  //$1:= texto a utilizar
  //$2:= Verdadero si se desea calcular el Alto de la imagen 
  //$3:=Ancho de la Imagen
  //$4:=Alto de la Imagen
  //$5:=Ancho en Pixeles para ser utilizado en la division de Lineas del texto ingresado
  //$6:=Tipo de letra (Fuente, por defecto Tahoma)
  //$7:=Tamaño de Letra
  // ----------------------------------------------------

C_TEXT:C284($1;$6;$t_fuente;$t_text;$textReference;$svgReference)
C_LONGINT:C283($5;$3;$4;$7;$l_lineas;$l_tamañoFuente;$l_alto;$ancho;$l_pxAncho)
C_PICTURE:C286($picture;$0)
C_TEXT:C284($textReference)
C_BOOLEAN:C305($2;$b_calcularTamaño)
C_REAL:C285($r_tamañoxLinea)
ARRAY TEXT:C222($at_texto;0)


$t_text:=$1
$l_ancho:=1800
$l_alto:=200
$l_pxAncho:=1800
$t_fuente:="Tahoma"
$l_tamañoFuente:=30

Case of 
	: (Count parameters:C259=2)
		$b_calcularTamaño:=$2
	: (Count parameters:C259=3)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
	: (Count parameters:C259=4)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
	: (Count parameters:C259=5)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
		$l_pxAncho:=$5
		
		
	: (Count parameters:C259=6)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
		$l_pxAncho:=$5
		$t_fuente:=$6
	: (Count parameters:C259=7)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
		$l_pxAncho:=$5
		$t_fuente:=$6
		$l_tamañoFuente:=$7
End case 

$t_text:=Replace string:C233($t_text;"\n";"\r")
TEXT TO ARRAY:C1149($t_text;$at_texto;$l_pxAncho;$t_fuente;$l_tamañoFuente)
$t_text:=AT_array2text (->$at_texto;"\r")


  //solo paea calcular alto de la imagen
If ($b_calcularTamaño)
	$l_lineas:=Size of array:C274($at_texto)
	$r_tamañoxLinea:=200/5
	$l_alto:=$l_lineas*$r_tamañoxLinea
End if 

$svgReference:=SVG_New ($l_ancho;$l_alto)
  //$textReference:=SVG_New_text ($svgReference;$t_text;0;0;$t_fuente;$l_tamañoFuente;0;2;"black";0;5;0)
$textReference:=SVG_New_text ($svgReference;$t_text;0;0;$t_fuente;$l_tamañoFuente)

$picture:=SVG_Export_to_picture ($svgReference)
SVG_CLEAR ($svgReference)

$0:=$picture











  // ----------------------------------------------------
  // Usuario (SO): Jorge Valenzuela
  // Fecha y hora: 09/02/17, 15:56:55
  // ----------------------------------------------------
  // Método: PIC_generaimagenHebreo
  // Descripción
  // este metodo es solo para imprimir un texto en hebreo en una imagen para que se pueda visualizar de manera correcta en un informe
  //actualmente al imprimir en un informe un texto o un campo(en superReport, PrintList, AreaList)se muestra de manera invertida
  //por ese motivo se tuvo que crear este metodo para que se puedan visualizar pero en una imagen
  //


  // Modificado por: Alexis Bustamante,Adrián Sepúlveda  (17-02-2017)

  // Parámetros
  //$1:= texto a utilizar
  //$2:= Verdadero si se desea calcular el Alto de la imagen 
  //$3:=Ancho de la Imagen
  //$4:=Alto de la Imagen
  //$5:=Ancho en Pixeles para ser utilizado en la division de Lineas del texto ingresado
  //$6:=Tipo de letra (Fuente, por defecto Tahoma)
  //$7:=Tamaño de Letra
  // ----------------------------------------------------

C_TEXT:C284($1;$6;$t_fuente;$t_text;$textReference;$svgReference)
C_LONGINT:C283($3;$4;$5;$7;$l_lineas;$l_tamañoFuente;$l_alto;$l_ancho;$l_pxAncho)
C_PICTURE:C286($picture;$0)
C_TEXT:C284($textReference)
C_BOOLEAN:C305($2;$b_calcularTamaño)
C_REAL:C285($r_tamañoxLinea)
ARRAY TEXT:C222($at_texto;0)


$t_text:=$1
$l_ancho:=1800
$l_alto:=200
$l_pxAncho:=1800
$t_fuente:="Tahoma"
$l_tamañoFuente:=30

Case of 
	: (Count parameters:C259=2)
		$b_calcularTamaño:=$2
	: (Count parameters:C259=3)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
	: (Count parameters:C259=4)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
	: (Count parameters:C259=5)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
		$l_pxAncho:=$5
	: (Count parameters:C259=6)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
		$l_pxAncho:=$5
		$t_fuente:=$6
	: (Count parameters:C259=7)
		$b_calcularTamaño:=$2
		$l_ancho:=$3
		$l_alto:=$4
		$l_pxAncho:=$5
		$t_fuente:=$6
		$l_tamañoFuente:=$7
End case 

$t_text:=Replace string:C233($t_text;"\n";"\r")
TEXT TO ARRAY:C1149($t_text;$at_texto;$l_pxAncho;$t_fuente;$l_tamañoFuente)
$t_text:=AT_array2text (->$at_texto;"\r")


  //solo paea calcular alto de la imagen en caso de 2do parametro true
If ($b_calcularTamaño)
	$l_lineas:=Size of array:C274($at_texto)
	$r_tamañoxLinea:=200/5
	$l_alto:=$l_lineas*$r_tamañoxLinea
End if 

$svgReference:=SVG_New ($l_ancho;$l_alto)
  //$textReference:=SVG_New_text ($svgReference;$t_text;0;0;$t_fuente;$l_tamañoFuente;0;2;"black";0;5;0)
$textReference:=SVG_New_text ($svgReference;$t_text;0;0;$t_fuente;$l_tamañoFuente)

$picture:=SVG_Export_to_picture ($svgReference)
SVG_CLEAR ($svgReference)

$0:=$picture



















