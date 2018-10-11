If (Form event:C388=On Clicked:K2:4)
	CD_Dlog (0;__ ("Todos los Avisos de Cobranza serán recalculados durante las tareas de inicio de día."))
End if 
LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)