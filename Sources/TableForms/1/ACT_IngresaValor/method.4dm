Case of 
	: (Form event:C388=On Load:K2:1)
		C_POINTER:C301($y_punteroCol1;$y_punteroCol2;$y_punteroCol3)
		
		OBJECT SET TITLE:C194(*;"lb_IngresoValorEnc1";__ ("Responsable"))
		OBJECT SET TITLE:C194(*;"lb_IngresoValorEnc2";__ ("%"))
		
		$y_punteroCol1:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_IngresaValorCol1")
		$y_punteroCol2:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_IngresaValorCol2")
		$y_punteroCol3:=OBJECT Get pointer:C1124(Object named:K67:5;"lb_IngresaValorCol3")
		
		COPY ARRAY:C226(aRelName;$y_punteroCol1->)
		AT_RedimArrays (Size of array:C274(aRelName);$y_punteroCol2)
		COPY ARRAY:C226(aPersID;$y_punteroCol3->)
		
		  //aPersID
		ARRAY LONGINT:C221($al_ids;0)
		ARRAY LONGINT:C221($al_pct;0)
		ACTcc_DividirEmision ("LeeArreglos";->[ACT_CuentasCorrientes:175]o_pct_emision:56;->$al_ids;->$al_pct)
		
		For ($l_indice;1;Size of array:C274(aPersID))
			$l_pos:=Find in array:C230($al_ids;aPersID{$l_indice})
			If ($l_pos>0)
				$y_punteroCol2->{$l_indice}:=$al_pct{$l_pos}
			End if 
		End for 
		
	: (Form event:C388=On Close Box:K2:21)
		
End case 

