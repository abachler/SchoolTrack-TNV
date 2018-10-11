//%attributes = {}
  // CIM_INFO_Server()
  // Por: Alberto Bachler K.: 04-11-14, 05:37:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


C_BLOB:C604($x_Blob)
C_LONGINT:C283($hl_Volumes;$i;$l_infoRef;$l_itemRef;$l_selected;$l_style)
C_REAL:C285($r_free;$r_size;$r_used)
C_TEXT:C284($t_info;$t_IPaddress;$t_ipConfig;$t_itemText;$t_loggedUser;$t_string;$t_volumeName;$t_4DinfoReportName;$t_4DinfoReportContent)

C_LONGINT:C283(<>vl_MemoriaUtilizada;<>lTotalMemory;<>lFreeMemory;<>vl_Cache;<>vl_CacheUtilizada)


$l_selected:=Selected list items:C379(hl_InfoItemsServer)
If ($l_selected=0)
	$l_selected:=1
End if 
GET LIST ITEM:C378(hl_InfoItemsServer;$l_selected;$l_infoRef;$t_itemText)

$y_infoEtiqueta:=OBJECT Get pointer:C1124(Object named:K67:5;"infoServer_etiqueta")
$y_infoDatos:=OBJECT Get pointer:C1124(Object named:K67:5;"infoServer_datos")

ARRAY TEXT:C222($y_infoEtiqueta->;0)
ARRAY TEXT:C222($y_infoDatos->;0)
ARRAY LONGINT:C221(aQR_Longint10;0)
Case of 
	: ($l_infoRef=1)  //Computador
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Nombre del computador"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_MachineName))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Propietario"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_MachineOwner))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Sistema Operativo"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_OSversion))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Sesión iniciada por"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_LoggedUser;"1"))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		$x_Blob:=SYS_GetServerMemory 
		BLOB_Blob2Vars (->$x_blob;0;-><>vl_MemoriaUtilizada;-><>lPhysicalMemory;-><>lFreeMemory;-><>vl_Cache;-><>vl_CacheUtilizada)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Memoria física"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(<>lPhysicalMemory;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Memoria física utilizada"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(<>vl_MemoriaUtilizada;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Memoria disponible"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(<>lFreeMemory;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Cache"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(<>vl_Cache;"###.###.##0")+" MB")
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Cache utilizada"))
		APPEND TO ARRAY:C911($y_infoDatos->;String:C10(<>vl_CacheUtilizada;"###.###.##0")+" MB")
		
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		$x_Blob:=SYS_GetServerVolumeList 
		$t_loggedUser:=SYS_GetServerProperty (XS_LoggedUser;"0")
		$hl_Volumes:=BLOB to list:C557($x_Blob)
		For ($i;1;Count list items:C380($hl_Volumes))
			GET LIST ITEM:C378($hl_Volumes;$i;$l_itemRef;$t_volumeName)
			$x_Blob:=SYS_GetServerVolumeAttributes ($t_volumeName)
			BLOB_Blob2Vars (->$x_Blob;0;->$r_size;->$r_used;->$r_free)
			$t_info:=String:C10($r_free;"### ### ### ##0"+<>tXS_RS_DecimalSeparator+"0")+" Gb "+__ ("disponibles de ")+String:C10($r_size;"### ### ### ##0"+<>tXS_RS_DecimalSeparator+"0")+" Gb"
			If ((SYS_IsWindows ) | ((SYS_IsMacintosh ) & ($t_volumeName#"Net") & ($t_volumeName#"Home") & ($t_volumeName#$t_loggedUser)))
				APPEND TO ARRAY:C911($y_infoEtiqueta->;"   "+$t_volumeName)
				APPEND TO ARRAY:C911($y_infoDatos->;$t_info)
				APPEND TO ARRAY:C911(aQR_Longint10;0)
			End if 
		End for 
		CLEAR LIST:C377($hl_Volumes)
	: ($l_infoRef=2)  //Red 
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("MacAdress"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_MacAddress))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Dirección de red"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		$t_IPaddress:=SYS_GetServerProperty (XS_IPaddress)
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Dirección IP"))
		APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_IPaddress;1;","))
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Mascara de subred"))
		APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_IPaddress;2;","))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Conectado a Internet"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_InternetConnected))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		
		If (SYS_IsWindows )
			$t_ipConfig:=SYS_GetServerProperty (XS_IPConfig)
			
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
				APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   DNS")+String:C10($i-6))
				APPEND TO ARRAY:C911($y_infoDatos->;ST_GetWord ($t_ipConfig;$i;","))
			End for 
		End if 
		
	: ($l_infoRef=3)  //Configuración regional
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Separadores"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador decimal"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (Decimal separator:K60:1))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador de miles"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (Thousand separator:K60:2))
		
		If (SYS_GetServerProperty (XS_Platform)="Win@")
			APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador de listas"))
			APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (109))
		End if 
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (Date separator:K60:10))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Separador hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (Time separator:K60:11))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Símbolo monetario"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (Currency symbol:K60:3))
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Formatos"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato corto fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System date short pattern:K60:7))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato mediano fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System date medium pattern:K60:8))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato largo fecha"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System date long pattern:K60:9))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato corto hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System time short pattern:K60:4))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato mediano hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System time medium pattern:K60:5))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Formato largo hora"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System time long pattern:K60:6))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Etiqueta 'AM'"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System time AM label:K60:15))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Etiqueta 'PM'"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (System time PM label:K60:16))
		
	: ($l_infoRef=4)
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
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_LastAppUpdate))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Versión 4D Server"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_4DVersion))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Servidor iniciado el:"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_lastServerStartup))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("Respaldos"))
		APPEND TO ARRAY:C911($y_infoDatos->;"")
		ST SET ATTRIBUTES:C1093($y_infoEtiqueta->{Size of array:C274($y_infoEtiqueta->)};1;MAXINT:K35:1;Attribute bold style:K65:1;1)
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   Último respaldo el:"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_LastBackupDate))
		
		APPEND TO ARRAY:C911($y_infoEtiqueta->;__ ("   En:"))
		APPEND TO ARRAY:C911($y_infoDatos->;SYS_GetServerProperty (XS_LastBackupPath))
		
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
		
		
		
	: ($l_infoRef=5)
		SYS_GetConnectedUsersList ($y_infoEtiqueta)
		ARRAY TEXT:C222($y_infoDatos->;Size of array:C274($y_infoEtiqueta->))
		
		
		  //: ($l_infoRef=6)
		  //$y_4DInfoReport:=OBJECT Get pointer(Object named;"server_4DInfoReport")
		  //aa4D_NP_Get_Last_Server_Report (->$t_4DinfoReportName;$y_4DInfoReport)
End case 

OBJECT SET VISIBLE:C603(*;"server_listbox";$l_infoRef<6)
OBJECT SET VISIBLE:C603(*;"server_4DInfoReport";$l_infoRef=6)