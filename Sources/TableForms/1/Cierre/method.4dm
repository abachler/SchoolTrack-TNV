Case of 
	: (Form event:C388=On Load:K2:1)
		
		OBJECT SET VISIBLE:C603(lb_ErroresPagos;False:C215)
		OBJECT SET VISIBLE:C603(bTextFile;False:C215)
		
		XS_SetInterface 
		vi_PageNumber:=1
		vi_step:=1
		
		  //Inicializaciones pagina 2
		
		ARRAY TEXT:C222(aMeses;0)
		COPY ARRAY:C226(<>atXS_MonthNames;aMeses)
		vl_Mes:=Month of:C24(Current date:C33(*))
		vs_Mes:=aMeses{vl_Mes}
		vl_Año:=Year of:C25(Current date:C33(*))-1
		
		vt_year:=ST_Uppercase ("Cierre: "+vs_Mes+" "+String:C10(vl_Año))
		
		C_TEXT:C284(vt_instrucciones;vt_infoCierre)
		vt_instrucciones:="Este asistente le guiará en el proceso de Cierre de AccountTrack"+"\r\r"+"Dicho proceso se realiza en 3 etapas"+"\r\r"+"-Diagnóstico de la base de datos"+"\r"+"-Selección de opciones de cierre"+"\r"+"-Archivaje de los datos"
		vt_infoCierre:="Favor indicar hasta que mes y año desea realizar el cierre"
		OBJECT SET VISIBLE:C603(*;"vt2";False:C215)
		
		  //Inicializaciones pagina 3
		
		$backupPath:=SYS_GetDataPath 
		If (Application type:C494=4D Remote mode:K5:5)
			$backupPath:=Replace string:C233($backupPath;Data file:C490;"")
		Else 
			$backupPath:=SYS_GetParentNme ($backupPath)
		End if 
		$backupPath:=$backupPath+"Respaldos Base de Datos"
		$cDate:=Current date:C33(*)
		$timestring:=String:C10(Current time:C178(*);2)
		$time:=Replace string:C233($timestring;":";"")
		$dateString:=String:C10(Year of:C25($cDate);"0000")+String:C10(Month of:C24($cDate);"00")+String:C10(Day of:C23($cDate);"00")+"_"+$time
		  //20150723 RCH En windows se estaba dejando el separador de carpeta ":"...
		  //If (Position("//";$backupPath)>0)
		  //$delimiter:="\\"
		  //Else 
		  //$delimiter:=":"
		  //End if 
		$backupPath:=$backupPath+Folder separator:K24:12+<>gRolBD+"_"+$dateString
		vt_backupFolder:=$backupPath+Folder separator:K24:12
		vt_backupFile:="Pre_Cierre_ACT"+String:C10(<>gYear)
		vt_Backup:=vt_backupFolder+vt_backupFile
		
		  //Inicializaciones pagina 4
		
		IT_SetEnterable (False:C215;0;->vi_AgnosAvisos;->vi_AgnosPagos;->vi_AgnosDocDep;->vi_AgnosDocTrib)
		vi_AgnosAvisos:=Year of:C25(Current date:C33(*))
		vi_AgnosPagos:=Year of:C25(Current date:C33(*))
		vi_AgnosDocDep:=Year of:C25(Current date:C33(*))
		vi_AgnosDocTrib:=Year of:C25(Current date:C33(*))
		cb_EliminaHAvisos:=0
		cb_EliminaHPagos:=0
		cb_EliminaHDocDep:=0
		cb_EliminaHDocTrib:=0
		
		  //Inicializaciones pagina 5
		
		cb_InactivaEgresados:=0
		cb_InactivaRetirados:=0
		cb_LimpiaMatrices:=0
		cb_LimpiaDesctoXCta:=0
		
		cb_inicializaUFields:=1
		  //20120629 RCH
		cb_eliminaDocCarNulos:=1
		
		ACTcae_CargaVarsCierre (vl_Año;vl_Mes)
		
		vt_infoCierre:=""
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
End case 
