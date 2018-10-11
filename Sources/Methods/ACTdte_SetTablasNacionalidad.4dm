//%attributes = {}
  //ACTdte_SetTablasNacionalidad

C_TEXT:C284($t_accion;$1)
C_POINTER:C301(${2};$y_puntero1;$y_puntero2)

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 

If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 

If (Count parameters:C259>=3)
	$y_puntero2:=$3
End if 





  // Modificado por: Alexis Bustamante (10-06-2017)
  //ticket 179869 

Case of 
	: ($t_accion="")
		C_TEXT:C284($t_json;$t_texto;$t_nombrePref)
		
		ARRAY TEXT:C222($atACT_paises;0)
		ARRAY TEXT:C222($atACT_paisesCod;0)
		
		APPEND TO ARRAY:C911($atACT_paises;"SENEGAL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"101")
		APPEND TO ARRAY:C911($atACT_paises;"GAMBIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"102")
		APPEND TO ARRAY:C911($atACT_paises;"GUINEA BISSAU")
		APPEND TO ARRAY:C911($atACT_paisesCod;"103")
		APPEND TO ARRAY:C911($atACT_paises;"GUINEA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"104")
		APPEND TO ARRAY:C911($atACT_paises;"SIERRA LEONA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"105")
		APPEND TO ARRAY:C911($atACT_paises;"LIBERIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"106")
		APPEND TO ARRAY:C911($atACT_paises;"COSTA DE MARFIL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"107")
		APPEND TO ARRAY:C911($atACT_paises;"GHANA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"108")
		APPEND TO ARRAY:C911($atACT_paises;"TOGO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"109")
		APPEND TO ARRAY:C911($atACT_paises;"NIGERIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"111")
		APPEND TO ARRAY:C911($atACT_paises;"SUDAFRICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"112")
		APPEND TO ARRAY:C911($atACT_paises;"BOTSWANA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"113")
		APPEND TO ARRAY:C911($atACT_paises;"LESOTHO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"114")
		APPEND TO ARRAY:C911($atACT_paises;"MALAWI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"115")
		APPEND TO ARRAY:C911($atACT_paises;"ZIMBABWE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"116")
		APPEND TO ARRAY:C911($atACT_paises;"ZAMBIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"117")
		APPEND TO ARRAY:C911($atACT_paises;"COMORAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"118")
		APPEND TO ARRAY:C911($atACT_paises;"MAURICIO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"119")
		APPEND TO ARRAY:C911($atACT_paises;"MADAGASCAR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"120")
		APPEND TO ARRAY:C911($atACT_paises;"MOZAMBIQUE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"121")
		APPEND TO ARRAY:C911($atACT_paises;"SWAZILANDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"122")
		APPEND TO ARRAY:C911($atACT_paises;"SUDAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"123")
		APPEND TO ARRAY:C911($atACT_paises;"EGIPTO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"124")
		APPEND TO ARRAY:C911($atACT_paises;"LIBIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"125")
		APPEND TO ARRAY:C911($atACT_paises;"TUNEZ")
		APPEND TO ARRAY:C911($atACT_paisesCod;"126")
		APPEND TO ARRAY:C911($atACT_paises;"ARGELIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"127")
		APPEND TO ARRAY:C911($atACT_paises;"MARRUECOS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"128")
		APPEND TO ARRAY:C911($atACT_paises;"CABO VERDE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"129")
		APPEND TO ARRAY:C911($atACT_paises;"CHAD")
		APPEND TO ARRAY:C911($atACT_paisesCod;"130")
		APPEND TO ARRAY:C911($atACT_paises;"NIGER")
		APPEND TO ARRAY:C911($atACT_paisesCod;"131")
		APPEND TO ARRAY:C911($atACT_paises;"MALI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"133")
		APPEND TO ARRAY:C911($atACT_paises;"MAURITANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"134")
		APPEND TO ARRAY:C911($atACT_paises;"TANZANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"135")
		APPEND TO ARRAY:C911($atACT_paises;"UGANDA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"136")
		APPEND TO ARRAY:C911($atACT_paises;"KENIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"137")
		APPEND TO ARRAY:C911($atACT_paises;"SOMALIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"138")
		APPEND TO ARRAY:C911($atACT_paises;"ETIOPIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"139")
		APPEND TO ARRAY:C911($atACT_paises;"ANGOLA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"140")
		APPEND TO ARRAY:C911($atACT_paises;"BURUNDI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"141")
		APPEND TO ARRAY:C911($atACT_paises;"RWANDA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"142")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA DEMOCRATICA DEL CONGO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"143")
		APPEND TO ARRAY:C911($atACT_paises;"CONGO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"144")
		APPEND TO ARRAY:C911($atACT_paises;"GABON")
		APPEND TO ARRAY:C911($atACT_paisesCod;"145")
		APPEND TO ARRAY:C911($atACT_paises;"SAO TOME Y PRINCIPE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"146")
		APPEND TO ARRAY:C911($atACT_paises;"GUINEA ECUATORIAL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"147")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA CENTRO AFRICANA. Abreviatura REP.CENT.AFRIC.")
		APPEND TO ARRAY:C911($atACT_paisesCod;"148")
		APPEND TO ARRAY:C911($atACT_paises;"CAMERUN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"149")
		APPEND TO ARRAY:C911($atACT_paises;"BENIN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"150")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO BRITÁNICO EN AFRICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"151")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO ESPAÑOL EN AFRICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"152")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO FRANCES EN AFRICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"153")
		APPEND TO ARRAY:C911($atACT_paises;"DJIBOUTI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"155")
		APPEND TO ARRAY:C911($atACT_paises;"SEYCHELLES")
		APPEND TO ARRAY:C911($atACT_paisesCod;"156")
		APPEND TO ARRAY:C911($atACT_paises;"NAMIBIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"159")
		APPEND TO ARRAY:C911($atACT_paises;"SUDAN DEL SUR    (1)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"160")
		APPEND TO ARRAY:C911($atACT_paises;"BURKINA FASO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"161")
		APPEND TO ARRAY:C911($atACT_paises;"ERITREA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"163")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS MARSHALL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"164")
		APPEND TO ARRAY:C911($atACT_paises;"SAHARAVI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"165")
		APPEND TO ARRAY:C911($atACT_paises;"VENEZUELA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"201")
		APPEND TO ARRAY:C911($atACT_paises;"COLOMBIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"202")
		APPEND TO ARRAY:C911($atACT_paises;"TRINIDAD Y TOBAGO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"203")
		APPEND TO ARRAY:C911($atACT_paises;"BARBADOS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"204")
		APPEND TO ARRAY:C911($atACT_paises;"JAMAICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"205")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA DOMINICANA. Abreviatura REP.DOMINICANA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"206")
		APPEND TO ARRAY:C911($atACT_paises;"BAHAMAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"207")
		APPEND TO ARRAY:C911($atACT_paises;"HAITI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"208")
		APPEND TO ARRAY:C911($atACT_paises;"CUBA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"209")
		APPEND TO ARRAY:C911($atACT_paises;"PANAMA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"210")
		APPEND TO ARRAY:C911($atACT_paises;"COSTA RICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"211")
		APPEND TO ARRAY:C911($atACT_paises;"NICARAGUA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"212")
		APPEND TO ARRAY:C911($atACT_paises;"EL SALVADOR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"213")
		APPEND TO ARRAY:C911($atACT_paises;"HONDURAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"214")
		APPEND TO ARRAY:C911($atACT_paises;"GUATEMALA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"215")
		APPEND TO ARRAY:C911($atACT_paises;"MEXICO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"216")
		APPEND TO ARRAY:C911($atACT_paises;"GUYANA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"217")
		APPEND TO ARRAY:C911($atACT_paises;"ECUADOR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"218")
		APPEND TO ARRAY:C911($atACT_paises;"PERU")
		APPEND TO ARRAY:C911($atACT_paisesCod;"219")
		APPEND TO ARRAY:C911($atACT_paises;"BRASIL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"220")
		APPEND TO ARRAY:C911($atACT_paises;"BOLIVIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"221")
		APPEND TO ARRAY:C911($atACT_paises;"PARAGUAY")
		APPEND TO ARRAY:C911($atACT_paisesCod;"222")
		APPEND TO ARRAY:C911($atACT_paises;"URUGUAY")
		APPEND TO ARRAY:C911($atACT_paisesCod;"223")
		APPEND TO ARRAY:C911($atACT_paises;"ARGENTINA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"224")
		APPEND TO ARRAY:C911($atACT_paises;"ESTADOS UNIDOS DE AMÉRICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"225")
		APPEND TO ARRAY:C911($atACT_paises;"CANADA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"226")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO BRITÁNICO EN AMERICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"227")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO FRANCES EN AMERICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"228")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO HOLANDES EN AMERICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"229")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO DE DINAMARCA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"230")
		APPEND TO ARRAY:C911($atACT_paises;"DOMINICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"231")
		APPEND TO ARRAY:C911($atACT_paises;"GRANADA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"232")
		APPEND TO ARRAY:C911($atACT_paises;"SANTA LUCIA (ISLAS OCCIDENTALES)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"233")
		APPEND TO ARRAY:C911($atACT_paises;"SAN VICENTE Y LAS GRANADINAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"234")
		APPEND TO ARRAY:C911($atACT_paises;"SURINAM")
		APPEND TO ARRAY:C911($atACT_paisesCod;"235")
		APPEND TO ARRAY:C911($atACT_paises;"BELICE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"236")
		APPEND TO ARRAY:C911($atACT_paises;"ANTIGUA Y BARBUDA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"240")
		APPEND TO ARRAY:C911($atACT_paises;"SAINT KITTS & NEVIS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"241")
		APPEND TO ARRAY:C911($atACT_paises;"ANGUILA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"242")
		APPEND TO ARRAY:C911($atACT_paises;"ARUBA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"243")
		APPEND TO ARRAY:C911($atACT_paises;"BERMUDAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"244")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS VIRGENES BRITANICAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"245")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS CAYMAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"246")
		APPEND TO ARRAY:C911($atACT_paises;"ANTILLAS NEERLANDESAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"247")
		APPEND TO ARRAY:C911($atACT_paises;"TURCAS Y CAICOS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"248")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS VIRGENES (ESTADOS UNIDOS DE AMERICA)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"249")
		APPEND TO ARRAY:C911($atACT_paises;"MARTINICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"250")
		APPEND TO ARRAY:C911($atACT_paises;"PUERTO RICO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"251")
		APPEND TO ARRAY:C911($atACT_paises;"MONSERRAT")
		APPEND TO ARRAY:C911($atACT_paisesCod;"252")
		APPEND TO ARRAY:C911($atACT_paises;"GROENLANDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"253")
		APPEND TO ARRAY:C911($atACT_paises;"JORDANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"301")
		APPEND TO ARRAY:C911($atACT_paises;"ARABIA SAUDITA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"302")
		APPEND TO ARRAY:C911($atACT_paises;"KUWAIT")
		APPEND TO ARRAY:C911($atACT_paisesCod;"303")
		APPEND TO ARRAY:C911($atACT_paises;"OMAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"304")
		APPEND TO ARRAY:C911($atACT_paises;"CHIPRE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"305")
		APPEND TO ARRAY:C911($atACT_paises;"ISRAEL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"306")
		APPEND TO ARRAY:C911($atACT_paises;"IRAK")
		APPEND TO ARRAY:C911($atACT_paisesCod;"307")
		APPEND TO ARRAY:C911($atACT_paises;"AFGHANISTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"308")
		APPEND TO ARRAY:C911($atACT_paises;"IRAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"309")
		APPEND TO ARRAY:C911($atACT_paises;"SIRIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"310")
		APPEND TO ARRAY:C911($atACT_paises;"LIBANO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"311")
		APPEND TO ARRAY:C911($atACT_paises;"QATAR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"312")
		APPEND TO ARRAY:C911($atACT_paises;"BAHREIN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"313")
		APPEND TO ARRAY:C911($atACT_paises;"SRI LANKA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"314")
		APPEND TO ARRAY:C911($atACT_paises;"CAMBODIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"315")
		APPEND TO ARRAY:C911($atACT_paises;"LAOS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"316")
		APPEND TO ARRAY:C911($atACT_paises;"INDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"317")
		APPEND TO ARRAY:C911($atACT_paises;"BUTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"318")
		APPEND TO ARRAY:C911($atACT_paises;"THAILANDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"319")
		APPEND TO ARRAY:C911($atACT_paises;"NEPAL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"320")
		APPEND TO ARRAY:C911($atACT_paises;"BANGLADESH")
		APPEND TO ARRAY:C911($atACT_paisesCod;"321")
		APPEND TO ARRAY:C911($atACT_paises;"PAKISTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"324")
		APPEND TO ARRAY:C911($atACT_paises;"VIETNAM")
		APPEND TO ARRAY:C911($atACT_paisesCod;"325")
		APPEND TO ARRAY:C911($atACT_paises;"MYANMAR (EX BIRMANIA)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"326")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS MALDIVAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"327")
		APPEND TO ARRAY:C911($atACT_paises;"INDONESIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"328")
		APPEND TO ARRAY:C911($atACT_paises;"MALASIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"329")
		APPEND TO ARRAY:C911($atACT_paises;"TAIWAN (FORMOSA)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"330")
		APPEND TO ARRAY:C911($atACT_paises;"JAPON")
		APPEND TO ARRAY:C911($atACT_paisesCod;"331")
		APPEND TO ARRAY:C911($atACT_paises;"SINGAPUR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"332")
		APPEND TO ARRAY:C911($atACT_paises;"COREA DEL SUR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"333")
		APPEND TO ARRAY:C911($atACT_paises;"COREA DEL NORTE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"334")
		APPEND TO ARRAY:C911($atACT_paises;"FILIPINAS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"335")
		APPEND TO ARRAY:C911($atACT_paises;"CHINA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"336")
		APPEND TO ARRAY:C911($atACT_paises;"MONGOLIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"337")
		APPEND TO ARRAY:C911($atACT_paises;"EMIRATOS ARABES UNIDOS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"341")
		APPEND TO ARRAY:C911($atACT_paises;"HONG KONG REGIÓN ADMINISTRATIVA ESPECIAL DE CHINA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"342")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO PORTUGUES EN ASIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"343")
		APPEND TO ARRAY:C911($atACT_paises;"BRUNEI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"344")
		APPEND TO ARRAY:C911($atACT_paises;"MACAO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"345")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA DE YEMEN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"346")
		APPEND TO ARRAY:C911($atACT_paises;"FIJI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"401")
		APPEND TO ARRAY:C911($atACT_paises;"NAURU")
		APPEND TO ARRAY:C911($atACT_paisesCod;"402")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS TONGA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"403")
		APPEND TO ARRAY:C911($atACT_paises;"SAMOA OCCIDENTAL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"404")
		APPEND TO ARRAY:C911($atACT_paises;"NUEVA ZELANDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"405")
		APPEND TO ARRAY:C911($atACT_paises;"AUSTRALIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"406")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO BRITÁNICO EN OCEANIA Y EL PACIFICO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"407")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO FRANCES EN OCEANIA Y EL PACIFICO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"408")
		APPEND TO ARRAY:C911($atACT_paises;"TERRITORIO NORTEAMERICANO EN OCEANIA Y EL PACIFICO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"409")
		APPEND TO ARRAY:C911($atACT_paises;"PAPUA, NUEVA GUINEA. Abreviatura PPUA.NVA.GUINEA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"412")
		APPEND TO ARRAY:C911($atACT_paises;"VANUATU")
		APPEND TO ARRAY:C911($atACT_paisesCod;"415")
		APPEND TO ARRAY:C911($atACT_paises;"KIRIBATI")
		APPEND TO ARRAY:C911($atACT_paisesCod;"416")
		APPEND TO ARRAY:C911($atACT_paises;"MICRONESIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"417")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS SALOMON")
		APPEND TO ARRAY:C911($atACT_paisesCod;"418")
		APPEND TO ARRAY:C911($atACT_paises;"TUVALU")
		APPEND TO ARRAY:C911($atACT_paisesCod;"419")
		APPEND TO ARRAY:C911($atACT_paises;"BELAU")
		APPEND TO ARRAY:C911($atACT_paisesCod;"420")
		APPEND TO ARRAY:C911($atACT_paises;"NIUE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"421")
		APPEND TO ARRAY:C911($atACT_paises;"POLINESIA FRANCESA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"422")
		APPEND TO ARRAY:C911($atACT_paises;"NUEVA CALEDONIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"423")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS MARIANAS DEL NORTE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"424")
		APPEND TO ARRAY:C911($atACT_paises;"GUAM")
		APPEND TO ARRAY:C911($atACT_paisesCod;"425")
		APPEND TO ARRAY:C911($atACT_paises;"TIMOR ORIENTAL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"426")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS COOK")
		APPEND TO ARRAY:C911($atACT_paisesCod;"427")
		APPEND TO ARRAY:C911($atACT_paises;"PORTUGAL")
		APPEND TO ARRAY:C911($atACT_paisesCod;"501")
		APPEND TO ARRAY:C911($atACT_paises;"ITALIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"504")
		APPEND TO ARRAY:C911($atACT_paises;"FRANCIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"505")
		APPEND TO ARRAY:C911($atACT_paises;"IRLANDA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"506")
		APPEND TO ARRAY:C911($atACT_paises;"DINAMARCA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"507")
		APPEND TO ARRAY:C911($atACT_paises;"SUIZA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"508")
		APPEND TO ARRAY:C911($atACT_paises;"AUSTRIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"509")
		APPEND TO ARRAY:C911($atACT_paises;"REINO UNIDO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"510")
		APPEND TO ARRAY:C911($atACT_paises;"SUECIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"511")
		APPEND TO ARRAY:C911($atACT_paises;"FINLANDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"512")
		APPEND TO ARRAY:C911($atACT_paises;"NORUEGA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"513")
		APPEND TO ARRAY:C911($atACT_paises;"BELGICA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"514")
		APPEND TO ARRAY:C911($atACT_paises;"HOLANDA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"515")
		APPEND TO ARRAY:C911($atACT_paises;"ISLANDIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"516")
		APPEND TO ARRAY:C911($atACT_paises;"ESPAÑA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"517")
		APPEND TO ARRAY:C911($atACT_paises;"ALBANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"518")
		APPEND TO ARRAY:C911($atACT_paises;"RUMANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"519")
		APPEND TO ARRAY:C911($atACT_paises;"GRECIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"520")
		APPEND TO ARRAY:C911($atACT_paises;"TURQUIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"522")
		APPEND TO ARRAY:C911($atACT_paises;"MALTA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"523")
		APPEND TO ARRAY:C911($atACT_paises;"SANTA SEDE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"524")
		APPEND TO ARRAY:C911($atACT_paises;"ANDORRA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"525")
		APPEND TO ARRAY:C911($atACT_paises;"BULGARIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"527")
		APPEND TO ARRAY:C911($atACT_paises;"POLONIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"528")
		APPEND TO ARRAY:C911($atACT_paises;"HUNGRIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"530")
		APPEND TO ARRAY:C911($atACT_paises;"LUXEMBURGO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"532")
		APPEND TO ARRAY:C911($atACT_paises;"LIECHTENSTEIN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"534")
		APPEND TO ARRAY:C911($atACT_paises;"MONACO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"535")
		APPEND TO ARRAY:C911($atACT_paises;"SAN MARINO")
		APPEND TO ARRAY:C911($atACT_paisesCod;"536")
		APPEND TO ARRAY:C911($atACT_paises;"ARMENIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"540")
		APPEND TO ARRAY:C911($atACT_paises;"AZERBAIJAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"541")
		APPEND TO ARRAY:C911($atACT_paises;"BELARUS")
		APPEND TO ARRAY:C911($atACT_paisesCod;"542")
		APPEND TO ARRAY:C911($atACT_paises;"BOSNIA Y HERZEGOVINA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"543")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA CHECA (D)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"544")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA ESLOVACA (D). Abreviatura REP.ESLOVACA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"545")
		APPEND TO ARRAY:C911($atACT_paises;"REPUBLICA DE SERBIA (2)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"546")
		APPEND TO ARRAY:C911($atACT_paises;"CROACIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"547")
		APPEND TO ARRAY:C911($atACT_paises;"ESLOVENIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"548")
		APPEND TO ARRAY:C911($atACT_paises;"ESTONIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"549")
		APPEND TO ARRAY:C911($atACT_paises;"GEORGIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"550")
		APPEND TO ARRAY:C911($atACT_paises;"KASAJSTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"551")
		APPEND TO ARRAY:C911($atACT_paises;"KIRGISTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"552")
		APPEND TO ARRAY:C911($atACT_paises;"LETONIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"553")
		APPEND TO ARRAY:C911($atACT_paises;"LITUANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"554")
		APPEND TO ARRAY:C911($atACT_paises;"MACEDONIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"555")
		APPEND TO ARRAY:C911($atACT_paises;"MOLDOVA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"556")
		APPEND TO ARRAY:C911($atACT_paises;"TADJIKISTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"557")
		APPEND TO ARRAY:C911($atACT_paises;"TURKMENISTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"558")
		APPEND TO ARRAY:C911($atACT_paises;"UCRANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"559")
		APPEND TO ARRAY:C911($atACT_paises;"UZBEKISTAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"560")
		APPEND TO ARRAY:C911($atACT_paises;"MONTENEGRO (2)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"561")
		APPEND TO ARRAY:C911($atACT_paises;"RUSIA (B)")
		APPEND TO ARRAY:C911($atACT_paisesCod;"562")
		APPEND TO ARRAY:C911($atACT_paises;"ALEMANIA")
		APPEND TO ARRAY:C911($atACT_paisesCod;"563")
		APPEND TO ARRAY:C911($atACT_paises;"GIBRALTAR")
		APPEND TO ARRAY:C911($atACT_paisesCod;"565")
		APPEND TO ARRAY:C911($atACT_paises;"GUERNSEY")
		APPEND TO ARRAY:C911($atACT_paisesCod;"566")
		APPEND TO ARRAY:C911($atACT_paises;"ISLAS DE MAN")
		APPEND TO ARRAY:C911($atACT_paisesCod;"567")
		APPEND TO ARRAY:C911($atACT_paises;"JERSEY")
		APPEND TO ARRAY:C911($atACT_paisesCod;"568")
		APPEND TO ARRAY:C911($atACT_paises;"CHILE")
		APPEND TO ARRAY:C911($atACT_paisesCod;"997")
		
		ACTdte_SetTablasNacionalidad ("NombrePrefTablaPaises";->$t_nombrePref)
		
		C_OBJECT:C1216($ob)
		$ob:=OB_Create 
		OB_SET ($ob;->$atACT_paises;"tablacodigospaises")
		OB_SET ($ob;->$atACT_paisesCod;"tablacodigos")
		$t_texto:=OB_Object2Json ($ob)
		
		PREF_Set (0;$t_nombrePref;$t_texto)
		
		  //NACIONALIDADES
		ARRAY TEXT:C222($atACT_paisesNac;0)
		ARRAY TEXT:C222($atACT_Nacionalidad;0)
		
		APPEND TO ARRAY:C911($atACT_paisesNac;"ALEMANIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Alemania")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ALEMANIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Alemana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ARGENTINA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Argentina")
		APPEND TO ARRAY:C911($atACT_paisesNac;"AUSTRALIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Australiana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"AUSTRIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Austria")
		APPEND TO ARRAY:C911($atACT_paisesNac;"AUSTRIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Austriaca")
		APPEND TO ARRAY:C911($atACT_paisesNac;"BOLIVIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Boliviana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"BRASIL")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Brasilera")
		APPEND TO ARRAY:C911($atACT_paisesNac;"REINO UNIDO")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Británica")
		APPEND TO ARRAY:C911($atACT_paisesNac;"CANADA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Canadiense")
		APPEND TO ARRAY:C911($atACT_paisesNac;"CHILE")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Chilena")
		APPEND TO ARRAY:C911($atACT_paisesNac;"COLOMBIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Colombiana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"COREA DEL SUR")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Corea")
		APPEND TO ARRAY:C911($atACT_paisesNac;"COREA DEL SUR")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Coreana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"CUBA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Cubana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"DINAMARCA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Danesa")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ECUADOR")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Ecuatoriana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ECUADOR")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Ecuatoriano")
		APPEND TO ARRAY:C911($atACT_paisesNac;"REINO UNIDO")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Escocesa")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ESPAÑA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Española")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ESTADOS UNIDOS DE AMÉRICA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Estado Unidense")
		APPEND TO ARRAY:C911($atACT_paisesNac;"FRANCIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Francesa")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ITALIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Italiana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"JAPON")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Japonesa")
		APPEND TO ARRAY:C911($atACT_paisesNac;"MEXICO")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Mexicana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"PERU")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Peruana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"RUMANIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Rumana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"SUECIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Sueca")
		APPEND TO ARRAY:C911($atACT_paisesNac;"SUIZA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Suiza")
		APPEND TO ARRAY:C911($atACT_paisesNac;"THAILANDIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Tailandesa")
		APPEND TO ARRAY:C911($atACT_paisesNac;"TAIWAN (FORMOSA)")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Taiwanese")
		APPEND TO ARRAY:C911($atACT_paisesNac;"URUGUAY")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Uruguaya")
		APPEND TO ARRAY:C911($atACT_paisesNac;"VENEZUELA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Venezolana")
		APPEND TO ARRAY:C911($atACT_paisesNac;"ZAMBIA")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Zambia")
		APPEND TO ARRAY:C911($atACT_paisesNac;"PARAGUAY")
		APPEND TO ARRAY:C911($atACT_Nacionalidad;"Paraguaya")
		
		ACTdte_SetTablasNacionalidad ("GuardaTablaNacionalidad";->$atACT_paisesNac;->$atACT_Nacionalidad)
		
	: ($t_accion="GuardaTablaNacionalidad")
		C_TEXT:C284($t_json;$t_texto;$t_nombrePref)
		
		ACTdte_SetTablasNacionalidad ("NombrePrefTablaNacionalidades";->$t_nombrePref)
		
		C_OBJECT:C1216($ob)
		$ob:=OB_Create 
		OB_SET ($ob;$y_puntero1;"tablanac_pais")
		OB_SET ($ob;$y_puntero2;"tablanac_nacionalidad")
		$t_texto:=OB_Object2Json ($ob)
		
		PREF_Set (0;$t_nombrePref;$t_texto)
		
	: ($t_accion="NombrePrefTablaPaises")
		$y_puntero1->:="ACT_TABLAPAISES_DTE"
		
	: ($t_accion="NombrePrefTablaNacionalidades")
		$y_puntero1->:="ACT_TABLANACIONALIDADES_DTE"
		
	: ($t_accion="NombrePrefTablaNacionalidadesColegio")
		$y_puntero1->:="ACT_TABLANACIONALIDADES_COLEGIO_DTE"
		
	: ($t_accion="GuardaTablaNacionalidadColegio")
		
		
		  // Modificado por: Alexis Bustamante (09-05-2017)
		  //Ticket Nº 179869
		C_TEXT:C284($t_json;$t_texto;$t_nombrePref)
		ACTdte_SetTablasNacionalidad ("NombrePrefTablaNacionalidadesColegio";->$t_nombrePref)
		
		C_OBJECT:C1216($ob)
		$ob:=OB_Create 
		OB_SET ($ob;$y_puntero1;"tablanac_pais")
		OB_SET ($ob;$y_puntero2;"tablanac_nacionalidad")
		$t_texto:=OB_Object2Json ($ob)
		PREF_Set (0;$t_nombrePref;$t_texto)
		  //: ($t_accion="GuardaTablaNacionalidadColegio")
		  //  //C_TEXT($t_json;$t_texto;$t_nombrePref)
		  //  //ACTdte_SetTablasNacionalidad ("NombrePrefTablaNacionalidadesColegio";->$t_nombrePref)
		  //  //$t_json:=JSON New 
		  //  //JSON_AgregaElemento ($t_json;$y_puntero1;"tablanac_pais")
		  //  //JSON_AgregaElemento ($t_json;$y_puntero2;"tablanac_nacionalidad")
		  //  //$t_texto:=JSON Export to text ($t_json;JSON_WITHOUT_WHITE_SPACE)
		  //  //JSON CLOSE ($t_json)
		  //  //PREF_Set (0;$t_nombrePref;$t_texto)
		
		
End case 