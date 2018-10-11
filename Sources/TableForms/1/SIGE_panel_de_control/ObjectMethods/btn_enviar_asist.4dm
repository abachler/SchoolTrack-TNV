Case of 
	: (Form event:C388=On Clicked:K2:4)
		
		C_LONGINT:C283($no_nivel)
		
		If (opt1=1)
			
			ARRAY LONGINT:C221($al_nivel_num;0)
			If (pc_2=1)
				
				For ($i;1;Size of array:C274(LB_SIGE))
					If (LB_SIGE{$i})
						APPEND TO ARRAY:C911($al_nivel_num;<>al_NumeroNivelesActivos{$i})
					End if 
				End for 
			Else 
				COPY ARRAY:C226(<>al_NumeroNivelesActivos;$al_nivel_num)
			End if 
			
			For ($i;1;Size of array:C274($al_nivel_num))
				SIGE_IngresoAsistencia ($al_nivel_num{$i};vi_MesNum)
			End for 
			
		Else 
			
			  //para dias seleccionados de un nivel en específico
			ARRAY TEXT:C222($at_keys;0)
			
			If (Size of array:C274(LB_SIGE)>0)
				
				For ($i;1;Size of array:C274(LB_SIGE))
					If (LB_SIGE{$i})
						APPEND TO ARRAY:C911($at_keys;at_Rol{$i}+"."+at_Cod_ens{$i}+"."+at_Cod_grado{$i}+"."+at_Fecha{$i})
					End if 
				End for 
				
				If (opt2=1)  //solicitud de ingreso de asistencia
					SIGE_IngresoAsistencia (vi_NivelNum;vi_MesNum;True:C214;->$at_keys)
				Else 
					  //verificación de la solicitud opt3=1
					SIGE_VerificaIngresoAsistencia (vi_NivelNum;vi_MesNum;->$at_keys)
				End if 
				
			End if 
			
			
		End if 
		
		Case of 
			: (opt1=1)
				$opcion:=1
			: (opt2=1)
				$opcion:=2
			: (opt3=1)
				$opcion:=3
		End case 
		
		SIGE_LoadDataArrays (4;$opcion;vi_MesNum;vi_NivelNum)
		SIGE_LoadDisplayLB (4)
		
End case 