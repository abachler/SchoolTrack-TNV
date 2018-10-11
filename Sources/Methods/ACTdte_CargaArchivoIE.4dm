//%attributes = {}
  //ACTdte_CargaArchivoIE
C_LONGINT:C283($i;$vl_numberArrays)
C_TIME:C306($ref)
C_POINTER:C301($vy_pointer)
C_TEXT:C284($delimiter;$vt_ruta;$vt_text;$vt_element)
C_BOOLEAN:C305($vb_continuar;$0)

ARRAY TEXT:C222($at_textos;0)
ARRAY TEXT:C222($atACT_Campos;0)
ARRAY LONGINT:C221($alACT_IdsCampos;0)
ARRAY TEXT:C222(atACT_encabezadosFile;0)
C_POINTER:C301($vy_pointer1)

QR_DeclareGenericArrays 

  //$vt_element:="IEV"
$vt_element:=$1
$t_rutaArchivo:=$2
If (Count parameters:C259>=3)
	$vy_pointer1:=$3
End if 

If ($vt_element#"")
	  //$vt_ruta:=xfGetFileName 
	If ($t_rutaArchivo#"")
		$vb_continuar:=True:C214
		ACTdte_OpcionesGenerales ("CargaArchivoConfiguracion";->$vt_element;->$atACT_Campos;->$alACT_IdsCampos)
		$vl_numberArrays:=Size of array:C274($alACT_IdsCampos)
		If (Not:C34(Is nil pointer:C315($vy_pointer1)))
			$vy_pointer1->:=$vl_numberArrays
		End if 
		
		$ref:=Open document:C264($t_rutaArchivo;"";Read mode:K24:5)
		If (ok=1)
			$vt_text:=""
			$delimiter:=ACTabc_DetectDelimiter (document)
			RECEIVE PACKET:C104($ref;$vt_text;$delimiter)
			
			  //captura encabezados para procesar subtablas
			AT_Text2Array (->atACT_encabezadosFile;$vt_text;"\t")
			
			RECEIVE PACKET:C104($ref;$vt_text;$delimiter)
			While ($vt_text#"")
				ARRAY TEXT:C222($at_textos;0)
				AT_Text2Array (->$at_textos;$vt_text;"\t")
				For ($i;1;Size of array:C274($at_textos))
					$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($i))
					
					  //20141201 para llenar los arreglos que no sean llenados antes. Por ejemplo, cuando la septima linea tenia MntImp, se insertaba en la primera posicion porque el arreglo no se conocia. Todos los demas daban 29 elementos. Este da 30.
					If (($i>1) & (Size of array:C274(aQR_Text1)>1))
						If (Size of array:C274(aQR_Text1)#(Size of array:C274($vy_pointer->)+1))
							AT_RedimArrays (Size of array:C274(aQR_Text1)-1;$vy_pointer)
						End if 
					End if 
					
					APPEND TO ARRAY:C911($vy_pointer->;$at_textos{$i})
				End for 
				While ($i<=$vl_numberArrays)
					$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($i))
					APPEND TO ARRAY:C911($vy_pointer->;"")
					$i:=$i+1
				End while 
				RECEIVE PACKET:C104($ref;$vt_text;$delimiter)
			End while 
			CLOSE DOCUMENT:C267($ref)
			
			  //verifica que el largo de todos los arreglos sea igual al del primero
			$l_largo:=Size of array:C274(aQR_Text1)
			For ($i;2;Size of array:C274($atACT_Campos))
				$vy_pointer:=Get pointer:C304("aQR_Text"+String:C10($i))
				AT_RedimArrays ($l_largo;$vy_pointer)
			End for 
			
		Else 
			$vb_continuar:=False:C215
		End if 
	Else 
		$vb_continuar:=False:C215
	End if 
Else 
	$vb_continuar:=False:C215
End if 
$0:=$vb_continuar