//%attributes = {}
  //ACTdte_CargarCAF

  //MÉTODO: DTE_CargarCAF

  //AUTOR: Marcelo Müller
  //FECHA: 03-10-2009
  //DESCRIPCIÓN: Procesa el archivo XML con CAF y entrega un arreglo con los datos obtenidos.
  //PARÁMETROS:
  //
  //$1: Path del archivo XML
  //$2: Puntero a arreglo de textos en donde se almacenarán los datos del CAF. Contiene 10 valores:
  //
  //1: RUT
  //2: Razón social
  //3: Tipo de documento
  //4: Folio inicial
  //5: Folio final
  //6: Fecha de generación del CAF
  //7: Módulo de la llave pública del contribuyente
  //8: Exponente de la llave pública del contribuyente
  //9: Llave privada del contribuyente en formato PEM
  //10: Llave pública del contribuyente en formato PEM
  //
  //RETORNO: Indicador de éxito de la operación (True ó False)

C_TEXT:C284($value)
$archivo:=$1
$res:=True:C214
$b_cerrarXML:=True:C214
EM_ErrorManager ("Install")
EM_ErrorManager ("SetMode";"")
$xml:=DOM Parse XML source:C719($archivo)
EM_ErrorManager ("Clear")
If (OK=0)
	$res:=False:C215
	$b_cerrarXML:=False:C215
End if 

  //RUT

If ($res=True:C214)
	
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/RE")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{1}:=$value
End if 

  //RAZÓN SOCIAL

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/RS")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{2}:=$value
	
End if 

  //TIPO DE DOCUMENTO

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/TD")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{3}:=$value
	
End if 

  //FOLIO INICIAL

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/RNG/D")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{4}:=$value
	
End if 

  //FOLIO FINAL

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/RNG/H")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{5}:=$value
	
End if 

  //FECHA DE GENERACIÓN

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/FA")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{6}:=$value
	
End if 

  //MÓDULO DE LA LLAVE PÚBLICA DEL CONTRIBUYENTE

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/RSAPK/M")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{7}:=$value
	
End if 

  //EXPONENTE DE LA LLAVE PÚBLICA DEL CONTRIBUYENTE

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/CAF/DA/RSAPK/E")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{8}:=$value
	
End if 

  //LLAVE PRIVADA DEL CONTRIBUYENTE EN FORMATO PEM

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/RSASK")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{9}:=$value
	
End if 

  //LLAVE PÚBLICA DEL CONTRIBUYENTE EN FORMATO PEM

If ($res=True:C214)
	$elem:=DOM Find XML element:C864($xml;"AUTORIZACION/RSAPUBK")
	DOM GET XML ELEMENT VALUE:C731($elem;$value)
	If (OK=0)
		$res:=False:C215
	End if 
	
	$2->{10}:=$value
	
End if 

If ($b_cerrarXML)
	DOM CLOSE XML:C722($xml)
End if 

$0:=$res
