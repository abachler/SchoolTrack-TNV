//%attributes = {}
  //ACTimp_ArrayDeclarations

C_TEXT:C284($vt_accion;$vt_retorno;$0)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1)

If (Count parameters:C259>=1)
	$vt_accion:=$1
End if 
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
Case of 
	: ($vt_accion="")
		ARRAY LONGINT:C221(aIDCta;0)
		ARRAY TEXT:C222(aPareo;0)
		ARRAY TEXT:C222(aIDItem;0)
		ARRAY TEXT:C222(aGlosa;0)
		ARRAY TEXT:C222(aMoneda;0)
		ARRAY TEXT:C222(aMontotxt;0)
		ARRAY TEXT:C222(aAfectoIVA;0)
		ARRAY TEXT:C222(aMesDesde;0)
		ARRAY TEXT:C222(aMesHasta;0)
		ARRAY TEXT:C222(aAño;0)
		ARRAY TEXT:C222(aAño2;0)
		ARRAY TEXT:C222(aCargoDescto;0)
		ARRAY TEXT:C222(aCtaContable;0)
		ARRAY TEXT:C222(aCodAux;0)
		ARRAY TEXT:C222(aCentro;0)
		ARRAY TEXT:C222(aCCtaContable;0)
		ARRAY TEXT:C222(aCCodAux;0)
		ARRAY TEXT:C222(aCCentro;0)
		ARRAY BOOLEAN:C223(aAprobado;0)
		ARRAY TEXT:C222(aMotivo;0)
		ARRAY TEXT:C222(aAfectoaDxCta;0)
		ARRAY TEXT:C222(aAfectoaDesctos;0)
		ARRAY TEXT:C222(aPctInteres;0)
		ARRAY TEXT:C222(aTipoInteres;0)
		ARRAY TEXT:C222(aImpUnica;0)
		ARRAY TEXT:C222(aNoDocTribs;0)
		ARRAY TEXT:C222(aDesctoH2;0)
		ARRAY TEXT:C222(aDesctoH3;0)
		ARRAY TEXT:C222(aDesctoH4;0)
		ARRAY TEXT:C222(aDesctoH5;0)
		ARRAY TEXT:C222(aDesctoH6;0)
		ARRAY TEXT:C222(aDesctoH7;0)
		ARRAY TEXT:C222(aDesctoH8;0)
		ARRAY TEXT:C222(aDesctoH9;0)
		ARRAY TEXT:C222(aDesctoH10;0)
		ARRAY TEXT:C222(aDesctoH11;0)
		ARRAY TEXT:C222(aDesctoH12;0)
		ARRAY TEXT:C222(aDesctoH13;0)
		ARRAY TEXT:C222(aDesctoH14;0)
		ARRAY TEXT:C222(aDesctoH15;0)
		ARRAY TEXT:C222(aDesctoH16;0)
		ARRAY TEXT:C222(aDesctoH17;0)
		ARRAY BOOLEAN:C223(aBloqueadas;0)
		  //para el codigo de barra  JVP 20160222
		ARRAY TEXT:C222(aCodigo_interno;0)
	: ($vt_accion="InsertaFinal")
		AT_Insert (0;1;->aPareo;->aIDItem;->aGlosa;->aMoneda;->aMontotxt;->aAfectoIVA;->aMesDesde;->aAño2;->aMesHasta;->aAño;->aCargoDescto;->aCtaContable;->aCodAux;->aCentro;->aCCtaContable;->aCCodAux;->aCCentro;->aNoDocTribs)
		AT_Insert (0;1;->aAprobado;->aMotivo;->aIDCta)
		AT_Insert (0;1;->aAfectoaDxCta;->aAfectoaDesctos;->aPctInteres;->aTipoInteres;->aImpUnica;->aDesctoH2;->aDesctoH3;->aDesctoH4;->aDesctoH5;->aDesctoH6;->aDesctoH7;->aDesctoH8;->aDesctoH9;->aDesctoH10;->aDesctoH11;->aDesctoH12;->aDesctoH13;->aDesctoH14;->aDesctoH15;->aDesctoH16;->aDesctoH17)
		AT_Insert (0;1;->aBloqueadas;->aCodigo_interno)
		
	: ($vt_accion="ConcatenaElementos")
		
		  // Modificado por: Saúl Ponce (23/ago./2017) Ticket Nº 187489, no se estaban importando los cargos
		  // vt_retorno:=aIDItem{$ptr1->}+aGlosa{$ptr1->}+aMoneda{$ptr1->}+aMontotxt{$ptr1->}+aAfectoIVA{$ptr1->}+aMesDesde{$ptr1->}+aAño{$ptr1->}+aMesHasta{$ptr1->}+aAño2{$ptr1->}+aCtaContable{$ptr1->}+aCodAux{$ptr1->}+aCentro{$ptr1->}+aCCtaContable{$ptr1->}+aCCodAux{$ptr1->}+aCCentro{$ptr1->}+aNoDocTribs{$ptr1->}+aAfectoaDxCta{$ptr1->}+aAfectoaDesctos{$ptr1->}+aPctInteres{$ptr1->}+aTipoInteres{$ptr1->}+aImpUnica{$ptr1->}+aDesctoH2{$ptr1->}+aDesctoH3{$ptr1->}+aDesctoH4{$ptr1->}+aDesctoH5{$ptr1->}+aDesctoH6{$ptr1->}+aDesctoH7{$ptr1->}+aDesctoH8{$ptr1->}+aDesctoH9{$ptr1->}+aDesctoH10{$ptr1->}+aDesctoH11{$ptr1->}+aDesctoH12{$ptr1->}+aDesctoH13{$ptr1->}+aDesctoH14{$ptr1->}+aDesctoH15{$ptr1->}+aDesctoH16{$ptr1->}+aDesctoH17{$ptr1->}+aCodigo_interno{$ptr1->}
		$vt_retorno:=aIDItem{$ptr1->}+aGlosa{$ptr1->}+aMoneda{$ptr1->}+aMontotxt{$ptr1->}+aAfectoIVA{$ptr1->}+aMesDesde{$ptr1->}+aAño{$ptr1->}+aMesHasta{$ptr1->}+aAño2{$ptr1->}+aCtaContable{$ptr1->}+aCodAux{$ptr1->}+aCentro{$ptr1->}+aCCtaContable{$ptr1->}+aCCodAux{$ptr1->}+aCCentro{$ptr1->}+aNoDocTribs{$ptr1->}+aAfectoaDxCta{$ptr1->}+aAfectoaDesctos{$ptr1->}+aPctInteres{$ptr1->}+aTipoInteres{$ptr1->}+aImpUnica{$ptr1->}+aDesctoH2{$ptr1->}+aDesctoH3{$ptr1->}+aDesctoH4{$ptr1->}+aDesctoH5{$ptr1->}+aDesctoH6{$ptr1->}+aDesctoH7{$ptr1->}+aDesctoH8{$ptr1->}+aDesctoH9{$ptr1->}+aDesctoH10{$ptr1->}+aDesctoH11{$ptr1->}+aDesctoH12{$ptr1->}+aDesctoH13{$ptr1->}+aDesctoH14{$ptr1->}+aDesctoH15{$ptr1->}+aDesctoH16{$ptr1->}+aDesctoH17{$ptr1->}+aCodigo_interno{$ptr1->}
		
	: ($vt_accion="OrdenaArreglos")  //los cargos se ordenan para acelerar la importacion de cargos
		AT_MultiLevelSort (">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>";->aIDItem;->aGlosa;->aMoneda;->aMontotxt;->aAfectoIVA;->aMesDesde;->aAño2;->aMesHasta;->aAño;->aCargoDescto;->aCtaContable;->aCodAux;->aCentro;->aCCtaContable;->aCCodAux;->aCCentro;->aNoDocTribs;->aAprobado;->aMotivo;->aIDCta;->aAfectoaDxCta;->aAfectoaDesctos;->aPctInteres;->aTipoInteres;->aImpUnica;->aDesctoH2;->aDesctoH3;->aDesctoH4;->aDesctoH5;->aDesctoH6;->aDesctoH7;->aDesctoH8;->aDesctoH9;->aDesctoH10;->aDesctoH11;->aDesctoH12;->aDesctoH13;->aDesctoH14;->aDesctoH15;->aDesctoH16;->aDesctoH17;->aCodigo_interno;->aBloqueadas;->aPareo)
		
End case 

$0:=$vt_retorno