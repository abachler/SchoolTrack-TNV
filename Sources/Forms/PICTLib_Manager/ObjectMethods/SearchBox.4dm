  // CIM_Principal.Subformulario()
  // Por: Alberto Bachler Klein: 21-10-15, 09:41:36
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_Glass;$l_evento)
C_TEXT:C284($t_Texto)

$l_evento:=SearchBox_FormEvent (OBJECT Get name:C1087(Object current:K67:2))
SearchBox_EnableButton (OBJECT Get name:C1087(Object current:K67:2);True:C214)

Case of 
	: ($l_evento=On Data Change:K2:15)
		SearchBox_EnableButton (OBJECT Get name:C1087(Object current:K67:2);True:C214)
		$t_Texto:=(OBJECT Get pointer:C1124(Object named:K67:5;"SearchBox"))->
		$l_number:=ST_String_IsNumber ($t_Texto)
		If ($l_number>0)
			QUERY:C277([ACT_CFG_DctosIndividuales:229];[ACT_CFG_DctosIndividuales:229]DTS_Modificacion:4;=;Num:C11($t_texto))
		Else 
			QUERY:C277([ACT_CFG_DctosIndividuales:229];[ACT_CFG_DctosIndividuales:229]Auto_UUID:2;=;"@"+$t_texto+"@")
		End if 
		
		
	: ($l_evento=-On Clicked:K2:4)
		If (Contextual click:C713)
			$l_Glass:=(OBJECT Get pointer:C1124(Object named:K67:5;"Glass";"SearchBox"))->
		End if 
End case 

