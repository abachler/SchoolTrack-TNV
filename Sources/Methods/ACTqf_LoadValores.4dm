//%attributes = {}
  //ACTqf_LoadValores

C_LONGINT:C283($1;$Campo)
ARRAY TEXT:C222(aValoresQFDocumentos;0)
$Campo:=$1
Case of 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
		Case of 
			: ($Campo=1)
			: ($Campo=2)
				ARRAY TEXT:C222(aValoresQFDocumentos;0)
				KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Documentos_en_Cartera:182]ID_Apoderado:2;"")
				AT_DistinctsFieldValues (->[Personas:7]Apellidos_y_nombres:30;->aValoresQFDocumentos)
			: ($Campo=3)
				ARRAY TEXT:C222(aValoresQFDocumentos;4)
				aValoresQFDocumentos{1}:="Al día"
				aValoresQFDocumentos{2}:="A fecha"
				aValoresQFDocumentos{3}:="Vencidos"
				aValoresQFDocumentos{4}:="Protestados"
			: ($Campo=4)
				ARRAY TEXT:C222(aValoresQFDocumentos;0)
				AT_DistinctsFieldValues (->[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8;->aValoresQFDocumentos)
			: ($Campo=5)
			: ($Campo=6)
			: ($Campo=7)
			: ($Campo=8)
				COPY ARRAY:C226(atACT_BankName;aValoresQFDocumentos)
				SORT ARRAY:C229(aValoresQFDocumentos;>)
		End case 
	: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
		Case of 
			: ($Campo=1)
			: ($Campo=2)
				COPY ARRAY:C226(atACT_BankName;aValoresQFDocumentos)
				SORT ARRAY:C229(aValoresQFDocumentos;>)
			: ($Campo=3)
			: ($Campo=4)
			: ($Campo=5)
		End case 
End case 