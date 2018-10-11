  // Build_Descarga()
  //
  //
  // creado por: Alberto Bachler Klein: 20-08-16, 13:25:04
  // -----------------------------------------------------------
C_DATE:C307($d_fechaGeneracion)
C_LONGINT:C283($i;$l_abajo;$l_arriba;$l_derecha;$l_dia;$l_izquierda)
C_TIME:C306($h_hora;$h_HoraGeneracion)
C_POINTER:C301($y_descarga;$y_dia;$y_hora;$y_instalarAuto;$y_instalarProgramado;$y_preferencias)
C_TEXT:C284($t_dts;$t_hora;$t_nombre;$t_rutaPrefs;$t_version)
C_OBJECT:C1216($ob_infoUpdates)

$y_preferencias:=OBJECT Get pointer:C1124(Object named:K67:5;"preferencias")
$y_descarga:=OBJECT Get pointer:C1124(Object named:K67:5;"descargar")
$y_instalarAuto:=OBJECT Get pointer:C1124(Object named:K67:5;"instalarAuto")
$y_instalarProgramado:=OBJECT Get pointer:C1124(Object named:K67:5;"instalarProgramado")
$y_hora:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")


Case of 
	: (Form event:C388=On Load:K2:1)
		$t_rutaPrefs:=Get 4D folder:C485(Database folder:K5:14)+"Preferences"+Folder separator:K24:12+"autoupdateSettings.json"
		$y_hora:=OBJECT Get pointer:C1124(Object named:K67:5;"hora")
		APPEND TO ARRAY:C911($y_hora->;?19:00:00?)
		For ($i;2;20)
			If ($y_hora->{$i-1}=?23:00:00?)
				APPEND TO ARRAY:C911($y_hora->;?03:00:00?)
			Else 
				APPEND TO ARRAY:C911($y_hora->;$y_hora->{$i-1}+?00:30:00?)
			End if 
		End for 
		$y_preferencias->:=BUILD_LoadPreferences 
		OB_GET ($y_preferencias->;$y_descarga;"descargar")
		OB_GET ($y_preferencias->;$y_instalarAuto;"instalarAuto")
		OB_GET ($y_preferencias->;$y_instalarProgramado;"instalarProgramado")
		OB_GET ($y_preferencias->;->$h_hora;"hora")
		OB_GET ($y_preferencias->;->$l_dia;"dia")
		  //$h_hora:=Time($t_hora;"-";":"))
		
		If ((OBJECT Get pointer:C1124(Object named:K67:5;"descargar"))->=1)
			OBJECT SET ENABLED:C1123(*;"instalar@";True:C214)
		Else 
			OBJECT SET ENABLED:C1123(*;"instalar@";False:C215)
		End if 
		
		OBJECT SET ENABLED:C1123(*;"Dia@";$y_instalarProgramado->=1)
		OBJECT SET ENABLED:C1123(*;"hora";$y_instalarProgramado->=1)
		
		$h_hora:=Choose:C955(Find in array:C230($y_hora->;$h_hora)>0;$h_hora;?03:00:00?)
		$y_hora->:=Find in array:C230($y_hora->;$h_hora)
		
		If ($l_dia=0)
			$l_dia:=1
		End if 
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"Dia"+String:C10($l_dia)))->:=1
		OBJECT GET COORDINATES:C663(*;"Dia"+String:C10($l_dia);$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		OBJECT SET COORDINATES:C1248(*;"hora";$l_derecha;$l_arriba)
		
		$ob_infoUpdates:=BUILD_LoadAutoupdateInfo 
		
		Case of 
			: (SYS_IsMacintosh )
				Case of 
					: (Application type:C494=4D Local mode:K5:1)  // solo para pruebas, la actualización aplica solo
						OB_GET ($ob_infoUpdates;->$t_version;"macOS.Mono32_version")
						OB_GET ($ob_infoUpdates;->$t_dts;"macOS.Mono32_dts")
						DT_ParseDateISO ($t_dts;->$d_fechaGeneracion;->$h_HoraGeneracion)
					: (Application type:C494=4D Remote mode:K5:5)
						OB_GET ($ob_infoUpdates;->$t_version;"macOS.Server32_version")
						OB_GET ($ob_infoUpdates;->$t_dts;"macOS.Server32_dts")
						DT_ParseDateISO ($t_dts;->$d_fechaGeneracion;->$h_HoraGeneracion)
					: (Application type:C494=4D Server:K5:6)
						$t_version:=SYS_GetServerProperty (XS_4DVersion)
						Case of 
							: ($t_version="@64-bit@")
								OB_GET ($ob_infoUpdates;->$t_version;"macOS.Server64_version")
								OB_GET ($ob_infoUpdates;->$t_dts;"macOS.Server64_dts")
								DT_ParseDateISO ($t_dts;->$d_fechaGeneracion;->$h_HoraGeneracion)
							: ($t_version="@32-bit@")
								OB_GET ($ob_infoUpdates;->$t_version;"macOS.Server32_version")
								OB_GET ($ob_infoUpdates;->$t_dts;"macOS.Server32_dts")
								DT_ParseDateISO ($t_dts;->$d_fechaGeneracion;->$h_HoraGeneracion)
						End case 
					: (Application type:C494=4D Volume desktop:K5:2)
						OB_GET ($ob_infoUpdates;->$t_version;"macOS.Mono32_version")
						OB_GET ($ob_infoUpdates;->$t_dts;"macOS.Mono32_dts")
						DT_ParseDateISO ($t_dts;->$d_fechaGeneracion;->$h_HoraGeneracion)
				End case 
		End case 
		
		$t_versionActual:=SYS_LeeVersionEstructura ("dts";->$t_dts)
		OBJECT SET TITLE:C194(*;"InfoVersion";$t_version+" ("+String:C10($d_fechaGeneracion;Internal date abbreviated:K1:6)+") - Su versión actual es "+$t_versionActual)
		
		
	: (Form event:C388=On Clicked:K2:4)
		$t_nombre:=OBJECT Get name:C1087(Object with focus:K67:3)
		$y_dia:=OBJECT Get pointer:C1124(Object with focus:K67:3)
		If ($t_nombre="Dia@")
			For ($i;1;7)
				(OBJECT Get pointer:C1124(Object named:K67:5;"Dia"+String:C10($i)))->:=0
			End for 
			$y_dia->:=1
			OBJECT GET COORDINATES:C663(*;OBJECT Get name:C1087(Object with focus:K67:3);$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			OBJECT SET COORDINATES:C1248(*;"hora";$l_derecha;$l_arriba)
		End if 
		
		OBJECT SET VISIBLE:C603(*;"infoActualizacion";False:C215)
		
	: (Form event:C388=On Load Record:K2:38)
		
	: (Form event:C388=On Activate:K2:9)
		
	: (Form event:C388=On Deactivate:K2:10)
		
	: (Form event:C388=On Page Change:K2:54)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Close Box:K2:21)
		
End case 




