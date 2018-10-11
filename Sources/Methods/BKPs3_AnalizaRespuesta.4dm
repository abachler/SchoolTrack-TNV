//%attributes = {}
  //BKPs3_AnalizaRespuesta

$t_tipo:=$1
$vx_responseBodyBlob:=$2

If (BLOB size:C605($vx_responseBodyBlob)>0)
	$ttext:=Convert to text:C1012($vx_responseBodyBlob;"UTF-8")
	
	$ref:=DOM Parse XML variable:C720($ttext)
	If (ok=1)
		$res:=True:C214
		
		C_TEXT:C284($t_valueCode;$t_msg;$t_respuesta)
		
		  //verifica error
		If ($res)
			$elem:=DOM Find XML element:C864($ref;"Error/Code")
			If (OK=1)
				DOM GET XML ELEMENT VALUE:C731($elem;$t_valueCode)
			Else 
				$res:=False:C215
			End if 
		End if 
		
		If ($res)
			$elem:=DOM Find XML element:C864($ref;"Error/Message")
			If (OK=1)
				DOM GET XML ELEMENT VALUE:C731($elem;$t_msg)
			Else 
				$res:=False:C215
			End if 
		End if 
		
		If ($t_valueCode="")
			Case of 
				: ($t_tipo="uploads")
					$elem:=DOM Find XML element:C864($ref;"InitiateMultipartUploadResult/UploadId")
					DOM GET XML ELEMENT VALUE:C731($elem;$t_respuesta)
					If (OK=0)
						$res:=False:C215
					End if 
					
				: ($t_tipo="lista")
					$elem:=DOM Find XML element:C864($ref;"ListMultipartUploadsResult/NextKeyMarker")
					DOM GET XML ELEMENT VALUE:C731($elem;$t_respuesta)
					If (OK=0)
						$res:=False:C215
					End if 
					
				: ($t_tipo="confirma")
					$t_element:="CompleteMultipartUploadResult/Location"
					$elem:=DOM Find XML element:C864($ref;$t_element)
					DOM GET XML ELEMENT VALUE:C731($elem;$t_respuesta)
					If (OK=0)
						$res:=False:C215
					End if 
					
				: ($t_tipo="upload")
					$elem:=DOM Find XML element:C864($ref;"ListMultipartUploadsResult/NextKeyMarker")
					DOM GET XML ELEMENT VALUE:C731($elem;$t_respuesta)
					If (OK=0)
						$res:=False:C215
					End if 
					
				: ($t_tipo="keys")
					C_LONGINT:C283($l_iteraciones;$l_peso)
					AT_Initialize ($3)
					AT_Initialize ($4)
					C_TEXT:C284($t_key)
					
					$elem:=DOM Find XML element:C864($ref;"ListBucketResult/KeyCount")
					DOM GET XML ELEMENT VALUE:C731($elem;$l_iteraciones)
					If (OK=0)
						$res:=False:C215
					Else 
						
						For ($l_indice;1;$l_iteraciones)
							$elem:=DOM Find XML element:C864($ref;"ListBucketResult/Contents["+String:C10($l_indice)+"]/Size")
							DOM GET XML ELEMENT VALUE:C731($elem;$l_peso)
							If ($l_peso>0)
								$elem:=DOM Find XML element:C864($ref;"ListBucketResult/Contents["+String:C10($l_indice)+"]/Key")
								DOM GET XML ELEMENT VALUE:C731($elem;$t_key)
								APPEND TO ARRAY:C911($3->;$t_key)
								APPEND TO ARRAY:C911($4->;$l_peso)
							End if 
						End for 
						
					End if 
					
			End case 
		Else 
			ALERT:C41("Error: "+$t_valueCode+". "+$t_msg)
		End if 
		
		DOM CLOSE XML:C722($ref)
	Else 
		$t_respuesta:=$ttext
	End if 
End if 
$0:=$t_respuesta