$choice:=Pop up menu:C542(vMotivos)
If ($choice#0)
	vtACT_MotivoProtesto:=ST_GetWord (vMotivos;$choice;";")
End if 