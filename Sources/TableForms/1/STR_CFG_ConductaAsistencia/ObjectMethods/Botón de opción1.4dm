$modo:=1
<>vr_RegistrarMinutosEnAtrasos:=$modo
PREF_Set (0;"RegistrarMinutosEnAtrasos";String:C10($modo))
_O_ENABLE BUTTON:C192(*;"oTabla@")
AL_SetEnterable (xALP_TablaFaltasMin;2;1)
AL_SetEnterable (xALP_TablaFaltasMin;3;1)
OBJECT SET ENTERABLE:C238(vt_Intervalos;True:C214)

If (j_tabla2=1)
	If (ATSTRAL_FALTATIPO{1}="1/6")
		vt_Intervalos:=""
		If (ATSTRAL_FALTACONV{1}>0)
			For ($i;1;6)
				If (ATSTRAL_FALTACONV{$i}>0)
					vt_Intervalos:=vt_Intervalos+String:C10(ATSTRAL_FALTACONV{$i})+","
				End if 
			End for 
			vt_Intervalos:=Substring:C12(vt_Intervalos;1;Length:C16(vt_Intervalos)-1)
		End if 
		OBJECT SET ENTERABLE:C238(vt_Intervalos;True:C214)
	End if 
Else 
	If (ATSTRAL_FALTATIPO{1}="1/4")
		vt_Intervalos:=""
		If (ATSTRAL_FALTACONV{1}>0)
			For ($i;1;4)
				If (ATSTRAL_FALTACONV{$i}>0)
					vt_Intervalos:=vt_Intervalos+String:C10(ATSTRAL_FALTACONV{$i})+","
				End if 
			End for 
			vt_Intervalos:=Substring:C12(vt_Intervalos;1;Length:C16(vt_Intervalos)-1)
		End if 
		OBJECT SET ENTERABLE:C238(vt_Intervalos;True:C214)
	End if 
End if 


If ((DConv1=0) & (DConv2=0) & (DConv3=0) & (DConv4=0))
	DConv1:=1
End if 
If (DConv4=1)
	AL_SetEnterable (xALP_TablaFaltasMin;4;1)
Else 
	AL_SetEnterable (xALP_TablaFaltasMin;4;0)
End if 