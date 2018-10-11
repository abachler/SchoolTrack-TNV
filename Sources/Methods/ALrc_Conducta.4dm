//%attributes = {}
  //ALrc_Conducta

C_LONGINT:C283($vlTotal)
C_LONGINT:C283($abs1;$abs2;$abs3;$abs4;$vl_DiasInasistencias)
C_LONGINT:C283($horasAbs1;$horasAbs2;$horasAbs3;$horasAbs4;$vl_HorasInasistencias)
C_LONGINT:C283($totalNegativas;$negativas1;$negativas2;$negativas3;$negativas4)
C_LONGINT:C283($totalpositivas;$positivas1;$positivas2;$positivas3;$positivas4)
C_LONGINT:C283($totalcastigos;$castigos1;$castigos2;$castigos3;$castigos4)
C_LONGINT:C283($totalsuspensiones;$suspensiones1;$suspensiones2;$suspensiones3;$suspensiones4)
C_LONGINT:C283($atrasos1;$atrasos2;$atrasos3;$atrasos4;$vl_Atrasos)
C_REAL:C285($porcentajeAsistencia1;$porcentajeAsistencia1;$porcentajeAsistencia2;$porcentajeAsistencia3;$porcentajeAsistencia4;$porcentajeAsistencia)

$s:=Size of array:C274(aValores)
PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
$0:=0

$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)


$abs1:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Dias:97
$horasAbs1:=[Alumnos_SintesisAnual:210]P01_Inasistencias_Horas:98
$porcentajeAsistencia1:=[Alumnos_SintesisAnual:210]P01_PorcentajeAsistencia:100
$atrasos1:=[Alumnos_SintesisAnual:210]P01_Atrasos_Sesiones:108+[Alumnos_SintesisAnual:210]P01_Atrasos_Jornada:107
$negativas1:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Negativas:103
$positivas1:=[Alumnos_SintesisAnual:210]P01_Anotaciones_Positivas:101
$castigos1:=[Alumnos_SintesisAnual:210]P01_Castigos:110
$suspensiones1:=[Alumnos_SintesisAnual:210]P01_Suspensiones:111

$abs2:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Dias:126
$horasAbs2:=[Alumnos_SintesisAnual:210]P02_Inasistencias_Horas:127
$porcentajeAsistencia2:=[Alumnos_SintesisAnual:210]P02_PorcentajeAsistencia:129
$atrasos2:=[Alumnos_SintesisAnual:210]P02_Atrasos_Sesiones:137+[Alumnos_SintesisAnual:210]P02_Atrasos_Jornada:136
$negativas2:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Negativas:132
$positivas2:=[Alumnos_SintesisAnual:210]P02_Anotaciones_Positivas:130
$castigos2:=[Alumnos_SintesisAnual:210]P02_Castigos:139
$suspensiones2:=[Alumnos_SintesisAnual:210]P02_Suspensiones:140

$abs3:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Dias:155
$horasAbs3:=[Alumnos_SintesisAnual:210]P03_Inasistencias_Horas:156
$porcentajeAsistencia3:=[Alumnos_SintesisAnual:210]P03_PorcentajeAsistencia:158
$atrasos3:=[Alumnos_SintesisAnual:210]P03_Atrasos_Sesiones:166+[Alumnos_SintesisAnual:210]P03_Atrasos_Jornada:165
$negativas3:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Negativas:161
$positivas3:=[Alumnos_SintesisAnual:210]P03_Anotaciones_Positivas:159
$castigos3:=[Alumnos_SintesisAnual:210]P03_Castigos:168
$suspensiones3:=[Alumnos_SintesisAnual:210]P03_Suspensiones:169

$abs4:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Dias:184
$horasAbs4:=[Alumnos_SintesisAnual:210]P04_Inasistencias_Horas:185
$porcentajeAsistencia4:=[Alumnos_SintesisAnual:210]P04_PorcentajeAsistencia:187
$atrasos4:=[Alumnos_SintesisAnual:210]P04_Atrasos_Sesiones:195+[Alumnos_SintesisAnual:210]P04_Atrasos_Jornada:194
$negativas4:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Negativas:190
$positivas4:=[Alumnos_SintesisAnual:210]P04_Anotaciones_Positivas:188
$castigos4:=[Alumnos_SintesisAnual:210]P04_Castigos:197
$suspensiones4:=[Alumnos_SintesisAnual:210]P04_Suspensiones:198

