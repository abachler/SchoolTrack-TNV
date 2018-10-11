  // [xShell_ExecutableCommands].Manager_v14.Botón invisible()
  // Por: Alberto Bachler K.: 21-02-14, 18:22:41
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)

C_BLOB:C604($x_blob)
C_BOOLEAN:C305($b_esDocumento;$b_esTexto)
C_LONGINT:C283($l_elemento;$l_proceso)
C_POINTER:C301($y_codigo;$y_objetoFuente)
C_TEXT:C284($t_codigo;$t_extension;$t_rutaArchivo)

ARRAY TEXT:C222($at_formatos;0)
ARRAY TEXT:C222($at_tiposNativos;0)

DRAG AND DROP PROPERTIES:C607($y_objetoFuente;$l_elemento;$l_proceso)
GET PASTEBOARD DATA TYPE:C958($at_tiposNativos;$at_formatos)

$y_codigo:=OBJECT Get pointer:C1124(Object named:K67:5;"codigo")

Case of 
	: (Form event:C388=On Drag Over:K2:13)
		Case of 
			: (Is nil pointer:C315($y_objetoFuente))
				$b_esDocumento:=(Find in array:C230($at_tiposNativos;"com.4d.private.file.url")>0)
				If ($b_esDocumento)
					$t_rutaArchivo:=Get file from pasteboard:C976(1)
					$t_extension:=SYS_extensionDocumento ($t_rutaArchivo)
					If ($t_extension=".txt")
						$0:=0
					Else 
						$0:=-1
					End if 
				End if 
			: ($b_esTexto)
				$0:=0
		End case 
		OBJECT SET ENABLED:C1123(*;"ejecutarCodigo";$y_codigo->#"")
		
	: (Form event:C388=On Drop:K2:12)
		If (Is nil pointer:C315($y_objetoFuente))
			$b_esTexto:=(Find in array:C230($at_tiposNativos;"com.4d.private.text.native@")>0)
			$b_esDocumento:=(Find in array:C230($at_tiposNativos;"com.4d.private.file.url")>0)
			Case of 
				: ($b_esTexto)
					$y_codigo->:=Get text from pasteboard:C524
					$t_codigo:=CODE_Get_html ($y_codigo->)
					WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
					GOTO OBJECT:C206(*;"codigo")
					
				: ($b_esDocumento)
					$t_rutaArchivo:=Get file from pasteboard:C976(1)
					$t_extension:=SYS_extensionDocumento ($t_rutaArchivo)
					If ($t_extension=".txt")
						  //$l_tamañoDocumento:=Get document size($t_rutaArchivo)
						  //$f_refDocumento:=Open document("";".TXT";Get pathname)
						DOCUMENT TO BLOB:C525($t_rutaArchivo;$x_blob)
						$t_codigo:=BLOB to text:C555($x_blob;UTF8 text without length:K22:17)
						$y_codigo->:=$t_codigo
						$t_codigo:=CODE_Get_html ($y_codigo->)
						WA SET PAGE CONTENT:C1037(*;"codigoHTML";$t_codigo;"")
						GOTO OBJECT:C206(*;"codigo")
					End if 
			End case 
			OBJECT SET ENABLED:C1123(*;"ejecutarCodigo";$y_codigo->#"")
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		
End case 

