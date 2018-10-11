//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Daniel Ledezma
  // Fecha y hora: 02-10-18, 18:59:36
  // ----------------------------------------------------
  // Método: UD_v20181002_SN3PubConfigUpd
  // Descripción
  // Ticket 209421
  // Separación de Conducta y Asistencia en las Opciones de Publicación
  // ----------------------------------------------------
C_LONGINT:C283($i;$l_idTermometro)
C_BLOB:C604($x_data)

$l_idTermometro:=IT_Progress (1;0;0;"Configuración de publicación de SchoolNet ...")

For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
	
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i/Size of array:C274(<>al_NumeroNivelesSchoolNet);"Configuración de publicación de SchoolNet ...")
	
	READ WRITE:C146([SN3_PublicationPrefs:161])
	QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=<>al_NumeroNivelesSchoolNet{$i})
	SN3_InitPubVariables 
	Case of 
		: (Records in selection:C76([SN3_PublicationPrefs:161])>1)
			KRL_DeleteSelection (->[SN3_PublicationPrefs:161];False:C215)
		: (Records in selection:C76([SN3_PublicationPrefs:161])=1)
			SN3_ParseConfigXML_OLD (->[SN3_PublicationPrefs:161]xData:2)
	End case 
	
	cb_PublicarAsistencia:=cb_PublicarConductaYAsistencia
	cb_PublicarConducta:=cb_PublicarConductaYAsistencia
	
	SET BLOB SIZE:C606($x_data;0)
	SN3_BuildConfigXML (->$x_data)
	[SN3_PublicationPrefs:161]xData:2:=$x_data
	COMPRESS BLOB:C534([SN3_PublicationPrefs:161]xData:2)
	SAVE RECORD:C53([SN3_PublicationPrefs:161])
	KRL_UnloadReadOnly (->[SN3_PublicationPrefs:161])
	
End for 
SET BLOB SIZE:C606($x_data;0)
$l_idTermometro:=IT_Progress (-1;$l_idTermometro)