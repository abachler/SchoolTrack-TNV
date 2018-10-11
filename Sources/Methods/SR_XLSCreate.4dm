//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce Ortega.
  // Fecha y hora: 08/01/17, 16:01:05
  // ----------------------------------------------------
  // Método: SR_XLSCreate()
  // Descripción: Tiene por objetivo permitir la creación de archivos XLS con más de 10 hojas.
  //
  // Parámetros: 
  // $1, puntero sobre el arreglo de texto con el nombre que se debe dar a cada una de las hojas en el libro.
  // $2, variable de texto que indica el path (debe incluir el nombre del archivo) donde se debe guardar el archivo creado.
  // 
  // Retorno:
  // $0, referencia de tipo longint al libro creado.
  // ----------------------------------------------------

C_POINTER:C301($vp_array)
C_TEXT:C284($vt_pathCreacion)
C_LONGINT:C283($vl_refLibro;$vl_hoja;$vl_ciclo;$vl_success;$vl_TotalHojas)
C_POINTER:C301($1)
C_TEXT:C284($2)

$0:=0

If (Count parameters:C259>=1)
	$vp_array:=$1
End if 

If (Count parameters:C259>=2)
	$vt_pathCreacion:=$2
End if 

If (Type:C295($vp_array->)=Text array:K8:16)
	
	If (($vt_pathCreacion#"") & (SYS_TestPathName ($vt_pathCreacion)#1))
		
		$vl_ciclo:=Choose:C955(Size of array:C274($vp_array->)>10;10;Size of array:C274($vp_array->))
		
		$vl_refLibro:=XLS Create ($vl_ciclo)
		
		If ($vl_refLibro#0)
			
			For ($vl_hoja;1;$vl_ciclo)
				XLS Set sheet name ($vl_refLibro;$vl_hoja;$vp_array->{$vl_hoja})
			End for 
			
			$vl_TotalHojas:=XLS Get total sheets ($vl_refLibro)
			
			$vl_success:=XLS Save as ($vl_refLibro;$vt_pathCreacion)
			
			If ($vl_success#0)
				
				XLS CLOSE ($vl_refLibro)
				
				If (Size of array:C274($vp_array->)>10)
					
					$vl_refLibro:=XLS Load ($vt_pathCreacion)
					
					If ($vl_refLibro#0)
						
						While ($vl_hoja<=Size of array:C274($vp_array->))
							XLS Add sheet ($vl_refLibro)
							XLS Set sheet name ($vl_refLibro;$vl_hoja;$vp_array->{$vl_hoja})
							$vl_hoja:=($vl_hoja+1)
						End while 
						
						$vl_success:=XLS Save as ($vl_refLibro;$vt_pathCreacion)
						
						If ($vl_success#0)
							$vl_TotalHojas:=XLS Get total sheets ($vl_refLibro)
							XLS CLOSE ($vl_refLibro)
						End if 
					End if 
				End if 
				
				$vl_refLibro:=XLS Load ($vt_pathCreacion)
				
				$0:=Choose:C955(($vl_TotalHojas=Size of array:C274($vp_array->)) & ($vl_refLibro>0);$vl_refLibro;0)
				
			End if 
		End if 
	End if 
End if 