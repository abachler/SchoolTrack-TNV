//%attributes = {}
  //ADTwa_RespuestaError

C_REAL:C285($1;$r_idError)
C_BOOLEAN:C305($b_conFormato;$2)

C_TEXT:C284($0;$json;$t_principal;$t_err;$node;$t_descripcion)
C_BOOLEAN:C305($b_conFormato)
C_TEXT:C284($t_descripcionMensaje)

$r_idError:=$1
If (Count parameters:C259>=2)
	$b_conFormato:=$2
End if 

Case of 
		  //Valores positivos se utilizaran para mensajes.
	: ($r_idError>0)
		$t_descripcion:="ok."
		Case of 
			: ($r_idError=1)
				$t_descripcionMensaje:="La licencia no permitió generar el DTE."
				
			: ($r_idError=2)
				$t_descripcionMensaje:="El documento tributario no pudo ser generado."
				
			: ($r_idError=3)
				$t_descripcionMensaje:="Documento no generado."
				
			: ($r_idError=4)
				$t_descripcionMensaje:="Documento sin folio."
				
			: ($r_idError=5)
				$t_descripcionMensaje:="Documento no emitido."
				
			Else 
				$t_descripcionMensaje:="Mensaje no clasificado."
				
		End case 
		  //Valores positivos se utilizaran para mensajes.
		
	: ($r_idError=0)
		$t_descripcion:="ok."
		
	: ($r_idError=-1)
		$t_descripcion:="Página no encontrada."
		
	: ($r_idError=-2)
		$t_descripcion:="Llave no coincide."
		
	: ($r_idError=-3)
		$t_descripcion:="Script no ejecutado."
		
	: ($r_idError=-4)
		$t_descripcion:="Error al crear alumno."
		
	: ($r_idError=-5)
		$t_descripcion:="Error al crear el apoderado académico."
		
	: ($r_idError=-6)
		$t_descripcion:="Error al crear el apoderado de cuenta."
		
	: ($r_idError=-7)
		$t_descripcion:="Error al crear la familia."
		
	: ($r_idError=-8)
		$t_descripcion:="Error al crear la madre."
		
	: ($r_idError=-9)
		$t_descripcion:="Error al crear al padre."
		
	: ($r_idError=-10)
		$t_descripcion:="Error al crear el Aviso de Cobranza."
		
	: ($r_idError=-11)
		$t_descripcion:="Error al crear los cargos."
		
	: ($r_idError=-12)
		$t_descripcion:="RUT madre no válido."
		
	: ($r_idError=-13)
		$t_descripcion:="RUT padre no válido."
		
	: ($r_idError=-14)
		$t_descripcion:="RUT alumno no válido."
		
	: ($r_idError=-15)
		$t_descripcion:="RUT apoderado académico no válido."
		
	: ($r_idError=-16)
		$t_descripcion:="RUT apoderado de cuenta no válido."
		
	: ($r_idError=-17)
		$t_descripcion:="Error al actualizar cuenta corriente."
		
	: ($r_idError=-18)
		$t_descripcion:="Error al ejecutar script."
		
	: ($r_idError=-19)
		$t_descripcion:="Script no encontrado."
		
	: ($r_idError=-20)
		$t_descripcion:="Apoderados asociados a más de una familia."
		
	: ($r_idError=-21)
		$t_descripcion:="Preferencia vacía."
		
	: ($r_idError=-22)
		$t_descripcion:="Rol base de datos no corresponde."
		
	: ($r_idError=-23)  //20160319 RCH
		$t_descripcion:="Proceso en ejecución."
		
	: ($r_idError=-24)  //20160319 RCH
		$t_descripcion:="Json no obtenido."
		
	: ($r_idError=-25)  //20160319 RCH
		$t_descripcion:="No fueron encontrados cargos."
		
	: ($r_idError=-26)  //20160319 RCH
		$t_descripcion:="La suma del monto de los cargos no corresponde al monto del pago."
		
	: ($r_idError=-27)  //20160319 RCH
		$t_descripcion:="La fecha no pudo ser obtenida."
		
	: ($r_idError=-28)  //20160319 RCH
		$t_descripcion:="Orden de compra no encontrada."
		
	: ($r_idError=-29)  //20160319 RCH
		$t_descripcion:="La orden de compra ya se encuentra en la base de datos."
		
	: ($r_idError=-30)  //20160319 RCH
		$t_descripcion:="El id_act no fue encontrado en la configuración de AccountTrack."
		
	: ($r_idError=-31)  //20160319 RCH
		$t_descripcion:="Se solicita la emisión de boletas pero los cargos asociados no están asociados a una Razón Social que emite Documentos Electrónicos."
		
	: ($r_idError=-32)  //20160319 RCH
		$t_descripcion:="El Tercero no pudo ser creado."
		
	: ($r_idError=-33)  //20160319 RCH
		$t_descripcion:="Los datos no son suficientes para crear al Tercero."
		
	: ($r_idError=-34)  //20160319 RCH
		$t_descripcion:="El Tercero SII no fue encontrado."
		
	: ($r_idError=-35)  //20160319 RCH
		$t_descripcion:="El Tercero SII no pudo ser creado."
		
	: ($r_idError=-36)  //20160319 RCH
		$t_descripcion:="El Tercero no pudo ser creado."
		
	: ($r_idError=-37)  //20160319 RCH
		$t_descripcion:="El Tercero no fue encontrado."
		
	: ($r_idError=-38)  //20160319 RCH
		$t_descripcion:="El Pago no pudo ser creado."
		
	: ($r_idError=-39)  //20160319 RCH
		$t_descripcion:="Apoderado/Tercero no encontrado al ingresar el pago"
		
	: ($r_idError=-40)  //20160319 RCH
		$t_descripcion:="Mes cerrado. Pago no ingresado."
		
	: ($r_idError=-41)  //20160319 RCH
		$t_descripcion:="Llave no corresponde."
		
	: ($r_idError=-42)  //20160319 RCH
		$t_descripcion:="Hay más de un apoderado/tercero asociado a los avisos."
		
	: ($r_idError=-43)  //20160319 RCH
		$t_descripcion:="El monto de los cargos no es mayor a 0."
		
	: ($r_idError=-44)  //20160319 RCH
		$t_descripcion:="Datos inválidos."
		
	: ($r_idError=-45)  //20160319 RCH
		$t_descripcion:="El Json de pago no pudo ser obtenido."
		
	: ($r_idError=-46)  //20160319 RCH
		$t_descripcion:="No fue identificado el pago."
		
	: ($r_idError=-47)
		$t_descripcion:="El pago quedó con saldo."
		
	: ($r_idError=-48)
		$t_descripcion:="Se solicita emitir el Documento Tributario pero no fue encontrado el id del pago."
		
	: ($r_idError=-49)
		$t_descripcion:="No hay datos del responsable para asociar el pago. Es posible asociar todos los pagos a un Tercero genérico. Para ello ingrese a la configuración de Postulaciones y marque la opción Asociar pagos a tercero genérico."
		
	: ($r_idError=-50)  //20160602 RCH
		$t_descripcion:="No se pudo generar identificar al Tercero genérico. V2"
		
	: ($r_idError=-51)  //20170818 RCH
		$t_descripcion:="El tercero debe tener nombre SII."
		
	Else 
		$t_descripcion:="Código "+String:C10($r_idError)+" no clasificado."
		
