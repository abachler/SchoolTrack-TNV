
$cell:=Self:C308->

Case of 
	: ($cell<iFirstDay)
		If (lastM=1)
			dDate:=DT_GetDateFromDayMonthYear (<>aDaysPtr{$cell}->;12;LastYear-1)
		Else 
			dDate:=DT_GetDateFromDayMonthYear (<>aDaysPtr{$cell}->;lastM-1;LastYear)
		End if 
	: ($cell>iLastDay)
		If (lastM=12)
			dDate:=DT_GetDateFromDayMonthYear (<>aDaysPtr{$cell}->;1;LastYear+1)
		Else 
			dDate:=DT_GetDateFromDayMonthYear (<>aDaysPtr{$cell}->;lastM+1;LastYear)
		End if 
	Else 
		dDate:=DT_GetDateFromDayMonthYear (<>aDaysPtr{$cell}->;lastM;LastYear)
End case 
ACCEPT:C269