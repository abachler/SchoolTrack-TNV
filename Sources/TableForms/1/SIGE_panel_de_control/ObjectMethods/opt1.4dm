SIGE_LoadDataArrays (4;1;vi_MesNum)
SIGE_LoadDisplayLB (4)

OBJECT SET ENABLED:C1123(*;"pc_1";True:C214)
OBJECT SET ENABLED:C1123(*;"pc_2";True:C214)
OBJECT SET VISIBLE:C603(*;"Texto_dias";False:C215)
OBJECT SET VISIBLE:C603(*;"Texto_mes";True:C214)
OBJECT SET VISIBLE:C603(*;"btn_enviar_asist";True:C214)

OBJECT SET VISIBLE:C603(*;"Nivel_txt";False:C215)
OBJECT SET VISIBLE:C603(*;"vt_nivel";False:C215)
OBJECT SET VISIBLE:C603(*;"btni_nivel";False:C215)
OBJECT SET VISIBLE:C603(*;"pic_triangulo_nivel";False:C215)

OBJECT SET TITLE:C194(*;"btn_enviar_asist";"Enviar Asistencias")
If (pc_1=1)
	OBJECT SET ENABLED:C1123(*;"bti_blockAL";True:C214)
Else 
	OBJECT SET ENABLED:C1123(*;"bti_blockAL";False:C215)
End if 
