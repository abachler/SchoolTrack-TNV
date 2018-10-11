//%attributes = {}
  // BBLci_MultaPorDevolucionTardia()
  // Por: Alberto Bachler: 09/11/13, 06:07:31
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_REAL:C285($2)

C_LONGINT:C283($l_recNumPrestamo)
C_REAL:C285($r_multa)
C_TEXT:C284($t_glosa;$t_titulo)

If (False:C215)
	C_LONGINT:C283(BBLci_MultaPorDevolucionTardia ;$1)
	C_REAL:C285(BBLci_MultaPorDevolucionTardia ;$2)
End if 

$l_recNumPrestamo:=$1
$r_multa:=$2
KRL_GotoRecord (->[BBL_Prestamos:60];$l_recNumPrestamo)

$t_titulo:=KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;->[BBL_Items:61]Primer_título:4)

CREATE RECORD:C68([BBL_Transacciones:59])
[BBL_Transacciones:59]ID_Mvt:1:=SQ_SeqNumber (->[BBL_Transacciones:59]ID_Mvt:1)
[BBL_Transacciones:59]Monto:2:=$r_multa
[BBL_Transacciones:59]Fecha:3:=Current date:C33(*)
[BBL_Transacciones:59]ID_User:4:=[BBL_Prestamos:60]Número_de_lector:2
[BBL_Transacciones:59]Glosa:6:=$t_titulo+" ("+String:C10([BBL_Prestamos:60]Días_de_atraso:15)+" día(s) de atraso)."
SAVE RECORD:C53([BBL_Transacciones:59])
KRL_ReloadAsReadOnly (->[BBL_Transacciones:59])
$t_glosa:=__ ("Monto: ")+String:C10($r_multa;"|Pesos")
BBLci_registroEnLog (Multa;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)

