//%attributes = {}
  //ACTtf_OpcionesTextosImp

C_LONGINT:C283($accion)
Case of 
	: (Count parameters:C259=0)
		$accion:=0
	: (Count parameters:C259=1)
		$accion:=$1
	Else 
		$accion:=$1
End case 

C_LONGINT:C283($vl_identificador;$vl_tipoArchivo)
C_TEXT:C284($vt_tipoArchivo)
C_TEXT:C284($vt_tipo)

ARRAY TEXT:C222($at_descPAC;0)
ARRAY TEXT:C222($at_descPAT;0)
ARRAY TEXT:C222($at_descCUP;0)
ARRAY TEXT:C222($at_descCHE;0)
ARRAY TEXT:C222($at_descEFE;0)
ARRAY TEXT:C222($at_descTDC;0)

  //ticket 157568 JVP
  //AT_Insert (0;3;->$at_descPAC)
AT_Insert (0;4;->$at_descPAC)
$at_descPAC{1}:="1"  //monto
$at_descPAC{2}:="6"  //ide unico
  //ticket 157568 JVP
$at_descPAC{3}:="2"  //Código respuesta
$at_descPAC{4}:="5"  //descripcion respuesta

APPEND TO ARRAY:C911($at_descPAC;"7")  //Fecha de pago//20180819 RCH


AT_Insert (0;6;->$at_descPAT)
$at_descPAT{1}:="1"  //MONTO
$at_descPAT{2}:="3"  //Número tarjeta de crédito
$at_descPAT{3}:="4"  //Nombre
$at_descPAT{4}:="6"  //Identificador único
$at_descPAT{5}:="2"  //Código respuesta
$at_descPAT{6}:="5"  //Descripción respuesta"
APPEND TO ARRAY:C911($at_descPAT;"7")  //Fecha de pago//20180819 RCH

AT_Insert (0;7;->$at_descCUP)
$at_descCUP{1}:="1"  //"Monto"
$at_descCUP{2}:="6"  //"Identificador único"
$at_descCUP{3}:="15"  //"Monto original"
$at_descCUP{4}:="17"  //"dia vencimiento
$at_descCUP{5}:="18"  //"mes vencimiento
$at_descCUP{6}:="19"  //"año vencimiento
$at_descCUP{7}:="20"  //"monto original en UF
If (<>vtXS_CountryCode="mx")
	APPEND TO ARRAY:C911($at_descCUP;"2")
	APPEND TO ARRAY:C911($at_descCUP;"5")
End if 
APPEND TO ARRAY:C911($at_descCUP;"7")  //Fecha de pago//20180819 RCH
  //$at_descCUP{8}:="22"  `DIA PAGO
  //$at_descCUP{9}:="23"  `MES PAGO
  //$at_descCUP{10}:="24"  `AÑO PAGO

AT_Insert (0;8;->$at_descCHE)
$at_descCHE{1}:="7"  //Fecha de pago
$at_descCHE{2}:="6"  //Identificador único
$at_descCHE{3}:="1"  //Monto
$at_descCHE{4}:="8"  //Cod. Banco
$at_descCHE{5}:="9"  //Serie
$at_descCHE{6}:="10"  //Cuenta
$at_descCHE{7}:="11"  //Fecha documento
$at_descCHE{8}:="13"  //Lugar de pago

AT_Insert (0;4;->$at_descEFE)
$at_descEFE{1}:="7"  //Fecha de pago
$at_descEFE{2}:="6"  //Identificador único
$at_descEFE{3}:="1"  //Monto
$at_descEFE{4}:="13"  //Lugar de pago

AT_Insert (0;6;->$at_descTDC)
$at_descTDC{1}:="7"  //Fecha de pago
$at_descTDC{2}:="6"  //Identificador único
$at_descTDC{3}:="1"  //Monto
$at_descTDC{4}:="12"  //Número tarjeta
$at_descTDC{5}:="13"  //Lugar de pago
$at_descTDC{6}:="14"  //Número de operación

