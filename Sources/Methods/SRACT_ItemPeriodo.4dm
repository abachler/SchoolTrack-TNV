//%attributes = {}
  //SRACT_ItemPeriodo

C_TEXT:C284($t_periodo)
C_POINTER:C301($y_pointer2String;$y_pointer2Num)
ARRAY TEXT:C222(atACT_PeriodosItems;0)
ARRAY TEXT:C222(atACT_ItemNamesRep;0)
ARRAY LONGINT:C221(alACT_ItemsIDsRep;0)

READ ONLY:C145([xxACT_Items:179])

If (Count parameters:C259>=1)
	$t_periodo:=$1
End if 

If (Count parameters:C259>=2)
	$y_pointer2String:=$2
End if 

If (Count parameters:C259>=3)
	$y_pointer2Num:=$3
End if 

If ($t_periodo="")
	$t_periodo:=PREF_fGet (0;"ACT_pref_filtroItems";"Todos")
End if 

QUERY:C277([xxACT_Items:179];[xxACT_Items:179]EsRelativo:5=False:C215)
DISTINCT VALUES:C339([xxACT_Items:179]Periodo:42;atACT_PeriodosItems)
SORT ARRAY:C229(atACT_PeriodosItems;<)
AT_Insert (1;1;->atACT_PeriodosItems)
atACT_PeriodosItems{1}:=__ ("Todos")

If (($t_periodo#"Todos") & ($t_periodo#""))
	QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]Periodo:42=$t_periodo)
	atACT_PeriodosItems:=Find in array:C230(atACT_PeriodosItems;$t_periodo)
Else 
	atACT_PeriodosItems:=1
End if 

ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Glosa:2;>)
SELECTION TO ARRAY:C260([xxACT_Items:179]Glosa:2;atACT_ItemNamesRep;[xxACT_Items:179]ID:1;alACT_ItemsIDsRep)

If ((Not:C34(Is nil pointer:C315($y_pointer2String))) & (Not:C34(Is nil pointer:C315($y_pointer2Num))))
	If (Size of array:C274(atACT_ItemNamesRep)>0)
		$y_pointer2String->:=atACT_ItemNamesRep{1}
		$y_pointer2Num->:=alACT_ItemsIDsRep{1}
	Else 
		CD_Dlog (0;__ ("No existen definiciones de items de cargo."))
		CANCEL:C270
	End if 
End if 