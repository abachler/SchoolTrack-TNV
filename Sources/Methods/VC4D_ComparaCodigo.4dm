//%attributes = {}
  // VC4D_ComparaCodigo()
  // Por: Alberto Bachler K.: 24-02-15, 11:25:11
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)

C_BLOB:C604($x_Blob)
C_POINTER:C301($y_NS;$y_URL;$y_WSN)
C_TEXT:C284($t_codigoLocal;$t_codigoRemoto;$t_errorWS;$t_ruta)

ARRAY TEXT:C222($at_CodigoLocal;0)
ARRAY TEXT:C222($at_CodigoRemoto;0)


If (False:C215)
	C_BOOLEAN:C305(VC4D_ComparaCodigo ;$0)
End if 


$t_ruta:=$1


$y_URL:=OBJECT Get pointer:C1124(Object named:K67:5;"URL")
$y_WSN:=OBJECT Get pointer:C1124(Object named:K67:5;"webServiceName")
$y_NS:=OBJECT Get pointer:C1124(Object named:K67:5;"nameSpace")

METHOD GET CODE:C1190($t_ruta;$t_codigoLocal;*)
AT_Text2Array (->$at_CodigoLocal;$t_codigoLocal;"\r")

If ($t_ruta="STRal_OnExplorerLoad")
	
End if 

WEB SERVICE SET PARAMETER:C777("ruta";$t_ruta)
$t_errorWS:=VC4D_CallWebService ("VC4Dws_ObtenCodigoRemoto";$y_URL->;$y_WSN->;$y_NS->)

If ($t_errorWS="")
	WEB SERVICE GET RESULT:C779($x_Blob;"codigoRemoto";*)  //20180514 RCH Ticket 206788
	$t_codigoRemoto:=BLOB to text:C555($x_Blob;UTF8 text without length:K22:17)
	
	If ($t_codigoRemoto#$t_codigoLocal)
		AT_Text2Array (->$at_CodigoRemoto;$t_codigoRemoto;"\r")
		
		$l_lineaVacia:=Find in array:C230($at_CodigoRemoto;"")
		While ($l_lineaVacia>0)
			DELETE FROM ARRAY:C228($at_CodigoRemoto;$l_lineaVacia)
			$l_lineaVacia:=Find in array:C230($at_CodigoRemoto;"")
		End while 
		
		
		$l_lineaVacia:=Find in array:C230($at_CodigoLocal;"")
		While ($l_lineaVacia>0)
			DELETE FROM ARRAY:C228($at_CodigoLocal;$l_lineaVacia)
			$l_lineaVacia:=Find in array:C230($at_CodigoLocal;"")
		End while 
		
		
		If (Size of array:C274($at_CodigoLocal)=Size of array:C274($at_CodigoRemoto))
			For ($i;2;Size of array:C274($at_CodigoLocal))
				If ($at_CodigoLocal{$i}#$at_CodigoRemoto{$i})
					If (Length:C16($at_CodigoLocal{$i})=Length:C16($at_CodigoRemoto{$i}))
						For ($i_char;1;Length:C16($at_CodigoLocal{$i}))
							If ($at_CodigoLocal{$i}[[$i_char]]#$at_CodigoRemoto{$i}[[$i_char]])
								$i_char:=Length:C16($at_CodigoLocal{$i})
								$i:=Size of array:C274($at_CodigoLocal)+1
								$0:=True:C214
							End if 
						End for 
					Else 
						$0:=True:C214
						$i:=Size of array:C274($at_CodigoLocal)+1
					End if 
				End if 
			End for 
		Else 
			$0:=True:C214
		End if 
	End if 
End if 