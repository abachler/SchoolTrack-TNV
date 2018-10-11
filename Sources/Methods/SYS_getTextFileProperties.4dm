//%attributes = {}
  // MÉTODO: SYS_getTextFileProperties
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/04/12, 18:13:17
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // SYS_getTextFileProperties(ruta;opcionVerificacion;separadorFilas;separadorColumnas{;numeroFilas{;numeroColumnas}}) -> Tamaño documento o error
  // -> ruta (&texto); ruta del documento a verificar
  // <- opcionVerificacion (&long); opciones de análisis del documento (pueden adicionarse)
  //    0: sin verificacion
  //    1: verifica estructura de los primeros 32000 caracteres
  //    2: verifica todo el documento
  //    4: muestra un mensaje de progreso (no aplica a la verificación de los 32000 primeros caracteres)
  // <- separadorFilas (punteroTexto); devuelve el separador de filas en variable pasada como puntero
  // <- separadorColumnas (punteroTexto; devuelve el separador de filas en variable pasada como puntero
  // <- numeroFilas (punteroNumérico); numero de filas en el documento; opcional (cuando se pasa este argumento se fuerza el análisis completo del documento
  // <- numeroColumnas (punteroNumérico); numero de filas en el documento; opcional
  // <- Tamaño documento o error (&long);
  //    >0 tamaño del doumento,
  //    -1 el archivo no es de tipo texto
  //    <1 tamaño del archivo en negativo (indica estructura de archivo inválida)
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_BOOLEAN:C305($b_estructuraInvalida)
C_LONGINT:C283($i;$l_caracteresLeidos;$l_IdProcesoProgreso;$l_numeroColumnasFila;$l_numeroColumnasTestigo;$l_numeroDeColumnas;$l_numeroDeFilas;$l_opcionAnalisis;$l_resultado;$l_tamañoDocumento)
C_TIME:C306($h_referenciaDocumento)
C_POINTER:C301($y_numeroColumnas;$y_numeroFilas;$y_separadorColumnas;$y_separadorFilas)
C_TEXT:C284($t_muestraTexto32K;$t_rutaDocumento;$t_separadorColumna;$t_separadorFilas;$t_textoFila;$t_TipoDocumento)

ARRAY TEXT:C222($at_FilasDocumento;0)
If (False:C215)
	C_LONGINT:C283(SYS_getTextFileProperties ;$0)
	C_TEXT:C284(SYS_getTextFileProperties ;$1)
	C_POINTER:C301(SYS_getTextFileProperties ;$3)
	C_POINTER:C301(SYS_getTextFileProperties ;$4)
	C_POINTER:C301(SYS_getTextFileProperties ;$5)
	C_POINTER:C301(SYS_getTextFileProperties ;$6)
End if 






  // CODIGO PRINCIPAL
$t_rutaDocumento:=$1
$l_opcionAnalisis:=$2
$y_separadorFilas:=$3
$y_separadorColumnas:=$4
$l_caracteresLeidos:=0

If (Count parameters:C259>=5)
	$l_opcionAnalisis:=$l_opcionAnalisis ?- 0  // si se desea obtener el numero de filas contenidas en el documento fuerzo el análisis completo.
	$l_opcionAnalisis:=$l_opcionAnalisis ?+ 1  // si se desea obtener el numero de filas contenidas en el documento fuerzo el análisis completo.
End if 

$t_TipoDocumento:=_o_Document type:C528($t_rutaDocumento)
$l_tamañoDocumento:=Get document size:C479($t_rutaDocumento)
$l_resultado:=$l_tamañoDocumento

Case of 
	: ($l_tamañoDocumento<=32000)  //si el tamaño del documento es inferior a 32000 desactivo el mensaje de avance y el analisis completo
		$l_opcionAnalisis:=$l_opcionAnalisis ?- 2
		$l_opcionAnalisis:=$l_opcionAnalisis ?- 1
		If ($l_opcionAnalisis>0)  // si enla llamada se especificó el análisis del documento
			$l_opcionAnalisis:=$l_opcionAnalisis ?+ 0  //fuerzo el análisis hasta 32000 caracteres, sin mensaje de avance
		End if 
		
	: ($l_tamañoDocumento<=1000000)  //si el tamaño del archivo es inferior a 1MB no es necesario el mensaje de avance (no será percibido por el usuario)
		$l_opcionAnalisis:=$l_opcionAnalisis ?- 2
End case 




