//%attributes = {}
  // CIM_INFO_Local()
  // Por: Alberto Bachler K.: 04-11-14, 05:57:13
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_BLOB:C604($x_Blob)
C_LONGINT:C283($hl_Volumes)
C_LONGINT:C283($i)
C_LONGINT:C283($l_itemRef)
C_LONGINT:C283($l_processIDage)
C_POINTER:C301($y_4DInfoReport)
C_POINTER:C301($y_infoDatos)
C_POINTER:C301($y_infoEtiqueta)
C_REAL:C285($r_free)
C_REAL:C285($r_size)
C_REAL:C285($r_used)
C_TEXT:C284($t_4DinfoReportName)
C_TEXT:C284($t_info)
C_TEXT:C284($t_IPaddress)
C_TEXT:C284($t_ipConfig)
C_TEXT:C284($t_itemText)
C_TEXT:C284($t_loggedUser)
C_TEXT:C284($t_string)
C_TEXT:C284($t_volumeName)



If (Selected list items:C379(hl_InfoItemsLocal)=0)
	SELECT LIST ITEMS BY POSITION:C381(hl_InfoItemsLocal;1)
End if 
GET LIST ITEM:C378(hl_InfoItemsLocal;Selected list items:C379(hl_InfoItemsLocal);$l_processIDage;$t_itemText)



$y_infoEtiqueta:=OBJECT Get pointer:C1124(Object named:K67:5;"infoLocal_etiqueta")
$y_infoDatos:=OBJECT Get pointer:C1124(Object named:K67:5;"infoLocal_datos")

ARRAY TEXT:C222($y_infoEtiqueta->;0)
ARRAY TEXT:C222($y_infoDatos->;0)
ARRAY LONGINT:C221(aQR_Longint1;0)

