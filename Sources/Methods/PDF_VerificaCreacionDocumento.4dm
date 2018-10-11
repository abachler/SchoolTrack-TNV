//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 07-03-17, 09:15:05
  // ----------------------------------------------------
  // Método: PDF_VerificaCreacionDocumento()
  // 
  // Descripción: Verifica que la creación de los documentos haya terminado, con el fin de evitar leer un archivo que no esté completo aún.
  // Realiza una comparación sucesiva del tamaño del archivo. Al encontrar en dos ocasiones el mismo tamaño, después del delay,
  // valida que el archivo ya tiene todos los datos necesarios.
  //
  // Parámetros:
  // Texto con el path hacia el archivo (debe incluir el nombre del PDF).
  // ----------------------------------------------------

C_TEXT:C284($t_rutaDocumento)
C_LONGINT:C283($l_contador;$l_contador2;$l_tamañoAcumulado;$l_tamañoItera)

If (False:C215)
	C_TEXT:C284(documentoCreado;$1)
End if 

If (Count parameters:C259=1)
	$t_rutaDocumento:=$1
End if 



$l_contador:=1
$l_contador2:=1



While ($l_contador<=5)
	If (Test path name:C476($t_rutaDocumento)=Is a document:K24:1)
		$l_tamañoAcumulado:=0
		$l_tamañoItera:=-1
		While ($l_tamañoAcumulado#$l_tamañoItera)
			$l_tamañoAcumulado:=Get document size:C479($t_rutaDocumento)
			DELAY PROCESS:C323(Current process:C322;10)
			$l_tamañoItera:=Get document size:C479($t_rutaDocumento)
		End while 
		$l_contador:=6
	Else 
		$l_contador:=($l_contador+1)
		DELAY PROCESS:C323(Current process:C322;60)
		$l_contador2:=(1+$l_contador2)
	End if 
End while 