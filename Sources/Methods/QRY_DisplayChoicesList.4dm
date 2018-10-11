//%attributes = {}
  // QRY_DisplayChoicesList()
  // Por: Alberto Bachler: 21/02/13, 13:56:42
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_POINTER:C301($1)

C_LONGINT:C283($l_numeroCampo;$l_NumeroTabla)
C_POINTER:C301($y_campo)
C_TEXT:C284($t_nombreCampo;$t_nombreVariable)

If (False:C215)
	C_POINTER:C301(QRY_DisplayChoicesList ;$1)
End if 
$y_campo:=$1


RESOLVE POINTER:C394($y_campo;$t_nombreVariable;$l_NumeroTabla;$l_numeroCampo)
READ ONLY:C145([xShell_Fields:52])
QUERY:C277([xShell_Fields:52];[xShell_Fields:52]NumeroTabla:1=$l_NumeroTabla;*)
QUERY:C277([xShell_Fields:52]; & ;[xShell_Fields:52]NumeroCampo:2;=;$l_numeroCampo)
If ([xShell_Fields:52]ListaDeValoresAsociados:11#"")
	Case of 
		: ([xShell_Fields:52]ListaDeValoresAsociados:11="Usuarios")
			ARRAY POINTER:C280(<>aChoicePtrs;1)
			<>aChoicePtrs{1}:=-><>aUsers
			TBL_ShowChoiceList (0;"Usuarios")
			If ((ok=1) & (choiceIdx>0))
				atQRY_ValorLiteral{atQRY_ValorLiteral}:=<>aChoicePtrs{1}->{choiceIdx}
				vtQRY_ValorLiteral:=<>aChoicePtrs{1}->{choiceIdx}
			End if 
			
		Else 
			ARRAY POINTER:C280(<>aChoicePtrs;0)
			ARRAY POINTER:C280(<>aChoicePtrs;1)
			<>aChoicePtrs{1}:=Get pointer:C304([xShell_Fields:52]ListaDeValoresAsociados:11)
			ARRAY TEXT:C222($at_Texto_ordenPreservado;0)
			COPY ARRAY:C226(<>aChoicePtrs{1}->;$at_Texto_ordenPreservado)
			$t_nombreCampo:=XSvs_nombreCampoLocal_Numero ($l_NumeroTabla;$l_numeroCampo)
			TBL_ShowChoiceList (0;$t_nombreCampo;-MAXINT:K35:1)
			If ((ok=1) & (choiceIdx>0))
				If ((Type:C295($1->)=Is integer:K8:5) | (Type:C295($1->)=Is longint:K8:6) | (Type:C295($1->)=Is real:K8:4))
					vtQRY_ValorLiteral:=String:C10(aIndex{choiceIdx})+" ("+<>aChoicePtrs{1}->{choiceIdx}+")"
				Else 
					atQRY_ValorLiteral{atQRY_ValorLiteral}:=<>aChoicePtrs{1}->{choiceIdx}
					vtQRY_ValorLiteral:=<>aChoicePtrs{1}->{choiceIdx}
				End if 
			End if 
			COPY ARRAY:C226($at_Texto_ordenPreservado;<>aChoicePtrs{1}->)
	End case 
End if 
