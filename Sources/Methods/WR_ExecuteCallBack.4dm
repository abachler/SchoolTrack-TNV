//%attributes = {}
  //WR_ExecuteCallBack

C_LONGINT:C283($1;$2;$area;$command)
$area:=$1
$command:=$2

Case of 
	: ($command=wr cmd open:K12007:12)
		QR_OpenReport 
	: ($command=wr cmd save as:K12007:14)
		QR_SaveReportAs 
	: ($command=wr cmd save:K12007:13)
		QR_SaveReport 
		  //: ($command=wr cmd insert 4D expression )
		  //WR_EditExpression 
	Else 
		WR EXECUTE COMMAND:P12000:113 ($area;$command)
End case 