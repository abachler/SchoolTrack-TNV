<>ST_v500b61:=False:C215  //5/11/98 at 17:26:39 by: Alberto Bachler
Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY POINTER:C280(<>aDaysPtr;42)
		bGrid:=0
		For ($i;1;42)
			<>aDaysPtr{$i}:=Get pointer:C304("iDay"+String:C10($i))
		End for 
		$m:=Month of:C24(Current date:C33(*))
		lastM:=$m
		lastYear:=Year of:C25(Current date:C33(*))
		smonth:=<>atXS_MonthNames{$m}+" "+String:C10(lastYear)
		$d1:=DT_GetDateFromDayMonthYear (1;$m;Year of:C25(Current date:C33(*)))
		$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 (Current date:C33(*));$m;Year of:C25(Current date:C33(*)))
		iFirstDay:=Day number:C114($d1)
		If (iFirstDay=1)
			iFirstDay:=7
		Else 
			iFirstDay:=iFirstDay-1
		End if 
		$dj:=iFirstDay+(Current date:C33(*)-$d1)
		iLastDay:=iFirstDay+($d2-$d1)
		$j:=1
		For ($i;iFirstDay-1;1;-1)
			<>aDaysPtr{$i}->:=Day of:C23($d1-$j)
			OBJECT SET COLOR:C271(<>aDaysPtr{$i}->;-14)
			$j:=$j+1
		End for 
		$j:=0
		For ($i;iFirstDay;iLastDay)
			<>aDaysPtr{$i}->:=Day of:C23($d1+$j)
			OBJECT SET COLOR:C271(<>aDaysPtr{$i}->;-15)
			$j:=$j+1
		End for 
		$j:=1
		For ($i;iLastDay+1;42)
			<>aDaysPtr{$i}->:=Day of:C23($d2+$j)
			$j:=$j+1
			OBJECT SET COLOR:C271(<>aDaysPtr{$i}->;-14)
		End for 
		For ($i;6;42;7)
			If (($i>=iFirstDay) & ($i<=iLastDay))
				OBJECT SET COLOR:C271(<>aDaysPtr{$i}->;-4)
			End if 
			If (($i>=iFirstDay) & ($i<=iLastDay))
				OBJECT SET COLOR:C271(<>aDaysPtr{$i+1}->;-3)
			End if 
		End for 
		OBJECT SET COLOR:C271(<>aDaysPtr{$dj}->;-6)
		OBJECT SET TITLE:C194(bToday;__ ("Hoy: ")+String:C10(Current date:C33(*);2))
		bCalGrid:=0
		
		
		
	: (Form event:C388=On Deactivate:K2:10)
		CANCEL:C270
End case 
