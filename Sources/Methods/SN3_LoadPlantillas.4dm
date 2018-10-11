//%attributes = {}
ARRAY TEXT:C222($result;0)
WEB SERVICE SET PARAMETER:C777("codpais";<>vtXS_CountryCode)
WEB SERVICE SET PARAMETER:C777("rolbd";<>gRolBD)

$err:=SN3_CallWebService ("sn3ws_plantillas_proceso.listado")

If ($err="")
	WEB SERVICE GET RESULT:C779($result;"resultado";*)
	ARRAY TEXT:C222(SN3_PlantillasNombres;0)
	ARRAY LONGINT:C221(SN3_PlantillasIDs;0)
	ARRAY TEXT:C222(SN3_PlantillasDesc;0)
	ARRAY LONGINT:C221(SN3_PlantillasEstilos;0)
	Case of 
		: (Size of array:C274($result)>1)
			If ($result{1}="@plantilla colegio")
				$index:=2
				vPlantillaColegio:=Num:C11($result{1})
			Else 
				$index:=1
				vPlantillaColegio:=-1
			End if 
			For ($i;$index;Size of array:C274($result))
				$id:=ST_GetWord ($result{$i};1;Char:C90(10))
				$nombre:=ST_GetWord ($result{$i};2;Char:C90(10))
				$desc:=ST_GetWord ($result{$i};3;Char:C90(10))
				APPEND TO ARRAY:C911(SN3_PlantillasNombres;$nombre)
				APPEND TO ARRAY:C911(SN3_PlantillasIDs;Num:C11($id))
				APPEND TO ARRAY:C911(SN3_PlantillasDesc;$desc)
				APPEND TO ARRAY:C911(SN3_PlantillasEstilos;Plain:K14:1)
			End for 
			SORT ARRAY:C229(SN3_PlantillasNombres;SN3_PlantillasIDs;SN3_PlantillasDesc;SN3_PlantillasEstilos;>)
			$el:=Find in array:C230(SN3_PlantillasIDs;vPlantillaColegio)
			If ($el#-1)
				SN3_PlantillasEstilos{$el}:=Bold:K14:2
			End if 
		: (Size of array:C274($result)=0)
			CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
		Else 
			CD_Dlog (0;__ ("No hay plantillas disponibles."))
	End case 
Else 
	CD_Dlog (0;__ ("No se pudo establecer la conexión con SchoolNet."))
End if 