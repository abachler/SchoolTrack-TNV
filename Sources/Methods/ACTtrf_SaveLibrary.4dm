//%attributes = {}
  //ACTtrf_SaveLibrary

If (Application type:C494=4D Remote mode:K5:5)
	$proc:=Execute on server:C373(Current method name:C684;Pila_256K;"Guardando archivos de transferencia bancaria")
Else 
	  //20130702 RCH Para evitar error por arreglo de formas de pago no definido...
	  //ACT_LeeConfiguracion 
	ACTfdp_CargaFormasDePago   //20130704 RCH
	
	C_BLOB:C604($blob)
	C_LONGINT:C283($l_eliminados)  //20130730 RCH
	
	QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]ID:1>=0)  //elimina sólo los métodos que utilizan métodos de la estructura
	$l_eliminados:=KRL_DeleteSelection (->[xxACT_ArchivosBancarios:118])
	If ($l_eliminados=1)
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Creando archivos de transferencia bancaria..."))
		ARRAY TEXT:C222($roles;37)
		AT_Inc (0)
		$roles{AT_Inc }:="256692"  //Highlands
		$roles{AT_Inc }:="155640"  //La Cruz
		$roles{AT_Inc }:="256544"  //Everest
		$roles{AT_Inc }:="248363"  //San Isidro
		$roles{AT_Inc }:="119687"  //Cumbres
		$roles{AT_Inc }:="90468"  //Grange
		$roles{AT_Inc }:="119717"  //Sto. Domingo
		$roles{AT_Inc }:="18392"  //Aleman Valpo.
		$roles{AT_Inc }:="17833"  //St. Margarets
		$roles{AT_Inc }:="3063"  //Liceo Boston (CO)
		$roles{AT_Inc }:="88706"  //Cia Maria Apoq.
		$roles{AT_Inc }:="8000560160"  //Gim. Britanico (CO)
		$roles{AT_Inc }:="92711"  //Kent
		$roles{AT_Inc }:="88722"  //Wenlock
		$roles{AT_Inc }:="89729"  //San Benito
		$roles{AT_Inc }:="3450"  //Buckingham (CO)
		$roles{AT_Inc }:="88781"  //monjas inglesas
		$roles{AT_Inc }:="74152"  //Aleman Osorno RCH
		$roles{AT_Inc }:="89508"  //Cia Maria Seminario
		  //$roles{AT_Inc }:="89788"  `Dunalastair
		  //$roles{AT_Inc }:="8978B"  `Dunalastair Valle Norte
		$roles{AT_Inc }:="89176"  //Craighouse
		  //$roles{AT_Inc }:="246247"  `Monte Tabor
		$roles{AT_Inc }:="17930"  //DSC Reñaca
		$roles{AT_Inc }:="30147"  //Inglés de Talca
		$roles{AT_Inc }:="17965"  //Compañía de María Viña del Mar
		$roles{AT_Inc }:="86118"  //Nuestra Señora de Andacollo
		$roles{AT_Inc }:="88730"  //Villa Maria
		$roles{AT_Inc }:="17914"  //Saint Paul's
		$roles{AT_Inc }:="68446"  //Instituto Alemán de Valdivia
		$roles{AT_Inc }:="88943"  //La Maisonnette 
		$roles{AT_Inc }:="250015"  //The Greenland School 
		$roles{AT_Inc }:="249769"  //San Felipe Diácono 
		$roles{AT_Inc }:="258253"  //San Miguel Arcángel
		$roles{AT_Inc }:="88692"  //The Newland School 
		$roles{AT_Inc }:="89036"  //Lincoln International Academy
		$roles{AT_Inc }:="86096"  //San Ignacio Alonso Ovalle
		
		APPEND TO ARRAY:C911($roles;"20154850784")  //casuarinas
		APPEND TO ARRAY:C911($roles;"88773")  //Manquehue
		APPEND TO ARRAY:C911($roles;"74063")  //San Mateo Osorno
		APPEND TO ARRAY:C911($roles;"DF0039")  //colegio Madrid MX
		APPEND TO ARRAY:C911($roles;"92789")  //Instituto Santa Maria
		APPEND TO ARRAY:C911($roles;"8002500161")  //Cumbres Medellin
		APPEND TO ARRAY:C911($roles;"249270")  //San Anselmo
		APPEND TO ARRAY:C911($roles;"PE0519330")  //Santa Teresita
		APPEND TO ARRAY:C911($roles;"DF0002")  //Yaocalli
		APPEND TO ARRAY:C911($roles;"002327065")  //Cumbres Caracas
		APPEND TO ARRAY:C911($roles;"8300698598")  //Cumbres Bogota
		APPEND TO ARRAY:C911($roles;"8998")  //Cambridge
		APPEND TO ARRAY:C911($roles;"8909167689")  //Cambridge
		APPEND TO ARRAY:C911($roles;"890916768-9")  //Cambridge
		APPEND TO ARRAY:C911($roles;"QRO01")  //(MX) Newland de Querétaro
		
		For ($s;1;Size of array:C274($roles))
			_O_ARRAY STRING:C218(80;$aMethods2Convert;0)
			ARRAY TEXT:C222($aMethodsTypes;0)
			ARRAY BOOLEAN:C223($aMethodImpExp;0)
			Case of 
				: ($roles{$s}="256692")  //HIghlands (listo)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					$aMethods2Convert{1}:="ACTabc_ImportPACHighlands"
					$aMethods2Convert{2}:="ACTabc_ImportPATHighlands"
					$aMethods2Convert{3}:="ACTabc_ExportPACHighlands"
					  //$aMethods2Convert{4}:="ACTabc_ExportPATHighlands"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAT"
					$aMethodsTypes{3}:="PAC"
					  //$aMethodsTypes{4}:="PAT"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					  //$aMethodImpExp{4}:=False
					$col:="Highlands"
					$pais:="cl"
				: ($roles{$s}="155640")  //La Cruz (listo)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					$aMethods2Convert{1}:="ACTabc_ImportPACLaCruz"
					$aMethods2Convert{2}:="ACTabc_ImportPATLaCruz"
					$aMethods2Convert{3}:="ACTabc_ExportPACLaCruz"
					  //$aMethods2Convert{4}:="ACTabc_ExportPATLaCruz"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAT"
					$aMethodsTypes{3}:="PAC"
					  //$aMethodsTypes{4}:="PAT"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					  //$aMethodImpExp{4}:=False
					$col:="La Cruz"
					$pais:="cl"
				: ($roles{$s}="256544")  //Everest (listo)
					  //ARRAY STRING(80;$aMethods2Convert;4)
					  //ARRAY TEXT($aMethodsTypes;4)
					  //ARRAY BOOLEAN($aMethodImpExp;4)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ImportPACEverest"
					$aMethods2Convert{2}:="ACTabc_ImportPATEverest"
					  //$aMethods2Convert{3}:="ACTabc_ExportPACEverest"
					  //$aMethods2Convert{4}:="ACTabc_ExportPATEverest"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAT"
					  //$aMethodsTypes{3}:="PAC"
					  //$aMethodsTypes{4}:="PAT"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					  //$aMethodImpExp{3}:=False
					  //$aMethodImpExp{4}:=False
					$col:="Everest"
					$pais:="cl"
				: ($roles{$s}="248363")  //San Isidro (listo)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ImportPACSanIsidro"
					$aMethods2Convert{2}:="ACTabc_ExportPACSanIsidro"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAC"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=False:C215
					$col:="San Isidro"
					$pais:="cl"
				: ($roles{$s}="119687")  //Cumbres (listo)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					AT_Inc (0)
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportPACCumbres"
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportPATCumbres"
					  //$aMethods2Convert{AT_Inc }:="ACTabc_ExportPACCumbres"
					AT_Inc (0)
					$aMethodsTypes{AT_Inc }:="PAC"
					$aMethodsTypes{AT_Inc }:="PAT"
					  //$aMethodsTypes{AT_Inc }:="PAC"
					AT_Inc (0)
					$aMethodImpExp{AT_Inc }:=True:C214
					$aMethodImpExp{AT_Inc }:=True:C214
					  //$aMethodImpExp{AT_Inc }:=False
					$col:="Cumbres"
					$pais:="cl"
					  //ARRAY STRING(80;$aMethods2Convert;4)
					  //ARRAY TEXT($aMethodsTypes;4)
					  //ARRAY BOOLEAN($aMethodImpExp;4)
					  //$aMethods2Convert{1}:="ACTabc_ImportPACCumbres"
					  //$aMethods2Convert{2}:="ACTabc_ImportPATCumbres"
					  //$aMethods2Convert{3}:="ACTabc_ExportPACCumbres"
					  //$aMethods2Convert{4}:="ACTabc_ExportPATCumbres"
					  //$aMethodsTypes{1}:="PAC"
					  //$aMethodsTypes{2}:="PAT"
					  //$aMethodsTypes{3}:="PAC"
					  //$aMethodsTypes{4}:="PAT"
					  //$aMethodImpExp{1}:=True
					  //$aMethodImpExp{2}:=True
					  //$aMethodImpExp{3}:=False
					  //$aMethodImpExp{4}:=False
					  //$col:="Cumbres"
					  //$pais:="cl"
				: ($roles{$s}="90468")  //Grange
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					  //$aMethods2Convert{1}:="ACTabc_ExportPACGrange"
					  //$aMethods2Convert{2}:="ACTabc_ExportPATGrange"
					$aMethods2Convert{1}:="ACTabc_ImportPACGrange"
					$aMethods2Convert{2}:="ACTabc_ImportPATGrange"
					  //$aMethodsTypes{1}:="PAC"
					  //$aMethodsTypes{2}:="PAT"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAT"
					  //$aMethodImpExp{1}:=False
					  //$aMethodImpExp{2}:=False
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$col:="Grange"
					$pais:="cl"
				: ($roles{$s}="119717")  //Sto. Domingo (listo)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportPATStoDomingo"
					  //$aMethods2Convert{2}:="ACTabc_ExportPATStoDomingo"
					$aMethodsTypes{1}:="PAT"
					  //$aMethodsTypes{2}:="PAT"
					$aMethodImpExp{1}:=True:C214
					  //$aMethodImpExp{2}:=False
					$col:="Santo Domingo"
					$pais:="cl"
				: ($roles{$s}="18392")  //Aleman de Valpo.
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportCUPAleman"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$col:="Alemán de Valpo."
					$pais:="cl"
				: ($roles{$s}="17833")  //St. Margarets
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					$aMethods2Convert{1}:="ACTabc_ImportPACScotiaStMargare"
					$aMethods2Convert{2}:="ACTabc_ImportCUPStMargarets"
					$aMethods2Convert{3}:="ACTabc_ExportPACStMargarets"
					$aMethods2Convert{4}:="ACTabc_ExportCUPStMargarets"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="PAC"
					$aMethodsTypes{4}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					$aMethodImpExp{4}:=False:C215
					$col:="St. Margarets"
					$pais:="cl"
				: ($roles{$s}="3063")  //Liceo Boston, Colombia
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ImportPATBoston"
					$aMethods2Convert{2}:="ACTabc_ExportPATBoston"
					$aMethodsTypes{1}:="PAT"
					$aMethodsTypes{2}:="PAT"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=False:C215
					$col:="Liceo Boston"
					$pais:="co"
				: ($roles{$s}="88706")  //Cia Maria APoquindo
					_O_ARRAY STRING:C218(80;$aMethods2Convert;5)
					ARRAY TEXT:C222($aMethodsTypes;5)
					ARRAY BOOLEAN:C223($aMethodImpExp;5)
					$aMethods2Convert{1}:="ACTabc_ExportPACCiaMApo"
					$aMethods2Convert{2}:="ACTabc_ImportPACCiaMApo"
					$aMethods2Convert{3}:="ACTabc_ExportCUPCiaMApo"
					$aMethods2Convert{4}:="ACTabc_ImportCUPCiaMApo"
					  //$aMethods2Convert{5}:="ACTabc_ExportPATCiaMApo"  `RCH
					$aMethods2Convert{5}:="ACTabc_ImportPATCiaMApo"  //RCH
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAC"
					$aMethodsTypes{3}:="Cuponera"
					$aMethodsTypes{4}:="Cuponera"
					  //$aMethodsTypes{5}:="PAT"
					$aMethodsTypes{5}:="PAT"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					$aMethodImpExp{4}:=True:C214
					  //$aMethodImpExp{5}:=False
					$aMethodImpExp{5}:=True:C214
					$col:="Cia. Maria Apoquindo"
					$pais:="cl"
				: ($roles{$s}="8000560160")  //Gimnasio Britanico, Colombia
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportCUPBritanico"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$col:="Gimnasio Británico"
					$pais:="co"
				: ($roles{$s}="92711")  //Kent
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					  //$aMethods2Convert{1}:="ACTabc_ExportPACKent" `eliminado incidente 61586
					  //$aMethods2Convert{2}:="ACTabc_ImportCUPKent"  `Kent RCH `eliminado incidente 61586
					$aMethods2Convert{1}:="ACTabc_ImportPACKent"  //RCH
					$aMethods2Convert{2}:="ACTabc_ExportCUPKent"  //RC
					  //$aMethodsTypes{1}:="PAC"
					  //$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="Cuponera"
					  //$aMethodImpExp{1}:=False
					  //$aMethodImpExp{2}:=True
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=False:C215
					$col:="Kent"
					$pais:="cl"
				: ($roles{$s}="88722")  //Wenlock
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					  //$aMethods2Convert{1}:="ACTabc_ExportPATWenlock"
					$aMethods2Convert{1}:="ACTabc_ExportCUPWenlock"
					  //$aMethodsTypes{1}:="PAT"
					$aMethodsTypes{1}:="Cuponera"
					  //$aMethodImpExp{1}:=False
					$aMethodImpExp{1}:=False:C215
					$col:="Wenlock"
					$pais:="cl"
				: ($roles{$s}="89729")  //San Benito
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					  //$aMethods2Convert{1}:="ACTabc_ExportPATSBenito"
					$aMethods2Convert{1}:="ACTabc_ExportCUPSBenito"
					$aMethods2Convert{2}:="ACTabc_ImportPATSBenito"
					$aMethods2Convert{3}:="ACTabc_ImportCUPSBenito"
					$aMethods2Convert{4}:="ACTabc_ImportPACSBenito"
					  //$aMethods2Convert{6}:="ACTabc_ExportPACSBenito" `incidente 64015
					  //$aMethodsTypes{1}:="PAT"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="PAT"
					$aMethodsTypes{3}:="Cuponera"
					$aMethodsTypes{4}:="PAC"
					  //$aMethodsTypes{6}:="PAC"
					  //$aMethodImpExp{1}:=False
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=True:C214
					$aMethodImpExp{4}:=True:C214
					  //$aMethodImpExp{6}:=False
					$col:="San Benito"
					$pais:="cl"
				: ($roles{$s}="3450")  //Buckingham (Colombia)
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportPACBuckingham"
					$aMethodsTypes{1}:="PAC"
					$aMethodImpExp{1}:=True:C214
					$col:="Buckingham"
					$pais:="co"
				: ($roles{$s}="88781")  //monjas inglesas
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPMInglesas"
					  //$aMethods2Convert{2}:="ACTabc_ImportCUPMInglesas"
					$aMethodsTypes{1}:="Cuponera"
					  //$aMethodsTypes{2}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					  //$aMethodImpExp{2}:=True
					$col:="Monjas Inglesas"
					$pais:="cl"
				: ($roles{$s}="74152")  //Aleman Osorno RCH
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					$aMethods2Convert{1}:="ACTabc_ExportCUPAOsorno"
					$aMethods2Convert{2}:="ACTabc_ExportPACAOsorno"
					$aMethods2Convert{3}:="ACTabc_ImportPACAOsorno"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="PAC"
					$aMethodsTypes{3}:="PAC"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=False:C215
					$aMethodImpExp{3}:=True:C214
					$col:="Alemán Osorno"
					$pais:="cl"
				: ($roles{$s}="89508")  //Cia Maria Seminario
					_O_ARRAY STRING:C218(80;$aMethods2Convert;5)
					ARRAY TEXT:C222($aMethodsTypes;5)
					ARRAY BOOLEAN:C223($aMethodImpExp;5)
					AT_Inc (0)
					  //$aMethods2Convert{1}:="ACTabc_ExportPATCiaMSeminario"
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportPATCiaMSeminario"
					$aMethods2Convert{AT_Inc }:="ACTabc_ExportPACCiaMSeminario"
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportPACCiaMSeminario"
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportCUPCiaMSeminario"
					$aMethods2Convert{AT_Inc }:="ACTabc_ExportCUPCiaMSeminario"
					  //$aMethodsTypes{1}:="PAT"
					AT_Inc (0)
					$aMethodsTypes{AT_Inc }:="PAT"
					$aMethodsTypes{AT_Inc }:="PAC"
					$aMethodsTypes{AT_Inc }:="PAC"
					$aMethodsTypes{AT_Inc }:="Cuponera"
					$aMethodsTypes{AT_Inc }:="Cuponera"
					  //$aMethodImpExp{1}:=False
					AT_Inc (0)
					$aMethodImpExp{AT_Inc }:=True:C214
					$aMethodImpExp{AT_Inc }:=False:C215
					$aMethodImpExp{AT_Inc }:=True:C214
					$aMethodImpExp{AT_Inc }:=True:C214
					$aMethodImpExp{AT_Inc }:=False:C215
					$col:="Cia Maria Seminario"
					$pais:="cl"
					  //: ($roles{$s}="89788")  `Dunalastair
					  //ARRAY STRING(80;$aMethods2Convert;1)
					  //ARRAY TEXT($aMethodsTypes;1)
					  //ARRAY BOOLEAN($aMethodImpExp;1)
					  //$aMethods2Convert{1}:="ACTabc_ExportPACDunalastair"
					  //$aMethodsTypes{1}:="PAC"
					  //$aMethodImpExp{1}:=False
					  //$col:="Dunalastair"
					  //$pais:="cl"
					  //: ($roles{$s}="8978B")  `Dunalastair Valle Norte
					  //ARRAY STRING(80;$aMethods2Convert;1)
					  //ARRAY TEXT($aMethodsTypes;1)
					  //ARRAY BOOLEAN($aMethodImpExp;1)
					  //$aMethods2Convert{1}:="ACTabc_ExportPACDunalastairVN"
					  //$aMethodsTypes{1}:="PAC"
					  //$aMethodImpExp{1}:=False
					  //$col:="Dunalastair Valle Norte"
					  //$pais:="cl"
				: ($roles{$s}="89176")  //Craighouse
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					$aMethods2Convert{1}:="ACTabc_ImportCUPCraighouse"
					$aMethods2Convert{2}:="ACTabc_ExportCUPCraighouse"
					$aMethods2Convert{3}:="ACTabc_ExportCUPCraighouse2"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=False:C215
					$aMethodImpExp{3}:=False:C215
					$col:="Craighouse"
					$pais:="cl"
					  //: ($roles{$s}="246247")  `Monte Tabor
					  //ARRAY STRING(80;$aMethods2Convert;6)
					  //ARRAY TEXT($aMethodsTypes;6)
					  //ARRAY BOOLEAN($aMethodImpExp;6)
					  //$aMethods2Convert{1}:="ACTabc_ImportCUPMTabor"
					  //$aMethods2Convert{2}:="ACTabc_ExportPACMTabor"
					  //$aMethods2Convert{3}:="ACTabc_ImportPACMTabor"
					  //$aMethods2Convert{4}:="ACTabc_ImportPATMTabor"
					  //$aMethods2Convert{5}:="ACTabc_ExportPATMTabor"
					  //$aMethods2Convert{6}:="ACTabc_ExportCUPMTabor"
					  //$aMethodsTypes{1}:="Cuponera"
					  //$aMethodsTypes{2}:="PAC"
					  //$aMethodsTypes{3}:="PAC"
					  //$aMethodsTypes{4}:="PAT"
					  //$aMethodsTypes{5}:="PAT"
					  //$aMethodsTypes{6}:="Cuponera"
					  //$aMethodImpExp{1}:=True
					  //$aMethodImpExp{2}:=False
					  //$aMethodImpExp{3}:=True
					  //$aMethodImpExp{4}:=True
					  //$aMethodImpExp{5}:=False
					  //$aMethodImpExp{6}:=False
					  //$col:="Monte Tabor"
					  //$pais:="cl"
				: ($roles{$s}="17930")  //DSC Reñaca
					  //ARRAY STRING(80;$aMethods2Convert;1)
					  //ARRAY TEXT($aMethodsTypes;1)
					  //ARRAY BOOLEAN($aMethodImpExp;1)
					  //$aMethods2Convert{1}:="ACTabc_ExportPATDSCReñaca"
					  //$aMethodsTypes{1}:="PAT"
					  //$aMethodImpExp{1}:=False
					  //$col:="DSC Reñaca"
					  //$pais:="cl"
				: ($roles{$s}="30147")  //Inglés de Talca
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ImportPACInglesTalca"
					$aMethods2Convert{2}:="ACTabc_ExportPACInglesTalca"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAC"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=False:C215
					$col:="Inglés de Talca"
					$pais:="cl"
				: ($roles{$s}="17965")  //Cía María Viña del mar
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					AT_Inc (0)
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportPATCiaMVM"
					  //$aMethods2Convert{AT_Inc }:="ACTabc_ExportPATCiaMVM"
					$aMethods2Convert{AT_Inc }:="ACTabc_ImportCUPCiaMVM"
					$aMethods2Convert{AT_Inc }:="ACTabc_ExportCUPCiaMVM"
					AT_Inc (0)
					$aMethodsTypes{AT_Inc }:="PAT"
					  //$aMethodsTypes{AT_Inc }:="PAT"
					$aMethodsTypes{AT_Inc }:="Cuponera"
					$aMethodsTypes{AT_Inc }:="Cuponera"
					AT_Inc (0)
					$aMethodImpExp{AT_Inc }:=True:C214
					  //$aMethodImpExp{AT_Inc }:=False
					$aMethodImpExp{AT_Inc }:=True:C214
					$aMethodImpExp{AT_Inc }:=False:C215
					$col:="Compañía de María Viña del Mar"
					$pais:="cl"
				: ($roles{$s}="86118")  //Nuestra Señora de Andacollo
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPNSDA"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="Nuestra Señora de Andacollo"
					$pais:="cl"
				: ($roles{$s}="88730")  //  `Villa Maria
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ExportCUPVillaMaria"
					$aMethods2Convert{2}:="ACTabc_ImportCUPVillaMaria"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$col:="Villa Maria Academy"
					$pais:="cl"
				: ($roles{$s}="17914")  //  `Saint Paul's
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPSPauls"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="Saint Paul's School"
					$pais:="cl"
				: ($roles{$s}="68446")  //Instituto Alemán de Valdivia
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ExportCUPIAValdivia"
					$aMethods2Convert{2}:="ACTabc_ExportPACIAValdivia"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="PAC"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=False:C215
					$col:="Instituto Alemán de Valdivia"
					$pais:="cl"
				: ($roles{$s}="88943")  //La Maisonnette 
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					$aMethods2Convert{1}:="ACTabc_ExportCUPMaisonnette"
					$aMethods2Convert{2}:="ACTabc_ImportPACLaMaisonnette"
					$aMethods2Convert{3}:="ACTabc_ExportPACLaMaisonnette"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="PAC"
					$aMethodsTypes{3}:="PAC"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					$col:="La Maisonnette"
					$pais:="cl"
				: ($roles{$s}="250015")  //The Greenland School 
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ExportCUPGreenland"
					$aMethods2Convert{2}:="ACTabc_ImportCUPGreenland"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$col:="The Greenland School"
					$pais:="cl"
				: ($roles{$s}="249769")  //San Felipe Diácono 
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPSanFelipe"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="San Felipe Diácono"
					$pais:="cl"
				: ($roles{$s}="258253")  //San Miguel Arcángel
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPSanMiguelA"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="San Miguel Arcángel"
					$pais:="cl"
				: ($roles{$s}="88692")  //The Newland School 
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPNewland"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="The Newland School"
					$pais:="cl"
				: ($roles{$s}="89036")  //Lincoln International Academy
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					$aMethods2Convert{1}:="ACTabc_ExportCUPLincoln"
					$aMethods2Convert{2}:="ACTabc_ImportCUPLincoln"
					$aMethods2Convert{3}:="ACTabc_ExportPACLincoln"
					$aMethods2Convert{4}:="ACTabc_ExportCUPLincoln2"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="PAC"
					$aMethodsTypes{4}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					$aMethodImpExp{4}:=False:C215
					$col:="Lincoln International Academy"
					$pais:="cl"
				: ($roles{$s}="86096")  //San Ignacio Alonso Ovalle
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPSanIgnacio"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="San Ignacio Alonso Ovalle"
					$pais:="cl"
				: ($roles{$s}="20154850784")  //casuarina
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					$aMethods2Convert{1}:="ACTabc_ExportCUPCasuarinas"
					$aMethods2Convert{2}:="ACTabc_ExportCUPCasuarinasBIF"
					$aMethods2Convert{3}:="ACTabc_ImportCUPCasuarinasIB"
					$aMethods2Convert{4}:="ACTabc_ImportCUPCasuarinasBIF"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="Cuponera"
					$aMethodsTypes{4}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=False:C215
					$aMethodImpExp{3}:=True:C214
					$aMethodImpExp{4}:=True:C214
					$col:="Casuarinas"
					$pais:="pe"
					
				: ($roles{$s}="88773")  //Manquehue
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportPATManquehue"
					$aMethodsTypes{1}:="PAT"
					$aMethodImpExp{1}:=False:C215
					$col:="Sagrados Corazones de Manquehue "
					$pais:="cl"
					
				: ($roles{$s}="74063")  //San Mateo Osorno
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportCUPSMateo"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$col:="Colegio San Mateo de Osorno"
					$pais:="cl"
					
				: ($roles{$s}="DF0039")  //colegio Madrid MX
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					$aMethods2Convert{1}:="ACTabc_ImportCUPMadrid"
					$aMethods2Convert{2}:="ACTabc_ImportCUPMadridBanamex"
					$aMethods2Convert{3}:="ACTabc_ImportPACMadridBancomer"
					$aMethods2Convert{4}:="ACTabc_ImportPATMadrid"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="PAC"
					$aMethodsTypes{4}:="PAT"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=True:C214
					$aMethodImpExp{4}:=True:C214
					$col:="Colegio Madrid"
					$pais:="mx"
					
				: ($roles{$s}="92789")  //Instituto Santa Maria
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPISM"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="Instituto Santa María"
					$pais:="cl"
					
				: ($roles{$s}="8002500161")  //Cumbres Medellin
					_O_ARRAY STRING:C218(80;$aMethods2Convert;3)
					ARRAY TEXT:C222($aMethodsTypes;3)
					ARRAY BOOLEAN:C223($aMethodImpExp;3)
					$aMethods2Convert{1}:="ACTabc_ImportPACCumbresCO"
					$aMethods2Convert{2}:="ACTabc_ImportCUPCumbresCO2"
					$aMethods2Convert{3}:="ACTabc_ExportPACCumbresM"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=False:C215
					$col:="Cumbres de Medellín"
					$pais:="co"
					
				: ($roles{$s}="249270")  //San Anselmo
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportCUPSanAnselmo"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$col:="San Anselmo"
					$pais:="cl"
					
				: ($roles{$s}="PE0519330")  //Santa Teresita
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					$aMethods2Convert{1}:="ACTabc_ExportCUPStaTeresita"
					$aMethods2Convert{2}:="ACTabc_ExportCUPStaTeresita2"
					$aMethods2Convert{3}:="ACTabc_ImportCUPBCPStaTeresita"
					$aMethods2Convert{4}:="ACTabc_ExportCUPStaTeresita3"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodsTypes{2}:="Cuponera"
					$aMethodsTypes{3}:="Cuponera"
					$aMethodsTypes{4}:="Cuponera"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=False:C215
					$aMethodImpExp{3}:=True:C214
					$aMethodImpExp{4}:=False:C215
					$col:="Santa Teresita"
					$pais:="pe"
					
				: ($roles{$s}="DF0002")  //Yaocalli
					_O_ARRAY STRING:C218(80;$aMethods2Convert;4)
					ARRAY TEXT:C222($aMethodsTypes;4)
					ARRAY BOOLEAN:C223($aMethodImpExp;4)
					$aMethods2Convert{1}:="ACTabc_ImportPATYaocalli1"
					$aMethods2Convert{2}:="ACTabc_ImportPATYaocalli2"
					$aMethods2Convert{3}:="ACTabc_ImportPATYaocalli3"
					$aMethods2Convert{4}:="ACTabc_ImportPATYaocalli4"
					$aMethodsTypes{1}:="PAT"
					$aMethodsTypes{2}:="PAT"
					$aMethodsTypes{3}:="PAT"
					$aMethodsTypes{4}:="PAT"
					$aMethodImpExp{1}:=True:C214
					$aMethodImpExp{2}:=True:C214
					$aMethodImpExp{3}:=True:C214
					$aMethodImpExp{4}:=True:C214
					$col:="Yaocalli"
					$pais:="mx"
					
				: ($roles{$s}="002327065")  //Cumbres Caracas
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportPATCumbresCaracas"
					$aMethodsTypes{1}:="PAT"
					$aMethodImpExp{1}:=False:C215
					$col:="Cumbres Caracas"
					$pais:="ve"
					
				: ($roles{$s}="8300698598")  //Cumbres Bogota
					_O_ARRAY STRING:C218(80;$aMethods2Convert;2)
					ARRAY TEXT:C222($aMethodsTypes;2)
					ARRAY BOOLEAN:C223($aMethodImpExp;2)
					$aMethods2Convert{1}:="ACTabc_ExportPACCumbresB"
					$aMethods2Convert{2}:="ACTabc_ImportPACCumbresBogota"
					$aMethodsTypes{1}:="PAC"
					$aMethodsTypes{2}:="PAC"
					$aMethodImpExp{1}:=False:C215
					$aMethodImpExp{2}:=True:C214
					$col:="Cumbres Bogotá"
					$pais:="co"
					
				: ($roles{$s}="8998")  //Cambridge
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportCUPCambridge"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$col:="Cambridge College"
					$pais:="cl"
					
				: (($roles{$s}="890916768-9") | ($roles{$s}="8909167689"))  //Montessori Medellín
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ExportPACMontessori"
					$aMethodsTypes{1}:="PAC"
					$aMethodImpExp{1}:=False:C215
					$col:="Montessori Medellín"
					$pais:="co"
					
				: ($roles{$s}="QRO01")  //(MX) Newland de Querétaro
					_O_ARRAY STRING:C218(80;$aMethods2Convert;1)
					ARRAY TEXT:C222($aMethodsTypes;1)
					ARRAY BOOLEAN:C223($aMethodImpExp;1)
					$aMethods2Convert{1}:="ACTabc_ImportCUPNewland"
					$aMethodsTypes{1}:="Cuponera"
					$aMethodImpExp{1}:=True:C214
					$col:="Newland de Querétaro"
					$pais:="mx"
			End case 
			
			For ($j;1;Size of array:C274($aMethods2Convert))
				$methodText:=4D_GetMethodText ($aMethods2Convert{$j})
				ARRAY TEXT:C222(aMethodText;0)
				AT_Text2Array (->aMethodText;$methodText;"\r")
				For ($i;Size of array:C274(aMethodText);1;-1)
					$pos:=Position:C15(Char:C90(96);aMethodText{$i})
					$pos2:=Position:C15("C_TEXT($2;$3)";aMethodText{$i})
					If ((($pos>0) & ($pos<5)) | ($pos2>0))
						AT_Delete ($i;1;->aMethodText)
					End if 
				End for 
				$methodText:=AT_array2text (->aMethodText;"\r")
				$methodText:=ACTtrf_AddCheckCode ($methodText)
				CREATE RECORD:C68([xxACT_ArchivosBancarios:118])
				[xxACT_ArchivosBancarios:118]Rol_BD:8:=$roles{$s}
				[xxACT_ArchivosBancarios:118]Codigo_Pais:7:=$pais
				[xxACT_ArchivosBancarios:118]ImpExp:5:=$aMethodImpExp{$j}
				[xxACT_ArchivosBancarios:118]Nombre:3:=ST_Boolean2Str ($aMethodImpExp{$j};"Importador ";"Exportador ")+$aMethodsTypes{$j}+" "+$col
				$vl_num:=0
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_num)
				QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Nombre:3=[xxACT_ArchivosBancarios:118]Nombre:3)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($vl_num>0)
					[xxACT_ArchivosBancarios:118]Nombre:3:=[xxACT_ArchivosBancarios:118]Nombre:3+" "+String:C10($vl_num)
				End if 
				$vl_type:=0
				Case of 
					: ($aMethodsTypes{$j}="Cuponera")
						$vl_type:=-11
					: ($aMethodsTypes{$j}="PAC")
						$vl_type:=-10
					: ($aMethodsTypes{$j}="PAT")
						$vl_type:=-9
					Else 
						TRACE:C157
				End case 
				[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=$vl_type
				[xxACT_ArchivosBancarios:118]Tipo:6:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->$vl_type)
				  //[xxACT_ArchivosBancarios]Tipo:=$aMethodsTypes{$j}
				TEXT TO BLOB:C554($methodText;[xxACT_ArchivosBancarios:118]xData:2;Mac text without length:K22:10)
				[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9:=False:C215
				SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
			End for 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$s/Size of array:C274($roles))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
		
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Guardando archivos de transferencia bancaria..."))
		SET BLOB SIZE:C606($blob;0)
		$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"TransferFiles.txt"
		If (SYS_TestPathName ($file)=Is a document:K24:1)
			DELETE DOCUMENT:C159($file)
		End if 
		SET CHANNEL:C77(10;$file)
		  //ALL RECORDS([xxACT_ArchivosBancarios])
		QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=False:C215)
		FIRST RECORD:C50([xxACT_ArchivosBancarios:118])
		nbRecords:=Records in selection:C76([xxACT_ArchivosBancarios:118])
		SEND VARIABLE:C80(nbRecords)
		While (Not:C34(End selection:C36([xxACT_ArchivosBancarios:118])))
			KRL_SendRecord (->[xxACT_ArchivosBancarios:118];True:C214)
			NEXT RECORD:C51([xxACT_ArchivosBancarios:118])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([xxACT_ArchivosBancarios:118])/Records in selection:C76([xxACT_ArchivosBancarios:118]))
		End while 
		SET CHANNEL:C77(11)
		
		UNLOAD RECORD:C212([xxACT_ArchivosBancarios:118])
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		CD_Dlog (0;__ ("Los registros de [xxACT_ArchivosBancarios] no pudieron ser eliminados. No fue posible guardar la librería."))
	End if 
End if 