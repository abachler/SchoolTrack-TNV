C_LONGINT:C283($l_resp;$l_resp2)
j_tabla1:=Num:C11(PREF_fGet (0;"ConfiguracionTablaPrimaria";"1"))
If (j_tabla1=0)
	$l_resp:=CD_Dlog (0;"Desea cambiar la configuracion de los atrasos "+"\r\r"+"¿Desea continuar?";"";"Si";"No")
	If ($l_resp=1)
		$l_resp2:=CD_Dlog (0;"Si efectua el cambio se eliminaran los atrasos del año"+"\r\r"+"¿Desea continuar?";"";"Si";"No")
		If ($l_resp2=1)
			j_tabla1:=1
			j_tabla2:=0
			PREF_Set (0;"ConfiguracionTablaPrimaria";String:C10(j_tabla1))
			STR_LeePreferenciasAtrasos2 
			If (j_tabla1=0)
				ATSTRAL_FALTATIPO{1}:="1/6"
				ATSTRAL_FALTATIPO{2}:="1/5"
				ATSTRAL_FALTATIPO{3}:="1/4"
				ATSTRAL_FALTATIPO{4}:="1/2"
				ATSTRAL_FALTATIPO{5}:="3/4"
				ATSTRAL_FALTATIPO{6}:="1"
				If (cb_RegistrarFraccionesEnAtrasos=1)
					vt_Intervalos:="un sexto,un quinto,un cuarto, medio, tres cuartos, uno"
				End if 
			Else 
				ATSTRAL_FALTATIPO{1}:="1/4"
				ATSTRAL_FALTATIPO{2}:="1/2"
				ATSTRAL_FALTATIPO{3}:="3/4"
				ATSTRAL_FALTATIPO{4}:="1"
				If (cb_RegistrarFraccionesEnAtrasos=1)
					vt_Intervalos:="un cuarto, medio, tres cuartos, uno"
				End if 
			End if 
			
			AL_UpdateArrays (xALP_TablaFaltasMin;-2)  //rch hasta aca 
			
			STR_eliminaAtrasos 
		Else 
			j_tabla1:=0
			j_tabla2:=1
			PREF_Set (0;"ConfiguracionTablaPrimaria";String:C10(j_tabla1))
		End if 
	Else 
		j_tabla1:=0
		j_tabla2:=1
		PREF_Set (0;"ConfiguracionTablaPrimaria";String:C10(j_tabla1))
	End if 
End if 

