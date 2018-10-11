//%attributes = {}
  // SRP_LeeTablaInforme()
  // 
  //
  // creado por: Alberto Bachler Klein: 04-04-16, 17:11:03
  // -----------------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_refArea;$l_refDataSource;$l_tabla)


If (False:C215)
	C_LONGINT:C283(SRP_LeeTablaInforme ;$0)
	C_LONGINT:C283(SRP_LeeTablaInforme ;$1)
End if 

$l_refArea:=$1

If (Application version:C493>="15@")
	  // obtengo la referencia del objeto DataSource
	$l_refDataSource:=SR_GetLongProperty ($l_refArea;1;SRP_DataSource)
	  // obtengo el numero de tabla del objeto DataSource
	$l_tabla:=SR_GetLongProperty ($l_refArea;$l_refDataSource;SRP_DataSource_TableID)
Else 
	$err:=SR Main Table2 (xReportData;0;vlQR_MainTable;"")
End if 


$0:=$l_Tabla