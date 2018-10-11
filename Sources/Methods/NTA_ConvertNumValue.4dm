//%attributes = {}
  //NTA_ConvertNumValue

Case of 
	: (Count parameters:C259>=10)
		$0:=NTA_convertNum2value ($1;$2;$3;$4;$5;$6;$7;$8;$9;$10)
	: (Count parameters:C259>=9)
		$0:=NTA_convertNum2value ($1;$2;$3;$4;$5;$6;$7;$8;$9)
	: (Count parameters:C259>=8)
		$0:=NTA_convertNum2value ($1;$2;$3;$4;$5;$6;$7;$8)
	Else 
		$0:=NTA_convertNum2value ($1;$2;$3;$4;$5;$6;$7)
End case 

