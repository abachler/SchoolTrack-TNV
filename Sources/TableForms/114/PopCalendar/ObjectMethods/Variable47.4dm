If (Self:C308->>0)
	$m:=Self:C308->
	lastm:=$m
	lastYear:=<>gYear
	smonth:=<>atXS_MonthNames{$m}+" "+String:C10(lastYear)
	$d1:=DT_GetDateFromDayMonthYear (1;$m;lastYear)
	$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($d1);$m;Year of:C25($d1))
	iFirstDay:=Day number:C114($d1)
	If (iFirstDay=1)
		iFirstDay:=7
	Else 
		iFirstDay:=iFirstDay-1
	End if 
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
	$d1:=DT_GetDateFromDayMonthYear (1;$m;lastYear)
	$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($d1);$m;Year of:C25($d1))
	iFirstDay:=Day number:C114($d1)
	If (iFirstDay=1)
		iFirstDay:=7
	Else 
		iFirstDay:=iFirstDay-1
	End if 
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
			If ((lastM=Month of:C24(Current date:C33)) & (lastYear=Year of:C25(Current date:C33)))
				$dj:=iFirstDay+(Current date:C33-$d1)
				OBJECT SET COLOR:C271(<>aDaysPtr{$dj}->;-6)
			End if 
		End if 
	End for 
End if 