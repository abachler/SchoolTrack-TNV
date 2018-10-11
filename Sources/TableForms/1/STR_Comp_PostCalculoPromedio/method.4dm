  // Método: Método de Formulario: [xxSTR_Constants]STR_Comp_PostCalculoPromedio
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 13/12/10, 10:34:33
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

If (Form event:C388=On Load:K2:1)
	_O_REDRAW LIST:C382(<>hl_avgDiff_Asignaturas)
	If (Count list items:C380(<>hl_avgDiff_Asignaturas)>0)
		SELECT LIST ITEMS BY POSITION:C381(<>hl_avgDiff_Asignaturas;1)
		EV2_CambiosPostRecalculo ("SelectAsignatura")
	End if 
End if 



