//%attributes = {}
  //dhQR_PrePrintInstructions

PERIODOS_Init 
EVS_LoadStyles 
If (Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))=1)
	ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
End if 

If (Count parameters:C259=1)
	vyQR_TablePointer:=$1
Else 
	vyQR_TablePointer:=yBWR_currentTable
End if 
If ((Table:C252(vyQR_TablePointer)=Table:C252(->[Alumnos:2])) & (Not:C34(Shift down:C543)))
	If (([xShell_Reports:54]ReportName:26#"Certificado de estudio@") & ([xShell_Reports:54]ReportName:26#"Concentración de notas@"))
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Retirado@")
	End if 
End if 