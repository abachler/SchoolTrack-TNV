
If (Self:C308->>0)
	$frecfact:=Self:C308->{Self:C308->}
	If (($frecfact#[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13) & ([ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13#"Seleccionar..."))
		vDEVflag_ACT:=True:C214
		  //manejar aqui las incidencias de un cambio de matriz
		
		  //no debe poder cambiarse si la deuda ya ha sido generada o se debe eliminar la 
		
		  //deuda posterior a la fecha de cambio para ser generada nuevamente 
		
		
		OK:=CD_Dlog (0;__ ("¿Esta usted seguro que desea cambiar la frecuencia de facturación?");__ ("");__ ("No");__ ("Sí"))
		If (ok=2)
			[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13:=$frecfact
		Else 
			$el:=Find in array:C230(<>atACT_FreqFacturacion;[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13)
			If ($el>0)
				Self:C308->:=$el
				[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13:=Self:C308->{$el}
			Else 
				[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13:="Seleccionar..."
				Self:C308->:=0
			End if 
		End if 
	Else 
		[ACT_CuentasCorrientes:175]Frecuencia_Facturacion:13:=$frecfact
	End if 
End if 