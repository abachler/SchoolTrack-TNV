//%attributes = {}
  // Método: z7_Extract (rutaArchivo:T; rutaDestino:T ; password:T; errorY) --> resultado:B
If (False:C215)
	  // código original de: Miyako
	  // modificado por Alberto Bachler Klein, 14/03/18, 10:32:35
	  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
End if 
C_TEXT:C284($1;$2;$3)
C_POINTER:C301($4)
C_BOOLEAN:C305($0)  //success = true, failure = false
C_BLOB:C604($x_respuesta)
C_TEXT:C284($t_rutaArchivo;$t_rutaDestino;$t_comando)



C_LONGINT:C283($l_parametros)
$l_parametros:=Count parameters:C259

If ($l_parametros>1)
	$t_rutaArchivo:=$1
	$t_rutaDestino:=$2
	
	  //flags set: 
	  //-y Assume Yes on all queries  
	$t_comando:=" -y x "+LEP_Escape_path ($t_rutaArchivo)+" -o"+LEP_Escape_path ($t_rutaDestino)
	
	If ($l_parametros>2)
		If (Length:C16($3)#0)
			$t_comando:=$t_comando+" -p"+LEP_Escape ($3)
		End if 
	End if 
	
	
	If (z7_Execute ($t_comando;->$x_respuesta))
		$0:=True:C214
	Else 
		
		If ($l_parametros>3)
			If (Not:C34(Is nil pointer:C315($4)))
				If (Type:C295($4->)=Is text:K8:3)
					$4->:=Convert to text:C1012($x_respuesta;"utf-8")
				End if 
			End if 
		End if 
	End if 
	
End if 