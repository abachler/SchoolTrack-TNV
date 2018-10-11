C_LONGINT:C283(exportReport)
C_TEXT:C284(vt_pathIOAA)
exportReport:=0
vt_pathIOAA:=""
If (cs_Exportar=1)
	vt_pathIOAA:=SYS_SelectFolder ("")
	If (ok=1)
		exportReport:=1
	Else 
		exportReport:=0
		vt_pathIOAA:=""
	End if 
	If (exportReport=1)
		If (cs_Imprimir=0)
			ARRAY LONGINT:C221($aRecNums;0)
			SELECTION TO ARRAY:C260([Cursos:3];$aRecNums)
			For ($j;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([Cursos:3];$aRecNums{$j})
				SRcu_InformeOficialARG 
			End for 
		End if 
	End if 
End if 
If (cs_Imprimir=1)
	ACCEPT:C269
Else 
	  // MOD Ticket N° 191835 PA 20171114
	vt_ErrorEjecucionScript:="Solo exportacion de informe SEC_REGISTRO DE ASISITENCIA V2"
	  //CANCEL
End if 