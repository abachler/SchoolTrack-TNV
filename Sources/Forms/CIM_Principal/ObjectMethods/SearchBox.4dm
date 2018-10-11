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
		CIM_Log_FiltraEventos 
		
	: ($l_evento=-On Clicked:K2:4)
		If (Contextual click:C713)
			$l_Glass:=(OBJECT Get pointer:C1124(Object named:K67:5;"Glass";"SearchBox"))->
		End if 
End case 

