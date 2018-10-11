Case of 
	: (Form event:C388=On Data Change:K2:15)
		Case of 
			: (Self:C308-><0)
				Self:C308->:=0
		End case 
		$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		Self:C308->:=Round:C94(Self:C308->;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
		
End case 