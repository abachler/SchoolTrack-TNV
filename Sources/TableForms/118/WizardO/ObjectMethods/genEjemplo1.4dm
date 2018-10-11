If (PWTrf_Pac1=1)  //archivos de pago
	If (PWTrf_h1=1)  //separado por caracter
		$ref:=Create document:C266("")
		If (ok=1)
			$path:=document
			C_TEXT:C284($texto)
			C_TEXT:C284($delim)
			C_LONGINT:C283($el;$i)
			
			Case of 
				: (WTrf_ac2=1)  //nuevo
					AL_UpdateArrays (xALP_ImportPagos;0)
					AL_ExitCell (xALP_ImportPagos)
					For ($i;1;Size of array:C274(al_Numero))
						al_Numero{$i}:=$i
					End for 
					$texto:="Ajustado a contenido"
					AT_Populate (->at_Relleno;->$texto)
					AL_UpdateArrays (xALP_ImportPagos;-2)
					cs_IEncabezado:=1
					Case of 
						: (WTrf_s1=1)
							$delim:="\t"
						: (WTrf_s2=1)
							$delim:=";"
						: (WTrf_s3=1)
							$delim:=","
						: (WTrf_s4=1)
							$delim:=WTrf_s4_CaracterOtro
					End case 
					$text:=AT_array2text (->at_Descripcion;$delim)
				: (WTrf_ac3=1)
					C_LONGINT:C283($maximo)
					$maximo:=AT_Maximum (->al_Numero;0)
					ARRAY TEXT:C222($at_Desc;$maximo)
					For ($i;1;$maximo)
						$el:=Find in array:C230(al_Numero;$i)
						If ($el>0)
							$at_Desc{$i}:=at_Descripcion{$el}
						End if 
					End for 
					Case of 
						: (WTrf_s1=1)
							$delim:="\t"
						: (WTrf_s2=1)
							$delim:=";"
						: (WTrf_s3=1)
							$delim:=","
						: (WTrf_s4=1)
							$delim:=WTrf_s4_CaracterOtro
					End case 
					$text:=AT_array2text (->$at_Desc;$delim)
			End case 
			
			IO_SendPacket ($ref;$text)
			CLOSE DOCUMENT:C267($ref)
			
			  //$msg:="Archivo generado con éxito."+◊cr+"Podrá encontrarlo en "+◊cr+◊cr+$path
			CD_Dlog (0;__ ("Archivo generado con éxito.\rPodrá encontrarlo en \r\r")+$path)
			
		End if 
	End if 
End if 