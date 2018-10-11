//%attributes = {}
  //BBLlbm_FormatoMarbete

[BBL_Items:61]Clasificacion:2:=Replace string:C233(ST_ClearSpaces ([BBL_Items:61]Clasificacion:2);" ";"\r")
[BBL_Items:61]Clasificacion:2:=[BBL_Items:61]Clasificacion:2+"\r"+"c. "+String:C10([BBL_Registros:66]Número_de_copia:2)