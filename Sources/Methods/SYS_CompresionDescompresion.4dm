//%attributes = {}
  // SYS_CompresionDescompresion()
  // Por: Alberto Bachler K.: 18-10-14, 12:32:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_POINTER:C301($4)
C_BOOLEAN:C305($5)

C_BOOLEAN:C305($b_eliminarOriginal;$b_resultado;$b_resultado7z;$b_usar7z)
C_POINTER:C301($y_resultado;$y_rutaResultado)
C_TEXT:C284($t_resultado;$t_password;$t_rutaDestino;$t_rutaOrigen)

ARRAY TEXT:C222($at_nombreComponentes;0)

  //Mono : A 4dzip cuando le pasas una carpeta con un solo archivo, tiene un problema de compresión hay que pasarle una ruta de archivo
ARRAY TEXT:C222($at_archives;0)

If (False:C215)
	C_BOOLEAN:C305(SYS_CompresionDescompresion ;$0)
	C_TEXT:C284(SYS_CompresionDescompresion ;$1)
	C_TEXT:C284(SYS_CompresionDescompresion ;$2)
	C_TEXT:C284(SYS_CompresionDescompresion ;$3)
	C_POINTER:C301(SYS_CompresionDescompresion ;$4)
	C_BOOLEAN:C305(SYS_CompresionDescompresion ;$5)
End if 

$t_rutaOrigen:=$1

  //ASM 20150312 Ticket 142420 . se ocasionaba un problema al querer comprimir un directorio completo, ya que la ruta de origen siempre terminaba con el Delimitador
If (Substring:C12($t_rutaOrigen;Length:C16($t_rutaOrigen);Length:C16($t_rutaOrigen))=Folder separator:K24:12)
	$t_rutaOrigen:=Substring:C12($t_rutaOrigen;1;Length:C16($t_rutaOrigen)-1)
	$vb_folder:=True:C214  //mono para hacer el document list
End if 


Case of 
	: (Count parameters:C259=2)
		$t_rutaDestino:=$2
	: (Count parameters:C259=3)
		$t_rutaDestino:=$2
		$t_password:=$3
	: (Count parameters:C259=4)
		$t_rutaDestino:=$2
		$t_password:=$3
		$y_resultado:=$4
	: (Count parameters:C259=5)
		$t_rutaDestino:=$2
		$t_password:=$3
		$y_resultado:=$4
		$b_eliminarOriginal:=$5
End case 

COMPONENT LIST:C1001($at_nombreComponentes)
If (Find in array:C230($at_nombreComponentes;"7z")>0)
	  // se utiliza el componente 7z si esta instalado
	$b_usar7z:=True:C214
End if 