$abs5:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Dias:213
$horasAbs5:=[Alumnos_SintesisAnual:210]P05_Inasistencias_Horas:214
$porcentajeAsistencia5:=[Alumnos_SintesisAnual:210]P05_PorcentajeAsistencia:216
$atrasos5:=[Alumnos_SintesisAnual:210]P05_Atrasos_Sesiones:224+[Alumnos_SintesisAnual:210]P05_Atrasos_Jornada:223
$negativas5:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Negativas:219
$positivas5:=[Alumnos_SintesisAnual:210]P05_Anotaciones_Positivas:217
$castigos5:=[Alumnos_SintesisAnual:210]P05_Castigos:226
$suspensiones5:=[Alumnos_SintesisAnual:210]P05_Suspensiones:227

$porcentajeAsistencia:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33

$vl_DiasInasistencias:=[Alumnos_SintesisAnual:210]Inasistencias_Dias:30
$vl_HorasInasistencias:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
$vl_Atrasos:=[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41+[Alumnos_SintesisAnual:210]Atrasos_Jornada:40
$totalNegativas:=[Alumnos_SintesisAnual:210]Anotaciones_Negativas:36
$totalPositivas:=[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34
$totalCastigos:=[Alumnos_SintesisAnual:210]Castigos:43
$totalSuspensiones:=[Alumnos_SintesisAnual:210]Suspensiones:44

$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
$modoRegistroAtrasos:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]Lates_Mode:16)
If (aCdtaPrints{1})  //porcentaje de aisistencia
	$0:=$0+1
	$s:=$s+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	aValores{$s}:="   "+aCdtaTitles{1}
	
	aEvalInfo1{$s}:=String:C10($porcentajeAsistencia1;"##0,0")
	aEvalInfo2{$s}:=String:C10($porcentajeAsistencia2;"##0,0")
	aEvalInfo3{$s}:=String:C10($porcentajeAsistencia3;"##0,0")
	aEvalInfo4{$s}:=String:C10($porcentajeAsistencia4;"##0,0")
	
	aEvalFinal{$s}:=String:C10($porcentajeAsistencia;"##0,0")
End if 


If (aCdtaPrints{2})  //inasistencias
	$s:=$s+1
	$0:=$0+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aValores{$s}:="   "+aCdtaTitles{2}
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	Case of 
		: ($modoRegistroAsistencia=1)  // dias
			
			aEvalInfo1{$s}:=String:C10($abs1)
			aEvalInfo2{$s}:=String:C10($abs2)*(Num:C11((vPeriodo=2) | (vPeriodo=3) | (vPeriodo=4)))
			aEvalInfo3{$s}:=String:C10($abs3)*(Num:C11((vPeriodo=3) | (vPeriodo=4)))
			aEvalInfo4{$s}:=String:C10($abs4)*(Num:C11(vPeriodo=4))
			aEvalFinal{$s}:=String:C10($vl_DiasInasistencias)
			
		: ($modoRegistroAsistencia=3)  // anual      
			$pointer:=Get pointer:C304("aEvalInfo"+String:C10(vPeriodo))
			$pointer->{$s}:=String:C10($vl_DiasInasistencias)
			aEvalFinal{$s}:=String:C10($vl_DiasInasistencias)
			
		: ($modoRegistroAsistencia=2)  // horas
			aEvalInfo1{$s}:=String:C10($horasAbs1;"###0")+" (horas)"
			aEvalInfo2{$s}:=String:C10($horasAbs2;"###0")+" (horas)"
			aEvalInfo3{$s}:=String:C10($horasAbs3;"###0")+" (horas)"
			aEvalInfo4{$s}:=String:C10($horasAbs4;"###0")+" (horas)"
			aEvalFinal{$s}:=String:C10($vl_HorasInasistencias;"###0")+" (horas)"
			
	End case 
End if 

