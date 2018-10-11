//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 11-09-18, 16:33:06
  // ----------------------------------------------------
  // Método: STWA2_MaterialDocenteDAO
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_OBJECT:C1216($o_raiz)

$y_Names:=$1
$y_Data:=$2
$t_accion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"accion")
$t_parametros:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"parametros")
$o_parametros:=JSON Parse:C1218($t_parametros)
$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$userName:=USR_GetUserName ($userID)

Case of 
	: ($t_accion="insert")
		$t_url:=OB Get:C1224($o_parametros;"url")
		$t_nombre:=OB Get:C1224($o_parametros;"nombre")
		$t_descripcion:=OB Get:C1224($o_parametros;"descripcion")
		$l_rnAsig:=OB Get:C1224($o_parametros;"rnAsig";Is longint:K8:6)
		
		If (KRL_GotoRecord (->[Asignaturas:18];$l_rnAsig;False:C215))
			CREATE RECORD:C68([Asignaturas_Adjuntos:230])
			[Asignaturas_Adjuntos:230]ID:1:=SQ_SeqNumber (->[Asignaturas_Adjuntos:230]ID:1)
			[Asignaturas_Adjuntos:230]id_asignatura:7:=[Asignaturas:18]Numero:1
			[Asignaturas_Adjuntos:230]nombre_adjunto:10:=$t_nombre
			[Asignaturas_Adjuntos:230]id_profesor:9:=$profID
			[Asignaturas_Adjuntos:230]descripcion:3:=$t_descripcion
			SAVE RECORD:C53([Asignaturas_Adjuntos:230])
			
			If (OK=1)
				READ ONLY:C145([xShell_Documents:91])
				CREATE RECORD:C68([xShell_Documents:91])
				[xShell_Documents:91]RelatedTable:1:=Table:C252(->[Asignaturas_Adjuntos:230])
				[xShell_Documents:91]RelatedID:2:=[Asignaturas_Adjuntos:230]ID:1
				[xShell_Documents:91]RefType:10:="URL"
				[xShell_Documents:91]DocumentType:5:="URL"
				[xShell_Documents:91]URL:11:=$t_url
				[xShell_Documents:91]DocumentName:3:=$t_nombre
				[xShell_Documents:91]OriginalPath:12:=""
				[xShell_Documents:91]DocSize:13:=0
				[xShell_Documents:91]DocumentDescription:4:=$t_descripcion
				[xShell_Documents:91]ApplicationName:6:=""
				SAVE RECORD:C53([xShell_Documents:91])
				Log_RegisterEvtSTW ("Material docente: Se agrea URL :"+$t_url+" a la asignatura: "+[Asignaturas:18]Asignatura:3+", ID SchoolTrack :"+String:C10([Asignaturas:18]Numero:1);$userID)
				OB SET:C1220($o_raiz;"OK";True:C214)
			End if 
			
		End if 
		
End case 

$0:=$o_raiz