//%attributes = {}
  // Método: 0xDev_ExpressionFinder_Example
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 03/08/10, 14:18:57
  // ---------------------------------------------
  // Descripción: 
  // Este método busca en el código de un metodo cuyo ID es pasado en $1 
  // todas las eventuales ocurrencias de Tablas distintas que pueden haber sido pasadas en argumento
  // en un llamado a SELECTION TO ARRAY (4D v11 no soporta esta posibilidad)
  // El método es llamado desde la herramienta de busqueda de expresiones complejas en el código de la aplicación

  // NO MODIFICAR ESTE METODO. DEDE SER UTILIZADO SOLO COMO UN EJEMPLO

  // Parámetros:
  // $1: ID del objeto código a analizar
  //----------------------------------------------




  // Declaraciones e inicializaciones
C_BLOB:C604($xMethod)
C_LONGINT:C283($offset;$endOfLine)
C_TEXT:C284($parameters;$text;$tableORField)
$idObject:=$1

  // Código principal
$xMethod:=4D_GetMethodTextBlob_By_CC4D_ID ($idObject)
ARRAY LONGINT:C221($aPositions;0)



  //cuento el número de veces que la sentencia esta presente en el código
  //en el arreglo $aPositions se cargan las posiciones iniciales de la sentencia
$counts:=API Count In Blob ($xMethod;"SELECTION TO ARRAY(";0;0;0;$aPositions)
For ($i;1;$counts)
	$offset:=$aPositions{$i}
	$text:=BLOB to text:C555($xMethod;Mac text without length:K22:10;$offset)  //leo el textodesde la posición inicial
	$endOfLine:=Position:C15(")"+"\r";$text)
	$lineText:=Substring:C12($text;1;$endOfLine)  //extraigo la línea de código
	
	  //extraigos solo los parametros y los pongo en un array
	$parameters:=Replace string:C233(Substring:C12($lineText;1;Length:C16($lineText)-1);"SELECTION TO ARRAY(";"")
	ARRAY TEXT:C222($aParameters;0)
	AT_Text2Array (->$aParameters;$parameters)
	
	
	$firstTable:=""  //inicializo la variable $firstTable donde almacenaré el primer argumento de tipo Tabla
	
	  //recorro el arreglo por pares (solo interesa el primer elemento del par)
	For ($iParameters;1;Size of array:C274($aParameters);2)
		$tableORField:=$aParameters{$iParameters}  //asigno el primer elemento del par a la variable
		
		Case of 
			: (($tableORField[[1]]="[") & ($tableORField[[Length:C16($tableORField)]]="]"))  //es una tabla
				If ($firstTable="")  //asigno el nombre del primer arfgumento de tipo tabla a la variable $firstTable
					$firstTable:=$tableORField
				Else 
					If ($firstTable#$tableORField)
						  //si ya se había asignado una tabla a $firstTable y la nueva tabla es distinta de $firstTable tenemos un error en el codigo
						  //agrego a los arreglos el ID del objeto código (si es positivo se mostrará como un error) y la linea de código
						APPEND TO ARRAY:C911(aCodeObjectIds;$idObject)
						APPEND TO ARRAY:C911(aCodeLineText;$lineText)
					End if 
				End if 
				
				
				
			: (($tableORField[[1]]="[") & ($tableORField[[Length:C16($tableORField)]]#"]"))  //es un campo
				  //es un campo, no hago nada
				
			: (Substring:C12($tableORField;Length:C16($tableORField)-1)="->")  //es un variable puntero sobre un campo
				  //el puntero no puede evaluado porque puede haber sido declarado en otro proceso
				  //agrego la ocurrencia con un ID negativo (será mostrado como una advertencia)  y la linea de código
				APPEND TO ARRAY:C911(aCodeObjectIds;-$idObject)
				APPEND TO ARRAY:C911(aCodeLineText;$lineText)
				
			: (Substring:C12($tableORField;Length:C16($tableORField)-2)="->{")  //en un elemento de arreglo puntero sobre un campo
				  //el puntero no puede evaluado porque puede haber sido declarado en otro proceso
				  //agrego la ocurrencia con un ID negativo (será mostrado como una advertencia)  y la linea de código
				APPEND TO ARRAY:C911(aCodeObjectIds;-$idObject)
				APPEND TO ARRAY:C911(aCodeLineText;$lineText)
				
		End case 
	End for 
End for 



