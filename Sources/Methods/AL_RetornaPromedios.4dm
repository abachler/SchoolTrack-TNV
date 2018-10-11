//%attributes = {}
  // Método: AL_RetornaPromedios
  //
  //
  // por Alberto Bachler Klein
  // creación 28/04/17, 08:50:23
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_TEXT:C284($4)
C_LONGINT:C283($5)
C_POINTER:C301($6)
C_POINTER:C301($7)
C_POINTER:C301($8)
C_POINTER:C301($9)
C_POINTER:C301($10)
C_POINTER:C301($11)
C_POINTER:C301($12)
C_POINTER:C301($13)
C_POINTER:C301($14)

C_LONGINT:C283($i;$l_decimalesNotas;$l_decimalesPuntos;$l_estiloEvaluacion;$l_maxNotas;$l_maxPuntos;$l_modoCalculo;$l_modoCalculoPromedio;$l_modoCalificacion;$l_modoImpresionOficial)
C_LONGINT:C283($l_numeroDecimales;$l_truncarPromedios)
C_POINTER:C301($y_ArregloPonderaciones;$y_arregloReales;$y_EstiloEvaluacionAsignatura;$y_MediaLiteral;$y_MediaNota;$y_MediaPuntos;$y_mediaReal;$y_MediaSimbolos;$y_NOf_conEstiloAsignatura)
C_REAL:C285($r_mediaNota;$r_mediaPuntos;$r_mediaReal;$r_real)
C_TEXT:C284($t_MediaLiteral;$t_MediaSimbolos;$t_tipoPromedio)
C_BOOLEAN:C305($b_usarNtaOficialAsignatura)

ARRAY REAL:C219($ar_reales;0)


If (False:C215)
	C_LONGINT:C283(AL_RetornaPromedios ;$1)
	C_LONGINT:C283(AL_RetornaPromedios ;$2)
	C_LONGINT:C283(AL_RetornaPromedios ;$3)
	C_TEXT:C284(AL_RetornaPromedios ;$4)
	C_LONGINT:C283(AL_RetornaPromedios ;$5)
	C_POINTER:C301(AL_RetornaPromedios ;$6)
	C_POINTER:C301(AL_RetornaPromedios ;$7)
	C_POINTER:C301(AL_RetornaPromedios ;$8)
	C_POINTER:C301(AL_RetornaPromedios ;$9)
	C_POINTER:C301(AL_RetornaPromedios ;$10)
	C_POINTER:C301(AL_RetornaPromedios ;$11)
	C_POINTER:C301(AL_RetornaPromedios ;$12)
	C_POINTER:C301(AL_RetornaPromedios ;$13)
	C_POINTER:C301(AL_RetornaPromedios ;$14)
End if 

$l_estiloEvaluacion:=$1
$l_modoCalificacion:=$2
$l_modoCalculoPromedio:=$3
$t_tipoPromedio:=$4
$l_truncarPromedios:=$5

$y_arregloReales:=$6
$y_ArregloPonderaciones:=$7
$y_mediaReal:=$8
$y_MediaNota:=$9
$y_MediaPuntos:=$10
$y_MediaLiteral:=$11
$y_MediaSimbolos:=$12

Case of 
	: (Count parameters:C259=14)
		$y_EstiloEvaluacionAsignatura:=$13
		$y_NOf_conEstiloAsignatura:=$14
	: (Count parameters:C259=13)
		$y_EstiloEvaluacionAsignatura:=$13
End case 


EVS_ReadStyleData ($l_estiloEvaluacion)
If (vrNTA_MinimoEscalaReferencia=0)
	$l_modoCalculo:=3
Else 
	$l_modoCalculo:=1
End if 
$r_maxNotas:=rGradesTo
$r_maxPuntos:=rPointsTo

Case of 
	: ($t_tipoPromedio="")
		$l_decimalesNotas:=11
		$l_decimalesPuntos:=11
	: ($t_tipoPromedio="PP")  // promedio Periodo
		$l_decimalesNotas:=iGradesDecPP
		$l_decimalesPuntos:=iPointsDecPP
	: ($t_tipoPromedio="PF")  // promedio final antes examenes
		$l_decimalesNotas:=iGradesDecPF
		$l_decimalesPuntos:=iPointsDecPF
	: ($t_tipoPromedio="NF")  // nota final interna
		$l_decimalesNotas:=iGradesDecNF
		$l_decimalesPuntos:=iPointsDecNF
	: ($t_tipoPromedio="NO")  // nota oficial
		$l_decimalesNotas:=iGradesDecNO
		$l_decimalesPuntos:=iPointsDecNO
