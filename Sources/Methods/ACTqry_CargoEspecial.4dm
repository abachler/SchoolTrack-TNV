//%attributes = {}
  //ACTqry_CargoEspecial
  // agregar ids de cargos especiales no eliminables por el usuario en ACTcar_EsCargoEspecial

C_LONGINT:C283($accion;$1)
$accion:=$1
Case of 
	: ($accion=3)  //descuentos afectos en caja
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-10)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoARecord 
		End if 
	: ($accion=4)  //descuentos exentos en caja
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-1)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoERecord 
		End if 
	: ($accion=5)  //descuento por diferencia moneda
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-102)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDctoMonedaRecord 
		End if 
	: ($accion=6)  //cargo por diferencia moneda
		READ WRITE:C146([xxACT_Items:179])
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-103)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateCargoMonedaRecord 
		End if 
	: ($accion=7)  //descuento exento nota de crédito
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-127)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoENC 
		End if 
	: ($accion=8)  //descuento afecto nota de crédito
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-128)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoANC 
		End if 
	: ($accion=9)  //cargo por devolución
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-129)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDevolucionNC 
		End if 
	: ($accion=10)  //descuento por cuenta
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-130)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoXCta 
		End if 
	: ($accion=11)  //descuento por número de hijo
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-131)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoXNoHijo 
		End if 
	: ($accion=12)  //descuento por número de cargas
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-132)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoXNoCargas 
		End if 
	: ($accion=13)  //descuento por generador
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-133)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoXGenerador 
		End if 
	: ($accion=14)  //descuentos relativos
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-134)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDesctoRelativo 
		End if 
	: ($accion=15)  //cargos relativos
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-135)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateCargoRelativo 
		End if 
	: ($accion=16)  //Dcto afecto condonación
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-136)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateCargoDctoACond 
		End if 
	: ($accion=17)  //Dcto exento condonación
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-137)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateCargoDctoECond 
		End if 
	: ($accion=18)  //Cargo afecto eliminacion dctos
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-138)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateCargoEliminDctoA 
		End if 
	: ($accion=19)  //cargo exento eliminacion dctos
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-139)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateCargoEliminDctoE 
		End if 
	: ($accion=20)  //cargo afecto descuento por tramo
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-140)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDescuentoTramoA 
		End if 
	: ($accion=21)  //cargo exento descuento por tramo
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=-141)
		If (Records in selection:C76([xxACT_Items:179])=0)
			ACTinit_CreateDescuentoTramoE 
		End if 
		
End case 