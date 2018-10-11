//%attributes = {}
  // BBLci_BusquedaRegistro()
  // Por: Alberto Bachler: 23/10/13, 11:59:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_indexPrefijoDocumento;$l_numeroRegistro;$l_recNumRegistro)
C_TEXT:C284($t_barcode;$t_barCodeSinPrefijo;$t_barcodeConPrefijo;$t_prefijo)

If (False:C215)
	C_TEXT:C284(BBLci_BusquedaRegistro ;$1)
End if 


$t_barcode:=$1
$l_recNumRegistro:=No current record:K29:2

  // busco el registro por el codigo de barra completo
$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$t_barCode)

If ($l_recNumRegistro=No current record:K29:2)
	  // si no encuentro busco el código de barra omitiendo el prefijo
	If (Length:C16($t_barcode)>4)
		If (ST_String_IsNumber (Substring:C12($t_barcode;1;3))=0)
			$t_prefijo:=Substring:C12($t_barcode;1;3)
			$l_indexPrefijoDocumento:=Find in array:C230(<>asBBL_AbrevMedia;$t_Prefijo)
			If ($l_indexPrefijoDocumento>0)
				
				  // excluyo el prefijo y busco sin prefijo
				$t_barCodeSinPrefijo:=Substring:C12($t_barcode;4)
				$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$t_barCodeSinPrefijo)
				
				  // si no encuentro nada es posible que el código de barra contenga ceros no significativos en su parte numerica
				If ($l_recNumRegistro=No current record:K29:2)
					  // excluyo los ceros no significativos, antepongo el prefijo  y hago la búsqueda
					$l_numeroRegistro:=Num:C11($t_barCodeSinPrefijo)
					$t_barcodeConPrefijo:=$t_prefijo+String:C10($l_numeroRegistro)
					$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]Barcode_SinFormato:26;$t_barcodeConPrefijo)
					
					  // si no encuentro nada utilizo sólo la parte numerica para buscar sobre el número de registro.
					If ($l_recNumRegistro=No current record:K29:2)
						$l_recNumRegistro:=Find in field:C653([BBL_Registros:66]No_Registro:25;$l_numeroRegistro)
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

  //MONO TICKET 184769
  //If ($l_recNumRegistro=No current record)
  //$l_numeroRegistro:=ST_String_IsNumber ($t_barcode)
  //If ($l_numeroRegistro>0)
  //$l_recNumRegistro:=Find in field([BBL_Registros]No_Registro;$l_numeroRegistro)
  //End if 
  //End if 


$0:=$l_recNumRegistro

If ($l_recNumRegistro=No current record:K29:2)
	REDUCE SELECTION:C351([BBL_Items:61];0)
	REDUCE SELECTION:C351([BBL_Registros:66];0)
End if 

