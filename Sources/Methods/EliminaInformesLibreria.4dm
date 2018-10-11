//%attributes = {}
  //START TRANSACTION
  // Creado por: Alexis Bustamante (18/08/2017)
  //Metodo para eliminar de librería informes duplicados en el repositorio.
C_LONGINT:C283($i;$x;$y;$l_idTermometro;$l_pos1)
ARRAY TEXT:C222($at_uuidEliminar;0)
ARRAY TEXT:C222($at_uuidActualizar;0)
ARRAY LONGINT:C221($al_indices;0)

C_TEXT:C284($t_json;$t_codigoPais;$t_codigoIdioma;$t_uuidColegio)

  //Informes que se deben quitar de la librería de los colegios ya que son duplicados en el Repositorio.
APPEND TO ARRAY:C911($at_uuidEliminar;"0802C05CB64444B189B0957C21C6E541")
APPEND TO ARRAY:C911($at_uuidEliminar;"FA6C38E2E0CA4F7BBD6F08242C2CB05C")
APPEND TO ARRAY:C911($at_uuidEliminar;"F27D651AFAD640568B4DCDF2595D1801")
APPEND TO ARRAY:C911($at_uuidEliminar;"2A0E6656EDA545A7B5BC5FD18F33E74F")
APPEND TO ARRAY:C911($at_uuidEliminar;"381A4865E9004ADFA42F2C95006AE86D")
APPEND TO ARRAY:C911($at_uuidEliminar;"DFC833B90E7B4AB9A80E61F4FAB9992F")
APPEND TO ARRAY:C911($at_uuidEliminar;"51E90CA255F34588AE6A4F43559CCCDB")
APPEND TO ARRAY:C911($at_uuidEliminar;"986AB8BEF82B4473B3A1597F07F7FE67")
APPEND TO ARRAY:C911($at_uuidEliminar;"6FE08CA0EEE04184A44153DC750DBC05")
APPEND TO ARRAY:C911($at_uuidEliminar;"3F75D98B2C1E4376AFA79E38767B61A7")
APPEND TO ARRAY:C911($at_uuidEliminar;"001CE7584AF748FCB87EEF088A3F01A1")
APPEND TO ARRAY:C911($at_uuidEliminar;"E1A8DA8A64284630973116617158837A")
APPEND TO ARRAY:C911($at_uuidEliminar;"CFE63610F556F840B694F6396846E28D")
APPEND TO ARRAY:C911($at_uuidEliminar;"B818E13C437E9144B4807F5AD2BD54B0")
APPEND TO ARRAY:C911($at_uuidEliminar;"EAC78DF4442ED24399DF4FB71BAB9D93")
APPEND TO ARRAY:C911($at_uuidEliminar;"29C254183E921B458DEA79E1FED5D04A")  //Cierre de caja duplicado

APPEND TO ARRAY:C911($at_uuidActualizar;"EFFAA4DCA2634C879B1344BF3A8B07FA")  //19 inf
APPEND TO ARRAY:C911($at_uuidActualizar;"A8576523D944034F9EE6EFC682E1A775")  //hay un informe triplicado,
APPEND TO ARRAY:C911($at_uuidActualizar;"A8576523D944034F9EE6EFC682E1A775")
APPEND TO ARRAY:C911($at_uuidActualizar;"1E37BE5F726C234C8955404C91B57231")
APPEND TO ARRAY:C911($at_uuidActualizar;"AB1911199CB47C4BB40E5FD3383514E7")
APPEND TO ARRAY:C911($at_uuidActualizar;"40F704F7D3F79D4EA5E55FAF29E9A942")
APPEND TO ARRAY:C911($at_uuidActualizar;"CF3567F12D0148389F11A1C247334388")
APPEND TO ARRAY:C911($at_uuidActualizar;"B2068E8A1C8C4C4587B1191FCFF25D37")
APPEND TO ARRAY:C911($at_uuidActualizar;"D346BF26628842FE829A466FFAD8EE05")
APPEND TO ARRAY:C911($at_uuidActualizar;"C73B60F2A8354989A80BD4BCF817CBC5")
APPEND TO ARRAY:C911($at_uuidActualizar;"D8C99C687F8246C3BAF7A34F8E539C3F")
APPEND TO ARRAY:C911($at_uuidActualizar;"97BAB72B9D4E4E9F839475BF29CFAF39")
APPEND TO ARRAY:C911($at_uuidActualizar;"9046B0537BAF4B01A2017B6814B654B9")
APPEND TO ARRAY:C911($at_uuidActualizar;"9046B0537BAF4B01A2017B6814B654B9")
APPEND TO ARRAY:C911($at_uuidActualizar;"9046B0537BAF4B01A2017B6814B654B9")
APPEND TO ARRAY:C911($at_uuidActualizar;"40F704F7D3F79D4EA5E55FAF29E9A942")  //uuid de actuaLIZACION

  //busco todos los reportes que estan en la librería del colegio.
$l_idTermometro:=IT_Progress (1;0;0;"Eliminando Informes Duplicados.")
For ($i;1;Size of array:C274($at_uuidEliminar))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($at_uuidEliminar);"")
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_uuidEliminar{$i})
	If (Records in selection:C76([xShell_Reports:54])>0)
		APPEND TO ARRAY:C911($al_indices;$i)
		KRL_DeleteSelection (->[xShell_Reports:54])
	End if 
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i/Size of array:C274($at_uuidEliminar);"")

  //informes que estaban duplicados pero se matubo el ultimo se busca actualizacion sino se descarga
$l_idTermometro:=IT_Progress (1;0;0;"Actualizando Informes")
For ($i;1;Size of array:C274($al_indices))
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274($al_indices);"")
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_uuidActualizar{$al_indices{$i}})
	If (Records in selection:C76([xShell_Reports:54])>0)
		RIN_DescargaActualizacion ($at_uuidActualizar{$al_indices{$i}};False:C215)
	Else 
		RIN_DescargaActualizacion ($at_uuidActualizar{$al_indices{$i}};False:C215)
	End if 
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i/Size of array:C274($al_indices);"")
  //CANCEL TRANSACTION