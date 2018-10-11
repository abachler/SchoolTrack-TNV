
Case of 
	: (Form event:C388=On Data Change:K2:15)
		
		If (Size of array:C274(alSTR_Horario_Desde)>0)
			If ((vhora_atraso<=alSTR_Horario_Desde{1}) | (vhora_atraso>=alSTR_Horario_Hasta{Size of array:C274(alSTR_Horario_Hasta)}))
				vhora_atraso:=?00:00:00?
				OBJECT SET VISIBLE:C603(*;"hora_texto_error";True:C214)
			Else 
				OBJECT SET VISIBLE:C603(*;"hora_texto_error";False:C215)
			End if 
		End if 
End case 