End case 



  // Modificado por: Alexis Bustamante (10-06-2017)
  //Ticket 179869

C_OBJECT:C1216($ob_raiz;$ob_datos)

$ob_raiz:=OB_Create 
$ob_datos:=OB_Create 
OB_SET ($ob_datos;->$r_idError;"codigo")
OB_SET ($ob_datos;->$t_descripcion;"descripcion")
If ($t_descripcionMensaje#"")
	OB_SET ($ob_datos;->$t_descripcionMensaje;"mensaje")
End if 
OB_SET ($ob_raiz;->$ob_datos;"estado")
$json:=OB_Object2Json ($ob_raiz)
$0:=$json
  //$t_principal:=JSON New 
  //$t_err:=JSON Append node ($t_principal;"estado")
  //$node:=JSON Append real ($t_err;"codigo";$r_idError)
  //$node:=JSON Append text ($t_err;"descripcion";$t_descripcion)
  //If ($t_descripcionMensaje#"")
  //$node:=JSON Append text ($t_err;"mensaje";$t_descripcionMensaje)
  //End if 
  //If ($b_conFormato)
  //$json:=JSON Export to text ($t_principal;JSON_WITH_WHITE_SPACE)
  //Else 
  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
  //End if 
  //JSON CLOSE ($t_principal)
  //$0:=$json


