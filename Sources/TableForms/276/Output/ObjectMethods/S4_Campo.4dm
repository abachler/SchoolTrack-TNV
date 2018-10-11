  // Método: Método de Objeto: [XShell_ReportObjLib_TableRefs].Output.vt_TableName
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 28/07/10, 07:02:57
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal
If (Is table number valid:C999([XShell_ReportObjLib_TableRefs:276]ID_Table:2))
	Self:C308->:=Table name:C256([XShell_ReportObjLib_TableRefs:276]ID_Table:2)
Else 
	Self:C308->:="Invalid Table number"
End if 