End case 

COPY ARRAY:C226($y_arregloReales->;$ar_reales)



For ($i;1;Size of array:C274($ar_reales))
	
	EVS_ReadStyleData ($y_EstiloEvaluacionAsignatura->{$i})
	
	If (Not:C34(Is nil pointer:C315($y_NOf_conEstiloAsignatura)))
		$b_usarNtaOficialAsignatura:=$y_NOf_conEstiloAsignatura->{$i}
		Case of 
			: (iPrintActa=Notas)
				If ($ar_reales{$i}>=rGradesFrom)
					If ($b_usarNtaOficialAsignatura)
						$ar_reales{$i}:=Round:C94($ar_reales{$i}/rGradesTo*100;11)
						$y_arregloReales->{$i}:=Round:C94($r_maxNotas*$ar_reales{$i}/100;$l_decimalesNotas)
					Else 
						$ar_reales{$i}:=Round:C94($ar_reales{$i}/$r_maxNotas*100;11)
						$y_arregloReales->{$i}:=Round:C94($r_maxNotas*$ar_reales{$i}/100;$l_decimalesNotas)
					End if 
				End if 
				
			: (iPrintActa=Puntos)
				If ($ar_reales{$i}>=rPointsFrom)
					If ($b_usarNtaOficialAsignatura)
						$ar_reales{$i}:=Round:C94($ar_reales{$i}/rPointsTo*100;11)
						$y_arregloReales->{$i}:=Round:C94($r_maxPuntos*$ar_reales{$i}/100;$l_decimalesPuntos)
					Else 
						$ar_reales{$i}:=Round:C94($ar_reales{$i}/$r_maxPuntos*100;11)
						$y_arregloReales->{$i}:=Round:C94($r_maxPuntos*$ar_reales{$i}/100;$l_decimalesPuntos)
					End if 
				End if 
		End case 
		
	Else 
		
		Case of 
			: (iPrintActa=Notas)
				If ($ar_reales{$i}>=rGradesFrom)
					$ar_reales{$i}:=Round:C94($ar_reales{$i}/rGradesTo*100;11)
					$y_arregloReales->{$i}:=Round:C94($r_maxNotas*$ar_reales{$i}/100;$l_decimalesNotas)
				End if 
				
			: (iPrintActa=Puntos)
				If ($ar_reales{$i}>=rPointsFrom)
					$ar_reales{$i}:=Round:C94($ar_reales{$i}/rPointsTo*100;11)
					$y_arregloReales->{$i}:=Round:C94($r_maxPuntos*$ar_reales{$i}/100;$l_decimalesPuntos)
				End if 
		End case 
	End if 
	
	
End for 




Case of 
	: ($l_modoCalculoPromedio=Ponderado por factor)
		$r_real:=AL_PromedioPonderadoPorFactor ($y_arregloReales;$y_ArregloPonderaciones)
		
	: ($l_modoCalculoPromedio=Ponderado por Int Horaria)
		$r_real:=AL_PromedioPonderadoPorHoras ($y_arregloReales;$y_ArregloPonderaciones)
		
	: ($l_modoCalculoPromedio=Sin ponderaciones)
		$r_real:=Round:C94(AT_Mean ($y_arregloReales;$l_modoCalculo);11)
		
End case 


