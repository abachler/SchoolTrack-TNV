//%attributes = {}
  //BKPs3_EscribeLog

If (Undefined:C82(<>atBKPaws_log))
	ARRAY TEXT:C222(<>atBKPaws_log;0)
End if 

AT_Insert (1;1;-><>atBKPaws_log)

<>atBKPaws_log{1}:=Timestamp:C1445+"\t"+$1
AT_Delete (1001;1;-><>atBKPaws_log)
  //SET TEXT TO PASTEBOARD(AT_array2text (-><>atBKPaws_log;"\n"))