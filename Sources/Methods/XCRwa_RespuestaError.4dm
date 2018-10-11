//%attributes = {}
  //XCRwa_RespuestaError

C_REAL:C285($1;$r_idError)
C_BOOLEAN:C305($b_conFormato;$2)

C_TEXT:C284($0;$json;$t_principal;$t_err;$node;$t_descripcion)
C_BOOLEAN:C305($b_conFormato)

$r_idError:=$1
If (Count parameters:C259>=2)
	$b_conFormato:=$2
End if 

Case of 
	: ($r_idError=0)
		$t_descripcion:="ok."
		
	: ($r_idError=-1)
		$t_descripcion:="Los parámetros no pudieron ser obtenidos."
		
	: ($r_idError=-2)
		$t_descripcion:="Página no encontrada."
		
	: ($r_idError=-3)
		$t_descripcion:="La llave no corresponde."
		
	: ($r_idError=-4)
		$t_descripcion:="No fue posible obtener el json."
		
	: ($r_idError=-5)
		$t_descripcion:="La suma del monto de las actividades no corresponde al monto del pago."
		
	: ($r_idError=-6)
		$t_descripcion:="El id_act no fue encontrado en la configuración de AccountTrack."
		
	: ($r_idError=-7)
		$t_descripcion:="El alumno no fue encontrado."
		
	: ($r_idError=-8)
		$t_descripcion:="La cuenta corriente no fue encontrada."
		
	: ($r_idError=-9)
		$t_descripcion:="El apoderado no fue encontrado."
		
	: ($r_idError=-10)
		$t_descripcion:="El json no pudo ser parseado."
		
	: ($r_idError=-11)
		$t_descripcion:="No fueron encontradas actividades extracurriculares."
		
	: ($r_idError=-12)
		$t_descripcion:="La fecha no pudo ser obtenida."
		
	: ($r_idError=-13)
		$t_descripcion:="Los cargos no pudieron ser creados."
		
	: ($r_idError=-14)
		$t_descripcion:="El Aviso de Cobranza no pudo ser creado."
		
	: ($r_idError=-15)
		$t_descripcion:="El Pago no pudo ser creado."
		
	: ($r_idError=-16)
		$t_descripcion:="El json con el resultado del pago no pudo ser parseado."
		
	: ($r_idError=-17)
		$t_descripcion:="No fue posible guardar la orden de compra."
		
	: ($r_idError=-18)
		$t_descripcion:="Llave vacía."
		
	: ($r_idError=-19)
		$t_descripcion:="No fue encontrada la orden de compra luego de ingresar el pago."
		
	: ($r_idError=-20)
		$t_descripcion:="Orden de compra no encontrada."
		
	: ($r_idError=-21)
		$t_descripcion:="La orden de compra ya se encuentra en la base de datos."
		
	: ($r_idError=-22)
		$t_descripcion:="Ya existe un proceso en ejecución."
		
	: ($r_idError=-23)
		$t_descripcion:="El cargo no pudo ser creado. Puede estar configurado como imputación única y ya podría existir."
		
	: ($r_idError=-24)
		$t_descripcion:="Se solicita la emisión de boletas pero los cargos asociados no están asociados a una Razón Social que emite Documentos Electrónicos."
		
	: ($r_idError=-25)
		$t_descripcion:="Los alumnos no tienen asociado un mismo apoderado. Los cargos no pueden ser creados."
		
	: ($r_idError=-26)
		$t_descripcion:="Se solicita emitir el Documento Tributario pero no fue encontrado el id del pago."
		
	: ($r_idError=-27)  //20150826 RCH Se agregan validaciones
		$t_descripcion:="No fue identificado el pago."
		
	: ($r_idError=-28)
		$t_descripcion:="El pago quedó con saldo."
		
	Else 
		$t_descripcion:="Código "+String:C10($r_idError)+" no clasificado."
		
End case 

  // Modificado por: Alexis Bustamante (10-06-2017)
  //TICKET 179869
  //cambio de plugin a comando nativo
C_OBJECT:C1216($ob_raiz;$ob_temp)

$ob_raiz:=OB_Create 
$ob_temp:=OB_Create 

OB_SET ($ob_temp;->$r_idError;"codigo")
OB_SET ($ob_temp;->$t_descripcion;"descripcion")
OB_SET ($ob_raiz;->$ob_temp;"estado")

  //$t_principal:=JSON New 
  //$t_err:=JSON Append node ($t_principal;"estado")
  //  //$node:=JSON Append real ($t_err;"código";$r_idError)
  //  //$node:=JSON Append text ($t_err;"descripción";$t_descripcion)
  //$node:=JSON Append real ($t_err;"codigo";$r_idError)
  //$node:=JSON Append text ($t_err;"descripcion";$t_descripcion)

  //If ($b_conFormato)
  //$json:=JSON Export to text ($t_principal;JSON_WITH_WHITE_SPACE)
  //Else 
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //End if 
  //JSON CLOSE ($t_principal)
$json:=OB_Object2Json ($ob_raiz)
$0:=$json