//%attributes = {"invisible":true,"shared":true}
C_TEXT:C284($1;$in)
C_TEXT:C284($0;$out)

$in:=$1

C_LONGINT:C283($i;$level)

$level:=0

$tab:=Char:C90(Space:K15:42)*2

$i:=1

ARRAY LONGINT:C221($pos;0)
ARRAY LONGINT:C221($len;0)

ON ERR CALL:C155("ERR_GenericOnError")
While (Match regex:C1019("(?m)^(.*)$";$in;$i;$pos;$len))
	
	$line:=Substring:C12($in;$pos{1};$len{1})
	If (Length:C16($line)#0)
		$i:=$pos{1}+$len{1}
	Else 
		$i:=$i+2
	End if 
	
	Case of 
		: (Match regex:C1019("(?mi)(^\\s*If.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Si.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Else.*)";$line))
		: (Match regex:C1019("(?mi)(^\\s*Sinon.*)";$line))
		: (Match regex:C1019("(?mi)(^\\s*End if.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Fin de si.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Repeat.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Repeter.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Until.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Jusque.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*While.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Tant que.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*End while.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Fin tant que.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*For.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Boucle.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*End for.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Fin de boucle.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Begin SQL.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Debut SQL.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*End SQL.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Fin SQL.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Case of.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*Au cas ou.*)";$line))
			$level:=$level+1
		: (Match regex:C1019("(?mi)(^\\s*End case.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
		: (Match regex:C1019("(?mi)(^\\s*Fin de cas.*)";$line))
			$level:=$level-1
			$out:=Delete string:C232($out;Length:C16($out);1)
	End case 
	$out:=$out+$line+"\n"+($tab*$level)
End while 

  //CODE HIGHLIGHT ($out;$out)

$0:=$out
ON ERR CALL:C155("")