//%attributes = {}
  // MPAmtx_LeeConfiguracion()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 29/07/12, 11:29:04
  // ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_POINTER:C301($3)
C_POINTER:C301($4)
C_POINTER:C301($5)
C_POINTER:C301($6)

C_LONGINT:C283($i;$l_bitPeriodo;$l_recNumConfig)

ARRAY INTEGER:C220($ai_OrdenCompetencia;0)
ARRAY INTEGER:C220($ai_ordenDimension;0)
ARRAY INTEGER:C220($ai_ordenEje;0)
ARRAY LONGINT:C221($al_IDCompetencia;0)
ARRAY LONGINT:C221($al_IdDimension;0)
ARRAY LONGINT:C221($al_IdEje;0)
ARRAY LONGINT:C221($al_recNumObjetosMatriz;0)
ARRAY TEXT:C222($at_nombreCompetencia;0)
ARRAY TEXT:C222($at_nombreDimension;0)
ARRAY TEXT:C222($at_NombreEje;0)
_O_ARRAY STRING:C218(11;$as_MnemoVariante;0)
If (False:C215)
	C_LONGINT:C283(MPAmtx_LeeConfiguracion ;$1)
	C_LONGINT:C283(MPAmtx_LeeConfiguracion ;$2)
	C_POINTER:C301(MPAmtx_LeeConfiguracion ;$3)
	C_POINTER:C301(MPAmtx_LeeConfiguracion ;$4)
	C_POINTER:C301(MPAmtx_LeeConfiguracion ;$5)
	C_POINTER:C301(MPAmtx_LeeConfiguracion ;$6)
End if 

  // CÓDIGO

$l_recNumConfig:=$1
$l_bitPeriodo:=$2
$y_arregloTipoObjeto:=$3
$y_arregloIDObjeto:=$4
$y_arregloNombreObjeto:=$5
$y_arregloRefIconos:=$6


ARRAY LONGINT:C221($y_arregloIDObjeto->;0)
ARRAY TEXT:C222($y_arregloNombreObjeto->;0)
ARRAY TEXT:C222($y_arregloRefIconos->;0)
ARRAY LONGINT:C221($y_arregloTipoObjeto->;0)

