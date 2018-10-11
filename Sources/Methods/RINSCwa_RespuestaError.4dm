//%attributes = {}
  //RINSCwa_RespuestaError

C_REAL:C285($1;$r_idError)
C_BOOLEAN:C305($b_conFormato;$2)

C_TEXT:C284($0;$json;$t_principal;$t_err;$node;$t_descripcion)
C_BOOLEAN:C305($b_conFormato)
C_TEXT:C284($t_detalle)

$r_idError:=$1
If (Count parameters:C259>=2)
	$b_conFormato:=$2
End if 

If (Count parameters:C259>=3)
	$t_detalle:=$3
End if 

Case of 
	: ($r_idError=0)
		$t_descripcion:="ok."
		
	: ($r_idError=-1)
		$t_descripcion:="Ya existe un proceso en ejecución."
		
	: ($r_idError=-2)
		$t_descripcion:="El json no pudo ser parseado."
		
	: ($r_idError=-3)
		$t_descripcion:="La llave no corresponde."
		
	: ($r_idError=-4)
		$t_descripcion:="Llave vacía."
		
	: ($r_idError=-5)
		$t_descripcion:="No fueron encontrados alumnos."
		
	: ($r_idError=-6)
		$t_descripcion:="La orden de compra ya se encuentra en la base de datos."
		
	: ($r_idError=-7)
		$t_descripcion:="El alumno no fue encontrado."
		
	: ($r_idError=-8)
		$t_descripcion:="La cuenta corriente no fue encontrada."
		
	: ($r_idError=-9)
		$t_descripcion:="Se solicita la emisión de boletas pero los cargos asociados no están asociados a una Razón Social que emite Documentos Electrónicos."
		
	: ($r_idError=-10)
		$t_descripcion:="El apoderado no fue encontrado."
		
	: ($r_idError=-11)
		$t_descripcion:="Los alumnos no tienen asociado un mismo apoderado. Los cargos no pueden ser creados."
		
	: ($r_idError=-12)
		$t_descripcion:="Los parámetros no pudieron ser obtenidos."
		
	: ($r_idError=-13)
		$t_descripcion:="Página no encontrada."
		
	: ($r_idError=-14)
		$t_descripcion:="El json no pudo ser obtenido."
		
	: ($r_idError=-15)
		$t_descripcion:="El id_act no fue encontrado en la configuración de AccountTrack."
		
	: ($r_idError=-16)
		$t_descripcion:="Hay ítems de cargo que no corresponden al período."
		
	: ($r_idError=-17)
		$t_descripcion:="El apoderado asociado a los alumnos no corresponde al que que viene en la petición."
		
	: ($r_idError=-18)
		$t_descripcion:="Los cargos no pudieron ser creados."
		
	: ($r_idError=-19)
		$t_descripcion:="Error de autenticación."
		
	: ($r_idError=-20)
		$t_descripcion:="No se pudo generar la deuda."
		
	: ($r_idError=-21)
		$t_descripcion:="No hay ítems de cargo configurados para el período solicitado."
		
	: ($r_idError=-22)
		$t_descripcion:="No hay pagos de matrícula."
		
	: ($r_idError=-23)
		$t_descripcion:="Hay al menos un banco no encontrado en la configuración."
		
	: ($r_idError=-24)
		$t_descripcion:="Los montos de pagos y cargos no coinciden."
		
	: ($r_idError=-25)
		$t_descripcion:="Los cargos quedaron con saldo."
		
	: ($r_idError=-26)
		$t_descripcion:="Los cargos nu pudieron ser creados."
		
	: ($r_idError=-27)
		$t_descripcion:="Pago webpay no encontrado para matrícula."
		
	: ($r_idError=-28)
		$t_descripcion:="Pago webpay no encontrado para Colegiatura."
		
	: ($r_idError=-29)
		$t_descripcion:="Montos pago matrícula no corresponden a cargos matrícula."
		
	: ($r_idError=-30)
		$t_descripcion:="Montos pago colegiatura no corresponden a cargos colegiatura."
		
	: ($r_idError=-31)
		$t_descripcion:="La orden de compra ya se encuentra en la base de datos."
		
	: ($r_idError=-32)
		$t_descripcion:="Cheque ya registrado en la base de datos."
		
	: ($r_idError=-33)
		$t_descripcion:="Los Avisos de Cobranza no pudieron ser creados."
		
	: ($r_idError=-34)
		$t_descripcion:="La fecha del proceso no es válida."
		
	: ($r_idError=-35)
		$t_descripcion:="Ya existe al menos un aviso de cobranza emitido para los cargos."
		
	: ($r_idError=-36)
		$t_descripcion:="Monto en Avisos emitidos no corresponden a total de cargos en json."
		
	: ($r_idError=-37)
		$t_descripcion:="La transacción no pudo ser validada."
		
	: ($r_idError=-38)  //20161129 RCH
		$t_descripcion:="El registro de ítem de cargo está en uso. Intente nuevamente."
		
	: ($r_idError=-39)  // 13/11/2017 Saúl Ponce O. Ticket 191466, Registrar pagos de colegiatura y mensualidad con el mismo cheque (datos idénticos en ambos pagos)
		$t_descripcion:="Se pagó con un único cheque colegiaturas y matrícula, pero las fechas de vencimiento son diferentes."
		
	: ($r_idError=-40)
		$t_descripcion:="Hay documentos duplicados dentro de los cheques a ingresar."
		
	: ($r_idError=-41)
		$t_descripcion:="Existe al menos un Aviso de Cobranza emitido para los alumnos y cargos solicitados."
		
	: ($r_idError=-42)
		$t_descripcion:="Fecha de documentos no válida."
		
	Else 
		$t_descripcion:="Código "+String:C10($r_idError)+" no clasificado."
		
End case 
$t_descripcion:=$t_descripcion+Choose:C955($t_detalle="";"";". ")+$t_detalle

C_OBJECT:C1216($ob_raiz)
OB SET:C1220($ob_raiz;"error";$r_idError;"mensaje";$t_descripcion)
If ($b_conFormato)
	$json:=JSON Stringify:C1217($ob_raiz;*)
Else 
	$json:=JSON Stringify:C1217($ob_raiz)
End if 
$0:=$json