  // Método: Método de Objeto: ReportObjectLib.hlSRop_VarTypes
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 22/02/10, 18:17:21
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones
C_TEXT:C284($itemText)

  // Código principal
GET LIST ITEM:C378(Self:C308->;*;viSRop_VariableType;$itemText)

Case of 
	: (viSRop_VariableType=SR Variable Type Array Element)
		OBJECT SET VISIBLE:C603(*;"elementoArreglo@";True:C214)
		OBJECT SET ENTERABLE:C238(*;"repeating@";False:C215)
		_O_DISABLE BUTTON:C193(*;"repeating@")
	: (viSRop_VariableType=SR Variable Type Array Auto)
		
		OBJECT SET VISIBLE:C603(*;"elementoArreglo@";False:C215)
		OBJECT SET ENTERABLE:C238(*;"repeating@";True:C214)
		_O_ENABLE BUTTON:C192(*;"repeating@")
End case 