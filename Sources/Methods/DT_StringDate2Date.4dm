//%attributes = {}
  //DT_StringDate2Date


$dateString:=ST_ClearSpaces ($1)

Case of 
	: (ST_CountWords ($dateString;1;"/")=3)
		$segment1:=ST_GetWord ($dateString;1;"/")
		$segment2:=ST_GetWord ($dateString;2;"/")
		$segment3:=ST_GetWord ($dateString;3;"/")
		
	: (ST_CountWords ($dateString;1;".")=3)
		$segment1:=ST_GetWord ($dateString;1;".")
		$segment2:=ST_GetWord ($dateString;2;".")
		$segment3:=ST_GetWord ($dateString;3;".")
		
	: (ST_CountWords ($dateString;1;",")=3)
		$segment1:=ST_GetWord ($dateString;1;",")
		$segment2:=ST_GetWord ($dateString;2;",")
		$segment3:=ST_GetWord ($dateString;3;",")
		
	: (ST_CountWords ($dateString;1;"-")=3)
		$segment1:=ST_GetWord ($dateString;1;"-")
		$segment2:=ST_GetWord ($dateString;2;"-")
		$segment3:=ST_GetWord ($dateString;3;"-")
		
	: (ST_CountWords ($dateString;1;" ")=3)
		$segment1:=ST_GetWord ($dateString;1;" ")
		$segment2:=ST_GetWord ($dateString;2;" ")
		$segment3:=ST_GetWord ($dateString;3;" ")
		
	Else 
		$segment1:=Substring:C12($dateString;1;2)
		$segment2:=Substring:C12($dateString;3;2)
		$segment3:=Substring:C12($dateString;5)
		
End case 



GET SYSTEM FORMAT:C994(System date short pattern:K60:7;$datepattern)
GET SYSTEM FORMAT:C994(Date separator:K60:10;dateSeparator)
$format:=Uppercase:C13(Replace string:C233($datepattern;dateSeparator;"/"))

Case of 
	: (($Format="DD/MM/YY") | ($Format="DD/MM/YYYY"))
		$day:=Num:C11($segment1)
		$month:=Num:C11($segment2)
		$year:=Num:C11($segment3)
		
	: ($Format="DD/YY/MM")
		$day:=Num:C11($segment1)
		$month:=Num:C11($segment3)
		$year:=Num:C11($segment2)
		
	: ($Format="MM/DD/YY")
		$day:=Num:C11($segment2)
		$month:=Num:C11($segment1)
		$year:=Num:C11($segment3)
		
	: ($Format="MM/YY/DD")
		$day:=Num:C11($segment2)
		$month:=Num:C11($segment3)
		$year:=Num:C11($segment1)
		
	: ($Format="YY/DD/MM")
		$day:=Num:C11($segment3)
		$month:=Num:C11($segment1)
		$year:=Num:C11($segment2)
		
	: ($Format="YY/MM/DD")
		$day:=Num:C11($segment3)
		$month:=Num:C11($segment2)
		$year:=Num:C11($segment1)
End case 

$date:=DT_GetDateFromDayMonthYear ($day;$month;$year)
$dateString:=DT_StrDateIsOK (String:C10($date);False:C215)  //verifico que la fecha sea válida

$0:=Date:C102($dateString)