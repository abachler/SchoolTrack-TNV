//%attributes = {}
  // LEP_EjecutaComando()
  // Por: Alberto Bachler: 11/07/13, 10:31:58
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)

C_BLOB:C604($x_Error;$x_flujoEntrada;$x_flujoError;$x_flujoSalida)
C_LONGINT:C283($l_plataforma)
C_POINTER:C301($y_Resultado)
C_TEXT:C284($t_error;$t_comando;$t_textoSalida)

ARRAY LONGINT:C221($l_largo;0)
ARRAY LONGINT:C221($l_posicion;0)
If (False:C215)
	C_TEXT:C284(LEP_EjecutaComando ;$1)
	C_POINTER:C301(LEP_EjecutaComando ;$2)
End if 
$t_comando:=$1
$y_Resultado:=$2

LAUNCH EXTERNAL PROCESS:C811($t_comando;$x_flujoEntrada;$x_flujoSalida;$x_flujoError)

_O_PLATFORM PROPERTIES:C365($l_plataforma)

If (BLOB size:C605($x_Error)=0)
	If ($l_plataforma=Mac OS:K25:2)
		$t_textoSalida:=Convert to text:C1012($x_flujoSalida;"utf-8")
	Else 
		$t_textoSalida:=BLOB to text:C555($x_flujoSalida;Mac text without length:K22:10)
	End if 
	
	If (Match regex:C1019("(Error:|WARNING:)\\s*(.*)";$t_textoSalida;1;$l_posicion;$l_largo))
		$t_error:=Substring:C12($t_textoSalida;$l_posicion{2};$l_largo{2})
		If (Not:C34(Is nil pointer:C315($y_Resultado)))
			Case of 
				: (Type:C295($y_Resultado->)=Is text:K8:3)
					$y_Resultado->:=$t_error
				: (Type:C295($y_Resultado->)=Is BLOB:K8:12)
					CONVERT FROM TEXT:C1011($t_error;"utf-8";$y_Resultado->)
			End case 
		End if 
	Else 
		$0:=True:C214
	End if 
Else 
	$0:=False:C215
	If (Not:C34(Is nil pointer:C315($y_Resultado)))
		Case of 
			: (Type:C295($y_Resultado->)=Is text:K8:3)
				If ($l_plataforma=Mac OS:K25:2)
					$y_Resultado->:=Convert to text:C1012($x_Error;"utf-8")
				Else 
					$y_Resultado->:=BLOB to text:C555($x_Error;Mac text without length:K22:10)
				End if 
			: (Type:C295($y_Resultado->)=Is BLOB:K8:12)
				$y_Resultado->:=$x_Error
		End case 
	End if 
End if 