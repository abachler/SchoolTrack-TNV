//%attributes = {}
  // Método: XLS_CreaArchivo
  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 17-10-14, 18:31:16
  // ----------------------------------------------------
  //
  // Descripción
  // Metodo que crea un archivo a partir de los parametros entregados.
  // PARAMETROS
  // $1 Nombre del archivo. Obligatorio. Debe ser la ruta completa, incluido el path.
  // $2 nombre libro
  // $3 Titulo para linea y columna 1
  // $4 encabezados de las columnas
  // $5 Puntero con arreglos a mostrar en el cuerpo
  // $6 Longint, ID progreso (ABK)
  // $7 Juego de caracteres en lo que se necesita exportar
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_LONGINT:C283($6)
C_TEXT:C284($7)

C_BOOLEAN:C305($vb_errorMostrado)
C_LONGINT:C283($l_col;$l_columnas;$l_fila;$l_filas;$l_hoja;$l_m;$l_numeroFilas;$l_progreso;$l_refXLS;$l_success)
C_POINTER:C301($y_datos;$y_encabezadosColumnas;$y_pointer1)
C_REAL:C285($r_type)
C_TEXT:C284($t_caracteres;$t_nombreCompletoArchivo;$t_nombreLibro;$t_texto;$t_tituloDocumento)

ARRAY TEXT:C222($at_docs;0)
ARRAY TEXT:C222($at_texto;0)



If (False:C215)
	C_LONGINT:C283(XLS_GeneraArchivo ;$0)
	C_TEXT:C284(XLS_GeneraArchivo ;$1)
	C_TEXT:C284(XLS_GeneraArchivo ;$2)
	C_TEXT:C284(XLS_GeneraArchivo ;$3)
	C_POINTER:C301(XLS_GeneraArchivo ;$4)
	C_POINTER:C301(XLS_GeneraArchivo ;$5)
	C_LONGINT:C283(XLS_GeneraArchivo ;$6)
	C_TEXT:C284(XLS_GeneraArchivo ;$7)
End if 

$t_nombreCompletoArchivo:=$1
$t_nombreLibro:=$2
$t_tituloDocumento:=$3
$y_encabezadosColumnas:=$4
$y_datos:=$5

Case of 
	: (Count parameters:C259=7)
		$l_progreso:=$6
		$t_caracteres:=$7
	: (Count parameters:C259=6)
		$l_progreso:=$6
End case 


If ($t_caracteres="")
	If (SYS_IsWindows )
		$t_caracteres:="windows-1252"
	Else 
		$t_caracteres:="MacRoman"
	End if 
End if 

If ($t_nombreLibro="")
	$t_nombreLibro:="Libro1"
End if 


  //If (Test path name($t_nombreCompletoArchivo)#Is a document)
  //$t_nombreCompletoArchivo:=Select document(SYS_CarpetaAplicacion (CLG_DocumentosLocal);".xls";"Guardar como…";File name entry;$at_docs)
  //End if

CREATE FOLDER:C475($t_nombreCompletoArchivo;*)

  //utiliza juego de caracteres especificado. Por defecto, depende de la plataforma
USE CHARACTER SET:C205($t_caracteres;0)

$l_refXLS:=XLS Create (1)
$l_hoja:=1
$l_fila:=1
XLS Set sheet name ($l_refXLS;$l_hoja;$t_nombreLibro)

  //si se quiere dejar en la primera hoja un título para el documento
If ($t_tituloDocumento#"")
	XLS Set text value ($l_refXLS;$l_hoja;$l_fila;1;$t_tituloDocumento)
	$l_fila:=$l_fila+1
End if 

  //encabezados de columnas
If (Size of array:C274($y_encabezadosColumnas->)>0)
	For ($l_col;1;Size of array:C274($y_encabezadosColumnas->))
		XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_col;$y_encabezadosColumnas->{$l_col})
	End for 
	$l_fila:=$l_fila+1
End if 

  //datos
$l_numeroFilas:=Size of array:C274($y_datos->{1}->)
$l_m:=Milliseconds:C459
If (Size of array:C274($y_datos->)>0)
	$y_pointer1:=$y_datos->{1}
	If (Size of array:C274($y_pointer1->)>0)
		For ($l_filas;1;Size of array:C274($y_pointer1->))
			For ($l_columnas;1;Size of array:C274($y_datos->))
				$y_pointer1:=$y_datos->{$l_columnas}
				$r_type:=Type:C295($y_pointer1->)
				Case of 
					: (($r_type=Text array:K8:16) | ($r_type=String array:K8:15))
						$t_texto:=$y_pointer1->{$l_filas}
						$t_texto:=Replace string:C233($t_texto;"\t";" ")
						$t_texto:=Replace string:C233($t_texto;"\n";"\r")
						$t_texto:=Replace string:C233($t_texto;"\r\r";"\r")
						Case of 
							: (ST_countlines ($t_texto)>24)
								AT_Text2Array (->$at_texto;$t_texto;"\r")
								AT_RedimArrays (24;->$at_texto)
								APPEND TO ARRAY:C911($at_texto;"…")
								$t_texto:=AT_array2text (->$at_texto;"\r")
								
							: (Length:C16($t_texto)>1024)
								$t_texto:=Substring:C12($t_texto;1;1024)
						End case 
						If (Position:C15("<SPAN";$t_texto)>0)
							$t_texto:=ST Get plain text:C1092($t_texto)
							XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;$t_texto)
						Else 
							XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;$t_texto)
						End if 
						
					: (($r_type=Real array:K8:17) | ($r_type=LongInt array:K8:19) | ($r_type=Integer array:K8:18))
						XLS Set real value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;$y_pointer1->{$l_filas})
					: ($r_type=Date array:K8:20)
						XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;String:C10($y_pointer1->{$l_filas};Internal date short special:K1:4))
					: ($r_type=Time array:K8:29)
						XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;String:C10($y_pointer1->{$l_filas};HH MM SS:K7:1))
					: ($r_type=Boolean array:K8:21)
						If ($y_pointer1->{$l_filas})
							XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;__ ("Verdadero"))
						Else 
							XLS Set text value ($l_refXLS;$l_hoja;$l_fila;$l_columnas;__ ("Falso"))
						End if 
					Else 
						If (Not:C34($vb_errorMostrado))
							CD_Dlog (0;"Arreglo no soportado")
						End if 
						$vb_errorMostrado:=True:C214
				End case 
			End for 
			$l_fila:=$l_fila+1
			If ($l_progreso>0)
				If (Dec:C9($l_filas/1000)=0)
					Progress SET PROGRESS ($l_progreso;$l_filas/$l_numeroFilas)
				End if 
			End if 
		End for 
	End if 
End if 

$l_m:=Milliseconds:C459-$l_m
  //datos

  //crea archivo
$l_success:=XLS Save as ($l_refXLS;$t_nombreCompletoArchivo)
XLS CLOSE ($l_refXLS)

  //retorna juego de caracteres
USE CHARACTER SET:C205(*;0)

  //retorna 1 cuando el archivo se generó ok
If ($l_success=1)
	$0:=1
Else 
	$0:=0
End if 