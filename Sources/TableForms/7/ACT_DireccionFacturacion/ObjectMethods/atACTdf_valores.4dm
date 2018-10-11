C_POINTER:C301($y_valores;$y_campos)

$y_valores:=OBJECT Get pointer:C1124(Object named:K67:5;"atACTdf_valores")
$y_campos:=OBJECT Get pointer:C1124(Object named:K67:5;"alACTdf_campos")

If ((Self:C308->>0) & (Self:C308-><=Size of array:C274($y_campos->)))
	Case of 
		: (Form event:C388=On Clicked:K2:4)
			Case of 
				: (Field:C253(Table:C252(->[Personas:7]);$y_campos->{Self:C308->})=->[Personas:7]Comuna:16)
					$l_existe:=Pop up menu:C542(AT_array2text (-><>aComuna;";"))
					If ($l_existe>0)
						$y_valores->{Self:C308->}:=<>aComuna{$l_existe}
					End if 
					
					If (Find in array:C230(<>aComuna;$y_valores->{Self:C308->})=-1)
						$y_valores->{Self:C308->}:=""  //20180108 RCH Si el elemento del arreglo no está es una comuna, se borra.
						BEEP:C151
					End if 
			End case 
			
		: (Form event:C388=On Data Change:K2:15)
			Case of 
				: (Field:C253(Table:C252(->[Personas:7]);$y_campos->{Self:C308->})=->[Personas:7]Comuna:16)
					If (Find in array:C230(<>aComuna;$y_valores->{Self:C308->})=-1)
						$y_valores->{Self:C308->}:=""
						BEEP:C151
					End if 
				: (Field:C253(Table:C252(->[Personas:7]);$y_campos->{Self:C308->})=->[Personas:7]eMail:34)
					If ($y_valores->{Self:C308->}#"")
						$y_valores->{Self:C308->}:=ACTdte_VerificaEmail ($y_valores->{Self:C308->};True:C214)
					End if 
			End case 
			
	End case 
	
End if 