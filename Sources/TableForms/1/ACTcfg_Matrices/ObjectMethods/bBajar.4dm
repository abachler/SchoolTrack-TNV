AL_UpdateArrays (xALP_ItemsMatriz;0)

$temp1:=alACT_IDItemMatriz{line}
$temp2:=atACT_GlosaItemMatriz{line}
$temp3:=arACT_AmountItemMatriz{line}
$temp4:=atACT_MonedaItemMatriz{line}
$temp5:=abACT_IsDiscountItemMatriz{line}
$temp6:=abACT_IsPercentItemMatriz{line}
$temp7:=abACT_esDescontable{line}
$temp8:=alACT_RecNumItems{line}

alACT_IDItemMatriz{line}:=alACT_IDItemMatriz{line+1}
atACT_GlosaItemMatriz{line}:=atACT_GlosaItemMatriz{line+1}
arACT_AmountItemMatriz{line}:=arACT_AmountItemMatriz{line+1}
atACT_MonedaItemMatriz{line}:=atACT_MonedaItemMatriz{line+1}
abACT_IsDiscountItemMatriz{line}:=abACT_IsDiscountItemMatriz{line+1}
abACT_IsPercentItemMatriz{line}:=abACT_IsPercentItemMatriz{line+1}
abACT_esDescontable{line}:=abACT_esDescontable{line+1}
alACT_RecNumItems{line}:=alACT_RecNumItems{line+1}

alACT_IDItemMatriz{line+1}:=$temp1
atACT_GlosaItemMatriz{line+1}:=$temp2
arACT_AmountItemMatriz{line+1}:=$temp3
atACT_MonedaItemMatriz{line+1}:=$temp4
abACT_IsDiscountItemMatriz{line+1}:=$temp5
abACT_IsPercentItemMatriz{line+1}:=$temp6
abACT_esDescontable{line+1}:=$temp7
alACT_RecNumItems{line+1}:=$temp8

AL_UpdateArrays (xALP_ItemsMatriz;-2)
ACTcfg_SortMatrixItems 
AL_SetLine (xALP_ItemsMatriz;line+1)
ACTcfg_TestMatrixButtons 