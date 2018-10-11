//%attributes = {}
  // BBLci_Renovacion()
  // Por: Alberto Bachler: 06/10/13, 17:59:03
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_recNumItem;$l_recNumLector;$l_recNumLectorActual;$l_recNumPrestamo;$l_recNumRegistro)

If (False:C215)
	C_LONGINT:C283(BBLci_Renovacion ;$0)
	C_LONGINT:C283(BBLci_Renovacion ;$1)
End if 

$l_recNumRegistro:=$1
KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro)

$l_recNumItem:=KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1)
QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3;*)
QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
If (Records in selection:C76([BBL_Prestamos:60])>0)
	$l_recNumPrestamo:=Record number:C243([BBL_Prestamos:60])
	$l_recNumLector:=Find in field:C653([BBL_Lectores:72]ID:1;[BBL_Prestamos:60]Número_de_lector:2)
	BBLci_Prestamo ($l_recNumRegistro;$l_recNumItem;$l_recNumLector)
Else 
	$l_recNumPrestamo:=-1
	$l_recNumLectorActual:=-1
	REDUCE SELECTION:C351([BBL_Registros:66];0)
	REDUCE SELECTION:C351([BBL_Items:61];0)
	REDUCE SELECTION:C351([BBL_Lectores:72];0)
	BEEP:C151
End if 

