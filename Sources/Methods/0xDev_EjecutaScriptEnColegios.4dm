//%attributes = {}
  //_0000_EjecutaScriptEnColegios
If (USR_GetUserID =-6)  //solo para pruebas
	C_TEXT:C284($t_llave;$t_urlIntranet;$t_jsonDatosColegio;$t_ref;$t_DatosConexion;$t_url;$t_direccionIP;$stwa)
	C_BLOB:C604($x_llave)
	C_LONGINT:C283($y;$l_puerto;$i)
	ARRAY TEXT:C222($at_httpHeaderNames;0)
	ARRAY TEXT:C222($at_httpHeaderValues;0)
	ARRAY TEXT:C222($nodes;0)
	ARRAY LONGINT:C221($types;0)
	ARRAY TEXT:C222($names;0)
	C_TEXT:C284($t_node;$t_name;$t_ip)
	
	ARRAY TEXT:C222($at_RBD;0)
	ARRAY TEXT:C222($at_cc;0)
	ARRAY TEXT:C222($at_respuestas;0)
	ARRAY TEXT:C222($at_error;0)
	
	  //APPEND TO ARRAY($at_RBD;"99999")
	  //APPEND TO ARRAY($at_RBD;"061576600")
	  //APPEND TO ARRAY($at_RBD;"234324")
	  //APPEND TO ARRAY($at_RBD;"A1234567")
	  //APPEND TO ARRAY($at_RBD;"245234344")
	  //APPEND TO ARRAY($at_RBD;"AR98998558")
	  //APPEND TO ARRAY($at_RBD;"AR242")
	  //APPEND TO ARRAY($at_RBD;"AR429")
	  //APPEND TO ARRAY($at_RBD;"100002")
	  //APPEND TO ARRAY($at_RBD;"4545243")
	  //APPEND TO ARRAY($at_RBD;"2453534635")
	  //APPEND TO ARRAY($at_RBD;"AR12345678")
	  //APPEND TO ARRAY($at_RBD;"AR1944")
	  //APPEND TO ARRAY($at_RBD;"AR898982")
	  //APPEND TO ARRAY($at_RBD;"3424524234324434")
	  //APPEND TO ARRAY($at_RBD;"30525379589")
	  //APPEND TO ARRAY($at_RBD;"AR6023")
	  //APPEND TO ARRAY($at_RBD;"AR7777111")
	  //APPEND TO ARRAY($at_RBD;"AR19992")
	  //APPEND TO ARRAY($at_RBD;"AR7585")
	  //APPEND TO ARRAY($at_RBD;"A304")
	  //APPEND TO ARRAY($at_RBD;"20259200")
	  //APPEND TO ARRAY($at_RBD;"62270000")
	  //APPEND TO ARRAY($at_RBD;"AR6444445")
	  //APPEND TO ARRAY($at_RBD;"100001")
	  //APPEND TO ARRAY($at_RBD;"61595600")
	  //APPEND TO ARRAY($at_RBD;"3424524234324")
	  //APPEND TO ARRAY($at_RBD;"AR5338")
	  //APPEND TO ARRAY($at_RBD;"AR1223344")
	  //APPEND TO ARRAY($at_RBD;"AR30642831352")
	  //APPEND TO ARRAY($at_RBD;"AR563434")
	  //APPEND TO ARRAY($at_RBD;"100008")
	  //APPEND TO ARRAY($at_RBD;"A1021")
	  //APPEND TO ARRAY($at_RBD;"AR2015")
	  //APPEND TO ARRAY($at_RBD;"AR20152")
	  //APPEND TO ARRAY($at_RBD;"AR66661")
	  //APPEND TO ARRAY($at_RBD;"BR241492")
	  //APPEND TO ARRAY($at_RBD;"89192")
	  //APPEND TO ARRAY($at_RBD;"9331")
	  //APPEND TO ARRAY($at_RBD;"18392")
	  //APPEND TO ARRAY($at_RBD;"88692")
	  //APPEND TO ARRAY($at_RBD;"117765")
	  //APPEND TO ARRAY($at_RBD;"126578")
	  //APPEND TO ARRAY($at_RBD;"264059")
	  //APPEND TO ARRAY($at_RBD;"22608")
	  //APPEND TO ARRAY($at_RBD;"312762")
	  //APPEND TO ARRAY($at_RBD;"168297")
	  //APPEND TO ARRAY($at_RBD;"179310")
	  //APPEND TO ARRAY($at_RBD;"260800")
	  //APPEND TO ARRAY($at_RBD;"88773")
	  //APPEND TO ARRAY($at_RBD;"88943")
	  //APPEND TO ARRAY($at_RBD;"119687")
	  //APPEND TO ARRAY($at_RBD;"251305")
	  //APPEND TO ARRAY($at_RBD;"74152")
	  //APPEND TO ARRAY($at_RBD;"88730")
	  //APPEND TO ARRAY($at_RBD;"86096")
	  //APPEND TO ARRAY($at_RBD;"257176")
	  //APPEND TO ARRAY($at_RBD;"74144")
	  //APPEND TO ARRAY($at_RBD;"77178")
	  //APPEND TO ARRAY($at_RBD;"145238")
	  //APPEND TO ARRAY($at_RBD;"248177")
	  //APPEND TO ARRAY($at_RBD;"176354")
	  //APPEND TO ARRAY($at_RBD;"176346")
	  //APPEND TO ARRAY($at_RBD;"204412")
	  //APPEND TO ARRAY($at_RBD;"WESTONVG")
	  //APPEND TO ARRAY($at_RBD;"88706")
	  //APPEND TO ARRAY($at_RBD;"ILL")
	  //APPEND TO ARRAY($at_RBD;"253480")
	  //APPEND TO ARRAY($at_RBD;"253352")
	  //APPEND TO ARRAY($at_RBD;"17914")
	  //APPEND TO ARRAY($at_RBD;"90042")
	  //APPEND TO ARRAY($at_RBD;"313734")
	  //APPEND TO ARRAY($at_RBD;"142808")
	  //APPEND TO ARRAY($at_RBD;"86177")
	  //APPEND TO ARRAY($at_RBD;"315044")
	  //APPEND TO ARRAY($at_RBD;"17833")
	  //APPEND TO ARRAY($at_RBD;"180971")
	  //APPEND TO ARRAY($at_RBD;"18237")
	  //APPEND TO ARRAY($at_RBD;"120944")
	  //APPEND TO ARRAY($at_RBD;"178594")
	  //APPEND TO ARRAY($at_RBD;"9051")
	  //APPEND TO ARRAY($at_RBD;"17884")
	  //APPEND TO ARRAY($at_RBD;"263117")
	  //APPEND TO ARRAY($at_RBD;"85898")
	  //APPEND TO ARRAY($at_RBD;"25464")
	  //APPEND TO ARRAY($at_RBD;"89923")
	  //APPEND TO ARRAY($at_RBD;"251070")
	  //APPEND TO ARRAY($at_RBD;"256544")
	  //APPEND TO ARRAY($at_RBD;"122653")
	  //APPEND TO ARRAY($at_RBD;"89230")
	  //APPEND TO ARRAY($at_RBD;"250554")
	  //APPEND TO ARRAY($at_RBD;"89915")
	  //APPEND TO ARRAY($at_RBD;"77003")
	  //APPEND TO ARRAY($at_RBD;"120634")
	  //APPEND TO ARRAY($at_RBD;"89176")
	  //APPEND TO ARRAY($at_RBD;"89036")
	  //APPEND TO ARRAY($at_RBD;"142328")
	  //APPEND TO ARRAY($at_RBD;"47902")
	  //APPEND TO ARRAY($at_RBD;"86452")
	  //APPEND TO ARRAY($at_RBD;"89796")
	  //APPEND TO ARRAY($at_RBD;"253294")
	  //APPEND TO ARRAY($at_RBD;"INFOCAP")
	  //APPEND TO ARRAY($at_RBD;"96474")
	  //APPEND TO ARRAY($at_RBD;"155217")
	  //APPEND TO ARRAY($at_RBD;"898422")
	  //APPEND TO ARRAY($at_RBD;"155640")
	  //APPEND TO ARRAY($at_RBD;"25999")
	  //APPEND TO ARRAY($at_RBD;"46892")
	  //APPEND TO ARRAY($at_RBD;"1787")
	  //APPEND TO ARRAY($at_RBD;"256692")
	  //APPEND TO ARRAY($at_RBD;"262382")
	  //APPEND TO ARRAY($at_RBD;"89095")
	  //APPEND TO ARRAY($at_RBD;"156310")
	  //APPEND TO ARRAY($at_RBD;"120863")
	  //APPEND TO ARRAY($at_RBD;"262722")
	  //APPEND TO ARRAY($at_RBD;"204005")
	  //APPEND TO ARRAY($at_RBD;"247189")
	  //APPEND TO ARRAY($at_RBD;"92215")
	  //APPEND TO ARRAY($at_RBD;"88722")
	  //APPEND TO ARRAY($at_RBD;"92711")
	  //APPEND TO ARRAY($at_RBD;"104876")
	  //APPEND TO ARRAY($at_RBD;"46949")
	  //APPEND TO ARRAY($at_RBD;"31110")
	  //APPEND TO ARRAY($at_RBD;"89729")
	  //APPEND TO ARRAY($at_RBD;"164704")
	  //APPEND TO ARRAY($at_RBD;"257036")
	  //APPEND TO ARRAY($at_RBD;"310476")
	  //APPEND TO ARRAY($at_RBD;"256439")
	  //APPEND TO ARRAY($at_RBD;"221449")
	  //APPEND TO ARRAY($at_RBD;"109002")
	  //APPEND TO ARRAY($at_RBD;"244821")
	  //APPEND TO ARRAY($at_RBD;"249440")
	  //APPEND TO ARRAY($at_RBD;"17760")
	  //APPEND TO ARRAY($at_RBD;"90530")
	  //APPEND TO ARRAY($at_RBD;"253855")
	  //APPEND TO ARRAY($at_RBD;"88781")
	  //APPEND TO ARRAY($at_RBD;"253103")
	  //APPEND TO ARRAY($at_RBD;"101010")
	  //APPEND TO ARRAY($at_RBD;"3611")
	  //APPEND TO ARRAY($at_RBD;"84646")
	  //APPEND TO ARRAY($at_RBD;"248363")
	  //APPEND TO ARRAY($at_RBD;"25395")
	  //APPEND TO ARRAY($at_RBD;"90468")
	  //APPEND TO ARRAY($at_RBD;"2577")
	  //APPEND TO ARRAY($at_RBD;"311197")
	  //APPEND TO ARRAY($at_RBD;"260010")
	  //APPEND TO ARRAY($at_RBD;"247618")
	  //APPEND TO ARRAY($at_RBD;"178128")
	  //APPEND TO ARRAY($at_RBD;"164313")
	  //APPEND TO ARRAY($at_RBD;"63363")
	  //APPEND TO ARRAY($at_RBD;"89885")
	  //APPEND TO ARRAY($at_RBD;"180556")
	  //APPEND TO ARRAY($at_RBD;"89664")
	  //APPEND TO ARRAY($at_RBD;"89958")
	  //APPEND TO ARRAY($at_RBD;"89966")
	  //APPEND TO ARRAY($at_RBD;"313270")
	  //APPEND TO ARRAY($at_RBD;"88633")
	  //APPEND TO ARRAY($at_RBD;"24642")
	  //APPEND TO ARRAY($at_RBD;"120871")
	  //APPEND TO ARRAY($at_RBD;"87629")
	  //APPEND TO ARRAY($at_RBD;"84638")
	  //APPEND TO ARRAY($at_RBD;"121835")
	  //APPEND TO ARRAY($at_RBD;"926736")
	  //APPEND TO ARRAY($at_RBD;"143480")
	  //APPEND TO ARRAY($at_RBD;"97993")
	  //APPEND TO ARRAY($at_RBD;"92371")
	  //APPEND TO ARRAY($at_RBD;"24671")
	  //APPEND TO ARRAY($at_RBD;"181722")
	  //APPEND TO ARRAY($at_RBD;"92789")
	  //APPEND TO ARRAY($at_RBD;"128848")
	  //APPEND TO ARRAY($at_RBD;"176060")
	  //APPEND TO ARRAY($at_RBD;"86037")
	  //APPEND TO ARRAY($at_RBD;"63045")
	  //APPEND TO ARRAY($at_RBD;"129585")
	  //APPEND TO ARRAY($at_RBD;"258253")
	  //APPEND TO ARRAY($at_RBD;"246999")
	  //APPEND TO ARRAY($at_RBD;"246247")
	  //APPEND TO ARRAY($at_RBD;"249769")
	  //APPEND TO ARRAY($at_RBD;"47988")
	  //APPEND TO ARRAY($at_RBD;"92169")
	  //APPEND TO ARRAY($at_RBD;"56553")
	  //APPEND TO ARRAY($at_RBD;"251437")
	  //APPEND TO ARRAY($at_RBD;"148660")
	  //APPEND TO ARRAY($at_RBD;"128465")
	  //APPEND TO ARRAY($at_RBD;"17817")
	  //APPEND TO ARRAY($at_RBD;"243051")
	  //APPEND TO ARRAY($at_RBD;"255203")
	  //APPEND TO ARRAY($at_RBD;"244090")
	  //APPEND TO ARRAY($at_RBD;"4722")
	  //APPEND TO ARRAY($at_RBD;"8605060637")
	  //APPEND TO ARRAY($at_RBD;"500")
	  //APPEND TO ARRAY($at_RBD;"3063")
	  //APPEND TO ARRAY($at_RBD;"8000560160")
	  //APPEND TO ARRAY($at_RBD;"CHMS170614")
	  //APPEND TO ARRAY($at_RBD;"GIS101109RB6")
	  //APPEND TO ARRAY($at_RBD;"CPD930827UC4")
	  //APPEND TO ARRAY($at_RBD;"CHMD")
	  //APPEND TO ARRAY($at_RBD;"EMA711115TL0")
	  //APPEND TO ARRAY($at_RBD;"DF0038")
	  //APPEND TO ARRAY($at_RBD;"101")
	  //APPEND TO ARRAY($at_RBD;"FEC970515N38")
	  //APPEND TO ARRAY($at_RBD;"ICM140617")
	  //APPEND TO ARRAY($at_RBD;"DF0002")
	  //APPEND TO ARRAY($at_RBD;"1")
	  //APPEND TO ARRAY($at_RBD;"CFM030306EF7")
	  //APPEND TO ARRAY($at_RBD;"AEI 720307 SY4")
	  //APPEND TO ARRAY($at_RBD;"UVM1")
	  //APPEND TO ARRAY($at_RBD;"169")
	  //APPEND TO ARRAY($at_RBD;"PEC821118JG4")
	  //APPEND TO ARRAY($at_RBD;"GED9412072P2")
	  //APPEND TO ARRAY($at_RBD;"MXHEBREO02")
	  //APPEND TO ARRAY($at_RBD;"213690730017")
	  //APPEND TO ARRAY($at_RBD;"4325436435")
	  //  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"AR")
	  //APPEND TO ARRAY($at_cc;"BR")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CL")
	  //APPEND TO ARRAY($at_cc;"CO")
	  //APPEND TO ARRAY($at_cc;"CO")
	  //APPEND TO ARRAY($at_cc;"CO")
	  //APPEND TO ARRAY($at_cc;"CO")
	  //APPEND TO ARRAY($at_cc;"CO")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"MX")
	  //APPEND TO ARRAY($at_cc;"UY")
	  //APPEND TO ARRAY($at_cc;"UY")
	
	APPEND TO ARRAY:C911($at_RBD;"PEC821118JG4")
	APPEND TO ARRAY:C911($at_cc;"MX")
	
	AT_RedimArrays (Size of array:C274($at_RBD);->$at_respuestas;->$at_error)
	
	$t_llave:="e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"+"traerDatosAccesoSTWA_xColegio"
	TEXT TO BLOB:C554($t_llave;$x_llave;UTF8 text without length:K22:17)
	$t_llave:=SHA512 ($x_llave;Crypto HEX)
	$t_urlIntranet:="https://serviciosintranet.colegium.com/servicios/traerDatosAccesoSTWA_xColegio/"+$t_llave
	
	APPEND TO ARRAY:C911($at_httpHeaderNames;"content-type")
	APPEND TO ARRAY:C911($at_httpHeaderValues;"application/json")
	
	
	For ($l_indiceColegios;1;Size of array:C274($at_RBD))
		$t_country:=Lowercase:C14($at_cc{$l_indiceColegios})
		$t_rol:=$at_RBD{$l_indiceColegios}
		
		$t_DatosConexion:=""
		
		  //$t_jsonDatosColegio:=OR_CreaJsonExport ("Intranet";<>gRolBD;<>vtXS_CountryCode)
		C_OBJECT:C1216($ob)
		OB SET:C1220($ob;"rolBD";$t_rol)
		OB SET:C1220($ob;"codigoPais";$t_country)
		$t_jsonDatosColegio:=JSON Stringify:C1217($ob)
		
		$y:=0
		$l_contador:=0
		While ($y#200)
			$y:=HTTP Request:C1158(HTTP POST method:K71:2;$t_urlIntranet;$t_jsonDatosColegio;$t_DatosConexion;$at_httpHeaderNames;$at_httpHeaderValues)
			$l_contador:=$l_contador+1
			If ($l_contador>100)
				TRACE:C157
			End if 
		End while 
		
		If ($y=200)
			
			C_OBJECT:C1216($ob;$ob_child)
			C_TEXT:C284($t_datos)
			$ob:=JSON Parse:C1218($t_DatosConexion)
			
			$t_datos:=OB Get:C1224($ob;"datos")
			$t_datos:=Replace string:C233($t_datos;"[";"")  //sin este reemplazo, json parse muestra error
			$t_datos:=Replace string:C233($t_datos;"]";"")  //sin este reemplazo, json parse muestra error
			$ob_child:=JSON Parse:C1218($t_datos)
			
			$t_url:=OB Get:C1224($ob_child;"direccionstwa2")
			$l_puerto:=OB Get:C1224($ob_child;"puerto")
			$t_direccionIP:=OB Get:C1224($ob_child;"direccionip")
			
			If ($t_direccionIP#"")
				$t_ip:=$t_direccionIP+":"+String:C10($l_puerto)
				
				$t_ip:="http://"+$t_ip+"/4DSOAP/"
				
				If (INET_IsHostAvailable ($t_direccionIP;$l_puerto))
					C_BLOB:C604($xBlob)
					C_TEXT:C284($t_script;vtWS_respuesta)
					
					  //ALERT(PREF_fGet (0;"ADT_ScriptImportaDatos"))
					  //$t_script:="PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("ALGO")+")"
					$t_script:="PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("11C2FCF1736846C2996617CAA191A8A1")+")"
					$t_script:="EXECUTE FORMULA(PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("884D37236F2E1545BB1B4DDA5A386F46")+"))"  //20140620 RCH Base Mayflower
					$t_script:="PREF_Set (0;"+ST_Qte ("ADT_ScriptImportaDatos")+";"+ST_Qte ("884D37236F2E1545BB1B4DDA5A386F46")+")"  //20140620 RCH Base Mayflower
					TRACE:C157
					  //verificar script de WSscript_EjemploScriptAEjecutar
					$t_script:=4D_GetMethodText ("WSscript_EjemploScriptAEjecutar")
					CONVERT FROM TEXT:C1011($t_script;"UTF-8";$xBlob)
					
					$dts:=DTS_MakeFromDateTime (Current date:C33(*))
					
					C_TEXT:C284($t_versionBaseDeDatos)
					$t_versionConFormato:=SYS_LeeVersionBaseDeDatos 
					
					  //If ($t_versionConFormato<"11.10.13778")
					  //$t_llave:=ACTwp_GeneraKey ($dts;$t_country;$t_rol)
					  //Else 
					$t_llave:=WSscript_GeneraLlave ($dts;$xBlob;$t_country;$t_rol)
					  //End if 
					
					WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
					WEB SERVICE SET PARAMETER:C777("script";$xBlob)
					WEB SERVICE SET PARAMETER:C777("dts";$dts)
					WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
					
					vl_ErrorCode:=0
					If ($l_puerto=0)
						$l_puerto:=80
					End if 
					EM_ErrorManager ("Install")
					EM_ErrorManager ("SetMode";"")
					WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_Ejecuta";"WSscripts_Ejecuta";"schooltrack";Web Service dynamic:K48:1)
					vtWS_respuesta:=""
					vtWS_ResultString:=""
					If ((OK=1) & (vl_ErrorCode=0))
						WEB SERVICE GET RESULT:C779(vtWS_respuesta;"json")
						WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
						
						If (vtWS_ResultString="Llave no válida.")
							$t_llave:=ACTwp_GeneraKey ($dts;$t_country;$t_rol)
							
							WEB SERVICE SET PARAMETER:C777("llave";$t_llave)
							WEB SERVICE SET PARAMETER:C777("script";$xBlob)
							WEB SERVICE SET PARAMETER:C777("dts";$dts)
							WEB SERVICE SET OPTION:C901(Web Service HTTP timeout:K48:9;240)
							
							EM_ErrorManager ("Install")
							EM_ErrorManager ("SetMode";"")
							WEB SERVICE CALL:C778($t_ip;"SchoolTrack_WebService#WSscripts_Ejecuta";"WSscripts_Ejecuta";"schooltrack";Web Service dynamic:K48:1)
							If (OK=1)
								WEB SERVICE GET RESULT:C779(vtWS_respuesta;"json")
								WEB SERVICE GET RESULT:C779(vtWS_ResultString;"result";*)
							End if 
							
						End if 
						If (vtWS_ResultString="")
							$at_error{$l_indiceColegios}:=vtWS_ResultString
							  //$t_ref:=JSON Parse text (vtWS_respuesta)
							  //If ($t_ref#"0")
							  //$at_respuestas{$l_indiceColegios}:=JSON Export to text ($t_ref;JSON_WITHOUT_WHITE_SPACE)
							  //End if 
							  //JSON CLOSE ($t_ref)
							
							$at_respuestas{$l_indiceColegios}:=vtWS_respuesta
							
						Else 
							$at_error{$l_indiceColegios}:="Error: "+vtWS_ResultString
						End if 
					Else 
						$at_error{$l_indiceColegios}:="ERROR: "+String:C10(vl_ErrorCode)
					End if 
					EM_ErrorManager ("Clear")
				Else 
					$at_error{$l_indiceColegios}:="Servidor no disponible: "+$t_ip
				End if 
			Else 
				$at_error{$l_indiceColegios}:="URL vacía"
			End if 
		Else 
			$at_error{$l_indiceColegios}:="Error http: "+String:C10($y)
		End if 
	End for 
	
	AT_Arrays2Text ("\r";"\t";->$at_respuestas;->$at_error)
	
	$t:=""
	For ($l_indice;1;Size of array:C274($at_respuestas))
		$t:=$t+$at_respuestas{$l_indice}+"\t"+$at_error{$l_indice}+"\r"
	End for 
	SET TEXT TO PASTEBOARD:C523($t)
	CD_Dlog (0;"Script ejecutado.")
	TRACE:C157
End if 