  // Método: Método de Objeto: [ACT_Boletas].NotasCreditoDebito.cs_generarDevolución
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 03-05-10, 19:20:04
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




If (Self:C308->=1)
	vr_montoDevolucion:=vr_MaxDevolucion
	If ((vr_montoDevolucion>vr_MaxDevolucion) | (vr_montoDevolucion>[ACT_Boletas:181]Monto_Total:6))
		vr_montoDevolucion:=0
		BEEP:C151
	End if 
Else 
	vr_montoDevolucion:=0
End if 