If ($t_tipoDocumento#"TEXT")  // si el documento no es de tipo texto devuelvo el error -1
	
	$l_resultado:=-1
	
Else 
	
	  //inicio el análisis...
	$h_referenciaDocumento:=Open document:C264($t_rutaDocumento;"";Read mode:K24:5)
	RECEIVE PACKET:C104($h_referenciaDocumento;$t_muestraTexto32K;MAXTEXTLENBEFOREV11:K35:3)
	
	  // detecto el probable separador de filas
	Case of 
		: (Position:C15(Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40);$t_muestraTexto32K)>0)
			$t_separadorFilas:="\r"+Char:C90(10)
		: (Position:C15(Char:C90(10);$t_muestraTexto32K)>0)
			$t_separadorFilas:=Char:C90(Line feed:K15:40)
		: (Position:C15("\r";$t_muestraTexto32K)>0)
			$t_separadorFilas:=Char:C90(Carriage return:K15:38)
	End case 
	
	
	If ($t_separadorFilas="")
		  // si no hay separador de filas no se trata de una archivo con filas y columnas
		$b_estructuraInvalida:=True:C214
	Else 
		
		  // si hay separador de filas puedo continuar con el análisis
		AT_Text2Array (->$at_FilasDocumento;$t_muestraTexto32K;$t_separadorFilas)
		
		
		  // determino el separador de columnas utilizado en la primera línea
		Case of 
			: (Position:C15(Char:C90(Tab:K15:37);$at_FilasDocumento{1})>0)
				$t_separadorColumna:=Char:C90(Tab:K15:37)
			: (Position:C15(";";$at_FilasDocumento{1})>0)
				$t_separadorColumna:=";"
			: (Position:C15(",";$at_FilasDocumento{1})>0)
				$t_separadorColumna:=","
		End case 
		
		
		
		
		  // si se detectaron separadores de filas columnas y hay opciones de verificación activas
		If (($t_separadorColumna#"") & ($l_opcionAnalisis>0))
			
			  // cuento el número de columnas en la primera fila
			$l_numeroColumnasTestigo:=ST_CountWords ($at_FilasDocumento{1};0;$t_separadorColumna)
			
			Case of 
				: ($l_opcionAnalisis ?? 0)
					  // en la llamada se solicitó un análisis restringido a los primeros 32000 caracteres (bit 0 encendido)
					  // solo se analizan los primeros 32000 caracteres del archivo
					For ($i;1;Size of array:C274($at_FilasDocumento)-1)
						$l_numeroColumnasFila:=ST_CountWords ($at_FilasDocumento{$i};0;$t_separadorColumna)
						If ($l_numeroColumnasFila#$l_numeroColumnasTestigo)
							$b_estructuraInvalida:=True:C214
							$i:=Size of array:C274($at_FilasDocumento)
						End if 
					End for 
					$l_numeroDeFilas:=Size of array:C274($at_FilasDocumento)
					
					
					
					
				: ($l_opcionAnalisis ?? 1)
					  // si en la llamada se solicitó un análisis completo (bit 1 de las opciones encendido)
					SET DOCUMENT POSITION:C482($h_referenciaDocumento;0)
					
					If ($l_opcionAnalisis ?? 2)  // en la llamada se se solicitó un mensaje de avance (bit 2 de las opciones encendido)
						$l_IdProcesoProgreso:=IT_Progress (1;0;0;"Análisis del documento")
					End if 
					
					RECEIVE PACKET:C104($h_referenciaDocumento;$t_textoFila;$t_separadorFilas)
					While ($t_textoFila#"")
						$l_numeroColumnasFila:=ST_CountWords ($t_textoFila;0;$t_separadorColumna)
						If ($l_numeroColumnasFila#$l_numeroColumnasTestigo)
							$b_estructuraInvalida:=True:C214
							$i:=Size of array:C274($at_FilasDocumento)
						End if 
						$l_caracteresLeidos:=$l_caracteresLeidos+Length:C16($t_textoFila)
						$r_progreso:=$l_caracteresLeidos/$l_tamañoDocumento
						
						If ($l_IdProcesoProgreso#0)
							$l_IdProcesoProgreso:=IT_Progress (0;$l_IdProcesoProgreso;0;"Análisis del documento...")
						End if 
						RECEIVE PACKET:C104($h_referenciaDocumento;$t_textoFila;$t_separadorFilas)
					End while 
					
					If ($l_IdProcesoProgreso#0)
						$l_IdProcesoProgreso:=IT_Progress (-1;$l_IdProcesoProgreso)
					End if 
					
			End case 
			
		End if 
	End if 
	CLOSE DOCUMENT:C267($h_referenciaDocumento)
End if 





If (($b_estructuraInvalida) | ($t_separadorFilas="") | ($t_separadorColumna=""))
	$l_resultado:=-$l_tamañoDocumento
Else 
	$l_resultado:=$l_tamañoDocumento
	$l_numeroDeColumnas:=$l_numeroColumnasTestigo
End if 

$y_separadorFilas->:=$t_separadorFilas
$y_separadorColumnas->:=$t_separadorColumna

Case of 
	: (Count parameters:C259=6)
		$y_numeroFilas:=$5
		$y_numeroColumnas:=$6
		$y_numeroFilas->:=$l_numeroDeFilas
		$y_numeroColumnas->:=$l_numeroColumnasTestigo
	: (Count parameters:C259=5)
		$y_numeroFilas:=$5
		$y_numeroFilas->:=$l_numeroDeFilas
End case 

$0:=$l_resultado