//%attributes = {}
  //ACTtrf_IsValidTransferFile

C_TEXT:C284($code;$1)
C_LONGINT:C283($err;$vl_long)

$code:=$1

$chs:=Char:C90(1)+Char:C90(1)+Char:C90(1)
  //20120110 RCH se cambia debido a que no consideraba los char (1)
  //$err:=Position($chs;$code)
$err:=Position:C15($chs;$code;1;$vl_long;*)

$0:=($err>0)