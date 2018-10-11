//%attributes = {}
  // BBLci_registroEnLog()
  // Por: Alberto Bachler: 25/09/13, 13:39:56
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)
C_TEXT:C284($5)

C_LONGINT:C283($l_Accion;$l_offset)
C_TEXT:C284($t_accion;$t_glosa;$t_Lector;$t_registro)

If (False:C215)
	C_LONGINT:C283(BBLci_registroEnLog ;$1)
	C_LONGINT:C283(BBLci_registroEnLog ;$2)
	C_LONGINT:C283(BBLci_registroEnLog ;$3)
	C_LONGINT:C283(BBLci_registroEnLog ;$4)
	C_TEXT:C284(BBLci_registroEnLog ;$5)
End if 

$l_Accion:=$1
$l_lector:=$2
$l_registro:=$3
$l_item:=$4
$t_glosa:=$5


CREATE RECORD:C68([xxBBL_Logs:41])

[xxBBL_Logs:41]DTS:2:=DTS_MakeFromDateTime 
[xxBBL_Logs:41]ID_TipoEvento:5:=$l_Accion
If ($l_lector>No current record:K29:2)
	KRL_GotoRecord (->[BBL_Lectores:72];$l_lector;False:C215)
	Case of 
		: ([BBL_Lectores:72]ID:1>0)
			[xxBBL_Logs:41]Texto_lector:9:=[BBL_Lectores:72]BarCode_SinFormato:38+" "+[BBL_Lectores:72]NombreCompleto:3
			[xxBBL_Logs:41]ID_Lector:6:=[BBL_Lectores:72]ID:1
		: ([BBL_Lectores:72]ID:1<0)
			[xxBBL_Logs:41]Texto_lector:9:=[BBL_Lectores:72]NombreCompleto:3
	End case 
End if 
If ($l_registro>No current record:K29:2)
	KRL_GotoRecord (->[BBL_Registros:66];$l_registro;False:C215)
	[xxBBL_Logs:41]Texto_registro_o_item:10:=[BBL_Registros:66]Barcode_SinFormato:26+" "+[BBL_Items:61]Primer_título:4+" (c. "+String:C10([BBL_Registros:66]Número_de_copia:2)+")"
	[xxBBL_Logs:41]ID_Registro:7:=[BBL_Registros:66]ID:3
	$l_item:=Find in field:C653([BBL_Items:61]Numero:1;[BBL_Registros:66]Número_de_item:1)
	KRL_GotoRecord (->[BBL_Items:61];$l_item;False:C215)
	[xxBBL_Logs:41]ID_Item:8:=[BBL_Items:61]Numero:1
End if 
If (($l_item>No current record:K29:2) & ($l_registro=No current record:K29:2))
	KRL_GotoRecord (->[BBL_Items:61];$l_item;False:C215)
	[xxBBL_Logs:41]ID_Item:8:=[BBL_Items:61]Numero:1
	[xxBBL_Logs:41]Texto_registro_o_item:10:=[BBL_Items:61]Clasificacion:2+" "+[BBL_Items:61]Primer_título:4
End if 
[xxBBL_Logs:41]Texto_Operacion:11:=$t_glosa
SAVE RECORD:C53([xxBBL_Logs:41])

READ ONLY:C145([xxBBL_Logs:41])
ALL RECORDS:C47([xxBBL_Logs:41])
ORDER BY:C49([xxBBL_Logs:41];[xxBBL_Logs:41]ID:4;<)

