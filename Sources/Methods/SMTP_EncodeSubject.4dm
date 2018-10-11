//%attributes = {}
  //SMTP_EncodeSubject

$subject:=$1
$subjectQ:=""
For ($i;1;Length:C16($subject))
	If (Character code:C91(Substring:C12($subject;$i;1))<127)
		$subjectQ:=$subjectQ+(Substring:C12($subject;$i;1))
	Else 
		$subjectQ:=$subjectQ+"="+Substring:C12(String:C10(Character code:C91(_O_Mac to Win:C463(Substring:C12($subject;$i;1)));"&X");5;2)
	End if 
End for 
$0:="=?iso-8859-1?Q?"+$subjectQ+"?="