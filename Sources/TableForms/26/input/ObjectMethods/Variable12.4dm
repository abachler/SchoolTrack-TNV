
ARRAY INTEGER:C220(aLines;0)
$r:=AL_GetSelect (xalp_Comunas;aLines)
If ($r=1)
	AL_UpdateArrays (xalp_ListaComunas;0)
	For ($i;1;Size of array:C274(aLines))
		$IndiceCreacion:=Size of array:C274(atBU_NomCom)+1
		INSERT IN ARRAY:C227(atBU_NomCom;$IndiceCreacion)
		atBU_NomCom{$IndiceCreacion}:=atBU_GenNomCom{aLines{$i}}
		READ WRITE:C146([BU_Rutas_Comunas:27])
		QUERY:C277([BU_Rutas_Comunas:27];[BU_Rutas_Comunas:27]Numero_Ruta:1=aLines{$i})
		SELECTION TO ARRAY:C260([BU_Rutas_Comunas:27]Nombre_Comuna:2;$comunas)
	End for 
	AL_UpdateArrays (xalp_ListaComunas;-2)
	AL_UpdateArrays (xalp_Comunas;0)
	For ($i;Size of array:C274(aLines);1;-1)
		AT_Delete (aLines{$i};1;->atBU_GenNomCom)
	End for 
	AL_UpdateArrays (xalp_Comunas;-2)
	AT_Initialize (->aLines)
End if 