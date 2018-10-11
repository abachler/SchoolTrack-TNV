//%attributes = {}
  // BBLci_Inventario()
  // Por: Alberto Bachler: 25/09/13, 19:07:04
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($1;$2;$3;$4)

$l_recNumRegistro:=$1
KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;True:C214)
$l_recNumItem:=KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Registros:66]Número_de_item:1;True:C214)

  // me aseguro que el registro no esté prestado actualmente. En caso contrario registro la devolución antes de inventoriarlo.
QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3;*)
QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
If (Records in selection:C76([BBL_Prestamos:60])>0)
	$l_recNumPrestamo:=Record number:C243([BBL_Prestamos:60])
	$l_recNumLector:=KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;True:C214)
	$r:=BBLci_Devolucion ($l_recNumRegistro;$l_recNumItem;$l_recNumPrestamo;$l_recNumLector)
End if 

KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;True:C214)
If (Locked:C147([BBL_Registros:66]))
	CD_Dlog (0;__ ("Otro usuario utiliza en este momento la ficha del registro.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde."))
Else 
	[BBL_Registros:66]Ultimo_inventario:6:=Current date:C33(*)
	SAVE RECORD:C53([BBL_Registros:66])
	BBLci_registroEnLog (Inventario;No current record:K29:2;Record number:C243([BBL_Registros:66]);No current record:K29:2;String:C10(Current date:C33;Internal date short special:K1:4))
End if 
KRL_ReloadAsReadOnly (->[BBL_Registros:66])

