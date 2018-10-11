//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 22-08-18, 09:39:28
  // ----------------------------------------------------
  // Método: ACTabc_OpcionesWizard
  // Descripción
  // Método para no repetir código en importación de pagos
  //
  // Parámetros
  // ----------------------------------------------------



C_TEXT:C284($1;$t_accion;$0;$t_retorno)
C_POINTER:C301($2;$3;$y_pointer1;$y_pointer2)


$t_accion:=$1
If (Count parameters:C259>=2)
	$y_pointer1:=$2
End if 

If (Count parameters:C259>=3)
	$y_pointer2:=$3
End if 

Case of 
	: ($t_accion="ObtieneDTSFechaParaFormato")
		
		Case of 
			: ($y_pointer1->="DDMMAAAA")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;3;2));Num:C11(Substring:C12($y_pointer2->;5;4))))
				
			: ($y_pointer1->="DDMMAA")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;3;2));Num:C11(Substring:C12($y_pointer2->;5;2))+2000))
				
			: ($y_pointer1->="MMDDAAAA")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;3;2));Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;5;4))))
				
			: ($y_pointer1->="MMDDAA")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;3;2));Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;5;2))+2000))
				
			: ($y_pointer1->="AAAAMMDD")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;7;2));Num:C11(Substring:C12($y_pointer2->;5;2));Num:C11(Substring:C12($y_pointer2->;1;4))))
				
			: ($y_pointer1->="AAMMDD")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;5;2));Num:C11(Substring:C12($y_pointer2->;3;2));Num:C11(Substring:C12($y_pointer2->;1;2))+2000))
				
			: ($y_pointer1->="DDMMAAAA con separador")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;4;2));Num:C11(Substring:C12($y_pointer2->;7;4))))
				
			: ($y_pointer1->="DDMMAA con separador")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;4;2));Num:C11(Substring:C12($y_pointer2->;7;2))+2000))
				
			: ($y_pointer1->="MMDDAAAA con separador")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;4;2));Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;7;4))))
				
			: ($y_pointer1->="MMDDAA con separador")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;4;2));Num:C11(Substring:C12($y_pointer2->;1;2));Num:C11(Substring:C12($y_pointer2->;7;2))+2000))
				
			: ($y_pointer1->="AAAAMMDD con separador")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;9;2));Num:C11(Substring:C12($y_pointer2->;6;2));Num:C11(Substring:C12($y_pointer2->;1;4))))
				
			: ($y_pointer1->="AAMMDD con separador")
				$t_retorno:=DTS_MakeFromDateTime (DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($y_pointer2->;7;2));Num:C11(Substring:C12($y_pointer2->;4;2));Num:C11(Substring:C12($y_pointer2->;1;2))+2000))
				
			Else 
				$t_retorno:=DTS_MakeFromDateTime (Date:C102($y_pointer2->))
		End case 
		
		
End case 

$0:=$t_retorno