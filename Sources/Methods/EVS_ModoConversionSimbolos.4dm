//%attributes = {}
  // EVS_ModoConversionSimbolos()
  //
  //
  // creado por: Alberto Bachler Klein: 30-06-16, 10:40:27
  // -----------------------------------------------------------
C_LONGINT:C283($0)

C_LONGINT:C283($l_modoConversion)


If (False:C215)
	C_LONGINT:C283(EVS_ModoConversionSimbolos ;$0)
End if 

Case of 
	: ((iEvaluationMode=Simbolos) & (iPrintMode=Simbolos) & (iViewMode=Simbolos) & (iPrintActa=Simbolos))
		$l_modoConversion:=Porcentaje
		
	: ((iEvaluationMode=Simbolos) & ((iPrintMode#Simbolos) | (iViewMode#Simbolos) | (iPrintActa#Simbolos)))
		Case of 
			: ((iPrintMode=Notas) & (iViewMode=Notas))
				$l_modoConversion:=Notas
			: ((iPrintMode=Puntos) & (iViewMode=Puntos))
				$l_modoConversion:=Puntos
			: (iPrintMode=Notas)
				$l_modoConversion:=Notas
			: (iPrintMode=Puntos)
				$l_modoConversion:=Puntos
			: (iPrintActa=Notas)
				$l_modoConversion:=Notas
			: (iPrintActa=Puntos)
				$l_modoConversion:=Puntos
			Else 
				$l_modoConversion:=Porcentaje
		End case 
		
	: (iEvaluationMode#Simbolos)
		$l_modoConversion:=iEvaluationMode
		
	: (iPrintMode#Simbolos)
		$l_modoConversion:=iPrintMode
		
	: (iViewMode#Simbolos)
		$l_modoConversion:=iViewMode
		
	: (iPrintActa#Simbolos)
		$l_modoConversion:=iPrintActa
		
End case 
(OBJECT Get pointer:C1124(Object named:K67:5;"modoConversionSimbolos"))->:=$l_modoConversion


$0:=$l_modoConversion

