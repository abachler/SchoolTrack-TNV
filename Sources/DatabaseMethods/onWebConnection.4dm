C_TEXT:C284($1;$2;$3;$4;$5;$cgi;$methodName;$parameters;vtWEB_parameters)

Case of 
	: (($1="stwa@") | ($1="/stwa@"))
		  //If (Secured Web connection)
		STWA2_OnWebConnection ($1;$2;$3;$4;$5;$6)
		  //Else 
		  //pagina de rechazo
		  //End if
		
	: (($1="actwa@") | ($1="/actwa@"))  //20130729 RCH para manejar las peticiones de ACTwa
		  //If (Secured Web connection)
		
		ACTwa_OnWebConnection ($1;$2;$3;$4;$5;$6)
		
	: (($1="adtwa@") | ($1="/adtwa@"))  //20140604 RCH para manejar las peticiones de postulacione
		
		ADTwa_OnWebConnection ($1;$2;$3;$4;$5;$6)
		
	: (($1="xcrwa@") | ($1="/xcrwa@"))  //20150818 RCH para manejar las peticiones de extracurriculares
		XCRwa_OnWebConnection ($1;$2;$3;$4;$5;$6)
		
	: (($1="rinscwa@") | ($1="/rinscwa@"))  //20150929 RCH Manejo de reinscripciones.
		RINSCwa_OnWebConnection ($1;$2;$3;$4;$5;$6)
		
	: (($1="servicios@") | ($1="/servicios@"))
		SERwa_OnWebConnection ($1;$2;$3;$4;$5;$6)  //20151027 JHB Servicios REST
		
	: (($1="bkpwa@") | ($1="/bkpwa@"))
		BKPwa_SolicitaRespaldo ($1;$2;$3;$4;$5;$6)  //20160118 RCH. Respaldos
		
	: (($1="dashboard@") | ($1="/dashboard@"))  //20160808 RCH
		DASHwa_OnWebConnection ($1;$2;$3;$4;$5;$6)  //20160808 RCH
	: ($1="Vista_Previa@")
		  //_0000_testASM 
	Else 
		If (LICENCIA_esModuloAutorizado (1;MediaTrack))
			$cgi:=Replace string:C233($1;"/4DCGI/";"")+"/"
			$methodName:=Substring:C12($cgi;Position:C15("BBLw";$cgi))
			
			$parameters:=Substring:C12($cgi;Position:C15("/";$cgi)+1)
			$parameters:=Substring:C12($parameters;1;Length:C16($parameters)-1)
			$parameters:=ST_GetWord ($parameters;1;"?")
			$estilo:=Num:C11(ST_GetWord ($MethodName;2;"?estilo="))
			$methodName:=Substring:C12($methodName;1;Length:C16($methodName)-1)
			$methodName:=ST_GetWord ($MethodName;1;"/")
			
			vtWEB_Host:=WEB_GetHTTPHeaderField ("Host")
			vtWEB_HTTPHost:="HTTP://"+vtWEB_Host
			vtWEB_Language:=WEB_GetHTTPHeaderField ("Accept-Language")
			vtWEB_UserAgent:=WEB_GetHTTPHeaderField ("User-Agent")
			vtWEB_URL:=$1
			vtWEB_Header:=$2
			vtWEB_ClientIPAddress:=$3
			vtWEB_HostIPAddress:=$4
			vtWEB_UserName:=$5
			vtWEB_UserPassword:=$6
			
			Case of 
				: (($methodName="") | ($methodName="mt"))
					READ ONLY:C145([xxBBL_Preferencias:65])
					ALL RECORDS:C47([xxBBL_Preferencias:65])
					FIRST RECORD:C50([xxBBL_Preferencias:65])
					If ([xxBBL_Preferencias:65]Nombre:1#"")
						<>vt_NameColegio:=[xxBBL_Preferencias:65]Nombre:1
					Else 
						READ ONLY:C145([Colegio:31])
						ALL RECORDS:C47([Colegio:31])
						FIRST RECORD:C50([Colegio:31])
						<>vt_NameColegio:=[Colegio:31]Nombre_Colegio:1
					End if 
					WEB SEND FILE:C619("search_1.shtml")
				: ($methodName="BBLw_more@")
					BBLw_more ($parameters)
				: ($methodName="BBLw_thesaurus@")
					BBLw_Thesaurus ($parameters)
				: ($methodName="BBLw_searchItems@")
					BBLw_SearchItems ($parameters)
				: ($methodName="BBLw_GetResultPage@")
					BBLw_GetResultPage ($parameters)
				: ($methodName="BBLw_sendItemDetail@")
					BBLw_SendItemDetail ($parameters)
				: ($methodName="BBLw_Reservation@")
					BBLw_reservation ($parameters)
					  //: ($methodName="BBLw_QuerybyKeyword@")
					  //BBLw_QueryByKeyword ($parameters;$estilo)
				: ($methodName="BBLw_QueryBySubject@")
					BBLw_BusquedaPorMateria ($parameters)
				: ($methodName="BBLw_GetWords@")
					BBLw_getWords ($parameters)
				: ($methodName="BBLw_PostReservation@")
					BBLw_PostReservation ($parameters)
				: ($methodName="BBLw_recents@")
					BBLw_recents ($parameters)
				: ($methodName="BBLw_GetLogo@")
					BBLw_GetLogo 
					  //: ($methodName="BBLw_AddLine")
					  //BBLw_addLine ($parameters;$estilo)
					  //: ($methodName="BBLw_ProcessLogForm")
					  //BBLw_ProcessLogForm ($parameters;$estilo)
					  //: ($methodName="BBLw_GetLogicPageRes")
					  //BBLw_GetLogicPageRes ($parameters)
				: ($methodName="BBLw_GetRecentsPage")
					BBLw_GetRecentsPage ($parameters)
			End case 
			
		Else 
			If (LICENCIA_esModuloAutorizado (1;SchoolTrack Web Access))
				WEB SEND TEXT:C677("Servidor Web SchoolTrack.")
			End if 
		End if 
End case 