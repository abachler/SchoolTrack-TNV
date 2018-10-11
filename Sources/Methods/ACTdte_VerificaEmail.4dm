//%attributes = {}
  //ACTdte_VerificaEmail 

C_LONGINT:C283($l_indice)
C_TEXT:C284($t_mail;$t_mailOrg;$0;$1)
ARRAY TEXT:C222($at_smtpTo;0)

$t_mail:=""

$t_mailOrg:=$1
$b_mostrarError:=$2

$t_mailOrg:=ST_GetCleanString ($t_mailOrg)
$t_mailOrg:=Replace string:C233($t_mailOrg;" ";"")
$t_mailOrg:=Replace string:C233($t_mailOrg;",";";")
$t_mailOrg:=Replace string:C233($t_mailOrg;";;";";")

AT_Text2Array (->$at_smtpTo;$t_mailOrg;";")

For ($l_indice;1;Size of array:C274($at_smtpTo))
	If (SMTP_VerifyEmailAddress ($at_smtpTo{$l_indice};$b_mostrarError)#"")
		$t_mail:=$t_mail+Choose:C955($t_mail="";"";";")+SMTP_VerifyEmailAddress ($at_smtpTo{$l_indice};False:C215)
	End if 
End for 

If (Substring:C12($t_mail;Length:C16($t_mail))=";")
	$t_mail:=Substring:C12($t_mail;1;Length:C16($t_mail)-1)
End if 

$0:=$t_mail