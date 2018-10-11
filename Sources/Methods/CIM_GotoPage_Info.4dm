//%attributes = {}
  // MÉTODO: CIM_GotoPage_Info
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 27/06/11, 11:35:29
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // CIM_GotoPage_Info()
  // ----------------------------------------------------




  // CODIGO PRINCIPAL
If (Application type:C494#4D Remote mode:K5:5)
	CIM_INFO_Local 
Else 
	CIM_INFO_Local 
	CIM_INFO_Server 
End if 
GOTO OBJECT:C206(hl_InfoItemsLocal)
