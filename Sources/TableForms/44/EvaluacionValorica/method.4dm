_O_C_STRING:C293(60;sValor1;sValor2;sValor3;sValor4;sValor5;sValor6)
_O_C_STRING:C293(3;sAbrevV1M;sAbrevV2;sAbrevV3;sAbrevV4;sAbrevV5;sAbrevV6)
_O_C_STRING:C293(2;sEvValor1;sEvValor2;sEvValor3;sEvValor4)
_O_C_STRING:C293(60;<>sEvDesc1;<>sEvDesc2;<>sEvDesc3;<>sEvDesc4)

Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		C_TEXT:C284(thetext)
		_O_ARRAY STRING:C218(60;<>aVIndic;0)
		_O_ARRAY STRING:C218(60;<>aValores;0)
		_O_ARRAY STRING:C218(2;<>aEscalaV;0)
		_O_ARRAY STRING:C218(3;<>aAbrevVal;0)
		BLOB_Blob2Vars (->[xxSTR_Constants:1]xIndicadoresEvValorica:37;0;-><>aValores;-><>aEscalaV;-><>aVIndic;-><>aAbrevVal;-><>sEvalExpl;-><>sEvalExpl1;-><>cb_EvalLibre)
		_O_ARRAY STRING:C218(60;<>aValores;6)
		_O_ARRAY STRING:C218(2;<>aEscalaV;4)
		_O_ARRAY STRING:C218(60;<>aVIndic;4)
		_O_ARRAY STRING:C218(3;<>aAbrevVal;6)
		For ($i;1;Size of array:C274(<>aValores))
			(Get pointer:C304("sValor"+String:C10($i)))->:=<>aValores{$i}
			(Get pointer:C304("sAbrevV"+String:C10($i)))->:=<>aAbrevVal{$i}
		End for 
		For ($i;1;Size of array:C274(<>aEscalaV))
			(Get pointer:C304("sEvValor"+String:C10($i)))->:=<>aEscalaV{$i}
			(Get pointer:C304("sEvDesc"+String:C10($i)))->:=<>aVindic{$i}
		End for 
End case 
