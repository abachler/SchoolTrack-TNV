//%attributes = {}
  //ACTbol_FiltraCargos
$SetdeRegistros:=$1

USE SET:C118($SetdeRegistros)
FIRST RECORD:C50([ACT_Avisos_de_Cobranza:124])
While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
	If ([ACT_Avisos_de_Cobranza:124]Monto_Neto:11<0)
		REMOVE FROM SET:C561([ACT_Avisos_de_Cobranza:124];$SetdeRegistros)
	End if 
	NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
End while 
USE SET:C118($SetdeRegistros)
ARRAY LONGINT:C221($al_RecNumRegistros;0)
LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_RecNumRegistros;"")
COPY ARRAY:C226($al_RecNumRegistros;$2->)