Case of 
	: ($accion=0)  //valida archivo
		READ WRITE:C146([xxACT_ArchivosBancarios:118])
		ARRAY LONGINT:C221(al_Numero;0)
		ARRAY TEXT:C222(at_Descripcion;0)
		ARRAY LONGINT:C221(al_PosIni;0)
		ARRAY LONGINT:C221(al_Largo;0)
		ARRAY LONGINT:C221(al_PosFinal;0)
		ARRAY TEXT:C222(at_Alineado;0)
		ARRAY TEXT:C222(at_Relleno;0)
		ARRAY LONGINT:C221(al_Decimales;0)
		ARRAY TEXT:C222(at_idsTextos;0)
		
		C_LONGINT:C283(PWTrf_h2;PWTrf_h1;WTrf_s1;WTrf_s2)
		C_LONGINT:C283(WTrf_s3;cs_IEncabezado;cs_IPie)
		C_LONGINT:C283(WTrf_s4)
		C_TEXT:C284(WTrf_s4_CaracterOtro)
		C_TEXT:C284(vIIdentificador;vt_ICodApr;vIFormatoCA)
		C_REAL:C285(cs_usarComoTexto)  //20180816 RCH
		
		ALL RECORDS:C47([xxACT_ArchivosBancarios:118])
		ARRAY LONGINT:C221($al_rNArchBanc;0)
		SELECTION TO ARRAY:C260([xxACT_ArchivosBancarios:118];$al_rNArchBanc)
		C_BLOB:C604(xBlob)
		For ($i;1;Size of array:C274($al_rNArchBanc))
			GOTO RECORD:C242([xxACT_ArchivosBancarios:118];$al_rNArchBanc{$i})
			If (([xxACT_ArchivosBancarios:118]CreadoPorAsistente:9=True:C214) & ([xxACT_ArchivosBancarios:118]ImpExp:5=True:C214))
				SET BLOB SIZE:C606(xBlob;0)
				xBlob:=[xxACT_ArchivosBancarios:118]xData:2
				  //BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro)
				BLOB_Blob2Vars (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;->at_idsTextos;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH
				$tipoArchivo:=[xxACT_ArchivosBancarios:118]Tipo:6
				$vl_tipoArchivo:=[xxACT_ArchivosBancarios:118]id_forma_de_pago:13
				SET BLOB SIZE:C606(xBlob;0)
				C_POINTER:C301($ptr)
				Case of 
					: ($vl_tipoArchivo=-10)
						$ptr:=->$at_descPAC
					: ($vl_tipoArchivo=-9)
						$ptr:=->$at_descPAT
					: ($vl_tipoArchivo=-11)
						$ptr:=->$at_descCUP
					: ($vl_tipoArchivo=-4)
						$ptr:=->$at_descCHE
					: ($vl_tipoArchivo=-3)
						$ptr:=->$at_descEFE
					: ($vl_tipoArchivo=-6)
						$ptr:=->$at_descTDC
					Else 
						$ptr:=->$at_descEFE
				End case 
				C_LONGINT:C283($diferencia)
				If (Size of array:C274(at_Descripcion)#Size of array:C274($ptr->))
					$diferencia:=Size of array:C274($ptr->)-Size of array:C274(at_Descripcion)
					Case of 
						: ($diferencia>0)
							If (PWTrf_h2=1)
								AT_Insert (0;$diferencia;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
							Else 
								AT_Insert (0;$diferencia;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
							End if 
						: ($diferencia<0)
							For ($j;Size of array:C274(at_idsTextos);1;-1)
								$el:=Find in array:C230($ptr->;at_idsTextos{$j})
								If ($el=-1)
									If (PWTrf_h2=1)
										AT_Delete ($j;1;->at_Descripcion;->al_PosIni;->al_Largo;->at_Alineado;->at_Relleno;->al_Decimales)
									Else 
										AT_Delete ($j;1;->al_Numero;->at_Descripcion;->at_Alineado;->at_Relleno;->al_Decimales)
									End if 
								End if 
							End for 
					End case 
				End if 
				If (Size of array:C274(at_idsTextos)#Size of array:C274($ptr->))
					COPY ARRAY:C226($ptr->;at_idsTextos)
				End if 
				$vl_identificador:=Num:C11(ST_GetWord (vIIdentificador;1;"_"))
				If ($vl_identificador#0)
					$vt_tipo:=ST_GetWord (vIIdentificador;3;"_")
					vIIdentificador:=String:C10($vl_identificador)+"_"+<>at_IDNacional_Names{$vl_identificador}+"_"+$vt_tipo
				End if 
				  //BLOB_Variables2Blob (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;$ptr;->WTrf_s4;->WTrf_s4_CaracterOtro)
				BLOB_Variables2Blob (->xBlob;0;->al_Numero;->at_Descripcion;->al_PosIni;->al_Largo;->al_PosFinal;->at_Alineado;->at_Relleno;->al_Decimales;->PWTrf_h2;->PWTrf_h1;->WTrf_s1;->WTrf_s2;->WTrf_s3;->cs_IEncabezado;->cs_IPie;->vIIdentificador;->vt_ICodApr;$ptr;->WTrf_s4;->WTrf_s4_CaracterOtro;->cs_usarComoTexto)  //20180817 RCH
				[xxACT_ArchivosBancarios:118]xData:2:=xBlob
				SAVE RECORD:C53([xxACT_ArchivosBancarios:118])
				SET BLOB SIZE:C606(xBlob;0)
			End if 
		End for 
		KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
		
	: ($accion=2)
		C_TEXT:C284($vt_idIdioma;$3;$0;$vt_idTexto;$2)
		ARRAY TEXT:C222($aTextosWizImport;2;22)
		$vt_idTexto:=$2
		$vt_idIdioma:=$3
		$aTextosWizImport{1}{1}:="1"
		$aTextosWizImport{2}{1}:="Monto total del pago"
		$aTextosWizImport{1}{2}:="2"
		$aTextosWizImport{2}{2}:="Código respuesta"
		$aTextosWizImport{1}{3}:="3"
		$aTextosWizImport{2}{3}:="Número tarjeta de crédito"
		$aTextosWizImport{1}{4}:="4"
		$aTextosWizImport{2}{4}:="Nombre"
		$aTextosWizImport{1}{5}:="5"
		$aTextosWizImport{2}{5}:="Descripción respuesta"
		$aTextosWizImport{1}{6}:="6"
		$aTextosWizImport{2}{6}:="Identificador único"
		$aTextosWizImport{1}{7}:="7"
		$aTextosWizImport{2}{7}:="Fecha de pago"
		$aTextosWizImport{1}{8}:="8"
		$aTextosWizImport{2}{8}:="Cod. Banco"
		$aTextosWizImport{1}{9}:="9"
		$aTextosWizImport{2}{9}:="Serie"
		$aTextosWizImport{1}{10}:="10"
		$aTextosWizImport{2}{10}:="Cuenta"
		$aTextosWizImport{1}{11}:="11"
		$aTextosWizImport{2}{11}:="Fecha documento"
		$aTextosWizImport{1}{12}:="12"
		$aTextosWizImport{2}{12}:="Número tarjeta"
		$aTextosWizImport{1}{13}:="13"
		$aTextosWizImport{2}{13}:="Lugar de pago"
		$aTextosWizImport{1}{14}:="14"
		$aTextosWizImport{2}{14}:="Número de operación"
		$aTextosWizImport{1}{15}:="15"
		$aTextosWizImport{2}{15}:="Monto original en pesos"
		$aTextosWizImport{1}{16}:="16"
		$aTextosWizImport{2}{16}:="Monto mora"
		$aTextosWizImport{1}{17}:="17"
		$aTextosWizImport{2}{17}:="Día vencimiento"
		$aTextosWizImport{1}{18}:="18"
		$aTextosWizImport{2}{18}:="Mes vencimiento"
		$aTextosWizImport{1}{19}:="19"
		$aTextosWizImport{2}{19}:="Año vencimiento"
		$aTextosWizImport{1}{20}:="20"
		$aTextosWizImport{2}{20}:="Monto original en UF"
		$aTextosWizImport{1}{21}:="21"
		$aTextosWizImport{2}{21}:="Diferencia moneda"
		$aTextosWizImport{1}{22}:="22"
		$aTextosWizImport{2}{22}:="Número de aviso de cobranza"
		  //$aTextosWizImport{1}{22}:="22"
		  //$aTextosWizImport{2}{22}:="Día de pago"
		  //$aTextosWizImport{1}{23}:="23"
		  //$aTextosWizImport{2}{23}:="Mes de pago"
		  //$aTextosWizImport{1}{24}:="24"
		  //$aTextosWizImport{2}{24}:="Año de pago"
		
		
		
		$el:=Find in array:C230($aTextosWizImport{1};$vt_idTexto)
		If ($el>0)
			Case of 
				: ($vt_idIdioma="cl")
					$0:=$aTextosWizImport{2}{$el}
				Else 
					$0:=$aTextosWizImport{2}{$el}
			End case 
		Else 
			$0:=""
		End if 
	: ($accion=3)
		$vt_tipoArchivo:=$2
		Case of 
			: ($vt_tipoArchivo="-10")
				COPY ARRAY:C226($at_descPAC;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descPAC))
			: ($vt_tipoArchivo="-9")
				COPY ARRAY:C226($at_descPAT;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descPAT))
			: ($vt_tipoArchivo="-11")
				COPY ARRAY:C226($at_descCUP;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descCUP))
			: ($vt_tipoArchivo="-4")
				COPY ARRAY:C226($at_descCHE;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descCHE))
			: ($vt_tipoArchivo="-3")
				COPY ARRAY:C226($at_descEFE;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descEFE))
			: ($vt_tipoArchivo="-6")
				COPY ARRAY:C226($at_descTDC;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descTDC))
			Else 
				  // efectivo para todas las demas formas
				COPY ARRAY:C226($at_descEFE;at_idsTextos)
				$0:=String:C10(Size of array:C274($at_descEFE))
		End case 
End case 