If ($t_rutaOrigen#"@.zip")
	  //no es un archivo comprimirdo en .zip que se desea descomprimir 
	  //y la ruta de destino no fue especificada o es inválida, usamos la ruta de destino por defecto: junto al original
	
	If (Test path name:C476($t_rutaOrigen)<0)
		$b_resultado:=False:C215
		$t_resultado:=__ ("No se encontro el documento a comprimir")
	Else 
		
		  // si la ruta de destino no fue especificada comprimo en la misma ruta que el archivo o carpeta original
		If ($t_rutaDestino="")
			If (($t_rutaOrigen="@.app:") & (Folder separator:K24:12=":"))  // en Mac, si es un paquete aplicación elimino la extensión .app y el separador
				$t_rutaDestino:=Replace string:C233($t_rutaOrigen;".app";"")+".zip"
			Else 
				$t_rutaDestino:=$t_rutaOrigen+".zip"
			End if 
		End if 
		
		Case of 
			: (($t_rutaDestino="") & ($b_usar7z))
				$t_rutaDestino:=Substring:C12($t_rutaOrigen;1;Length:C16($t_rutaOrigen))+".zip"
			: (($t_rutaDestino="") & (Not:C34($b_usar7z)))
				$t_rutaDestino:=Substring:C12($t_rutaOrigen;1;Length:C16($t_rutaOrigen))+".zip"
			: (($t_rutaDestino="@.zip") & ($b_usar7z))
				$t_rutaDestino:=Replace string:C233($t_rutaDestino;".zip";".7z")
			: (($t_rutaDestino="@.7z") & (Not:C34($b_usar7z)))
				$t_rutaDestino:=Replace string:C233($t_rutaDestino;".7z";".zip")
			: (($t_rutaDestino#"@.7z") & ($t_rutaDestino#"@.zip") & ($b_usar7z))
				$t_rutaDestino:=$t_rutaDestino+".zip"
			: (($t_rutaDestino#"@.7z") & ($t_rutaDestino#"@.zip") & (Not:C34($b_usar7z)))
				$t_rutaDestino:=$t_rutaDestino+".zip"
		End case 
	End if 
	
Else 
	If (Test path name:C476($t_rutaOrigen)<0)
		$b_resultado:=False:C215
		$t_resultado:=__ ("No se encontro el documento a descomprimir")
	Else 
		Case of 
			: (($t_rutaDestino="") & ($b_usar7z))
				$t_rutaDestino:=Replace string:C233($t_rutaOrigen;".7z";"")
			: (($t_rutaDestino="") & (Not:C34($b_usar7z)))
				$t_rutaDestino:=Replace string:C233($t_rutaOrigen;".zip";"")
		End case 
	End if 
End if 

Case of 
	: (($t_rutaDestino="@.zip") & ($b_usar7z))
		$t_rutaDestino:=Replace string:C233($t_rutaDestino;".zip";".7z")
	: (($t_rutaDestino="@.7z") & (Not:C34($b_usar7z)))
		$t_rutaDestino:=Replace string:C233($t_rutaDestino;".7z";".zip")
End case 


If ($t_resultado="")
	If ($t_rutaOrigen="@.zip")
		  // la ruta de origen es un archivo comprimido en .zip, lo descomprimimos
		
		If ($t_rutaDestino="")
			$t_rutaDestino:=SYS_GetParentNme ($t_rutaOrigen)
		End if 
		
		Case of 
			: ($b_usar7z)
				  // es un archivo comprimido con .7z. Se asume que se debe descomprimir en la ruta indicada en $t_rutaDestino
				EXECUTE METHOD:C1007("z7_Extract";$b_resultado;$t_rutaOrigen;$t_rutaDestino;$t_password;->$t_resultado)
				
			: (Not:C34($b_usar7z))
				  // es un archivo comprimido con .zip. Se asume que se debe descomprimir en la ruta indicada en $t_rutaDestino
				$b_resultado:=(Unzip ($t_rutaOrigen;$t_rutaDestino)=1)
		End case 
		
	Else 
		If ($b_usar7z)
			EXECUTE METHOD:C1007("z7_Archive";$b_resultado;$t_rutaOrigen;$t_rutaDestino;$t_password;->$t_resultado)
		Else 
			  //Mono bug 4dzip
			If (Test path name:C476($t_rutaOrigen)=Is a folder:K24:2)
				DOCUMENT LIST:C474($t_rutaOrigen;$at_archives)
				If (Size of array:C274($at_archives)=1)
					$t_rutaOrigen:=$t_rutaOrigen+Folder separator:K24:12+$at_archives{1}
				End if 
			End if 
			
			$b_resultado:=(Zip ($t_rutaOrigen;$t_rutaDestino)=1)
		End if 
	End if 
	
	
	If (($b_eliminarOriginal) & ($b_resultado))
		Case of 
			: (Test path name:C476($t_rutaOrigen)=Is a document:K24:1)
				DELETE DOCUMENT:C159($t_rutaOrigen)
			: (Test path name:C476($t_rutaOrigen)=Is a folder:K24:2)
				SYS_DeleteFolder ($t_rutaOrigen)
		End case 
	End if 
End if 


If (Not:C34(Is nil pointer:C315($y_resultado)))
	If ($t_resultado="")
		$y_resultado->:=$t_rutaDestino
	Else 
		$y_resultado->:=$t_resultado
	End if 
End if 

$0:=$b_resultado