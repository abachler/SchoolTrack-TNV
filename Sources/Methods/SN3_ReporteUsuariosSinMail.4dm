//%attributes = {}
C_BOOLEAN:C305($b_MensajeAlumnos;$b_MensjePersonas)
C_LONGINT:C283($l_indice;$l_therm)
C_TIME:C306($h_Ref)
C_TEXT:C284($t_NombreArchivo;$t_NombreArchivoAlumno;$t_Ruta;$t_RutaArchivo)

If (SYS_IsWindows )
	USE CHARACTER SET:C205("windows-1252";0)
Else 
	USE CHARACTER SET:C205("MacRoman";0)
End if 

$t_Ruta:=xfGetDirName ("Seleccione ubicación")

If ($t_Ruta#"")
	QUERY:C277([Personas:7];[Personas:7]Inactivo:46=False:C215;*)
	QUERY:C277([Personas:7]; & ;[Personas:7]eMail:34="")
	ORDER BY:C49([Personas:7];[Personas:7]No:1;>)
	If (Records in selection:C76([Personas:7])>0)
		$l_therm:=IT_UThermometer (1;0;"Verificando Email de Relaciones Familiares...")
		SELECTION TO ARRAY:C260([Personas:7]Apellidos_y_nombres:30;at_PersonasNombre;[Personas:7]RUT:6;at_PersonasRut;[Personas:7]No:1;at_PersonasID)
		$t_NombreArchivo:="RelacionesFamiliares_sin_Mail.TXT"
		$t_RutaArchivo:=$t_Ruta+$t_NombreArchivo
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		If (SYS_TestPathName ($t_RutaArchivo)=1)
			DELETE DOCUMENT:C159($t_RutaArchivo)
		End if 
		If (ok=1)
			$h_Ref:=Create document:C266($t_RutaArchivo;"TEXT")
			If ($h_Ref#?00:00:00?)
				IO_SendPacket ($h_Ref;"No SchoolTrack"+"\t"+"Nombre"+"\t"+"Rut"+"\r")
				For ($l_indice;1;Size of array:C274(at_PersonasNombre))
					IO_SendPacket ($h_Ref;String:C10(at_PersonasID{$l_indice})+"\t"+at_PersonasNombre{$l_indice}+"\t"+at_PersonasRut{$l_indice}+"\r")
				End for 
				
				CLOSE DOCUMENT:C267($h_Ref)
			Else 
				$b_MensjePersonas:=True:C214
			End if 
		Else 
			$b_MensjePersonas:=True:C214
		End if 
		IT_UThermometer (-2;$l_therm)
	Else 
		  //Mensaje
	End if 
	
	QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activo";*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]eMAIL:68="")
	ORDER BY:C49([Alumnos:2];[Alumnos:2]numero:1;>)
	If (Records in selection:C76([Alumnos:2])>0)
		$l_therm:=IT_UThermometer (1;0;"Verificando Email de Alumnos...")
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;at_AlumnosNombre;[Alumnos:2]RUT:5;at_AlumnosRut;[Alumnos:2]numero:1;at_AlumnosID)
		$t_NombreArchivoAlumno:="Alumnos_sin_Mail.TXT"
		$t_RutaArchivo:=$t_Ruta+$t_NombreArchivoAlumno
		EM_ErrorManager ("Install")
		EM_ErrorManager ("SetMode";"")
		If (SYS_TestPathName ($t_RutaArchivo)=1)
			DELETE DOCUMENT:C159($t_RutaArchivo)
		End if 
		If (ok=1)
			$h_Ref:=Create document:C266($t_RutaArchivo;"TEXT")
			If ($h_Ref#?00:00:00?)
				IO_SendPacket ($h_Ref;"No SchoolTrack"+"\t"+"Nombre Alumno"+"\t"+"RUT"+"\r")
				For ($l_indice;1;Size of array:C274(at_AlumnosNombre))
					IO_SendPacket ($h_Ref;String:C10(at_AlumnosID{$l_indice})+"\t"+at_AlumnosNombre{$l_indice}+"\t"+at_AlumnosRut{$l_indice}+"\r")
				End for 
				CLOSE DOCUMENT:C267($h_Ref)
			Else 
				$b_MensajeAlumnos:=True:C214
			End if 
		Else 
			$b_MensajeAlumnos:=True:C214
		End if 
	End if 
	IT_UThermometer (-2;$l_therm)
Else 
	  //Mensaje
End if 

Case of 
	: (($b_MensajeAlumnos) & ($b_MensjePersonas))
		CD_Dlog (0;__ ("No fue posible generar los archivos. Es probable que estos se encuentren en uso.")+"\r\r"+__ ("Intente más tarde."))
	: ($b_MensajeAlumnos)
		CD_Dlog (0;__ ("No fue posible generar el archivo ")+ST_Qte ($t_NombreArchivoAlumno)+__ (". Revise si el archivo está en uso.")+"\r\r"+__ ("Intente más tarde."))
	: ($b_MensjePersonas)
		CD_Dlog (0;__ ("No fue posible generar el archivo ")+ST_Qte ($t_NombreArchivo)+__ (". Revise si el archivo está en uso.")+"\r\r"+__ ("Intente más tarde."))
End case 

USE CHARACTER SET:C205(*;0)