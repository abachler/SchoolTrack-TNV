//%attributes = {}
  //ACTbol_FormArraysDeclarations

C_TEXT:C284($vt_accion)

If (Count parameters:C259=1)
	$vt_accion:=$1
End if 

Case of 
	: ($vt_accion="")
		  //Para cargos involucrados en boleta
		ARRAY TEXT:C222(atACT_CGlosaImpresion;0)
		ARRAY REAL:C219(arACT_MontoPagado;0)
		ARRAY TEXT:C222(atACT_CAlumno;0)
		ARRAY LONGINT:C221(alACT_Cantidad;0)
		  //20130626 RCH NF CANTIDAD
		ARRAY REAL:C219(arACT_Cantidad;0)
		
		  //Para pagos involucrados en boleta
		ARRAY TEXT:C222(atACT_PagoFormaBol;0)
		ARRAY REAL:C219(arACT_PagoMontoBol;0)
		ARRAY REAL:C219(arACT_PagoSaldoBol;0)
		ARRAY TEXT:C222(atACT_PagoEstadoDocBol;0)
		ARRAY LONGINT:C221(alACT_PagoIDBol;0)
		
		  //Para alumnos de boleta
		ARRAY TEXT:C222(atACT_CCCurso;0)
		ARRAY TEXT:C222(atACT_CCAlumno;0)
		
		ACTbol_FormArraysDeclarations ("DctosAsociados")
		
	: ($vt_accion="DctosAsociados")
		ARRAY LONGINT:C221(alACT_NumDctoAsoc;0)
		ARRAY TEXT:C222(atACT_TipoDctoAsoc;0)
		ARRAY REAL:C219(arACT_MontoDctoAsoc;0)
		ARRAY BOOLEAN:C223(abACT_Nulo;0)
		
End case 



