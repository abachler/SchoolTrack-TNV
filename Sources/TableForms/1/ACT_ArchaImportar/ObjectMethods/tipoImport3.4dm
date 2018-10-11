If (Not:C34(ACTcm_IsMonthOpenFromDate (vdACT_ImpRealDate)))
	CD_Dlog (0;__ ("Los pagos no podrán ser registrados con esta fecha ya que corresponde a un mes cerrado."))
	vdACT_ImpRealDate:=Current date:C33(*)
End if 
vd_FechaUF:=vdACT_ImpRealDate
vt_FechaUF:=String:C10(vd_FechaUF)
