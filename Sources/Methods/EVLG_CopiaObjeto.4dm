//%attributes = {}
  //EVLG_CopiaObjeto

C_LONGINT:C283($1;$idMatrizOrigen;$2;$idMatrizDestino;$3;$tipoObjeto;$4;$idObjeto;$5;$refPeriodo;$6;$desdeNivel;$7;$hastaNivel)
$idMatrizOrigen:=$1
$idMatrizDestino:=$2
$tipoObjeto:=$3
$idObjeto:=$4
$refPeriodo:=$5

Case of 
	: ($tipoObjeto=Eje_Aprendizaje)
		$answer:=CD_Dlog (0;__ ("¿Desea copiar todos los aprendizajes esperados del eje a la configuracion seleccionada?");__ ("");__ ("Si");__ ("No"))
		If ($answer=1)
			  // verificamos que la existencia del eje en la configuración seleccionada
			READ WRITE:C146([MPA_ObjetosMatriz:204])
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizOrigen;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$idObjeto)
			LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$aRecNums)
			For ($i;1;Size of array:C274($aRecNums))
				GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNums{$i})
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizDestino;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_ObjetosMatriz:204]ID_Eje:3;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_ObjetosMatriz:204]ID_Dimension:4;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_ObjetosMatriz:204]ID_Competencia:5)
				If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
					GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNums{$i})
					DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
					[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatrizDestino
				End if 
				[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $refPeriodo
				SAVE RECORD:C53([MPA_ObjetosMatriz:204])
			End for 
		End if 
		
	: ($tipoObjeto=Dimension_Aprendizaje)
		  // drag and drop de una dimensión 
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizOrigen;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=$idObjeto)
		$idEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
		LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$aRecNums)
		For ($i;1;Size of array:C274($aRecNums))
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNums{$i})
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizDestino;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_ObjetosMatriz:204]ID_Eje:3;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_ObjetosMatriz:204]ID_Dimension:4;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_ObjetosMatriz:204]ID_Competencia:5)
			If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
				GOTO RECORD:C242([MPA_ObjetosMatriz:204];$aRecNums{$i})
				DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
				[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
				[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatrizDestino
			End if 
			[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $refPeriodo
			SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		End for 
		
		
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizDestino;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$idEje;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
		If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
			  // si no existe lo creamos en la configuración seleccionada
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizOrigen;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$idEje;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
			[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatrizDestino
		End if 
		[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $refPeriodo
		SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		
	: ($tipoObjeto=Logro_Aprendizaje)
		  // drag and drop de un aprendizaje esperado
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizOrigen;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Competencia:5=$idObjeto)
		$recNum:=Record number:C243([MPA_ObjetosMatriz:204])
		$idEje:=[MPA_ObjetosMatriz:204]ID_Eje:3
		$idDimension:=[MPA_ObjetosMatriz:204]ID_Dimension:4
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizDestino;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=[MPA_ObjetosMatriz:204]ID_Eje:3;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=[MPA_ObjetosMatriz:204]ID_Dimension:4;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Competencia:5=[MPA_ObjetosMatriz:204]ID_Competencia:5)
		If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
			GOTO RECORD:C242([MPA_ObjetosMatriz:204];$recNum)
			DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
			[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatrizDestino
		End if 
		[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $refPeriodo
		SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizDestino;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$idEje;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
		If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
			  // si no existe lo creamos en la configuración seleccionada
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizOrigen;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3=$idEje;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Eje_Aprendizaje)
			DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
			[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatrizDestino
		End if 
		[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $refPeriodo
		SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		
		READ WRITE:C146([MPA_ObjetosMatriz:204])
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizDestino;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=$idDimension;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
		If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
			  // si no existe lo creamos en la configuración seleccionada
			QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;$idMatrizOrigen;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4=$idDimension;*)
			QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
			DUPLICATE RECORD:C225([MPA_ObjetosMatriz:204])
			[MPA_ObjetosMatriz:204]Auto_UUID:28:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
			[MPA_ObjetosMatriz:204]ID_Matriz:1:=$idMatrizDestino
		End if 
		[MPA_ObjetosMatriz:204]Periodos:7:=[MPA_ObjetosMatriz:204]Periodos:7 ?+ $refPeriodo
		SAVE RECORD:C53([MPA_ObjetosMatriz:204])
		
		
End case 
