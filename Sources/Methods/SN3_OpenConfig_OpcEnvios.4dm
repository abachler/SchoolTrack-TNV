//%attributes = {}
  //SN3_OpenConfig_OpcEnvios

  //20152010 JVP agrego validacion de modulo y proceso
If (LICENCIA_esModuloAutorizado (1;SchoolNet))
	
	If (USR_GetMethodAcces (Current method name:C684))
		
		WDW_OpenFormWindow (->[SN3_PublicationPrefs:161];"OpcionesEnvios";0;4;__ ("Configuración SchoolNet"))
		DIALOG:C40([SN3_PublicationPrefs:161];"OpcionesEnvios")
		CLOSE WINDOW:C154
	Else 
		ok:=0
	End if 
Else 
	CD_Dlog (0;__ ("Lo siento, Ud. no está autorizado para utilizar esta función."))
	ok:=0
End if 

If (ok=1)
	Case of 
		: (bUpdateAll=1)
			If (cb_Manual_OnServer=1)
				$p:=Execute on server:C373("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;True:C214)
				LOG_RegisterEvt ("Envío manual de todos los datos a SchoolNet iniciado en el servidor.")
				SN3_RegisterLogEntry (SN3_Log_Info;"Envío manual de todos los datos a SchoolNet iniciado en el servidor.")
			Else 
				$r:=CD_Dlog (0;__ ("El envío de datos a SchoolNet comenzará ahora en esta máquina.");"";__ ("Cancelar");__ ("Continuar"))
				If ($r=2)
					$p:=New process:C317("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;True:C214)
					LOG_RegisterEvt ("Envío manual de todos los datos a SchoolNet iniciado en "+Current machine:C483+".")
					SN3_RegisterLogEntry (SN3_Log_Info;"Envío manual de todos los datos a SchoolNet iniciado en "+Current machine:C483+".")
				End if 
			End if 
		: (bUpdateMod=1)
			If (cb_Manual_OnServer=1)
				$p:=Execute on server:C373("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;False:C215)
				LOG_RegisterEvt ("Envío manual de datos modificados a SchoolNet iniciado en el servidor.")
				SN3_RegisterLogEntry (SN3_Log_Info;"Envío manual de datos modificados a SchoolNet iniciado en el servidor.")
			Else 
				$r:=CD_Dlog (0;__ ("El envío de datos a SchoolNet comenzará ahora en esta máquina.");"";__ ("Cancelar");__ ("Continuar"))
				If ($r=2)
					$p:=New process:C317("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;False:C215)
					LOG_RegisterEvt ("Envío manual de datos modificados a SchoolNet iniciado en "+Current machine:C483+".")
					SN3_RegisterLogEntry (SN3_Log_Info;"Envío manual de datos modificados a SchoolNet iniciado en "+Current machine:C483+".")
				End if 
			End if 
		: (b_Manual_Enviar=1)
			NIV_LoadArrays 
			hl_Niveles:=New list:C375
			APPEND TO LIST:C376(hl_Niveles;"Todos";SN3_TodosLosNiveles)
			APPEND TO LIST:C376(hl_Niveles;"-";0)
			For ($i;1;Size of array:C274(<>al_NumeroNivelesSchoolNet))
				APPEND TO LIST:C376(hl_Niveles;<>at_NombreNivelesSchoolNet{$i};<>al_NumeroNivelesSchoolNet{$i})
			End for 
			hl_Dato:=Load list:C383("SN3_DatosPublicables")
			APPEND TO LIST:C376(hl_Dato;"-";0)
			APPEND TO LIST:C376(hl_Dato;"Datos Generales";SN3_DTi_DatosGenerales)
			APPEND TO LIST:C376(hl_Dato;"Alumnos";SN3_DTi_Alumnos)
			APPEND TO LIST:C376(hl_Dato;"Relaciones Familiares";SN3_DTi_RelacionesFamiliares)
			APPEND TO LIST:C376(hl_Dato;"Familias";SN3_DTi_Familias)
			APPEND TO LIST:C376(hl_Dato;"Profesores";SN3_DTi_Profesores)
			APPEND TO LIST:C376(hl_Dato;"Cursos";SN3_DTi_Cursos)
			APPEND TO LIST:C376(hl_Dato;"Asignaturas";SN3_DTi_Asignaturas)
			APPEND TO LIST:C376(hl_Dato;"Actividades Extracurriculares (Definiciones)";SN3_DTi_ActividadesExtraCurr)
			APPEND TO LIST:C376(hl_Dato;"Matrices de Aprendizaje";SN3_DTi_MatricesAprendizaje)
			C_BLOB:C604(xBlob)
			SET BLOB SIZE:C606(xBlob;0)
			$text:=""
			For ($y;1;Size of array:C274(SN3_Manual_DataRefs))
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Niveles;SN3_Manual_NivelesLong{$y})
				GET LIST ITEM:C378(hl_Niveles;Selected list items:C379(hl_Niveles);$nivelRef;$nivel)
				SELECT LIST ITEMS BY REFERENCE:C630(hl_Dato;SN3_Manual_DataRefs{$y})
				GET LIST ITEM:C378(hl_Dato;Selected list items:C379(hl_Dato);$datoRef;$dato)
				$cuales:=("Todos"*Num:C11(SN3_Manual_CualesDatosBool{$y}))+("Sólo Modificados"*Num:C11(Not:C34(SN3_Manual_CualesDatosBool{$y})))
				$text:=$text+$dato+", "+$nivel+", "+$cuales+"\r"
			End for 
			$text:=Substring:C12($text;1;Length:C16($text)-1)
			HL_ClearList (hl_Dato;hl_Niveles)
			BLOB_Variables2Blob (->xBlob;0;->SN3_Manual_DataRefs;->SN3_Manual_NivelesLong;->SN3_Manual_CualesDatosBool)
			If (cb_Manual_OnServer=1)
				$p:=Execute on server:C373("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;True:C214;xBlob)
				LOG_RegisterEvt ("Envío manual de datos a SchoolNet iniciado en el servidor. Se envía:"+"\r"+$text)
				SN3_RegisterLogEntry (SN3_Log_Info;"Envío manual de datos a SchoolNet iniciado en el servidor. Se envía:"+"\r"+$text)
			Else 
				$r:=CD_Dlog (0;__ ("El envío de datos a SchoolNet comenzará ahora en esta máquina.");"";__ ("Cancelar");__ ("Continuar"))
				If ($r=2)
					$p:=New process:C317("SN3_SendData2SchoolNet";128000;"Envio de Datos SN3";True:C214;True:C214;xBlob)
					LOG_RegisterEvt ("Envío manual de datos a SchoolNet iniciado en "+Current machine:C483+". Se envía:"+"\r"+$text)
					SN3_RegisterLogEntry (SN3_Log_Info;"Envío manual de datos a SchoolNet iniciado en "+Current machine:C483+". Se envía:"+"\r"+$text)
				End if 
			End if 
			SET BLOB SIZE:C606(xBlob;0)
	End case 
End if 
