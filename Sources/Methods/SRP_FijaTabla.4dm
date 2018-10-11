//%attributes = {}
  // SRP_FijaTabla(area:L ; numeroTabla:L)
  // 
  //
  // creado por: Alberto Bachler Klein: 04-04-16, 17:08:22
  // -----------------------------------------------------------


C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_LONGINT:C283($l_error;$l_refArea;$l_refDataSource;$l_tabla)


If (False:C215)
	C_LONGINT:C283(SRP_FijaTabla ;$0)
	C_LONGINT:C283(SRP_FijaTabla ;$1)
	C_LONGINT:C283(SRP_FijaTabla ;$2)
End if 

$l_refArea:=$1
$l_tabla:=Abs:C99($2)

$l_refDataSource:=SR_GetLongProperty ($l_refArea;1;SRP_DataSource)
SR_SetLongProperty ($l_refArea;$l_refDataSource;SRP_DataSource_TableID;Abs:C99($l_tabla))
