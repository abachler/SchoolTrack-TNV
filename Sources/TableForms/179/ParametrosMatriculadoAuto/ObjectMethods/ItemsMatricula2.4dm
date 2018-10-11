ARRAY INTEGER:C220($ai_lines;0)
$line:=AL_GetSelect (xAL_ACT_cfg_ItemsMatricula;$ai_lines)
If (Size of array:C274($ai_lines)>0)
	$resp:=CD_Dlog (0;__ ("¿Está seguro de que desea quitar el(los) ítem(s) asociado(s)?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
	If ($resp=1)
		AL_UpdateArrays (xAL_ACT_cfg_ItemsMatricula;0)
		For ($i;Size of array:C274($ai_lines);1;-1)
			  //20120723 RCH Se registran cambios en conf
			$vt_log:="Eliminación de Ítem Matrícula. Ítem eliminado: "+atACTcfg_GlosaItemMatricula{$i}+", id: "+String:C10(alACTcfg_IdItemMatricula{$i})+"."
			ACTcfg_ItemsMatricula ("AgregaLogItemsMatricula";->$vt_log)
			
			AT_Delete ($ai_lines{$i};1;->alACTcfg_IdItemMatricula;->atACTcfg_GlosaItemMatricula)
		End for 
		AL_UpdateArrays (xAL_ACT_cfg_ItemsMatricula;-2)
		AL_SetLine (xAL_ACT_cfg_ItemsMatricula;0)
	End if 
End if 
ACTcfg_ItemsMatricula ("SeteaEstadosObjetosCfg")