//%attributes = {}
  // BBLci_RegistraPago()
  // Por: Alberto Bachler: 09/11/13, 06:14:46
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_idlector:=$1
$r_pago:=$2


CREATE RECORD:C68([BBL_Transacciones:59])
[BBL_Transacciones:59]ID_Mvt:1:=SQ_SeqNumber (->[BBL_Transacciones:59]ID_Mvt:1)
[BBL_Transacciones:59]Monto:2:=$r_pago
[BBL_Transacciones:59]Fecha:3:=Current date:C33(*)
[BBL_Transacciones:59]ID_User:4:=[BBL_Lectores:72]ID:1
[BBL_Transacciones:59]is_Paiement:5:=True:C214
SAVE RECORD:C53([BBL_Transacciones:59])
KRL_ReloadAsReadOnly (->[BBL_Transacciones:59])
$t_glosa:=__ ("Monto: ")+String:C10($r_pago;"|Pesos")
BBLci_registroEnLog (Pago;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)