EVS_ReadStyleData ($l_estiloEvaluacion)
Case of 
	: ($l_modoCalificacion=Notas)
		  //MONO TICKET 215957
		If (iConversionTable=1)
			If ($l_truncarPromedios=1)
				$r_real:=Trunc:C95($r_real;$l_decimalesNotas)
			Else 
				$r_real:=Round:C94($r_real;$l_decimalesNotas)
			End if 
		End if 
		  ////////////////////////////////////
		$y_mediaReal->:=EV2_Nota_a_Real ($r_real)
		$y_mediaNota->:=EV2_Real_a_Nota ($y_mediaReal->;$l_truncarPromedios;$l_decimalesNotas)
		$y_mediaReal->:=EV2_Nota_a_Real ($y_mediaNota->)
		$y_mediaPuntos->:=EV2_Real_a_Puntos ($y_mediaReal->;$l_truncarPromedios;$l_decimalesPuntos)
		$y_MediaLiteral->:=EV2_Real_a_Literal ($y_mediaReal->;Notas;$l_decimalesNotas;$l_truncarPromedios)
		$y_MediaSimbolos->:=EV2_Real_a_Simbolo ($y_mediaReal->)
		
	: ($l_modoCalificacion=Puntos)
		  //MONO TICKET 215957
		If (iConversionTable=1)
			If ($l_truncarPromedios=1)
				$r_real:=Trunc:C95($r_real;$l_decimalesPuntos)
			Else 
				$r_real:=Round:C94($r_real;$l_decimalesPuntos)
			End if 
		End if 
		  ////////////////////////////////////
		$y_mediaReal->:=EV2_Puntos_a_Real ($r_real)
		$y_mediaPuntos->:=EV2_Real_a_Puntos ($y_mediaReal->;$l_truncarPromedios;$l_decimalesPuntos)
		$y_mediaReal->:=EV2_Puntos_a_Real ($y_mediaNota->)
		$y_mediaNota->:=EV2_Real_a_Nota ($y_mediaReal->;$l_truncarPromedios;$l_decimalesNotas)
		$y_MediaLiteral->:=EV2_Real_a_Literal ($y_mediaReal->;Puntos;$l_decimalesPuntos;$l_truncarPromedios)
		$y_MediaSimbolos->:=EV2_Real_a_Simbolo ($y_mediaReal->)
		
	: ($l_modoCalificacion=Simbolos)
		$y_mediaReal->:=$r_real  //MONO 211695
		Case of 
			: ((iEvaluationMode=Notas) & (vi_ConvertSymbolicAverage=1))
				$y_mediaNota->:=EV2_Real_a_Nota ($r_real;$l_truncarPromedios;$l_decimalesNotas)
				$y_mediaReal->:=EV2_Nota_a_Real ($y_mediaNota->)
				$y_MediaSimbolos->:=EV2_Real_a_Simbolo ($y_mediaReal->)
				$y_mediaPuntos->:=EV2_Real_a_Puntos ($y_mediaReal->;$l_truncarPromedios;$l_decimalesPuntos)
				
			: ((iEvaluationMode=Puntos) & (vi_ConvertSymbolicAverage=1))
				$y_mediaPuntos->:=EV2_Real_a_Puntos ($y_mediaReal->;$l_truncarPromedios;$l_decimalesPuntos)
				$y_mediaReal->:=EV2_Puntos_a_Real ($y_mediaPuntos->)
				$y_MediaSimbolos->:=EV2_Real_a_Simbolo ($y_mediaReal->)
				$y_mediaNota->:=EV2_Real_a_Nota ($y_mediaReal->;$l_truncarPromedios;$l_decimalesNotas)
				
			Else 
				$y_MediaSimbolos->:=EV2_Real_a_Simbolo ($y_mediaReal->)
				$y_mediaNota->:=EV2_Real_a_Nota ($y_mediaReal->;$l_truncarPromedios;$l_decimalesNotas)
				$y_mediaPuntos->:=EV2_Real_a_Puntos ($y_mediaReal->;$l_truncarPromedios;$l_decimalesPuntos)
		End case 
		$y_MediaLiteral->:=$y_MediaSimbolos->
		
		
	: ($l_modoCalificacion=Porcentaje)
		$y_mediaNota->:=EV2_Real_a_Nota ($r_real;$l_truncarPromedios;$l_decimalesNotas)
		$y_mediaPuntos->:=EV2_Real_a_Puntos ($r_real;$l_truncarPromedios;$l_decimalesPuntos)
		$y_MediaSimbolos->:=EV2_Real_a_Simbolo ($r_real)
		$y_mediaReal->:=Round:C94($r_real;1)
		$y_MediaLiteral->:=EV2_Real_a_Literal ($y_mediaReal->;Porcentaje;$l_decimalesPuntos;$l_truncarPromedios)
		
End case 




