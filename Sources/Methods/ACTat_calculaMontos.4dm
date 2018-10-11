//%attributes = {}
  //ACTat_calculaMontos

  //no se utiliza
  //C_POINTER($2;$3)
  //C_DATE($vd_fecha)
  //C_LONGINT($j)
  //C_REAL($vr_montoMP;$0)
  //$vl_saldoMonedaCargo:=1
  //$vl_saldoMonedaColegio:=0
  //  `$1 accion 
  //  `$2 àrreglo con moneda
  //  `$3 arreglo con montos
  //  `$4 fecha
  //$vd_fecha:=$4
  //ARRAY REAL($ar_sumaMontos;0)
  //ARRAY TEXT($at_monedaCargos;0)
  //ARRAY TEXT($at_monedaCargos2;0)
  //COPY ARRAY($2->;$at_monedaCargos)
  //COPY ARRAY($at_monedaCargos;$at_monedaCargos2)
  //AT_DistinctsArrayValues (->$at_monedaCargos)
  //For ($i;1;Size of array($at_monedaCargos))
  //AT_Insert (0;1;->$ar_sumaMontos)
  //$at_monedaCargos2{0}:=$at_monedaCargos{$i}
  //AT_SearchArray (->$at_monedaCargos2;"=")
  //For ($j;1;Size of array(DA_Return))
  //  `6++96+ Vichin 20080322
  //  `If ($ar_montoNeto{DA_Return{$j}}>0)
  //$ar_sumaMontos{$i}:=$ar_sumaMontos{$i}+$3->{DA_Return{$j}}
  //End for 
  //End for 
  //Case of 
  //: ($1="monedaxdefecto")
  //For ($i;1;Size of array($ar_sumaMontos))
  //If ($at_monedaCargos{$i}=<>vsACT_MonedaColegio)
  //$0:=$0+$ar_sumaMontos{$i}
  //Else 
  //$0:=$0+ACTut_retornaMontoEnMoneda ($ar_sumaMontos{$i};$at_monedaCargos{$i};$vd_fecha;<>vsACT_MonedaColegio;$vd_fecha)
  //End if 
  //End for 
  //: ($1="monedaPais")
  //For ($i;1;Size of array($ar_sumaMontos))
  //If ($at_monedaCargos{$i}=ST_GetWord (ACT_DivisaPais ;1;";"))
  //$0:=$0+$ar_sumaMontos{$i}
  //Else 
  //$0:=$0+ACTut_retornaMontoEnMoneda ($ar_sumaMontos{$i};$at_monedaCargos{$i};$vd_fecha;ST_GetWord (ACT_DivisaPais ;1;";");$vd_fecha)
  //End if 
  //End for 
  //End case 