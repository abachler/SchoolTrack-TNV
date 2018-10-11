$modo:=2
<>vr_RegistrarMinutosEnAtrasos:=$modo
PREF_Set (0;"RegistrarMinutosEnAtrasos";String:C10($modo))
_O_ENABLE BUTTON:C192(*;"oTabla@")
AL_SetEnterable (xALP_TablaFaltasMin;2;1)
AL_SetEnterable (xALP_TablaFaltasMin;3;1)
OBJECT SET ENTERABLE:C238(vt_Intervalos;False:C215)
vt_Intervalos:=""
If (j_tabla2=1)
	vt_Intervalos:="un sexto,un quinto,un cuarto, medio, tres cuartos, uno"
Else 
	vt_Intervalos:="un cuarto, medio, tres cuartos, uno"
End if 



If ((DConv1=0) & (DConv2=0) & (DConv3=0) & (DConv4=0))
	DConv1:=1
End if 
If (DConv4=1)
	AL_SetEnterable (xALP_TablaFaltasMin;4;1)
Else 
	AL_SetEnterable (xALP_TablaFaltasMin;4;0)
End if 