If ($l_recNumConfig>=0)
	KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumConfig;False:C215)
	vtEVLG_SpecificConfig:=__ ("Competencias esperadas en matriz: ")+[MPA_AsignaturasMatrices:189]NombreMatriz:2
	
	  //RELATE MANY([MPA_AsignaturasMatrices]ID_Matriz)
	QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Matriz:1=[MPA_AsignaturasMatrices:189]ID_Matriz:1)
	QUERY SELECTION BY FORMULA:C207([MPA_ObjetosMatriz:204];([MPA_ObjetosMatriz:204]Periodos:7 ?? $l_bitPeriodo) | ([MPA_ObjetosMatriz:204]Periodos:7 ?? 0) | ([MPA_ObjetosMatriz:204]Periodos:7=0))
	If (Records in selection:C76([MPA_ObjetosMatriz:204])=0)
	Else 
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)
		
		ORDER BY:C49([MPA_ObjetosMatriz:204];[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;>;[MPA_DefinicionEjes:185]AlphaSort:21;>;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;>;[MPA_DefinicionDimensiones:188]AlphaSort:8;>;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;>;[MPA_DefinicionCompetencias:187]AlphaSort:24;>)
		SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$al_recNumObjetosMatriz;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$y_arregloTipoObjeto->;[MPA_ObjetosMatriz:204]ID_Eje:3;$al_IdEje;[MPA_DefinicionEjes:185]Nombre:3;$at_NombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$ai_ordenEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$al_IdDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$at_nombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$ai_ordenDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$al_IDCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$at_nombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$ai_OrdenCompetencia;[MPA_DefinicionCompetencias:187]Mnemo:26;$as_MnemoVariante)
		  //elimino registros existentes en matrices sin relaciones con los objetos definidos en el mapa
		For ($i;Size of array:C274($al_recNumObjetosMatriz);1;-1)
			Case of 
				: (($y_arregloTipoObjeto->{$i}=Eje_Aprendizaje) & ($at_NombreEje{$i}=""))
					GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_recNumObjetosMatriz{$i})
					DELETE RECORD:C58([MPA_ObjetosMatriz:204])
					AT_Delete ($i;1;->$ai_ordenEje;->$ai_ordenDimension;->$ai_OrdenCompetencia;->$al_recNumObjetosMatriz;$y_arregloTipoObjeto;->$al_IdEje;->$at_NombreEje;->$al_IdDimension;->$at_nombreDimension;->$al_IDCompetencia;->$at_nombreCompetencia;->$as_MnemoVariante)
					
				: (($y_arregloTipoObjeto->{$i}=Dimension_Aprendizaje) & ($at_nombreDimension{$i}=""))
					GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_recNumObjetosMatriz{$i})
					DELETE RECORD:C58([MPA_ObjetosMatriz:204])
					AT_Delete ($i;1;->$ai_ordenEje;->$ai_ordenDimension;->$ai_OrdenCompetencia;->$al_recNumObjetosMatriz;$y_arregloTipoObjeto;->$al_IdEje;->$at_NombreEje;->$al_IdDimension;->$at_nombreDimension;->$al_IDCompetencia;->$at_nombreCompetencia;->$as_MnemoVariante)
					
				: (($y_arregloTipoObjeto->{$i}=Logro_Aprendizaje) & ($at_nombreCompetencia{$i}=""))
					GOTO RECORD:C242([MPA_ObjetosMatriz:204];$al_recNumObjetosMatriz{$i})
					DELETE RECORD:C58([MPA_ObjetosMatriz:204])
					AT_Delete ($i;1;->$ai_ordenEje;->$ai_ordenDimension;->$ai_OrdenCompetencia;->$al_recNumObjetosMatriz;$y_arregloTipoObjeto;->$al_IdEje;->$at_NombreEje;->$al_IdDimension;->$at_nombreDimension;->$al_IDCompetencia;->$at_nombreCompetencia;->$as_MnemoVariante)
					
			End case 
		End for 
		
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Structure configuration:K51:2;Structure configuration:K51:2)
		SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Structure configuration:K51:2;Structure configuration:K51:2)
		ARRAY TEXT:C222($y_arregloNombreObjeto->;Size of array:C274($al_recNumObjetosMatriz))
		ARRAY LONGINT:C221($y_arregloIDObjeto->;Size of array:C274($al_recNumObjetosMatriz))
		ARRAY TEXT:C222($y_arregloRefIconos->;Size of array:C274($al_recNumObjetosMatriz))
		For ($i;1;Size of array:C274($al_recNumObjetosMatriz))
			Case of 
				: ($y_arregloTipoObjeto->{$i}=Eje_Aprendizaje)
					$y_arregloRefIconos->{$i}:="^9002"
					$y_arregloIDObjeto->{$i}:=$al_IdEje{$i}
					$y_arregloNombreObjeto->{$i}:=<>nbSpace+$at_NombreEje{$i}
				: ($y_arregloTipoObjeto->{$i}=Dimension_Aprendizaje)
					$y_arregloRefIconos->{$i}:=Char:C90(Space:K15:42)*2+"^9002"
					$y_arregloIDObjeto->{$i}:=$al_IdDimension{$i}
					$y_arregloNombreObjeto->{$i}:=<>nbSpace+$at_nombreDimension{$i}
				: ($y_arregloTipoObjeto->{$i}=Logro_Aprendizaje)
					$y_arregloRefIconos->{$i}:=""
					$y_arregloIDObjeto->{$i}:=$al_IDCompetencia{$i}
					If ($as_MnemoVariante{$i}="")
						$y_arregloNombreObjeto->{$i}:=<>nbSpace*3+$at_nombreCompetencia{$i}
					Else 
						$y_arregloNombreObjeto->{$i}:=<>nbSpace*3+"["+$as_MnemoVariante{$i}+"]"+$at_nombreCompetencia{$i}
					End if 
			End case 
		End for 
	End if 
End if 
