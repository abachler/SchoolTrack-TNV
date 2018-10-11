//%attributes = {}
  //ACTfdp_EstadosXDefecto

C_TEXT:C284($vt_accion)
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4;$vy_pointer5)
C_POINTER:C301(${2})

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 
If (Count parameters:C259>=6)
	$vy_pointer5:=$6
End if 

Case of 
	: ($vt_accion="EstadosPagares")
		  // pagares
		APPEND TO ARRAY:C911($vy_pointer1->;-16)
		APPEND TO ARRAY:C911($vy_pointer2->;-101)
		APPEND TO ARRAY:C911($vy_pointer3->;__ ("Protestado"))
		APPEND TO ARRAY:C911($vy_pointer4->;"PG")
		APPEND TO ARRAY:C911($vy_pointer5->;False:C215)
		
		APPEND TO ARRAY:C911($vy_pointer1->;-16)
		APPEND TO ARRAY:C911($vy_pointer2->;-102)
		APPEND TO ARRAY:C911($vy_pointer3->;__ ("Anulado"))
		APPEND TO ARRAY:C911($vy_pointer4->;"")
		APPEND TO ARRAY:C911($vy_pointer5->;True:C214)
		
		APPEND TO ARRAY:C911($vy_pointer1->;-16)
		APPEND TO ARRAY:C911($vy_pointer2->;-103)
		APPEND TO ARRAY:C911($vy_pointer3->;__ ("Vigente"))
		APPEND TO ARRAY:C911($vy_pointer4->;"")
		APPEND TO ARRAY:C911($vy_pointer5->;False:C215)
		
		  //APPEND TO ARRAY($vy_pointer1->;-16)
		  //APPEND TO ARRAY($vy_pointer2->;-104)
		  //APPEND TO ARRAY($vy_pointer3->;__ ("Por Devolver"))
		  //APPEND TO ARRAY($vy_pointer4->;"")
		  //APPEND TO ARRAY($vy_pointer5->;False)
		
		APPEND TO ARRAY:C911($vy_pointer1->;-16)
		APPEND TO ARRAY:C911($vy_pointer2->;-105)
		APPEND TO ARRAY:C911($vy_pointer3->;__ ("Devuelto"))
		APPEND TO ARRAY:C911($vy_pointer4->;"")
		APPEND TO ARRAY:C911($vy_pointer5->;False:C215)
		  //APPEND TO ARRAY($alACT_idsFormasPago;-16)
		  //APPEND TO ARRAY($alACT_idsEstados;-101)
		  //APPEND TO ARRAY($atACT_estados;__ ("Protestado"))
		  //APPEND TO ARRAY($atACT_codInterno;"PG")
		  //
		  //APPEND TO ARRAY($alACT_idsFormasPago;-16)
		  //APPEND TO ARRAY($alACT_idsEstados;-102)
		  //APPEND TO ARRAY($atACT_estados;__ ("Anulado"))
		  //APPEND TO ARRAY($atACT_codInterno;"")
		  //
		  //APPEND TO ARRAY($alACT_idsFormasPago;-16)
		  //APPEND TO ARRAY($alACT_idsEstados;-103)
		  //APPEND TO ARRAY($atACT_estados;__ ("Vigente"))
		  //APPEND TO ARRAY($atACT_codInterno;"")
		  //
		  //APPEND TO ARRAY($alACT_idsFormasPago;-16)
		  //APPEND TO ARRAY($alACT_idsEstados;-104)
		  //APPEND TO ARRAY($atACT_estados;__ ("Por Devolver"))
		  //APPEND TO ARRAY($atACT_codInterno;"")
		  //
		  //APPEND TO ARRAY($alACT_idsFormasPago;-16)
		  //APPEND TO ARRAY($alACT_idsEstados;-105)
		  //APPEND TO ARRAY($atACT_estados;__ ("Devuelto"))
		  //APPEND TO ARRAY($atACT_codInterno;"")
		
		
	: ($vt_accion="")
		  //los estados por defecto (id negativo) no pueden ser asignados desde la opcion Cambiar estado...
		
		ARRAY LONGINT:C221($alACT_idsEstados;0)  // id que tiene que ser unico
		ARRAY TEXT:C222($atACT_estados;0)
		ARRAY LONGINT:C221($alACT_idsFormasPago;0)
		ARRAY TEXT:C222($atACT_codInterno;0)
		ARRAY BOOLEAN:C223($abACT_anulaPago;0)
		
		  //id desde el -2 al -50 para cheques y documentos de pago
		  //id desde el -51 al -100 para letras
		  //id desde el -102 al -150 pagares
		  //id desde el -151 al -200 efectivo
		  //id desde el -202 al -250 tarjeta credito
		  //id desde el -251 al -300 tarjeta de debito
		  //id desde el -302 al -350 PAT
		  //id desde el -351 al -400 PAC
		  //id desde el -402 al -450 Cuponera
		  //id desde el -451 al -500 nota de credito
		  //id desde el -502 al -550 transferencia
		  //id desde el -551 al -600 deposito
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-4)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Cheque a fecha"))
		APPEND TO ARRAY:C911($atACT_codInterno;"CHF")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-3)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-2)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Protestado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"CP")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-5)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Vencido"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-6)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-7)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Protestado y reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-8)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo y protestado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-9)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo y reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-10)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo, protestado y reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-4)
		APPEND TO ARRAY:C911($alACT_idsEstados;-11)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Depositado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"CD")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		  // letras
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-51)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Protestada"))
		APPEND TO ARRAY:C911($atACT_codInterno;"LP")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-52)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nula"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-53)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-54)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Protestado y reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-55)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo y protestado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-56)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo y reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-57)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo, protestado y reemplazado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-8)
		APPEND TO ARRAY:C911($alACT_idsEstados;-58)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Depositado"))
		APPEND TO ARRAY:C911($atACT_codInterno;"CD")
		APPEND TO ARRAY:C911($abACT_anulaPago;False:C215)
		
		
		  // estos estados deben ser creados a mano para que los puedan asignar desde la opcion correspondiente
		  //APPEND TO ARRAY($alACT_idsFormasPago;-8)
		  //APPEND TO ARRAY($alACT_idsEstados;-54)
		  //APPEND TO ARRAY($atACT_estados;__ ("Aceptada"))
		  //APPEND TO ARRAY($atACT_codInterno;"")
		  //APPEND TO ARRAY($abACT_anulaPago;False)
		  //
		  //APPEND TO ARRAY($alACT_idsFormasPago;-8)
		  //APPEND TO ARRAY($alACT_idsEstados;-53)
		  //APPEND TO ARRAY($atACT_estados;__ ("Letra Bancaria"))
		  //APPEND TO ARRAY($atACT_codInterno;"LB")
		  //APPEND TO ARRAY($abACT_anulaPago;False)
		
		  //id desde el -102 al -150 pagares
		ACTfdp_EstadosXDefecto ("EstadosPagares";->$alACT_idsFormasPago;->$alACT_idsEstados;->$atACT_estados;->$atACT_codInterno;->$abACT_anulaPago)
		
		  //id desde el -151 al -200 efectivo
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-3)
		APPEND TO ARRAY:C911($alACT_idsEstados;-151)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -202 al -250 tarjeta credito
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-6)
		APPEND TO ARRAY:C911($alACT_idsEstados;-202)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -251 al -300 tarjeta de debito
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-7)
		APPEND TO ARRAY:C911($alACT_idsEstados;-251)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -302 al -350 PAT
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-9)
		APPEND TO ARRAY:C911($alACT_idsEstados;-302)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -351 al -400 PAC
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-10)
		APPEND TO ARRAY:C911($alACT_idsEstados;-351)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -402 al -450 Cuponera
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-11)
		APPEND TO ARRAY:C911($alACT_idsEstados;-402)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -451 al -500 nota de credito
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-12)
		APPEND TO ARRAY:C911($alACT_idsEstados;-451)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -502 al -550 transferencia
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-13)
		APPEND TO ARRAY:C911($alACT_idsEstados;-502)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //id desde el -551 al -600 deposito
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-14)
		APPEND TO ARRAY:C911($alACT_idsEstados;-551)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //20140421 RCH Soporta pago nulo WP
		  //id desde el -601 al -650 Webpay
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-18)
		APPEND TO ARRAY:C911($alACT_idsEstados;-601)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //20141009 RCH Soporta pago nulo pago web
		  //id desde el -651 al -700 Webpay
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-19)
		APPEND TO ARRAY:C911($alACT_idsEstados;-651)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		  //20160119 ASM
		  //id desde el -701 al -750 payworks
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-20)
		APPEND TO ARRAY:C911($alACT_idsEstados;-701)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		
		  //20170526 RCH
		  //id desde el -751 al -800 Servipag
		APPEND TO ARRAY:C911($alACT_idsFormasPago;-21)
		APPEND TO ARRAY:C911($alACT_idsEstados;-751)
		APPEND TO ARRAY:C911($atACT_estados;__ ("Nulo"))
		APPEND TO ARRAY:C911($atACT_codInterno;"")
		APPEND TO ARRAY:C911($abACT_anulaPago;True:C214)
		
		For ($i;1;Size of array:C274($alACT_idsEstados))
			READ WRITE:C146([ACT_EstadosFormasdePago:201])
			QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id:1=$alACT_idsEstados{$i})
			If (Records in selection:C76([ACT_EstadosFormasdePago:201])=0)
				CREATE RECORD:C68([ACT_EstadosFormasdePago:201])
				[ACT_EstadosFormasdePago:201]id:1:=$alACT_idsEstados{$i}
				[ACT_EstadosFormasdePago:201]Codigo_interno:4:=$atACT_codInterno{$i}
			End if 
			[ACT_EstadosFormasdePago:201]Estado:3:=$atACT_estados{$i}
			[ACT_EstadosFormasdePago:201]id_forma_pago:2:=$alACT_idsFormasPago{$i}
			[ACT_EstadosFormasdePago:201]anula_pago:10:=$abACT_anulaPago{$i}
			SAVE RECORD:C53([ACT_EstadosFormasdePago:201])
			KRL_UnloadReadOnly (->[ACT_EstadosFormasdePago:201])
		End for 
		
End case 