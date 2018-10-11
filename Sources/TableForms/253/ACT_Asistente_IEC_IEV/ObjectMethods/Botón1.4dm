  // [ACT_IECV].ACT_Asistente_IEC_IEV.Botón1()


C_LONGINT:C283($l_result)
ARRAY TEXT:C222($at_proveedores;0)
ARRAY TEXT:C222($at_proveedoresMethod;0)
ACTmnu_OpcionesGeneracionIECV ("CargaProveedoresXDefecto";->$at_proveedores;->$at_proveedoresMethod)
$vt_pref:=atACT_NombreFormato{atACT_NombreFormato}

$t_editar:=""
$t_eliminar:=""
Case of 
	: (Size of array:C274(atACT_NombreFormato)=0)
		$t_editar:="(Editar"
		$t_eliminar:="(Eliminar"
		
	: (Find in array:C230($at_proveedores;$vt_pref)#-1)
		$t_editar:="(Editar"
		$t_eliminar:="(Eliminar"
		
	Else 
		$t_editar:="Editar"
		$t_eliminar:="Eliminar"
		
End case 

$l_result:=Pop up menu:C542($t_editar+";-;"+"Cargar"+";-;"+$t_eliminar;0)

Case of 
	: ($l_result=1)
		
		C_BOOLEAN:C305($valid;$validFile)
		C_LONGINT:C283($offset)
		C_TEXT:C284($t_nombrePref)
		C_BOOLEAN:C305(vbACT_noMostrarTexto)
		C_BLOB:C604($xBlob)
		
		$t_nombrePref:=atACT_ReferenciaPref{atACT_ReferenciaPref}
		If ($t_nombrePref#"")
			vbACT_noMostrarTexto:=True:C214
			$xBlob:=PREF_fGetBlob (0;$t_nombrePref;$xBlob)
			
			If (BLOB size:C605($xBlob)>0)
				$offset:=0
				vtCode:=Convert to text:C1012($xBlob;"MacRoman")
				$validFile:=ACTtrf_IsValidTransferFile (vtCode)
				If ($validFile)
					vtCode:=ACTtrf_RemoveCheckCode (vtCode)
					WDW_OpenFormWindow (->[xxACT_ArchivosBancarios:118];"EditArchivoBancario";-1;4;__ ("Edición de código de IECV"))
					DIALOG:C40([xxACT_ArchivosBancarios:118];"EditArchivoBancario")
					CLOSE WINDOW:C154
					If (OK=1)
						  //agrega caracteres de validacion al texto...
						vtCode:=ACTtrf_AddCheckCode (vtCode)
						CONVERT FROM TEXT:C1011(vtCode;"MacRoman";$xBlob)
						  //TEXT TO BLOB(vtCode;$xBlob;Mac text without length)
						
						  //guarda preferencia
						PREF_SetBlob (0;$t_nombrePref;$xBlob)
						
						SET BLOB SIZE:C606($xBlob;0)
						vtCode:=""
					End if 
				Else 
					CD_Dlog (0;__ ("El código almacenado en este registro parece estar corrupto. Póngase en contacto con el personal de Colegium para solucionar este problema."))
				End if 
				
			Else 
				CD_Dlog (0;__ ("Archivo de configuración no encontrado."))
			End if 
		End if 
		
	: ($l_result=3)
		C_TEXT:C284($filePath;$vt_code;$vt_nombreProveedor)
		C_LONGINT:C283($err;$vl_recs;$vl_offSet)
		  //carga archivo
		$filePath:=xfGetFileName ("Restaurar desde:";"")
		If ($filePath#"")
			USE CHARACTER SET:C205("MacRoman";1)
			
			C_BLOB:C604($xBlob)
			DOCUMENT TO BLOB:C525(document;$xBlob)
			$vl_offSet:=0
			$vt_code:=Convert to text:C1012($xBlob;"MacRoman")
			$validFile:=ACTtrf_IsValidTransferFile ($vt_code)
			If ($validFile)
				
				  //ABK 20170213: desactivo este código: FootRunner abandonado, al parecer el código está validado antes en ACTtrf_IsValidTransferFile. 
				  // y la validación no es posible en PROCESS 4D TAGS si no se hace
				If (False:C215)
					  //  //footrunner valida el codigo
					  //$err:=FRAppendChecksum ($vt_code)
					  //If ($err#0)
					  //CD_Dlog (0;__ ("Error al validar el código."))
					  //Else 
				End if 
				
				
				  //obtengo el nombre del proveedor desde el nombre del archivo
				$vt_nombreProveedor:=SYS_Path2FileName ($filePath)
				$vt_nombreProveedor:=Substring:C12($vt_nombreProveedor;1;Length:C16($vt_nombreProveedor)-4)
				$vt_nombreProveedor:=Replace string:C233($vt_nombreProveedor;"_";"")
				
				ARRAY TEXT:C222($at_proveedores;0)
				ACTmnu_OpcionesGeneracionIECV ("CargaProveedoresXDefecto";->$at_proveedores)
				If (Find in array:C230($at_proveedores;$vt_nombreProveedor)#-1)
					$vt_nombreProveedor:=$vt_nombreProveedor+" 1"
				End if 
				$t_prefName:=ACTmnu_OpcionesGeneracionIECV ("GetNombrePreferencia")
				
				  //con el nombre base de la preferencia mas el proveedor obtengo el string completo
				$vt_nombrePref:=$t_prefName+"_"+$vt_nombreProveedor
				$vt_nombrePrefOrg:=$vt_nombrePref
				  //cargo los proveedores para saber si ya hay alguno llamado igual
				$vl_recs:=1
				$vl_contador:=1
				While ($vl_recs#0)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_recs)
					QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]Reference:1=$vt_nombrePref)
					SET QUERY DESTINATION:C396(Into current selection:K19:1)
					If ($vl_recs#0)
						$vt_nombrePref:=$vt_nombrePrefOrg+" "+String:C10($vl_contador)
					End if 
					$vl_contador:=$vl_contador+1
				End while 
				If ($vl_recs=0)
					ACTmnu_OpcionesGeneracionIECV ("CreaPrefModeloImportacion";->$vt_nombrePref;->$xBlob)
					
					  //carga conf
					ACTmnu_OpcionesGeneracionIECV ("CargaModelosImportacion")
					
				Else 
					CD_Dlog (0;__ ("Ya existe un proveedor con el nombre ")+ST_Qte ($vt_nombreProveedor)+"."+"\r\r"+__ ("El archivo no puede ser guardado."))
				End if 
				SET BLOB SIZE:C606($xBlob;0)
				
				
				  //End if 
				
			Else 
				CD_Dlog (0;__ ("Código no válido"))
			End if 
			
			USE CHARACTER SET:C205(*;1)
		End if 
		
		
	: ($l_result=5)
		ARRAY TEXT:C222($at_proveedores;0)
		ACTmnu_OpcionesGeneracionIECV ("CargaProveedoresXDefecto";->$at_proveedores)
		$t_nombrePref:=atACT_ReferenciaPref{atACT_ReferenciaPref}
		$t_pref:=ST_GetWord ($t_nombrePref;4;"_")
		If (Find in array:C230($at_proveedores;$t_pref)=-1)
			$l_resp:=CD_Dlog (0;__ ("Se eliminará el modelo de procesamiento "+ST_Qte ($t_nombrePref)+".")+"\r\n"+"\r\n"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
			If ($l_resp=1)
				READ WRITE:C146([xShell_Prefs:46])
				QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
				QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$t_nombrePref)
				If (Not:C34(Locked:C147([xShell_Prefs:46])))
					DELETE RECORD:C58([xShell_Prefs:46])
					KRL_UnloadReadOnly (->[xShell_Prefs:46])
					LOG_RegisterEvt ("Archivo de información electrónica de Compra y Venta eliminado. Archivo eliminado: "+$t_nombrePref+".")
					
					ACTmnu_OpcionesGeneracionIECV ("CargaModelosImportacion")
					
				Else 
					CD_Dlog (0;__ ("El registro no pudo ser eliminado"))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("Los modelos por defecto no pueden ser eliminados."))
		End if 
End case 
