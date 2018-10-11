//%attributes = {}
  //EVLG_ExpandCollapseObject

C_TEXT:C284($1;$action)
C_LONGINT:C283($2;$idMatriz;$3;$tipoObjeto;$4;$idObjeto;$5;$rowALP)
C_POINTER:C301($6;$arrayTipoObjeto;$7;$arrayIDObjeto;$8;$arrayNombreObjeto;$9;$arrayIconos)
$action:=$1
$idMatriz:=$2
$tipoObjeto:=$3
$idObjeto:=$4
$rowALP:=$5
$arrayTipoObjeto:=$6
$arrayIDObjeto:=$7
$arrayNombreObjeto:=$8
$arrayIconos:=$9

SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Automatic:K51:4;Manual:K51:3)
SET FIELD RELATION:C919([MPA_DefinicionCompetencias:187]ID_Dimension:23;Manual:K51:3;Manual:K51:3)
SET FIELD RELATION:C919([MPA_DefinicionDimensiones:188]ID_Eje:3;Manual:K51:3;Manual:K51:3)
ARRAY LONGINT:C221($aRecNums;0)

Case of 
	: ($action="Collapse")
		$tipoObjeto:=$arrayTipoObjeto->{$rowALP}
		$elements2Delete:=0
		Case of 
			: ($tipoObjeto=Eje_Aprendizaje)
				$arrayIconos->{$rowALP}:="^9003"
			: ($tipoObjeto=Dimension_Aprendizaje)
				$arrayIconos->{$rowALP}:=Char:C90(Space:K15:42)*2+"^9003"
		End case 
		For ($i;$rowALP+1;Size of array:C274($arrayIconos->))
			If ($arrayTipoObjeto->{$i}<=$tipoObjeto)
				$i:=Size of array:C274($arrayIconos->)
			Else 
				$elements2Delete:=$elements2Delete+1
			End if 
		End for 
		AT_Delete ($rowALP+1;$elements2Delete;$arrayNombreObjeto;$arrayIconos;$arrayTipoObjeto;$arrayIDObjeto)
		
	: ($action="Expand")
		Case of 
			: ($tipoObjeto=Eje_Aprendizaje)
				  //lectura de objetos no asociados a dimensión
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3;=;$idObjeto;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Matriz:1=$idMatriz;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]ID_Dimension:4=0)
				If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
					$arrayIconos->{$rowALP}:="^9002"
				End if 
				
				If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
					$registros:=Records in selection:C76([MPA_ObjetosMatriz:204])
					AT_Insert ($rowALP+1;$registros;$arrayNombreObjeto;$arrayIconos;$arrayTipoObjeto;$arrayIDObjeto)
					SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$aRecNums;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$aTipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$aIDEje;[MPA_DefinicionEjes:185]Nombre:3;$aNombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$aOrdenEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$aIDDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$aNombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$aOrdenDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$aIDCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$aNombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$aOrdenCompetencia)
					AT_MultiLevelSort (">>>";->$aOrdenEje;->$aOrdenDimension;->$aOrdenCompetencia;->$aRecNums;->$aTipoObjeto;->$aIDEje;->$aNombreEje;->$aIDDimension;->$aNombreDimension;->$aIDCompetencia;->$aNombreCompetencia)
					For ($iObjetos;1;Size of array:C274($aRecNums))
						$arrayIconos->{$rowALP+$iObjetos}:=""
						$arrayIDObjeto->{$rowALP+$iObjetos}:=$aIDCompetencia{$iObjetos}
						$arrayNombreObjeto->{$rowALP+$iObjetos}:=Char:C90(Space:K15:42)*4+$aNombreCompetencia{$iObjetos}
						$arrayTipoObjeto->{$rowALP+$iObjetos}:=Logro_Aprendizaje
					End for 
					$rowALP:=$rowALP+$registros
				End if 
				
				  //dimensiones
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Eje:3;=;$idObjeto;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Matriz:1=$idMatriz)
				QUERY SELECTION:C341([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Dimension_Aprendizaje)
				If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
					$arrayIconos->{$rowALP}:="^9002"
					$registros:=Records in selection:C76([MPA_ObjetosMatriz:204])
					AT_Insert ($rowALP+1;$registros;$arrayNombreObjeto;$arrayIconos;$arrayTipoObjeto;$arrayIDObjeto)
					SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$aRecNums;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$aTipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$aIDEje;[MPA_DefinicionEjes:185]Nombre:3;$aNombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$aOrdenEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$aIDDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$aNombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$aOrdenDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$aIDCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$aNombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$aOrdenCompetencia)
					AT_MultiLevelSort (">>>";->$aOrdenEje;->$aOrdenDimension;->$aOrdenCompetencia;->$aRecNums;->$aTipoObjeto;->$aIDEje;->$aNombreEje;->$aIDDimension;->$aNombreDimension;->$aIDCompetencia;->$aNombreCompetencia)
					For ($iObjetos;1;Size of array:C274($aIDDimension))
						SET QUERY LIMIT:C395(1)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$records)
						QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4=$aIDDimension{$iObjetos};*)
						QUERY:C277([MPA_ObjetosMatriz:204]; & [MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						SET QUERY LIMIT:C395(0)
						If ($records>0)
							$arrayIconos->{$rowALP+$iObjetos}:=Char:C90(Space:K15:42)*2+"^9003"
						Else 
							$arrayIconos->{$rowALP+$iObjetos}:=""
						End if 
						$arrayIDObjeto->{$rowALP+$iObjetos}:=$aIDDimension{$iObjetos}
						$arrayNombreObjeto->{$rowALP+$iObjetos}:=Char:C90(Space:K15:42)*2+$aNombreDimension{$iObjetos}
						$arrayTipoObjeto->{$rowALP+$iObjetos}:=Dimension_Aprendizaje
					End for 
				End if 
				
			: ($tipoObjeto=Dimension_Aprendizaje)
				QUERY:C277([MPA_ObjetosMatriz:204];[MPA_ObjetosMatriz:204]ID_Dimension:4;=;$idObjeto;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]Tipo_Objeto:2=Logro_Aprendizaje;*)
				QUERY:C277([MPA_ObjetosMatriz:204]; & ;[MPA_ObjetosMatriz:204]ID_Matriz:1=$idMatriz)
				If (Records in selection:C76([MPA_ObjetosMatriz:204])>0)
					$registros:=Records in selection:C76([MPA_ObjetosMatriz:204])
					$arrayIconos->{$rowALP}:=Char:C90(Space:K15:42)*2+"^9002"
					AT_Insert ($rowALP+1;$registros;$arrayNombreObjeto;$arrayIconos;$arrayTipoObjeto;$arrayIDObjeto)
					SELECTION TO ARRAY:C260([MPA_ObjetosMatriz:204];$aRecNums;[MPA_ObjetosMatriz:204]Tipo_Objeto:2;$aTipoObjeto;[MPA_ObjetosMatriz:204]ID_Eje:3;$aIDEje;[MPA_DefinicionEjes:185]Nombre:3;$aNombreEje;[MPA_DefinicionEjes:185]OrdenamientoNumerico:9;$aOrdenEje;[MPA_ObjetosMatriz:204]ID_Dimension:4;$aIDDimension;[MPA_DefinicionDimensiones:188]Dimensión:4;$aNombreDimension;[MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20;$aOrdenDimension;[MPA_ObjetosMatriz:204]ID_Competencia:5;$aIDCompetencia;[MPA_DefinicionCompetencias:187]Competencia:6;$aNombreCompetencia;[MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25;$aOrdenCompetencia)
					AT_MultiLevelSort (">>>";->$aOrdenEje;->$aOrdenDimension;->$aOrdenCompetencia;->$aRecNums;->$aTipoObjeto;->$aIDEje;->$aNombreEje;->$aIDDimension;->$aNombreDimension;->$aIDCompetencia;->$aNombreCompetencia)
					For ($iObjetos;1;Size of array:C274($aRecNums))
						$arrayIconos->{$rowALP+$iObjetos}:=""
						$arrayIDObjeto->{$rowALP+$iObjetos}:=$aIDCompetencia{$iObjetos}
						$arrayNombreObjeto->{$rowALP+$iObjetos}:=Char:C90(Space:K15:42)*4+$aNombreCompetencia{$iObjetos}
						$arrayTipoObjeto->{$rowALP+$iObjetos}:=Logro_Aprendizaje
					End for 
				End if 
		End case 
End case 

SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Dimension:4;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([MPA_ObjetosMatriz:204]ID_Competencia:5;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([MPA_DefinicionCompetencias:187]ID_Dimension:23;Structure configuration:K51:2;Structure configuration:K51:2)
SET FIELD RELATION:C919([MPA_DefinicionDimensiones:188]ID_Eje:3;Structure configuration:K51:2;Structure configuration:K51:2)