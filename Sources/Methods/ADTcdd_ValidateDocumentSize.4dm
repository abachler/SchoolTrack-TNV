//%attributes = {}
  //ADTcdd_ValidateDocumentSize

C_BOOLEAN:C305($vb_continuar;$0)
C_TEXT:C284($vt_msj;$vt_extension)
C_REAL:C285($vr_size)

$vt_path2Document:=$1
$vl_maxSize:=$2
$vl_recomendado:=$3

If (Test path name:C476($vt_path2Document)=Is a document:K24:1)
	$vr_size:=Get document size:C479($vt_path2Document)
	If ($vr_size>0)
		$vt_extension:=Substring:C12(SYS_Path2FileName ($vt_path2Document);Length:C16(SYS_Path2FileName ($vt_path2Document))-3)
		$vb_continuar:=True:C214
		If (Round:C94($vr_size/1024/1024;0)>$vl_maxSize)
			If (($vt_extension#".zip") & ($vt_extension#".rar"))
				$vb_continuar:=False:C215
				$vt_msj:=__ ("Los archivos con tamaño superior a "+String:C10($vl_maxSize)+" MB deben ser tener extensión ")+ST_Qte (".zip")+" o "+ST_Qte (".rar")+"."+"\r\r"
				CD_Dlog (0;$vt_msj)
			End if 
		End if 
		If ($vb_continuar)
			If (Round:C94($vr_size/1024/1024;0)>$vl_recomendado)
				$vt_msj:=__ ("Cargar archivos de gran tamaño puede producir eventuales problemas de memoria, es recomendable no hacerlo. Se recomienda subir archivos de hasta "+String:C10($vl_recomendado)+" Mb de tamaño.")
				If (($vt_extension#".zip") & ($vt_extension#".rar"))
					$vt_msj:=$vt_msj+"\r\r"+__ ("Se recomienda comprimir los archivos en ")+ST_Qte (".zip")+" o "+ST_Qte (".rar")+"."
				End if 
				$vt_msj:=$vt_msj+"\r\r"+__ ("¿Desea continuar?")
				$vl_resp:=CD_Dlog (0;$vt_msj;"";__ ("Si");__ ("No"))
				If ($vl_resp=2)
					$vb_continuar:=False:C215
				End if 
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("Archivo vacío."))
	End if 
Else 
	CD_Dlog (0;__ ("Archivo no encontrado."))
End if 
$0:=$vb_continuar