If (aCdtaPrints{3})  //atrasos
	$s:=$s+1
	$0:=$0+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	aValores{$s}:="   "+aCdtaTitles{3}
	If ($modoRegistroAtrasos=1)
		aEvalInfo1{$s}:=String:C10($atrasos1)
		aEvalInfo2{$s}:=String:C10($atrasos2)*(Num:C11((vPeriodo=2) | (vPeriodo=3) | (vPeriodo=4)))
		aEvalInfo3{$s}:=String:C10($atrasos3)*(Num:C11((vPeriodo=3) | (vPeriodo=4)))
		aEvalInfo4{$s}:=String:C10($atrasos4)*(Num:C11(vPeriodo=4))
		aEvalFinal{$s}:=String:C10($vl_Atrasos)  //*(Num(vPeriodo=◊iPeriodos))
	Else 
		$pointer:=Get pointer:C304("aEvalInfo"+String:C10(vPeriodo))
		$pointer->{$s}:=String:C10($vl_Atrasos)
		aEvalFinal{$s}:=String:C10($vl_Atrasos)
	End if 
End if 


If (aCdtaPrints{4})  //anotaciones positivas
	$s:=$s+1
	$0:=$0+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	aValores{$s}:="   "+aCdtaTitles{4}
	aEvalInfo1{$s}:=String:C10($positivas1)
	aEvalInfo2{$s}:=String:C10($positivas2)*(Num:C11((vPeriodo=2) | (vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo3{$s}:=String:C10($positivas3)*(Num:C11((vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo4{$s}:=String:C10($positivas4)*(Num:C11(vPeriodo=4))
	aEvalFinal{$s}:=String:C10($totalPositivas)  //*(Num(vPeriodo=◊iPeriodos))  
End if 

If (aCdtaPrints{5})  //anotaciones negativas
	$s:=$s+1
	$0:=$0+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	aValores{$s}:="   "+aCdtaTitles{5}
	aEvalInfo1{$s}:=String:C10($negativas1)
	aEvalInfo2{$s}:=String:C10($negativas2)*(Num:C11((vPeriodo=2) | (vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo3{$s}:=String:C10($negativas3)*(Num:C11((vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo4{$s}:=String:C10($negativas4)*(Num:C11(vPeriodo=4))
	aEvalFinal{$s}:=String:C10($totalNegativas)  //*(Num(vPeriodo=◊iPeriodos))  
End if 


If (aCdtaPrints{6})  //castigos
	$s:=$s+1
	$0:=$0+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	aValores{$s}:="   "+aCdtaTitles{6}
	aEvalInfo1{$s}:=String:C10($castigos1)
	aEvalInfo2{$s}:=String:C10($castigos2)*(Num:C11((vPeriodo=2) | (vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo3{$s}:=String:C10($castigos3)*(Num:C11((vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo4{$s}:=String:C10($castigos4)*(Num:C11(vPeriodo=4))
	aEvalFinal{$s}:=String:C10($totalCastigos)  //*(Num(vPeriodo=◊iPeriodos))  
End if 


If (aCdtaPrints{7})  //suspensiones
	$s:=$s+1
	$0:=$0+1
	AT_Insert ($s;1;->aValores;->aEvalInfo1;->aEvalInfo2;->aEvalInfo3;->aEvalInfo4;->aEvalFinal;->aEvalSort;->aEvalPos)
	aEvalSort{$s}:=1
	aEvalPos{$s}:=$s
	aValores{$s}:="   "+aCdtaTitles{7}
	aEvalInfo1{$s}:=String:C10($suspensiones1)
	aEvalInfo2{$s}:=String:C10($suspensiones2)*(Num:C11((vPeriodo=2) | (vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo3{$s}:=String:C10($suspensiones3)*(Num:C11((vPeriodo=3) | (vPeriodo=4)))
	aEvalInfo4{$s}:=String:C10($suspensiones4)*(Num:C11(vPeriodo=4))
	aEvalFinal{$s}:=String:C10($totalSuspensiones)  //*(Num(vPeriodo=◊iPeriodos))  
End if 
If ($0>0)
	$0:=$0+2
End if 