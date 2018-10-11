//%attributes = {}
  //Ejemplo json
C_LONGINT:C283($l_agregar_glosa;$l_emitir_boleta;$l_indice;$l_orden_compra)
C_REAL:C285($r_monto_total)
C_TEXT:C284($json;$t_apellido1_pagador;$t_apellido2_pagador;$t_aplicacion;$t_fecha_pago;$t_llave;$t_nombres_pagador;$t_uuid_transaccion;$t_uuidApdo;$t_uuidCta)
C_OBJECT:C1216($ob;$ob_raiz;$ob_temp)

ARRAY OBJECT:C1221($ao_datospagos;0)
If (Not:C34(Is compiled mode:C492))
	ARRAY TEXT:C222(atXCR_uuidXCR;0)
	ARRAY TEXT:C222(atXCR_uuidAL;0)
	ARRAY TEXT:C222(atXCR_nombre;0)
	ARRAY TEXT:C222(atXCR_nombres;0)
	ARRAY TEXT:C222(atXCR_ap1;0)
	ARRAY TEXT:C222(atXCR_ap2;0)
	ARRAY REAL:C219(arXCR_montos;0)
	ARRAY REAL:C219(arXCR_idACT;0)
	
	APPEND TO ARRAY:C911(atXCR_uuidXCR;"f605cb87-29e7-41bd-bc44-88092c3b5010")
	  //APPEND TO ARRAY(atXCR_uuidAL;"C7E98A801EA10649BDE6B08A53B8ED7A")
	APPEND TO ARRAY:C911(atXCR_uuidAL;"6DA75445C31AED4384B76B27ABCB57A2")
	APPEND TO ARRAY:C911(atXCR_nombre;"TENIS")
	APPEND TO ARRAY:C911(atXCR_nombres;"BEATRIZ CONSUELO MARIA")
	APPEND TO ARRAY:C911(atXCR_ap1;"CANALES")
	APPEND TO ARRAY:C911(atXCR_ap2;"HENRIQUEZ")
	APPEND TO ARRAY:C911(arXCR_montos;35000)
	APPEND TO ARRAY:C911(arXCR_idACT;80)
	
	APPEND TO ARRAY:C911(atXCR_uuidXCR;"08605eff-02f1-4245-9a27-3e591ee66823")
	  //APPEND TO ARRAY(atXCR_uuidAL;"C66612ADEB9EDE4D9402467B191790EE")
	APPEND TO ARRAY:C911(atXCR_uuidAL;"E5FB0D415E5F8D448EBFBF73DC5FBDA5")
	APPEND TO ARRAY:C911(atXCR_nombre;"PINTURA")
	APPEND TO ARRAY:C911(atXCR_nombres;"BEATRIZ CONSUELO MARIA")
	APPEND TO ARRAY:C911(atXCR_ap1;"CANALES")
	APPEND TO ARRAY:C911(atXCR_ap2;"HENRIQUEZ")
	APPEND TO ARRAY:C911(arXCR_montos;60000)
	APPEND TO ARRAY:C911(arXCR_idACT;80)
	
	  //$t_uuidApdo:="3E5760B4-31CD-704E-B62F-124A6101AB57"
	$t_uuidApdo:="CE123C579114FC4F99E56004B4209765"
	For ($l_indice;1;Size of array:C274(atXCR_uuidAL))
		$t_uuidCta:=$t_uuidCta+atXCR_uuidAL{$l_indice}
	End for 
	$t_llave:=XCRwa_GeneraLlave ($t_uuidApdo;$t_uuidCta)
	
	
	
	
	$ob_raiz:=OB_Create 
	
	$r_monto_total:=95000
	$t_uuid_transaccion:="397f0e86-fcab-47df-8834-457712d15a7b"
	$t_fecha_pago:="2015-08-13T00:00:00.000Z"
	$l_orden_compra:=22988
	$t_nombres_pagador:="Prueba"
	$t_apellido1_pagador:=""
	$t_apellido2_pagador:=""
	$l_agregar_glosa:=1
	
	$l_emitir_boleta:=1
	$t_aplicacion:="Extracurriculares"
	
	OB_SET ($ob_raiz;->$r_monto_total;"monto_total")
	OB_SET ($ob_raiz;->$t_uuid_transaccion;"uuid_transaccion")
	OB_SET ($ob_raiz;->$t_fecha_pago;"fecha_pago")
	OB_SET ($ob_raiz;->$l_orden_compra;"orden_compra")
	OB_SET ($ob_raiz;->$t_uuidApdo;"uuid_pagador")
	OB_SET ($ob_raiz;->$t_nombres_pagador;"nombres_pagador")
	OB_SET ($ob_raiz;->$t_apellido1_pagador;"apellido1_pagador")
	OB_SET ($ob_raiz;->$t_apellido2_pagador;"apellido2_pagador")
	OB_SET ($ob_raiz;->$l_agregar_glosa;"agregar_glosa")
	OB_SET ($ob_raiz;->$t_llave;"llave")
	OB_SET ($ob_raiz;->$l_emitir_boleta;"emitir_boleta")
	OB_SET ($ob_raiz;->$t_aplicacion;"aplicacion")
	
	  //$t_principal:=JSON New
	  //  //$t_err:=JSON Append node ($t_principal;"estado")
	  //$node:=JSON Append real ($t_principal;"monto_total";95000)
	  //$node:=JSON Append text ($t_principal;"uuid_transaccion";"397f0e86-fcab-47df-8834-457712d15a7b")
	  //$node:=JSON Append text ($t_principal;"fecha_pago";"2015-08-13T00:00:00.000Z")
	  //node:=JSON Append real ($t_principal;"orden_compra";22988)
	  //  //node:=JSON Append text ($t_principal;"uuid_pagador";"a8d12869-ae30-4fdf-9131-586a2263ce5a")
	  //node:=JSON Append text ($t_principal;"uuid_pagador";$t_uuidApdo)
	  //node:=JSON Append text ($t_principal;"nombres_pagador";"Prueba")
	  //node:=JSON Append text ($t_principal;"apellido1_pagador";"")
	  //node:=JSON Append text ($t_principal;"apellido2_pagador";"")
	  //node:=JSON Append real ($t_principal;"agregar_glosa";1)
	  //node:=JSON Append text ($t_principal;"llave";$t_llave)
	  //node:=JSON Append real ($t_principal;"emitir_boleta";1)
	  //node:=JSON Append text ($t_principal;"aplicacion";"Extracurriculares")
	
	  //$temporal:=JSON Append node ($t_principal;"datos_pagos")
	For ($l_indice;1;Size of array:C274(atXCR_uuidXCR))
		
		$ob_temp:=OB_Create 
		
		OB_SET ($ob_temp;->atXCR_uuidXCR{$l_indice};"uuid_detalle_extracurricular")
		OB_SET ($ob_temp;->atXCR_uuidAL{$l_indice};"uuid_alumno")
		OB_SET ($ob_temp;->atXCR_nombre{$l_indice};"nombre")
		OB_SET ($ob_temp;->atXCR_nombres{$l_indice};"nombres_alumno")
		OB_SET ($ob_temp;->atXCR_ap1{$l_indice};"apellido1_alumno")
		OB_SET ($ob_temp;->atXCR_ap2{$l_indice};"apellido2_alumno")
		OB_SET ($ob_temp;->arXCR_montos{$l_indice};"monto")
		OB_SET ($ob_temp;->arXCR_idACT{$l_indice};"id_act")
		
		
		  //$t_dato:=JSON Append node ($temporal;"dato")
		  //$node:=JSON Append text ($t_dato;"uuid_detalle_extracurricular";atXCR_uuidXCR{$l_indice})
		  //$node:=JSON Append text ($t_dato;"uuid_alumno";atXCR_uuidAL{$l_indice})
		  //$node:=JSON Append text ($t_dato;"nombre";atXCR_nombre{$l_indice})
		  //$node:=JSON Append text ($t_dato;"nombres_alumno";atXCR_nombres{$l_indice})
		  //$node:=JSON Append text ($t_dato;"apellido1_alumno";atXCR_ap1{$l_indice})
		  //$node:=JSON Append text ($t_dato;"apellido2_alumno";atXCR_ap2{$l_indice})
		  //$node:=JSON Append real ($t_dato;"monto";arXCR_montos{$l_indice})
		  //$node:=JSON Append real ($t_dato;"id_act";arXCR_idACT{$l_indice})
		APPEND TO ARRAY:C911($ao_datospagos;$ob_temp)
		CLEAR VARIABLE:C89($ob_temp)
	End for 
	OB_SET ($ob_raiz;->$ao_datospagos;"datos_pagos")
	  //JSON SET TYPE ($temporal;JSON_ARRAY)
	  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
	  //JSON CLOSE ($t_principal)
	$json:=OB_Object2Json ($ob_raiz)
End if 
$0:=$json