//%attributes = {}
  //AS_ShowHideNotaOficial


AL_UpdateArrays (xALP_ASNotas;0)
If (vb_NotaOficialVisible)
	vb_NotaOficialVisible:=False:C215
Else 
	vb_NotaOficialVisible:=True:C214
End if 
AS_PaginaEvaluacion 