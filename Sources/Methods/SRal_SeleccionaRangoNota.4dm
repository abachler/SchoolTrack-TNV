//%attributes = {}
  //SRal_SeleccionaRangoNota

C_TEXT:C284(vtRango)
C_TEXT:C284(vtOrden1;vtOrden2;vtOrden3)
C_LONGINT:C283(vlAL_WinRef)
C_TEXT:C284(vt_cantidad1;vt_cantidad2;vt_mensaje)
C_BOOLEAN:C305(vb_export)
vtRango:="Rango nota"
vtOrden1:="Nivel/Curso"
vtOrden2:="Apellidos y nombres"
vtOrden3:="Promedio"
vt_cantidad1:="1"
vt_cantidad2:="4"
vb_export:=True:C214
vt_mensaje:="La búsqueda se efectúa sobre el promedio general oficial del alumno."
vlAL_WinRef:=WDW_OpenFormWindow (->[xxSTR_Constants:1];"STR_SeleccionaNivelRango";-1;4;__ ("Búsqueda de registros"))
DIALOG:C40([xxSTR_Constants:1];"STR_SeleccionaNivelRango")
CLOSE WINDOW:C154
If (ok=1)
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>=vNivelInterno1;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<=vNivelInterno2)
	If (Records in selection:C76([Alumnos:2])>0)
		If (Num:C11(vt_cantidad2)=0)
			vt_cantidad2:="7"
		End if 
		If ((Num:C11(vt_cantidad1)>0) & (Num:C11(vt_cantidad2)>0))
			QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Promedio_General_Oficial:32>=vt_cantidad1;*)
			QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]Promedio_General_Oficial:32<=vt_cantidad2)
			If (Records in selection:C76([Alumnos:2])>0)
				Case of 
					: (btOrden1=1)
						Case of 
							: (OrdenD=1)
								ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;<;[Alumnos:2]Promedio_General_Oficial:32;<)
							Else 
								ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>;[Alumnos:2]Promedio_General_Oficial:32;>)
						End case 
					: (btOrden2=1)
						Case of 
							: (OrdenD=1)
								ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;<;[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]Promedio_General_Oficial:32;<)
							Else 
								ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>;[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]Promedio_General_Oficial:32;>)
						End case 
					: (btOrden3=1)
						Case of 
							: (OrdenD=1)
								ORDER BY:C49([Alumnos:2];[Alumnos:2]Promedio_General_Oficial:32;<;[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;<)
							Else 
								ORDER BY:C49([Alumnos:2];[Alumnos:2]Promedio_General_Oficial:32;>;[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
						End case 
					Else 
						Case of 
							: (OrdenD=1)
								ORDER BY:C49([Alumnos:2];[Alumnos:2]Promedio_General_Oficial:32;<;[Alumnos:2]nivel_numero:29;<;[Alumnos:2]curso:20;<;[Alumnos:2]apellidos_y_nombres:40;<)
							Else 
								ORDER BY:C49([Alumnos:2];[Alumnos:2]Promedio_General_Oficial:32;>;[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
						End case 
				End case 
				If (cs_Exportar=1)
					ARRAY TEXT:C222(aText1;0)
					ARRAY TEXT:C222(aText2;0)
					ARRAY TEXT:C222(aText3;0)
					ARRAY REAL:C219(aReal1;0)
					SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;aText1;[Alumnos:2]curso:20;aText2;[Alumnos:2]Promedio_General_Oficial:32;aText3;[Alumnos:2]Promedio_General_Numerico:57;aReal1)
					C_TEXT:C284($folderPath;$filePath;$text;$fileName;vt_Foldername)
					C_TIME:C306($ref)
					$fileName:="Listado de alumnos.txt"
					vt_Foldername:=xfGetDirName ("Seleccione el directorio donde desea guardar los archivos")
					If (vt_folderName#"")
						$filePath:=vt_Foldername+$fileName
						EM_ErrorManager ("Install")
						EM_ErrorManager ("SetMode";"")
						$ref:=Create document:C266($filePath;"TEXT")
						EM_ErrorManager ("Clear")
						If ($ref#?00:00:00?)
							$text:="Exportado el "+String:C10(Current date:C33(*);7)+", a las "+String:C10(Current time:C178(*);2)+", por "+<>tUSR_CurrentUser+"."+"\r\r"
							IO_SendPacket ($ref;$text)
							$text:="Apellidos y nombres"+"\t"+"Curso"+"\t"+"Promedio general oficial"+"\t"+"Promedio general con decimales"+"\r"
							IO_SendPacket ($ref;$text)
							For ($i;1;Size of array:C274(aReal1))
								$text:=aText1{$i}+"\t"+aText2{$i}+"\t"+aText3{$i}+"\t"+String:C10(aReal1{$i})+"\r"
								IO_SendPacket ($ref;$text)
							End for 
						End if 
						CLOSE DOCUMENT:C267($ref)
						AT_Initialize (->aText1;->aText2;->aText3;->aReal1)
						CD_Dlog (0;__ ("Informe exportado. Lo encontrará en: ")+$filePath+__ (".\r\rLe recomendamos abrir el archivo con Excel."))
					End if 
					ok:=0
				Else 
				End if 
			Else 
				CD_Dlog (0;__ ("No hay alumnos que cumplan con el rango de calificaciones ingresado."))
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("No hay alumnos para los niveles seleccionados."))
	End if 
End if 