Case of 
	: ($l_processIDage=1)  //Computador
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Nombre del computador"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_MachineName))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Propietario"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_MachineOwner))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Sistema Operativo"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_OSversion))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Sesión iniciada por"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_LoggedUser;"1"))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		$x_Blob:=SYS_GetLocalMemory 
		BLOB_Variables2Blob (->$x_blob;0;->vl_MemoriaUtilizada;->vlPhysicalMemory;->vlFreeMemory;->vl_Cache;->vl_CacheUtilizada)
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Memoria"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Memoria física"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(vlPhysicalMemory;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Memoria física utilizada"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(vl_MemoriaUtilizada;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Memoria disponible"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(vlFreeMemory;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Cache"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(vl_Cache;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Cache utilizada"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(vl_CacheUtilizada;"###.###.##0")+" MB")
		
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Discos"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		$x_Blob:=SYS_GetLocalVolumeList 
		$t_loggedUser:=SYS_GetLocalProperty (XS_LoggedUser;"0")
		$hl_Volumes:=BLOB to list:C557($x_Blob)
		For ($i;1;Count list items:C380($hl_Volumes))
			GET LIST ITEM:C378($hl_Volumes;$i;$l_itemRef;$t_volumeName)
			$x_Blob:=SYS_GetLocalVolumesAttributes ($t_volumeName)
			BLOB_Blob2Vars (->$x_Blob;0;->$r_size;->$r_used;->$r_free)
			$t_info:=String:C10($r_free;"### ### ### ##0"+<>tXS_RS_DecimalSeparator+"0")+" GB "+__ ("disponibles de ")+String:C10($r_size;"### ### ### ##0"+<>tXS_RS_DecimalSeparator+"0")+" GB"
			If ((SYS_IsWindows ) | ((SYS_IsMacintosh ) & ($t_volumeName#"Net") & ($t_volumeName#"Home") & ($t_volumeName#$t_loggedUser)))
				APPEND TO ARRAY:C911($y_infoEtiqueta->;"   "+$t_volumeName)
				APPEND TO ARRAY:C911($y_infoDatos->;$t_info)
				
			End if 
		End for 
		CLEAR LIST:C377($hl_Volumes)
		
	: ($l_processIDage=2)  //Red 
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("MacAdress"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_MacAddress))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Dirección de red"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		$t_IPaddress:=SYS_GetLocalProperty (XS_IPaddress)
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Dirección IP"))
		APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_IPaddress;1;","))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Mascara de subred"))
		APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_IPaddress;2;","))
		
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Conectado a Internet"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_InternetConnected))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		If (SYS_IsWindows )
			$t_ipConfig:=SYS_GetLocalProperty (XS_IPConfig)
			
			
			  //$t_ipConfig:="Condor,lester.colegium.com,Hybid,DNS No,Routing No,Proxy No,192.168.0.19,192.168.0.9"
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Nombre de red"))
			APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_ipConfig;1;","))
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Dominio"))
			APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_ipConfig;2;","))
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			$t_string:=Replace string:C233(ST_GetWord ($t_ipConfig;3;",");"Hybid";__ ("Híbrida"))  //corrige error de winAPI
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Tipo de red"))
			APPEND TO ARRAY:C911($y_infoDatos->;$t_string)
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			If (ST_GetWord ($t_ipConfig;4;",")="DNS No")
				$t_string:=__ ("No")
			Else 
				$t_string:=__ ("Si")
			End if 
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Es servidor de dominio"))
			APPEND TO ARRAY:C911($y_infoDatos->;$t_string)
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			If (ST_GetWord ($t_ipConfig;5;",")="Routing No")
				$t_string:=__ ("No")
			Else 
				$t_string:=__ ("Si")
			End if 
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Utilizado como ruteador"))
			APPEND TO ARRAY:C911($y_infoDatos->;$t_string)
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			If (ST_GetWord ($t_ipConfig;6;",")="Proxy No")
				$t_string:=__ ("No")
			Else 
				$t_string:=__ ("Si")
			End if 
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Utilizado como proxy"))
			APPEND TO ARRAY:C911($y_infoDatos->;$t_string)
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Servidores DNS"))
			APPEND TO ARRAY:C911($y_infoDatos->;"")
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			For ($i;7;ST_CountWords ($t_ipConfig;0;","))
				APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   DNS ")+String:C10($i-6))
				APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_ipConfig;$i;","))
			End for 
		End if 
		
	: ($l_processIDage=3)  //Configuración regional
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Separadores"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador decimal"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (Decimal separator:K60:1))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador de miles"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (Thousand separator:K60:2))
		
		If (SYS_IsWindows )
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador de listas"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (109))
		End if 
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (Date separator:K60:10))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (Time separator:K60:11))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Símbolo monetario"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (Currency symbol:K60:3))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Formatos"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato corto fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System date short pattern:K60:7))
		
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato mediano fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System date medium pattern:K60:8))
		
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato largo fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System date long pattern:K60:9))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato corto hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System time short pattern:K60:4))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato mediano hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System time medium pattern:K60:5))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato largo hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System time long pattern:K60:6))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Etiqueta 'AM'"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System time AM label:K60:15))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Etiqueta 'PM'"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (System time PM label:K60:16))
		
		
	: ($l_processIDage=4)  //SchoolTrack 
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Licencias"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Max. usuarios concurrentes"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (220))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Licencias concurrentes contratadas"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (221))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Usuarios conectados"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (222))
		
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Versión"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Versión SchoolTrack"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_LeeVersionEstructura )
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Actualizada el "))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_LastAppUpdate))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Versión Cliente"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_4DVersion))
		
		
		
		If ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Volume desktop:K5:2))
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Carpetas y documentos"))
			APPEND TO ARRAY:C911($y_infoDatos->;"")
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Aplicación:"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_StructureName))
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Carpeta de la aplicación:"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_StructureFolder))
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Base de datos:"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_DataFileName))
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Carpeta de la Base de datos:"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_DataFileFolder))
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Respaldos"))
			APPEND TO ARRAY:C911($y_infoDatos->;"")
			ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Último respaldo el:"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_LastBackupDate))
			
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   En:"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetLocalProperty (XS_LastBackupPath))
		End if 
		
		  //: ($l_processIDage=5)  //Información detallada 
		  //If ((Application type=4D Remote mode) | (Application type=4D Local mode))
		  //$y_4DInfoReport:=OBJECT Get pointer(Object named;"local_4DInfoReport")
		  //$x_blob:=4DInfoReports ("getLocal")
		  //$y_4DInfoReport->:=BLOB to text($x_blob;UTF8 text without length)
		  //  //aa4D_NP_Get_Last_Server_Report (->$t_4DinfoReportName;$y_4DInfoReport)
		  //End if 
End case 

OBJECT SET VISIBLE:C603(*;"local_listbox";$l_processIDage<5)
OBJECT SET VISIBLE:C603(*;"local_4DInfoReport";$l_processIDage=5)