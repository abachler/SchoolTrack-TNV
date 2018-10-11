//%attributes = {}
  // MPA_ListaEnunciadosMapa()
  // Por: Alberto Bachler K.: 16-05-14, 17:12:16
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)

C_BOOLEAN:C305($b_abortar;$b_retornoEsLista)
C_LONGINT:C283($hl_competencias;$i_competencia;$i_dimension;$i_eje;$l_ejes;$l_hlListaTemporal;$l_hlSublista;$l_idArea;$l_idMateria;$l_indexEtapa)
C_LONGINT:C283($l_indexNivel;$l_nivelNumero;$l_refDimensionActual;$l_refEjeActual;$l_referenciaItem)
C_POINTER:C301($y_retorno)
C_TEXT:C284($t_asignatura;$t_variante)
C_OBJECT:C1216($o_Enunciado)

ARRAY LONGINT:C221($al_enunciadosIdCompetencia;0)
ARRAY LONGINT:C221($al_enunciadosIdDimension;0)
ARRAY LONGINT:C221($al_enunciadosIdEje;0)
ARRAY LONGINT:C221($al_enunciadosTipo;0)
ARRAY LONGINT:C221($al_idCompetencia;0)
ARRAY LONGINT:C221($al_IdDimension;0)
ARRAY LONGINT:C221($al_IdEje;0)
ARRAY LONGINT:C221($al_recNumCompetencias;0)
ARRAY LONGINT:C221($al_recNumDimensiones;0)
ARRAY LONGINT:C221($al_recNumEjes;0)
ARRAY TEXT:C222($at_Competencia;0)
ARRAY TEXT:C222($at_Dimension;0)
ARRAY TEXT:C222($at_Eje;0)
ARRAY TEXT:C222($at_enunciadosNombre;0)
ARRAY TEXT:C222($at_mnemoVariante;0)





If (False:C215)
	C_TEXT:C284(MPA_ListaEnunciadosMapa ;$1)
	C_LONGINT:C283(MPA_ListaEnunciadosMapa ;$2)
	C_POINTER:C301(MPA_ListaEnunciadosMapa ;$3)
End if 

$t_asignatura:=$1
$l_nivelNumero:=$2
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
		  // devuelve un objeto con arreglos en la variable pasada en puntero
	: (Type:C295($y_retorno->)=Is BLOB:K8:12)
		  // devuelve un blob en la variable pasada en puntero
		  // el blob contendrá un objeto con arreglos
	: (Type:C295($y_retorno->)=Is text:K8:3)
		  // devuelve un json con arreglos en la variable texto pasada en puntero
End case 

  //KRL_FindAndLoadRecordByIndex (->[xxSTR_Materias]Materia;->$t_asignatura;False)
KRL_FindAndLoadRecordByIndex (->[MPA_DefinicionAreas:186]AreaAsignatura:4;->[xxSTR_Materias:20]AreaMPA:4;False:C215)
$l_idMateria:=[xxSTR_Materias:20]ID_Materia:16
$l_idArea:=[MPA_DefinicionAreas:186]ID:1

$l_indexNivel:=Find in array:C230(<>aNivNo;$l_nivelNumero)
If (OK=1)
	BLOB_Blob2Vars (->[MPA_DefinicionAreas:186]xEtapas:10;0;->atMPA_EtapasArea;->alMPA_NivelDesde;->alMPA_NivelHasta)
	$l_indexEtapa:=0
	For ($i;1;Size of array:C274(alMPA_NivelDesde))
		If (($l_nivelNumero>=alMPA_NivelDesde{$i}) & ($l_nivelNumero<=alMPA_NivelHasta{$i}))
			$l_indexEtapa:=$i
			$i:=Size of array:C274(alMPA_NivelDesde)
		End if 
	End for 
End if 





  //LECTURA DE COMPETENCIAS NO ASOCIADOS A EJES O DIMENSIONES
QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Area:11=$l_IdArea;*)
QUERY:C277([MPA_DefinicionCompetencias:187]; & [MPA_DefinicionCompetencias:187]ID_Eje:2=0)
QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=[xxSTR_Materias:20]ID_Materia:16)
QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)

SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
	SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNumCompetencias;[MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencia;[MPA_DefinicionCompetencias:187]Mnemo:26;$at_mnemoVariante)
	For ($i_competencia;1;Size of array:C274($al_recNumCompetencias);1)
		If ($at_mnemoVariante{$i_competencia}#"")
			$t_variante:="["+$at_mnemoVariante{$i_competencia}+"] "
		Else 
			$t_variante:=""
		End if 
		$l_referenciaItem:=$l_referenciaItem+1
		If ($b_retornoEsLista)
			APPEND TO LIST:C376($y_retorno->;$t_variante+Replace string:C233($at_Competencia{$i_competencia};"\r";" | ");$l_referenciaItem)
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

QUERY:C277([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]ID_Area:2=$l_IdArea)
QUERY SELECTION BY FORMULA:C207([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]BitsNiveles:20 ?? $l_indexNivel)
If (Records in selection:C76([MPA_DefinicionEjes:185])>0)
	$l_ejes:=Records in selection:C76([MPA_DefinicionEjes:185])
	ORDER BY:C49([MPA_DefinicionEjes:185];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>)
	SELECTION TO ARRAY:C260([MPA_DefinicionEjes:185];$al_recNumEjes;[MPA_DefinicionEjes:185]ID:1;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_Eje)
	
	For ($i_eje;1;Size of array:C274($al_recNumEjes);1)
		$l_referenciaItem:=$l_referenciaItem+1
		$l_refEjeActual:=$l_referenciaItem
		If ($b_retornoEsLista)
			APPEND TO LIST:C376($y_retorno->;Replace string:C233($at_Eje{$i_eje};"\r";" | ");$l_referenciaItem)
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
		QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Eje:2=$al_IdEje{$i_eje};*)
		QUERY:C277([MPA_DefinicionCompetencias:187]; & ;[MPA_DefinicionCompetencias:187]ID_Dimension:23=0)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
		QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria)
		QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
		If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNumCompetencias;[MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencia)
			For ($i_competencia;1;Size of array:C274($al_recNumCompetencias);1)
				$l_referenciaItem:=$l_referenciaItem+1
				If ($b_retornoEsLista)
					APPEND TO LIST:C376($l_hlSublista;Replace string:C233($at_Competencia{$i_competencia};"\r";" | ");$l_referenciaItem)
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"TipoObjeto";Logro_Aprendizaje)
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"IdObjeto";$al_idCompetencia{$i_competencia})
				Else 
					APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Competencia{$i_competencia})
					APPEND TO ARRAY:C911($al_enunciadosTipo;Eje_Aprendizaje)
					APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_eje})
					APPEND TO ARRAY:C911($al_enunciadosIdDimension;0)
					APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;$al_idCompetencia{$i_competencia})
				End if 
			End for 
		End if 
		
		  //busco las dimensiones del eje
		QUERY:C277([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]ID_Eje:3=$al_IdEje{$i_eje})
		QUERY SELECTION BY FORMULA:C207([MPA_DefinicionDimensiones:188];[MPA_DefinicionDimensiones:188]BitsNiveles:21 ?? $l_indexNivel)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([MPA_DefinicionDimensiones:188];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		If (Records in selection:C76([MPA_DefinicionDimensiones:188])>0)
			SELECTION TO ARRAY:C260([MPA_DefinicionDimensiones:188];$al_recNumDimensiones;[MPA_DefinicionDimensiones:188]ID:1;$al_IdDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_Dimension)
			For ($i_dimension;1;Size of array:C274($al_recNumDimensiones);1)
				$l_referenciaItem:=$l_referenciaItem+1
				$l_refDimensionActual:=$l_referenciaItem
				If ($b_retornoEsLista)
					APPEND TO LIST:C376($l_hlSublista;Replace string:C233($at_Dimension{$i_dimension};"\r";" | ");$l_referenciaItem)
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"TipoObjeto";Dimension_Aprendizaje)
					SET LIST ITEM PARAMETER:C986($l_hlSublista;0;"IdObjeto";$al_idDimension{$i_dimension})
					SET LIST ITEM PROPERTIES:C386($l_hlSublista;0;False:C215;Underline:K14:4;0)
				Else 
					APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Dimension{$i_dimension})
					APPEND TO ARRAY:C911($al_enunciadosTipo;Dimension_Aprendizaje)
					APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_eje})
					APPEND TO ARRAY:C911($al_enunciadosIdDimension;$al_idDimension{$i_dimension})
					APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;0)
				End if 
				
				  // busco las competencias de la dimensión
				QUERY:C277([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]ID_Dimension:23=$al_idDimension{$i_dimension})
				QUERY SELECTION:C341([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=0;*)
				QUERY SELECTION:C341([MPA_DefinicionCompetencias:187]; | ;[MPA_DefinicionCompetencias:187]RestriccionSubsector:3=$l_IdMateria)
				QUERY SELECTION BY FORMULA:C207([MPA_DefinicionCompetencias:187];[MPA_DefinicionCompetencias:187]BitNiveles:28 ?? $l_indexNivel)
				
				
				If (Records in selection:C76([MPA_DefinicionCompetencias:187])>0)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					ORDER BY:C49([MPA_DefinicionCompetencias:187];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
					SELECTION TO ARRAY:C260([MPA_DefinicionCompetencias:187];$al_recNumCompetencias;[MPA_DefinicionCompetencias:187]ID:1;$al_idCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_Competencia;[MPA_DefinicionCompetencias:187]Mnemo:26;$at_mnemoVariante)
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					$hl_competencias:=New list:C375
					For ($i_competencia;1;Size of array:C274($al_recNumCompetencias);1)
						If ($at_mnemoVariante{$i_competencia}#"")
							$t_variante:="["+$at_mnemoVariante{$i_competencia}+"] "
						Else 
							$t_variante:=""
						End if 
						$l_referenciaItem:=$l_referenciaItem+1
						If ($b_retornoEsLista)
							APPEND TO LIST:C376($hl_competencias;$t_variante+Replace string:C233($at_Competencia{$i_competencia};"\r";" | ");$l_referenciaItem)
							SET LIST ITEM PARAMETER:C986($hl_competencias;0;"TipoObjeto";Logro_Aprendizaje)
							SET LIST ITEM PARAMETER:C986($hl_competencias;0;"IdObjeto";$al_idCompetencia{$i_competencia})
						Else 
							APPEND TO ARRAY:C911($at_enunciadosNombre;$at_Competencia{$i_competencia})
							APPEND TO ARRAY:C911($al_enunciadosTipo;Logro_Aprendizaje)
							APPEND TO ARRAY:C911($al_enunciadosIdEje;$al_IdEje{$i_eje})
							APPEND TO ARRAY:C911($al_enunciadosIdDimension;$al_idDimension{$i_dimension})
							APPEND TO ARRAY:C911($al_enunciadosIdCompetencia;$al_idCompetencia{$i_competencia})
						End if 
					End for 
					
					If ($b_retornoEsLista)
						SET LIST ITEM:C385($l_hlSublista;$l_refDimensionActual;$at_Dimension{$i_dimension};$l_refDimensionActual;$hl_competencias;True:C214)
					End if 
				End if 
			End for 
		End if 
		
		If ($b_retornoEsLista)
			If (Count list items:C380($l_hlSublista)>0)
				$l_hlListaTemporal:=Copy list:C626($l_hlSublista)
				SET LIST ITEM:C385($y_retorno->;$l_refEjeActual;$at_Eje{$i_eje};$l_refEjeActual;$l_hlListaTemporal;True:C214)
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




