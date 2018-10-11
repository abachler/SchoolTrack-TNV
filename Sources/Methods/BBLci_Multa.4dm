//%attributes = {}
  // BBLci_Multa()
  // Por: Alberto Bachler: 17/09/13, 12:52:32
  //  ---------------------------------------------
  //  Impone una multa al lector cuyo recNum se pasó en $recNumLector
  //  El monto de la multa corresponderá a la conversion numértica de la primera "palabra" de $t_parametro
  //  La glosa de la multa es la segunda "palabra" de $t_parametro
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_REAL:C285($2)

C_LONGINT:C283($recNumLector)
C_REAL:C285($r_montoMulta)
C_TEXT:C284($t_glosaMulta;$t_montoMulta;$t_parametro)

If (False:C215)
	C_LONGINT:C283(BBLci_Multa ;$1)
	C_REAL:C285(BBLci_Multa ;$2)
End if 

$recNumLector:=$1
$r_montoMulta:=$2
$t_glosaMulta:=Replace string:C233($t_parametro;$t_montoMulta;"")
$t_glosaMulta:=ST_ClearSpaces ($t_glosaMulta)

If ($r_montoMulta=0)
	$r_montoMulta:=Num:C11(CD_Request (__ ("Monto de la multa:");__ ("Aceptar");__ ("");__ ("")))
End if 

If ($r_montoMulta>0)
	If ($recNumLector>=0)
		READ ONLY:C145([BBL_Lectores:72])
		GOTO RECORD:C242([BBL_Lectores:72];$recNumLector)
		CREATE RECORD:C68([BBL_Transacciones:59])
		[BBL_Transacciones:59]ID_Mvt:1:=0
		[BBL_Transacciones:59]Monto:2:=$r_montoMulta
		[BBL_Transacciones:59]Fecha:3:=Current date:C33(*)
		[BBL_Transacciones:59]ID_User:4:=[BBL_Lectores:72]ID:1
		[BBL_Transacciones:59]Glosa:6:=$t_glosaMulta
		SAVE RECORD:C53([BBL_Transacciones:59])
		UNLOAD RECORD:C212([BBL_Transacciones:59])
		GOTO RECORD:C242([BBL_Lectores:72];$recNumLector)
		$t_glosa:=String:C10($r_montoMulta)
		BBLci_registroEnLog (Multa;Record number:C243([BBL_Lectores:72]);No current record:K29:2;Record number:C243([BBL_Items:61]);$t_glosa)
	Else 
		BEEP:C151
	End if 
End if 

  //BBLci_SwitchMode (1)
