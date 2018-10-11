
Case of 
	: (Form event:C388=On Load:K2:1)
		XS_SetInterface 
		_O_C_STRING:C293(60;sValor1;sValor2;sValor3;sValor4;sValor5;sValor6)
		_O_C_STRING:C293(3;sAbrevV1M;sAbrevV2;sAbrevV3;sAbrevV4;sAbrevV5;sAbrevV6)
		_O_C_STRING:C293(2;sEvValor1;sEvValor2;sEvValor3;sEvValor4)
		_O_C_STRING:C293(60;<>sEvDesc1;<>sEvDesc2;<>sEvDesc3;<>sEvDesc4)
		_O_ARRAY STRING:C218(60;<>aXCRCcept;6)
		_O_ARRAY STRING:C218(3;<>aXCRAbrv;6)
		_O_ARRAY STRING:C218(60;<>aXCRInd;4)
		_O_ARRAY STRING:C218(2;<>aXCRAbrvInd;4)
		READ WRITE:C146([xxSTR_Constants:1])
		LOAD RECORD:C52([xxSTR_Constants:1])
		BLOB_Blob2Vars (->[xxSTR_Constants:1]xIndicadoresEvExtra:39;0;-><>aXCRCcept;-><>aXCRAbrv;-><>aXCRInd;-><>aXCRAbrvInd;-><>sXCRExpl1;-><>sXCRExpl2)
		_O_ARRAY STRING:C218(60;<>aXCRCcept;6)
		_O_ARRAY STRING:C218(3;<>aXCRAbrv;6)
		_O_ARRAY STRING:C218(2;<>aXCRAbrvInd;4)
		_O_ARRAY STRING:C218(60;<>aXCRInd;4)
		
		For ($i;1;Size of array:C274(<>aXCRCcept))
			(Get pointer:C304("sValor"+String:C10($i)))->:=<>aXCRCcept{$i}
			(Get pointer:C304("sAbrevV"+String:C10($i)))->:=<>aXCRAbrv{$i}
		End for 
		For ($i;1;Size of array:C274(<>aXCRInd))
			(Get pointer:C304("sEvValor"+String:C10($i)))->:=<>aXCRAbrvInd{$i}
			(Get pointer:C304("sEvDesc"+String:C10($i)))->:=<>aXCRInd{$i}
		End for 
End case 
