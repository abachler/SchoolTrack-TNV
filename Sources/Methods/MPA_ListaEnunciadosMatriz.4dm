//%attributes = {}
  // MPA_ListaEnunciadosMatriz()
  // Por: Alberto Bachler K.: 19-05-14, 16:13:45
  //  ---------------------------------------------
  // 
  //
  //  --------------------------------------------
C_LONGINT:C283($hl_competencias;$i_competencia;$i_dimension;$i_eje;$l_hlSublista;$l_periodo;$l_recNumConfig;$l_recNumMatriz)
C_POINTER:C301($y_retorno)

ARRAY LONGINT:C221($al_recNumObjetoCompetencia;0)
ARRAY LONGINT:C221($al_recNumObjetoDimension;0)
ARRAY LONGINT:C221($al_recNumObjetoEje;0)
ARRAY TEXT:C222($at_Competencia;0)
ARRAY TEXT:C222($at_Dimension;0)
ARRAY TEXT:C222($at_Eje;0)

ARRAY TEXT:C222($at_enunciadosNombre;0)
ARRAY LONGINT:C221($al_enunciadosTipo;0)
ARRAY LONGINT:C221($al_enunciadosIdEje;0)
ARRAY LONGINT:C221($al_enunciadosIdDimension;0)
ARRAY LONGINT:C221($al_enunciadosIdCompetencia;0)

$l_recNumMatriz:=$1
$l_periodo:=$2
$y_retorno:=$3

Case of 
	: (Type:C295($y_retorno->)=Is longint:K8:6)
		  // se asume que el longint es un puntero sobre una lista jerárquica
		If (Is a list:C621($y_retorno->))
			CLEAR LIST:C377($y_retorno->;*)
			$y_retorno->:=New list:C375
			$l_hlSublista:=New list:C375
			$b_retornoEsLista:=True:C214
		Else 
			ALERT:C41("ERROR: El longint pasado en puntero no es un lista.")
			$b_abortar:=True:C214
		End if 
		
	: (Type:C295($y_retorno->)=Is object:K8:27)
		  // devuelve un objeto en la variable pasada en puntero
	: (Type:C295($y_retorno->)=Is BLOB:K8:12)
		  // devuelve un blob en la variable pasada en puntero
		  // el blob contendrá un objeto
	: (Type:C295($y_retorno->)=Is text:K8:3)
		  // devuelve un json en la variable texto pasada en puntero
End case 

KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatriz;False:C215)


SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1;=;[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje;*)
QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3;=;0;*)
QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4;=;0)
QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)

If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
	SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetoCompetencia;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_idCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencia)
	For ($i_competencia;1;Size of array:C274($al_recNumObjetoCompetencia);1)
		If ($b_retornoEsLista)
			APPEND TO LIST:C376($y_retorno->;Replace string:C233($at_Competencia{$i_competencia};"\r";" | ");$al_recNumObjetoCompetencia{$i_competencia})
			SET LIST ITEM PARAMETER:C986($y_retorno->;0;"TipoObjeto";Logro_Aprendizaje)
			SET LIST ITEM PARAMETER:C986($y_retorno->;0;"IdObjeto";$al_idCompetencia{$i_competencia})
		Else 
			APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Competencia{$i_competencia})
			APPEND TO ARRAY:C911($al_enunciadosTipo;Logro_Aprendizaje)
			APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;$al_idCompetencia{$i_competencia})
			APPEND TO ARRAY:C911($al_enunciadosIdDimension;0)
			APPEND TO ARRAY:C911($al_enunciadosIdEje;0)
		End if 
	End for 
End if 

SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)
QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=Eje_Aprendizaje)
QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>)

