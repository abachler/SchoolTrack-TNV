//%attributes = {"executedOnServer":true}
  // DOCL_guardaDocumento()
  // Por: Alberto Bachler: 17/09/13, 13:41:57
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_BLOB:C604($4)
C_TEXT:C284($5)
C_POINTER:C301($6)

C_BLOB:C604($x_Blob)
C_LONGINT:C283($l_numeroTabla;$l_recNum)
C_TIME:C306($h_refArchivo)
C_POINTER:C301($y_blob;$y_tabla;$y_miniatura)
C_TEXT:C284($t_claseDocumento;$t_descripcion;$t_nombreArchivo;$t_nombreArchivoOriginal;$t_refRegistro;$t_refTabla;$t_rutaArchivo;$t_rutaCarpeta;$t_uuid)

If (False:C215)
	C_TEXT:C284(DOCL_guardaDocumento ;$0)
	C_POINTER:C301(DOCL_guardaDocumento ;$1)
	C_TEXT:C284(DOCL_guardaDocumento ;$2)
	C_TEXT:C284(DOCL_guardaDocumento ;$3)
	C_BLOB:C604(DOCL_guardaDocumento ;$4)
	C_TEXT:C284(DOCL_guardaDocumento ;$5)
	C_POINTER:C301(DOCL_guardaDocumento ;$6)
End if 
$y_tabla:=$1
$t_refRegistro:=$2
$t_uuid:=$3
$x_blob:=$4
$t_nombreArchivoOriginal:=$5

Case of 
	: (Count parameters:C259=6)
		$y_miniatura:=$6
End case 

$l_numeroTabla:=Table:C252($y_tabla)
$t_refTabla:=String:C10($l_numeroTabla)

$t_refColeccion:=$t_refTabla+"."+$t_refRegistro
QUERY:C277([DocumentLibrary:234];[DocumentLibrary:234]PrimaryKey:9=$t_refColeccion)
ORDER BY:C49([DocumentLibrary:234];[DocumentLibrary:234]Order:17;<)


$l_recNum:=Find in field:C653([DocumentLibrary:234]Auto_UUID:2;$t_uuid)
If ($l_recNum<0)
	$t_refColeccion:=$t_refTabla+"."+$t_refRegistro
	QUERY:C277([DocumentLibrary:234];[DocumentLibrary:234]PrimaryKey:9=$t_refColeccion)
	ORDER BY:C49([DocumentLibrary:234];[DocumentLibrary:234]Order:17;<)
	$l_ordenamiento:=[DocumentLibrary:234]Order:17+1
	
	CREATE RECORD:C68([DocumentLibrary:234])
	[DocumentLibrary:234]refTabla:8:=$t_refTabla
	[DocumentLibrary:234]refRegistro:1:=$t_refRegistro
	[DocumentLibrary:234]Order:17:=$l_ordenamiento
Else 
	READ WRITE:C146([DocumentLibrary:234])
	GOTO RECORD:C242([DocumentLibrary:234];$l_recNum)
End if 

If (Not:C34(Locked:C147([DocumentLibrary:234])))
	[DocumentLibrary:234]Extension:6:=SYS_extensionDocumento ($t_nombreArchivoOriginal)
	[DocumentLibrary:234]Document_name:7:=$t_nombreArchivoOriginal
	If (Not:C34(Is nil pointer:C315($y_Miniatura)))
		[DocumentLibrary:234]Thumbnail:4:=$y_Miniatura->
	Else 
		[DocumentLibrary:234]Thumbnail:4:=[DocumentLibrary:234]Thumbnail:4*0
	End if 
	
	If (BLOB size:C605($x_Blob)>0)
		If (Application version:C493>="13.3.@")
			[DocumentLibrary:234]Document_xContent:10:=$x_Blob
			SAVE RECORD:C53([DocumentLibrary:234])
		Else 
			SAVE RECORD:C53([DocumentLibrary:234])
			$t_rutaCarpeta:=sys_getRutaBaseDatos +"Document Library"+Folder separator:K24:12+$t_refTabla+Folder separator:K24:12+$t_refRegistro+Folder separator:K24:12
			SYS_CreateFolder ($t_rutaCarpeta)
			$t_rutaArchivo:=$t_rutaCarpeta+[DocumentLibrary:234]Auto_UUID:2+[DocumentLibrary:234]Extension:6
			If (OK=1)
				$h_refArchivo:=Create document:C266($t_rutaArchivo)
				CLOSE DOCUMENT:C267($h_refArchivo)
				BLOB TO DOCUMENT:C526($t_rutaArchivo;$x_Blob)
			Else 
				REDUCE SELECTION:C351([DocumentLibrary:234];0)
			End if 
		End if 
	Else 
		REDUCE SELECTION:C351([DocumentLibrary:234];0)
	End if 
Else 
	REDUCE SELECTION:C351([DocumentLibrary:234];0)
End if 

If ([DocumentLibrary:234]Auto_UUID:2="")
	OK:=0
Else 
	OK:=1
	$0:=[DocumentLibrary:234]Auto_UUID:2
End if 