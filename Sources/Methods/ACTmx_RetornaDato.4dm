//%attributes = {}
  //ACTmx_RetornaDato

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301($ptr1;$ptr2;$ptr3)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 

Case of 
	: ($vt_accion="SetArreglo2DimReferenciaGlobal")
		ARRAY TEXT:C222($ptr1->;0;0)
		ARRAY TEXT:C222($ptr1->;2;36)
		
		$ptr1->{1}{1}:="0"
		$ptr1->{2}{1}:="0"
		$ptr1->{1}{2}:="1"
		$ptr1->{2}{2}:="1"
		$ptr1->{1}{3}:="2"
		$ptr1->{2}{3}:="2"
		$ptr1->{1}{4}:="3"
		$ptr1->{2}{4}:="3"
		$ptr1->{1}{5}:="4"
		$ptr1->{2}{5}:="4"
		$ptr1->{1}{6}:="5"
		$ptr1->{2}{6}:="5"
		$ptr1->{1}{7}:="6"
		$ptr1->{2}{7}:="6"
		$ptr1->{1}{8}:="7"
		$ptr1->{2}{8}:="7"
		$ptr1->{1}{9}:="8"
		$ptr1->{2}{9}:="8"
		$ptr1->{1}{10}:="9"
		$ptr1->{2}{10}:="9"
		$ptr1->{1}{11}:="A"
		$ptr1->{2}{11}:="1"
		$ptr1->{1}{12}:="B"
		$ptr1->{2}{12}:="2"
		$ptr1->{1}{13}:="C"
		$ptr1->{2}{13}:="3"
		$ptr1->{1}{14}:="D"
		$ptr1->{2}{14}:="4"
		$ptr1->{1}{15}:="E"
		$ptr1->{2}{15}:="5"
		$ptr1->{1}{16}:="F"
		$ptr1->{2}{16}:="6"
		$ptr1->{1}{17}:="G"
		$ptr1->{2}{17}:="7"
		$ptr1->{1}{18}:="H"
		$ptr1->{2}{18}:="8"
		$ptr1->{1}{19}:="I"
		$ptr1->{2}{19}:="9"
		$ptr1->{1}{20}:="J"
		$ptr1->{2}{20}:="1"
		$ptr1->{1}{21}:="K"
		$ptr1->{2}{21}:="2"
		$ptr1->{1}{22}:="L"
		$ptr1->{2}{22}:="3"
		$ptr1->{1}{23}:="M"
		$ptr1->{2}{23}:="4"
		$ptr1->{1}{24}:="N"
		$ptr1->{2}{24}:="5"
		$ptr1->{1}{25}:="O"
		$ptr1->{2}{25}:="6"
		$ptr1->{1}{26}:="P"
		$ptr1->{2}{26}:="7"
		$ptr1->{1}{27}:="Q"
		$ptr1->{2}{27}:="8"
		$ptr1->{1}{28}:="R"
		$ptr1->{2}{28}:="9"
		$ptr1->{1}{29}:="S"
		$ptr1->{2}{29}:="1"
		$ptr1->{1}{30}:="T"
		$ptr1->{2}{30}:="2"
		$ptr1->{1}{31}:="U"
		$ptr1->{2}{31}:="3"
		$ptr1->{1}{32}:="V"
		$ptr1->{2}{32}:="4"
		$ptr1->{1}{33}:="W"
		$ptr1->{2}{33}:="5"
		$ptr1->{1}{34}:="X"
		$ptr1->{2}{34}:="6"
		$ptr1->{1}{35}:="Y"
		$ptr1->{2}{35}:="7"
		$ptr1->{1}{36}:="Z"
		$ptr1->{2}{36}:="8"
		
		
	: ($vt_accion="DatoDesdeCondensado36")
		ARRAY LONGINT:C221($alACT_residuos;0)
		ARRAY TEXT:C222($atACT_arrayPos;2;36)
		C_LONGINT:C283($vl_suma;$vl_num)
		ACTmx_RetornaDato ("SetArreglo2Dim";->$atACT_arrayPos)
		For ($i;Length:C16($ptr1->);1;-1)
			$pos:=Find in array:C230($atACT_arrayPos{2};$ptr1->[[$i]])
			$vl_suma:=$vl_suma+(Num:C11($atACT_arrayPos{1}{$pos})*(36^$vl_num))
			$vl_num:=$vl_num+1
		End for 
		$ptr2->:=String:C10($vl_suma)
		
	: ($vt_accion="FechaCondensada36")
		ARRAY LONGINT:C221($alACT_residuos;0)
		ARRAY TEXT:C222($atACT_arrayPos;2;36)
		ACTmx_RetornaDato ("SetArreglo2Dim";->$atACT_arrayPos)
		
		$vl_cociente:=Num:C11($ptr1->)
		While ($vl_cociente#0)
			APPEND TO ARRAY:C911($alACT_residuos;Mod:C98($vl_cociente;36))
			$vl_cociente:=Int:C8($vl_cociente/36)
		End while 
		AT_RedimArrays (4;->$alACT_residuos)
		$ptr2->:=""
		For ($i;1;Size of array:C274($alACT_residuos))
			$pos:=Find in array:C230($atACT_arrayPos{1};String:C10($alACT_residuos{$i}))
			$ptr2->:=$atACT_arrayPos{2}{$pos}+$ptr2->
		End for 
		
	: ($vt_accion="MontoCondensado36")
		ARRAY LONGINT:C221($alACT_residuos;0)
		ARRAY TEXT:C222($atACT_arrayPos;2;36)
		ACTmx_RetornaDato ("SetArreglo2Dim";->$atACT_arrayPos)
		
		$vl_cociente:=Num:C11($ptr1->)
		While ($vl_cociente#0)
			APPEND TO ARRAY:C911($alACT_residuos;Mod:C98($vl_cociente;36))
			$vl_cociente:=Int:C8($vl_cociente/36)
		End while 
		AT_RedimArrays (5;->$alACT_residuos)
		$ptr2->:=""
		For ($i;1;Size of array:C274($alACT_residuos))
			$pos:=Find in array:C230($atACT_arrayPos{1};String:C10($alACT_residuos{$i}))
			$ptr2->:=$atACT_arrayPos{2}{$pos}+$ptr2->
		End for 
		
	: ($vt_accion="SetArreglo2Dim")
		ARRAY TEXT:C222($ptr1->;0;0)
		ARRAY TEXT:C222($ptr1->;2;36)
		
		$ptr1->{1}{1}:="0"
		$ptr1->{2}{1}:="0"
		$ptr1->{1}{2}:="1"
		$ptr1->{2}{2}:="1"
		$ptr1->{1}{3}:="2"
		$ptr1->{2}{3}:="2"
		$ptr1->{1}{4}:="3"
		$ptr1->{2}{4}:="3"
		$ptr1->{1}{5}:="4"
		$ptr1->{2}{5}:="4"
		$ptr1->{1}{6}:="5"
		$ptr1->{2}{6}:="5"
		$ptr1->{1}{7}:="6"
		$ptr1->{2}{7}:="6"
		$ptr1->{1}{8}:="7"
		$ptr1->{2}{8}:="7"
		$ptr1->{1}{9}:="8"
		$ptr1->{2}{9}:="8"
		$ptr1->{1}{10}:="9"
		$ptr1->{2}{10}:="9"
		$ptr1->{1}{11}:="10"
		$ptr1->{2}{11}:="A"
		$ptr1->{1}{12}:="11"
		$ptr1->{2}{12}:="B"
		$ptr1->{1}{13}:="12"
		$ptr1->{2}{13}:="C"
		$ptr1->{1}{14}:="13"
		$ptr1->{2}{14}:="D"
		$ptr1->{1}{15}:="14"
		$ptr1->{2}{15}:="E"
		$ptr1->{1}{16}:="15"
		$ptr1->{2}{16}:="F"
		$ptr1->{1}{17}:="16"
		$ptr1->{2}{17}:="G"
		$ptr1->{1}{18}:="17"
		$ptr1->{2}{18}:="H"
		$ptr1->{1}{19}:="18"
		$ptr1->{2}{19}:="I"
		$ptr1->{1}{20}:="19"
		$ptr1->{2}{20}:="J"
		$ptr1->{1}{21}:="20"
		$ptr1->{2}{21}:="K"
		$ptr1->{1}{22}:="21"
		$ptr1->{2}{22}:="L"
		$ptr1->{1}{23}:="22"
		$ptr1->{2}{23}:="M"
		$ptr1->{1}{24}:="23"
		$ptr1->{2}{24}:="N"
		$ptr1->{1}{25}:="24"
		$ptr1->{2}{25}:="O"
		$ptr1->{1}{26}:="25"
		$ptr1->{2}{26}:="P"
		$ptr1->{1}{27}:="26"
		$ptr1->{2}{27}:="Q"
		$ptr1->{1}{28}:="27"
		$ptr1->{2}{28}:="R"
		$ptr1->{1}{29}:="28"
		$ptr1->{2}{29}:="S"
		$ptr1->{1}{30}:="29"
		$ptr1->{2}{30}:="T"
		$ptr1->{1}{31}:="30"
		$ptr1->{2}{31}:="U"
		$ptr1->{1}{32}:="31"
		$ptr1->{2}{32}:="V"
		$ptr1->{1}{33}:="32"
		$ptr1->{2}{33}:="W"
		$ptr1->{1}{34}:="33"
		$ptr1->{2}{34}:="X"
		$ptr1->{1}{35}:="34"
		$ptr1->{2}{35}:="Y"
		$ptr1->{1}{36}:="35"
		$ptr1->{2}{36}:="Z"
		
	: ($vt_accion="NumeroDeSeccionDesdeArreglo")
		For ($i;1;Size of array:C274($ptr1->))
			$vl_noNivel:=$ptr1->{$i}
			$vt_nivel:=""
			ACTmx_RetornaDato ("NivelDesdeNoNivel";->$vl_noNivel;->$vt_nivel)
			APPEND TO ARRAY:C911($ptr2->;$vt_nivel)
		End for 
		
	: ($vt_accion="NivelDesdeNoNivel")
		$vl_noNivel:=$ptr1->
		Case of 
			: (($vl_noNivel<18) & ($vl_noNivel>-6))
				$ptr2->:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$vl_noNivel;->[xxSTR_Niveles:6]Nivel:1)
			: (($vl_noNivel=Nivel_Retirados) | ($vl_noNivel=Nivel_Egresados))
				$ptr2->:="Exalumnos Morosos"
			: (($vl_noNivel=Nivel_AdmisionDirecta) | ($vl_noNivel=Nivel_AdmissionTrack))
				$ptr2->:="Nuevos Ingresos"
		End case 
		
	: ($vt_accion="RetornaNumeroMesCuota1Yaocalli")
		Case of 
			: ($ptr2->=-5)
				$ptr1->:=9
			: ($ptr2->=-4)
				$ptr1->:=9
			: ($ptr2->=-3)
				$ptr1->:=9
			: ($ptr2->=-2)
				$ptr1->:=9
			: ($ptr2->=-1)
				$ptr1->:=9
			: ($ptr2->=1)
				$ptr1->:=9
			: ($ptr2->=2)
				$ptr1->:=9
			: ($ptr2->=3)
				$ptr1->:=9
			: ($ptr2->=4)
				$ptr1->:=9
			: ($ptr2->=5)
				$ptr1->:=9
			: ($ptr2->=6)
				$ptr1->:=9
			: ($ptr2->=7)
				$ptr1->:=9
			: ($ptr2->=8)
				$ptr1->:=9
			: ($ptr2->=9)
				$ptr1->:=9
			: ($ptr2->=10)
				$ptr1->:=8
			: ($ptr2->=11)
				$ptr1->:=8
			: ($ptr2->=12)
				$ptr1->:=8
			Else 
				$ptr1->:=0
		End case 
		
End case 