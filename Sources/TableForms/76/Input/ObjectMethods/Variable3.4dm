
Case of 
	: ([xShell_Userfields:76]FieldType:2=0)
		If (Length:C16(sUFvalue)>70)
			sUFvalue:=Substring:C12(sUFValue;1;70)
			  //       $r:=cd_Dlog (0;Remplacer chaine(◊aStrConst{43};"^0";"70"))

		End if 
	: ([xShell_Userfields:76]FieldType:2=4)
		sUFvalue:=DT_StrDateIsOK (sUFvalue)
		If (sUFvalue="00/0/00")
			sUFvalue:=""
		End if 
	: ([xShell_Userfields:76]FieldType:2=1)
		If (Round:C94(Abs:C99(Num:C11(sUfValue));2)>99999999999.99)
			  //       $r:=cd_Dlog (0;◊aStrConst{46};"-99 999 999 999,99"+Caractere(13)+"+99 999

			sUFvalue:=""
		Else 
			sUFvalue:=String:C10(Round:C94(Num:C11(sUFValue);2);"|Real")
		End if 
	: ([xShell_Userfields:76]FieldType:2=9)
		If (Abs:C99(Num:C11(sUfValue))>99999999999)
			  //       $r:=cd_Dlog (0;◊aStrConst{46};"-99 999 999 999"+Caractere(13)+"+99 999 99

			sUFvalue:=""
		Else 
			sUFvalue:=String:C10(Round:C94(Num:C11(sUFValue);0);"|Entero")
		End if 
End case 