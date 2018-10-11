//%attributes = {}
  //  `0xDev_SendAllReports2Repository
  //
  //If (Application type=4D Remote Mode )
  //$p:=Execute on server(Current method name;64000)
  //
  //Else 
  //C_LONGINT(vlWS_IDInformeOut)
  //
  //READ WRITE([xShell_Reports])
  //
  //QUERY([xShell_Reports];[xShell_Reports]Modificacion_Fecha=!00/00/00!)
  //APPLY TO SELECTION([xShell_Reports];[xShell_Reports]Modificacion_Fecha:=!01/09/2000!)
  //  `
  //QUERY([xShell_Reports];[xShell_Reports]LangageCode="")
  //APPLY TO SELECTION([xShell_Reports];[xShell_Reports]LangageCode:="es")
  //
  //QUERY([xShell_Reports];[xShell_Reports]IsStandard=True)
  //
  //
  //ARRAY LONGINT($aRecNums;0)
  //LONGINT ARRAY FROM SELECTION([xShell_Reports];$aRecNums;"")
  //
  //
  //
  //CD_THERMOMETRE (1;0;__ ("Enviando informes al repositorio..."))
  //For ($i;1;Size of array($aRecNums))
  //GOTO RECORD([xShell_Reports];$aRecNums{$i})
  //CD_THERMOMETRE (0;$i/Size of array($aRecNums)*100;__ ("Enviando informes al repositorio: ")+[xShell_Reports]ReportName)
  //$result:=QR_RIN_RecordExists_NU 
  //If ($result>0)
  //  `Añade el modulo
  //vt_Keywords:=[xShell_Reports]Modulo+"\r"
  //  `Añade el nombre de la tabla principal 
  //Case of 
  //: ([xShell_Reports]ReportType="")  `Busca nombre de tabla principal si es super report
  //QUERY([xShell_Tables];[xShell_Tables]TableNumber;=;[xShell_Reports]SR_MainTable)
  //vt_Keywords:=vt_Keywords+[xShell_Tables]TableName+"\r"
  //Else   `Busca nombre de tabla principal para los otros tipo de informes distindos  a super report
  //QUERY([xShell_Tables];[xShell_Tables]TableNumber;=;[xShell_Reports]MainTable)
  //vt_Keywords:=vt_Keywords+[xShell_Tables]TableName+"\r"
  //End case 
  //
  //If ([xShell_Reports]RelatedTable#0)  `Busca nombre de tabla relacionada si tiene.
  //QUERY([xShell_Tables];[xShell_Tables]TableNumber;=;[xShell_Reports]RelatedTable)
  //vt_Keywords:=vt_Keywords+[xShell_Tables]TableName+"\r"
  //End if 
  //vtRIN_Comentario:="Añadido al repositorio"
  //$idInforme:=QR_RIN_SendReport_NU 
  //End if 
  //End for 
  //CD_THERMOMETRE (-1)
  //End if 
  //
