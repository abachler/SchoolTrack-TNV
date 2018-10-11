  // Metodos y Comandos.Botón1()
  // Por: Alberto Bachler: 26/02/13, 08:25:49
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
SORT LIST:C391(hl_temas)
LIST TO BLOB:C556(hl_temas;$x_Blob)
$l_error:=KRL_SendFileToServer ("Resources"+Folder separator:K24:12+"4DCommandList_"+"ES"+".blob";$x_Blob)

  //HL_ClearList (hl_comandos;hl_temas;hl_metodos)




