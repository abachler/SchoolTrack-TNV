//%attributes = {}
  // Método: BKPwa_GeneraRespuesta
  // código original de: RCH
  // modificado por Alberto Bachler Klein, 16/03/18, 18:15:20
  // correcciones menores en los textos
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––



C_REAL:C285($1;$r_idError)
C_BOOLEAN:C305($b_conFormato;$3)

C_TEXT:C284($0;$json;$t_descripcion;$t_descAdicional;$2)
C_BOOLEAN:C305($b_conFormato)

$r_idError:=$1
If (Count parameters:C259>=2)
	$t_descAdicional:=$2
End if 
If (Count parameters:C259>=3)
	$b_conFormato:=$3
End if 

Case of 
	: ($r_idError=0)
		$t_descripcion:="ok."
		
	: ($r_idError=-1)
		  //$t_descripcion:="Ya existe un proceso en ejecución."
		$t_descripcion:="Error al obtener los parámetros para el servicio."
		
	: ($r_idError=-2)
		$t_descripcion:="Servicio inexistente."
		
	: ($r_idError=-3)
		$t_descripcion:="Carpeta respaldos no encontrada."
		
	: ($r_idError=-4)
		$t_descripcion:="No hay respaldos en la lista de respaldos."
		
	: ($r_idError=-5)
		$t_descripcion:="No se encontró ningun respaldo."
		
	: ($r_idError=-6)
		$t_descripcion:="No fueron encontrados respaldos."
		
	: ($r_idError=-7)
		$t_descripcion:="El colegio no permite el envío automático de bases de datos. Configurar en Centro de Información y Mantenimiento/Respaldos."
		
	: ($r_idError=-8)
		$t_descripcion:="El servidor no está configurado como servidor oficial."
		
	Else 
		$t_descripcion:="Archivo no encontrado."
		
End case 

If ($t_descAdicional#"")
	$t_descripcion:=$t_descripcion+" "+$t_descAdicional
End if 

C_OBJECT:C1216($ob_raiz)
OB SET:C1220($ob_raiz;"error";$r_idError;"mensaje";$t_descripcion)
If ($b_conFormato)
	$json:=JSON Stringify:C1217($ob_raiz;*)
Else 
	$json:=JSON Stringify:C1217($ob_raiz)
End if 

BKP_EscribeLog ($json)

$0:=$json