If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
	SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetoEje;[MPA_ObjetosMatriz:204]ID_Eje:3;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_Eje)
	For ($i_eje;1;Size of array:C274($al_recNumObjetoEje);1)
		If ($b_retornoEsLista)
			APPEND TO LIST:C376($y_retorno->;Replace string:C233($at_Eje{$i_eje};"\r";" | ");$al_recNumObjetoEje{$i_eje})
			SET LIST ITEM PARAMETER:C986($y_retorno->;0;"TipoObjeto";Eje_Aprendizaje)
			SET LIST ITEM PARAMETER:C986($y_retorno->;0;"IdObjeto";$al_IdEje{$i_eje})
			SET LIST ITEM PROPERTIES:C386($y_retorno->;0;False:C215;Bold:K14:2;0)
		Else 
			APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Eje{$i_eje})
			APPEND TO ARRAY:C911($al_enunciadosTipo;Eje_Aprendizaje)
			APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_eje})
			APPEND TO ARRAY:C911($al_enunciadosIdDimension;0)
			APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;0)
		End if 
		
		  //busco competencias asociadas directamente al eje (sin dimension)
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3;=$al_IdEje{$i_Eje};*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4;=;0;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=;Logro_Aprendizaje)
		QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
		ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
		
		If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetoCompetencia;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_idCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencia)
			For ($i_competencia;1;Size of array:C274($al_recNumObjetoCompetencia);1)
				If ($b_retornoEsLista)
					APPEND TO LIST:C376($l_hlSublista;Replace string:C233($at_Competencia{$i_competencia};"\r";" | ");$al_recNumObjetoCompetencia{$i_competencia})
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"TipoObjeto";Logro_Aprendizaje)
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"IdObjeto";$al_idCompetencia{$i_competencia})
				Else 
					APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Competencia{$i_competencia})
					APPEND TO ARRAY:C911($al_enunciadosTipo;Logro_Aprendizaje)
					APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;$al_idCompetencia{$i_competencia})
					APPEND TO ARRAY:C911($al_enunciadosIdDimension;0)
					APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_Eje})
				End if 
			End for 
		End if 
		
		  //busco las dimensiones del eje
		QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Eje:3;=$al_IdEje{$i_Eje};*)
		QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=Dimension_Aprendizaje)
		QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
		ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>)
		
		If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
			SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetoDimension;[MPA_ObjetosMatriz:204]ID_Dimension:4;$al_idDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_Dimension)
			
			For ($i_dimension;1;Size of array:C274($al_recNumObjetoDimension);1)
				If ($b_retornoEsLista)
					APPEND TO LIST:C376($l_hlSublista;Replace string:C233($at_Dimension{$i_dimension};"\r";" | ");$al_recNumObjetoDimension{$i_dimension})
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"TipoObjeto";Dimension_Aprendizaje)
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"IdObjeto";$al_idDimension{$i_dimension})
					SET LIST ITEM PROPERTIES:C386($l_hlSublista;0;False:C215;Underline:K14:4;0)
				Else 
					APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Dimension{$i_dimension})
					APPEND TO ARRAY:C911($al_enunciadosTipo;Dimension_Aprendizaje)
					APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;0)
					APPEND TO ARRAY:C911($al_enunciadosIdDimension;$al_idDimension{$i_dimension})
					APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_Eje})
				End if 
				
				
				  // busco las competencias de la dimensión
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Dimension:4;=;$al_idDimension{$i_dimension};*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;=Logro_Aprendizaje)
				QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_periodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
				ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
				If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
					SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetoCompetencia;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_idCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencia)
					$hl_competencias:=New list:C375
					For ($i_competencia;1;Size of array:C274($al_recNumObjetoCompetencia);1)
						If ($b_retornoEsLista)
							APPEND TO LIST:C376($hl_competencias;Replace string:C233($at_Competencia{$i_competencia};"\r";" | ");$al_recNumObjetoCompetencia{$i_competencia})
							SET LIST ITEM PARAMETER:C986($hl_competencias;0;"TipoObjeto";Logro_Aprendizaje)
							SET LIST ITEM PARAMETER:C986($hl_competencias;0;"IdObjeto";$al_idCompetencia{$i_competencia})
						Else 
							APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Competencia{$i_competencia})
							APPEND TO ARRAY:C911($al_enunciadosTipo;Logro_Aprendizaje)
							APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;$al_idCompetencia{$i_competencia})
							APPEND TO ARRAY:C911($al_enunciadosIdDimension;$al_idDimension{$i_dimension})
							APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_Eje})
						End if 
					End for 
					If ($b_retornoEsLista)
						SET LIST ITEM:C385($l_hlSublista;$al_recNumObjetoDimension{$i_dimension};$at_Dimension{$i_dimension};$al_recNumObjetoDimension{$i_dimension};$hl_competencias;True:C214)
					End if 
				End if 
			End for 
		End if 
		
		If ($b_retornoEsLista)
			If (Count list items:C380($l_hlSublista)>0)
				$l_hlListaTemporal:=Copy list:C626($l_hlSublista)
				SET LIST ITEM:C385($y_retorno->;$al_recNumObjetoEje{$i_eje};$at_Eje{$i_eje};$al_recNumObjetoEje{$i_eje};$l_hlListaTemporal;True:C214)
				CLEAR LIST:C377($l_hlSublista)
				$l_hlSublista:=New list:C375
			End if 
		End if 
	End for 
End if 

If ($b_retornoEsLista)
	CLEAR LIST:C377($l_hlSublista)
	SET LIST PROPERTIES:C387($y_retorno->;_o_Ala Macintosh:K28:1;_o_Macintosh node:K28:5;20)
Else 
	OB SET ARRAY:C1227($o_Enunciado;"enunciado";$at_enunciadosNombre)
	OB SET ARRAY:C1227($o_Enunciado;"tipo";$al_enunciadosTipo)
	OB SET ARRAY:C1227($o_Enunciado;"idEje";$al_enunciadosIdEje)
	OB SET ARRAY:C1227($o_Enunciado;"IdDimension";$al_enunciadosIdDimension)
	OB SET ARRAY:C1227($o_Enunciado;"IdCompetencia";$al_enunciadosIdCompetencia)
	
	Case of 
		: (Type:C295($y_retorno->)=Is object:K8:27)
			$y_retorno->:=OB Copy:C1225($o_Enunciado)
			
		: (Type:C295($y_retorno->)=Is BLOB:K8:12)
			OB_ObjectToBlob (->$o_Enunciado;$y_retorno)
			  // devuelve un blob en la variable pasada en puntero
			  // el blob contendrá un objeto
			
		: (Type:C295($y_retorno->)=Is text:K8:3)
			  // devuelve un json en la variable texto pasada en puntero
			$y_retorno->:=JSON Stringify:C1217($o_Enunciado;*)
			
	End case 
End if 





