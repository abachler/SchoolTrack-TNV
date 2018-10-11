Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(<>aPExmAsig;5)
		<>aPExmAsig{1}:="Fecha de eximición"
		<>aPExmAsig{3}:="Aleatoriamente"
		<>aPExmAsig{2}:="Orden alfabético"
		<>aPExmAsig{4}:="Asignatura"
		<>aPExmAsig{5}:="Curso"
	: (Form event:C388=On Clicked:K2:4)
		If (Self:C308->>0)
			Case of 
				: (Self:C308->=1)
					AL_SetSort (xALP_Exim;2)
				: (Self:C308->=2)
					AL_SetSort (xALP_Exim;3)
				: (Self:C308->=3)
					AL_SetSort (xALP_Exim;4;5;3;2)
				: (Self:C308->=4)
					AL_SetSort (xALP_Exim;4;2)
				: (Self:C308->=5)
					AL_SetSort (xALP_Exim;5;3)
			End case 
			For ($i;1;Size of array:C274(<>aExmNo))
				<>aExmNo{$i}:=$i
			End for 
			AL_SetSort (xALP_Exim;1)
			AL_UpdateArrays (xALP_Exim;Size of array:C274(<>aExmNo))
		End if 
End case 