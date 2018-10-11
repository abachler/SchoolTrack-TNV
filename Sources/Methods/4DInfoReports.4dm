//%attributes = {}
  //  // ----------------------------------------------------
  //  // Usuario (SO): Alberto Bachler Klein
  //  // Fecha y hora: 15-10-15, 09:58:17
  //  // ----------------------------------------------------
  //  // Método: 4DInfoReports
  //  // Descripción
  //  // 
  //  //
  //  // Parámetros
  //  // ----------------------------------------------------
  //C_BLOB($x_blob)
  //C_BLOB($0)

  //C_BOOLEAN($b_rutaOK)
  //C_TEXT($t_encabezado;$t_evento;$t_rutaInformes)

  //ARRAY TEXT($at_Components;0)



  //$t_evento:=$1



  //COMPONENT LIST($at_Components)
  //If (Find in array($at_Components;"4D_Info_Report@")>0)
  //Case of 
  //: ($t_evento="startOnServer")
  //4DInfoReports_StartOnServer 

  //: ($t_evento="getLastServerReport")
  //aa4D_NP_Get_Last_Server_Report (->$t_4DinfoReportName;$y_4DInfoReport)
  //TEXT TO BLOB($t_4DinfoReportName;$x_blob;UTF8 text without length)

  //: ($t_evento="getLocal")
  //$t_rutaReporte:=Temporary folder+"Reportes de ejecución"
  //EXECUTE METHOD("aa4D_M_Folder_Rep_SetPath_local";$b_rutaOK;->$t_rutaReporte)
  //aa4D_M_CreateReport_faceless 
  //DOCUMENT LIST($t_rutaReporte;$at_documentos;Absolute path)
  //If (Size of array($at_documentos)>0)
  //SORT ARRAY($at_documentos;<)
  //DOCUMENT TO BLOB($at_documentos{1};$x_blob)
  //End if 
  //End case 





  //End if 

  //$0:=$x_blob