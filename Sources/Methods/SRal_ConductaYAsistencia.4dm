//%attributes = {}
  //SRal_ConductaYAsistencia


  //se mantiene por razones de compatibilidad de los informes.
  //el metodo que asigna la oinformación a variables es SRal_InformacionConductual

MESSAGES OFF:C175

If (Count parameters:C259=1)
	vPeriodo:=$1
Else 
	vPeriodo:=viSTR_PeriodoActual_Numero
End if 
SRal_InformacionConductual (vPeriodo)









