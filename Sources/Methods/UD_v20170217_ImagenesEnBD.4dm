//%attributes = {}
  // UD_v20170217_ImagenesEnBD()
  // 
  //
  // creado por: Alberto Bachler Klein: 16-02-17, 17:37:30
  // -----------------------------------------------------------

C_BOOLEAN:C305($b_is_jpg;$b_is_Pict;$b_is_png;$b_is_svg)
C_LONGINT:C283($i_registros;$i_tablas;$l_Progreso1;$l_Progreso2;$l_registros;$l_tablas)
C_PICTURE:C286($p_imagen)
C_POINTER:C301($y_tabla)
C_REAL:C285($r_compresion)
C_TEXT:C284($t_Campo;$t_tabla)

ARRAY LONGINT:C221($al_recNum;0)
ARRAY POINTER:C280($ay_campos;0)
ARRAY TEXT:C222($at_codecs;0)

APPEND TO ARRAY:C911($ay_campos;->[Alumnos:2]Fotografía:78)
APPEND TO ARRAY:C911($ay_campos;->[Profesores:4]Firma:15)
APPEND TO ARRAY:C911($ay_campos;->[Profesores:4]Fotografia:59)
APPEND TO ARRAY:C911($ay_campos;->[xxSTR_Niveles:6]Logo:49)
APPEND TO ARRAY:C911($ay_campos;->[Personas:7]Fotografia:43)
APPEND TO ARRAY:C911($ay_campos;->[Colegio:31]Logo:37)
APPEND TO ARRAY:C911($ay_campos;->[xShell_ApplicationData:45]Logo:9)
APPEND TO ARRAY:C911($ay_campos;->[xShell_Users:47]Signature:15)
If (False:C215)
	APPEND TO ARRAY:C911($ay_campos;->[xShell_Reports:54]pSuperReportData:12)
End if 

APPEND TO ARRAY:C911($ay_campos;->[BBL_Registros:66]CodigoBarra_Imagen:24)
APPEND TO ARRAY:C911($ay_campos;->[BBL_Lectores:72]Fotografia:32)
APPEND TO ARRAY:C911($ay_campos;->[BBL_Lectores:72]CodigoBarra_Imagen:36)
APPEND TO ARRAY:C911($ay_campos;->[Familia:78]Fotografia:35)
APPEND TO ARRAY:C911($ay_campos;->[MPA_DefinicionEjes:185]Graphic:22)
APPEND TO ARRAY:C911($ay_campos;->[MPA_DefinicionCompetencias:187]Graphic:29)
APPEND TO ARRAY:C911($ay_campos;->[MPA_DefinicionDimensiones:188]Graphic:22)
APPEND TO ARRAY:C911($ay_campos;->[xShell_PictLibrary:194]pict:3)
APPEND TO ARRAY:C911($ay_campos;->[DocumentLibrary:234]Thumbnail:4)
APPEND TO ARRAY:C911($ay_campos;->[ADT_Candidatos_Documentos:241]icono:8)
APPEND TO ARRAY:C911($ay_campos;->[ACT_RazonesSociales:279]logo:17)

$l_Progreso1:=Progress New 
Progress SET TITLE ($l_Progreso1;"Conversión de imagenes a JPG")
Progress SET WINDOW VISIBLE (True:C214;100;100;True:C214)
$l_Progreso2:=Progress New 
$l_tablas:=Size of array:C274($ay_campos)
For ($i_tablas;1;$l_tablas)
	$y_tabla:=Table:C252(Table:C252($ay_campos{$i_tablas}))
	$t_tabla:=Table name:C256($y_tabla)
	$t_Campo:=Uppercase:C13($t_tabla)+"."+Field name:C257($ay_campos{$i_tablas})
	ALL RECORDS:C47($y_tabla->)
	LONGINT ARRAY FROM SELECTION:C647($y_tabla->;$al_recNum)
	$l_registros:=Size of array:C274($al_recNum)
	
	Progress SET MESSAGE ($l_Progreso1;$t_tabla)
	Progress SET TITLE ($l_Progreso2;$t_tabla)
	For ($i_registros;1;Size of array:C274($al_recNum))
		
		KRL_GotoRecord ($y_tabla;$al_recNum{$i_registros};True:C214)
		If (OK=1)
			If (Picture size:C356($ay_campos{$i_tablas}->)>0)
				$p_imagen:=$ay_campos{$i_tablas}->
				
				GET PICTURE FORMATS:C1406($ay_campos{$i_tablas}->;$at_codecs)
				$b_is_png:=(Find in array:C230($at_codecs;".png")>0)
				$b_is_jpg:=(Find in array:C230($at_codecs;".jpg")>0)
				$b_is_svg:=(Find in array:C230($at_codecs;".svg")>0)
				$b_is_Pict:=(Find in array:C230($at_codecs;".pict")>0)
				
				
				  // defino la tasa de compresión. Si se trata un thumbnail (original almacenado externamente) aplico una tasa de compresión de 0,8
				$r_compresion:=Choose:C955(($t_Campo="Fotografía") | ($t_Campo="Thumbnail");0.8;1)
				Case of 
					: (($b_is_Pict) & (Size of array:C274($at_codecs)=1))
						CONVERT PICTURE:C1002($p_imagen;".jpg";$r_compresion)
						
					: ($b_is_svg)
						  // nada, la dejamos como está, son códigos de barra
						
					: (($b_is_png) & ($b_is_jpg))
						  // la imagen está en dos formatos, la convierto en una imagen de un solo formato: JPG
						CONVERT PICTURE:C1002($p_imagen;".jpg";$r_compresion)
						
					: (Not:C34($b_is_jpg) & Not:C34($b_is_png))
						  // la imagen está probalmente en formato pict incompatible. La confierto a JPG
						CONVERT PICTURE:C1002($p_imagen;".jpg";$r_compresion)
						
					: ($b_is_png)
						  // la imagen está en formato png, la convierto a jpg
						CONVERT PICTURE:C1002($p_imagen;".jpg";$r_compresion)
						
					: ($b_is_jpg & Not:C34($b_is_png))
						  // no hacemos nada, dejamos la imagen como estaba
						  //CONVERT PICTURE($p_imagen;".jpg";$r_compresion)
						
					Else 
						CONVERT PICTURE:C1002($p_imagen;".jpg";$r_compresion)
						$ay_campos{$i_tablas}->:=$p_imagen
						
						
				End case 
				$ay_campos{$i_tablas}->:=$p_imagen
				SAVE RECORD:C53($y_tabla->)
				
			End if 
		End if 
		
		Progress SET PROGRESS ($l_Progreso2;$i_registros/$l_registros;String:C10($i_registros)+" / "+String:C10($l_registros)+" "+$t_campo)
		Progress SET PROGRESS ($l_Progreso1;$i_tablas/$l_tablas)
	End for 
	UNLOAD RECORD:C212($y_tabla->)
End for 
Progress QUIT ($l_Progreso2)
Progress QUIT ($l_Progreso1)



PICTLib_ConvertPICTs 





