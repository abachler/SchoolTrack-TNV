//%attributes = {}
  //SRACTlc_InitiPrintingVariables

  //LETRAS DE CAMBIO
Case of 
	: (Count parameters:C259=2)
		$accion:=$1
		$index:=$2
	: (Count parameters:C259=1)
		$accion:=$1
	Else 
		$accion:=1
End case 

C_DATE:C307(vdACT_SRlc_fEmision1;vdACT_SRlc_fEmision2;vdACT_SRlc_fEmision3;vdACT_SRlc_fEmision4)
C_LONGINT:C283(vlACT_SRlc_dEmision1;vlACT_SRlc_dEmision2;vlACT_SRlc_dEmision3;vlACT_SRlc_dEmision4)
C_LONGINT:C283(vlACT_SRlc_mEmision1;vlACT_SRlc_mEmision2;vlACT_SRlc_mEmision3;vlACT_SRlc_mEmision4)
C_LONGINT:C283(vlACT_SRlc_aEmision1;vlACT_SRlc_aEmision2;vlACT_SRlc_aEmision3;vlACT_SRlc_aEmision4)
C_DATE:C307(vdACT_SRlc_fVencimiento1;vdACT_SRlc_fVencimiento2;vdACT_SRlc_fVencimiento3;vdACT_SRlc_fVencimiento4)
C_LONGINT:C283(vlACT_SRlc_dVEncimiento1;vlACT_SRlc_dVEncimiento2;vlACT_SRlc_dVEncimiento3;vlACT_SRlc_dVEncimiento4)
C_LONGINT:C283(vlACT_SRlc_mVencimiento1;vlACT_SRlc_mVencimiento2;vlACT_SRlc_mVencimiento3;vlACT_SRlc_mVencimiento4)
C_LONGINT:C283(vlACT_SRlc_aVencimiento1;vlACT_SRlc_aVencimiento2;vlACT_SRlc_aVencimiento3;vlACT_SRlc_aVencimiento4)
C_LONGINT:C283(vlACT_SRlc_noLetra1;vlACT_SRlc_noLetra2;vlACT_SRlc_noLetra3;vlACT_SRlc_noLetra4)
C_LONGINT:C283(vlACT_SRlc_noTLetra1;vlACT_SRlc_noTLetra2;vlACT_SRlc_noTLetra3;vlACT_SRlc_noTLetra4)
C_LONGINT:C283(vlACT_SRlc_mPesosLetra1;vlACT_SRlc_mPesosLetra2;vlACT_SRlc_mPesosLetra3;vlACT_SRlc_mPesosLetra4)
C_TEXT:C284(vtACT_SRlc_mPalabraLetra1;vtACT_SRlc_mPalabraLetra2;vtACT_SRlc_mPalabraLetra3;vtACT_SRlc_mPalabraLetra4)
C_TEXT:C284(vtACT_SRlc_apeNom1;vtACT_SRlc_apeNom2;vtACT_SRlc_apeNom3;vtACT_SRlc_apeNom4)
C_TEXT:C284(vtACT_SRlc_ideUnico1;vtACT_SRlc_ideUnico2;vtACT_SRlc_ideUnico3;vtACT_SRlc_ideUnico4)
C_TEXT:C284(vtACT_SRlc_domicilio1;vtACT_SRlc_domicilio2;vtACT_SRlc_domicilio3;vtACT_SRlc_domicilio4)
C_TEXT:C284(vtACT_SRlc_comuna1;vtACT_SRlc_comuna2;vtACT_SRlc_comuna3;vtACT_SRlc_comuna4)
C_TEXT:C284(vtACT_SRlc_ciudad1;vtACT_SRlc_ciudad2;vtACT_SRlc_ciudad3;vtACT_SRlc_ciudad4)
C_TEXT:C284(vtACT_SRlc_codFamilia1;vtACT_SRlc_codFamilia2;vtACT_SRlc_codFamilia3;vtACT_SRlc_codFamilia4)
C_LONGINT:C283(vlACT_SRlc_Folio1;vlACT_SRlc_Folio2;vlACT_SRlc_Folio3;vlACT_SRlc_Folio4)
C_TEXT:C284(vtACT_SRlc_mTEmision1;vtACT_SRlc_mTEmision2;vtACT_SRlc_mTEmision3;vtACT_SRlc_mTEmision4)
C_TEXT:C284(vtACT_SRlc_mTVencimiento1;vtACT_SRlc_mTVencimiento2;vtACT_SRlc_mTVencimiento3;vtACT_SRlc_mTVencimiento4)
Case of 
	: ($accion=2)
		vlACT_SRlc_Folio1:=0
		vdACT_SRlc_fEmision1:=!00-00-00!
		vlACT_SRlc_dEmision1:=0
		vlACT_SRlc_mEmision1:=0
		vtACT_SRlc_mTEmision1:=""
		vlACT_SRlc_aEmision1:=0
		vdACT_SRlc_fVencimiento1:=!00-00-00!
		vlACT_SRlc_dVEncimiento1:=0
		vlACT_SRlc_mVencimiento1:=0
		vtACT_SRlc_mTVencimiento1:=""
		vlACT_SRlc_aVencimiento1:=0
		vlACT_SRlc_noLetra1:=0
		vlACT_SRlc_noTLetra1:=0
		vlACT_SRlc_mPesosLetra1:=0
		vtACT_SRlc_mPalabraLetra1:=""
		vtACT_SRlc_apeNom1:=""
		vtACT_SRlc_ideUnico1:=""
		vtACT_SRlc_domicilio1:=""
		vtACT_SRlc_comuna1:=""
		vtACT_SRlc_ciudad1:=""
		vtACT_SRlc_codFamilia1:=""
		
		vlACT_SRlc_Folio2:=0
		vdACT_SRlc_fEmision2:=!00-00-00!
		vlACT_SRlc_dEmision2:=0
		vlACT_SRlc_mEmision2:=0
		vtACT_SRlc_mTEmision2:=""
		vlACT_SRlc_aEmision2:=0
		vdACT_SRlc_fVencimiento2:=!00-00-00!
		vlACT_SRlc_dVEncimiento2:=0
		vlACT_SRlc_mVencimiento2:=0
		vtACT_SRlc_mTVencimiento2:=""
		vlACT_SRlc_aVencimiento2:=0
		vlACT_SRlc_noLetra2:=0
		vlACT_SRlc_noTLetra2:=0
		vlACT_SRlc_mPesosLetra2:=0
		vtACT_SRlc_mPalabraLetra2:=""
		vtACT_SRlc_apeNom2:=""
		vtACT_SRlc_ideUnico2:=""
		vtACT_SRlc_domicilio2:=""
		vtACT_SRlc_comuna2:=""
		vtACT_SRlc_ciudad2:=""
		vtACT_SRlc_codFamilia2:=""
		
		vlACT_SRlc_Folio3:=0
		vdACT_SRlc_fEmision3:=!00-00-00!
		vlACT_SRlc_dEmision3:=0
		vlACT_SRlc_mEmision3:=0
		vtACT_SRlc_mTEmision3:=""
		vlACT_SRlc_aEmision3:=0
		vdACT_SRlc_fVencimiento3:=!00-00-00!
		vlACT_SRlc_dVEncimiento3:=0
		vlACT_SRlc_mVencimiento3:=0
		vtACT_SRlc_mTVencimiento3:=""
		vlACT_SRlc_aVencimiento3:=0
		vlACT_SRlc_noLetra3:=0
		vlACT_SRlc_noTLetra3:=0
		vlACT_SRlc_mPesosLetra3:=0
		vtACT_SRlc_mPalabraLetra3:=""
		vtACT_SRlc_apeNom3:=""
		vtACT_SRlc_ideUnico3:=""
		vtACT_SRlc_domicilio3:=""
		vtACT_SRlc_comuna3:=""
		vtACT_SRlc_ciudad3:=""
		vtACT_SRlc_codFamilia3:=""
		
		vlACT_SRlc_Folio4:=0
		vdACT_SRlc_fEmision4:=!00-00-00!
		vlACT_SRlc_dEmision4:=0
		vlACT_SRlc_mEmision4:=0
		vtACT_SRlc_mTEmision4:=""
		vlACT_SRlc_aEmision4:=0
		vdACT_SRlc_fVencimiento4:=!00-00-00!
		vlACT_SRlc_dVEncimiento4:=0
		vlACT_SRlc_mVencimiento4:=0
		vtACT_SRlc_mTVencimiento4:=""
		vlACT_SRlc_aVencimiento4:=0
		vlACT_SRlc_noLetra4:=0
		vlACT_SRlc_noTLetra4:=0
		vlACT_SRlc_mPesosLetra4:=0
		vtACT_SRlc_mPalabraLetra4:=""
		vtACT_SRlc_apeNom4:=""
		vtACT_SRlc_ideUnico4:=""
		vtACT_SRlc_domicilio4:=""
		vtACT_SRlc_comuna4:=""
		vtACT_SRlc_ciudad4:=""
		vtACT_SRlc_codFamilia4:=""
	: ($accion=3)
		C_POINTER:C301($varPtr)
		
		$varPtr:=Get pointer:C304("vlACT_SRlc_Folio"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vdACT_SRlc_fEmision"+String:C10($index))
		$varPtr->:=!00-00-00!
		$varPtr:=Get pointer:C304("vlACT_SRlc_dEmision"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vlACT_SRlc_mEmision"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vtACT_SRlc_mTEmision"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vlACT_SRlc_aEmision"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vdACT_SRlc_fVencimiento"+String:C10($index))
		$varPtr->:=!00-00-00!
		$varPtr:=Get pointer:C304("vlACT_SRlc_dVEncimiento"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vtACT_SRlc_mTVencimiento"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vlACT_SRlc_mVencimiento"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vlACT_SRlc_aVencimiento"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vlACT_SRlc_noLetra"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vlACT_SRlc_noTLetra"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vlACT_SRlc_mPesosLetra"+String:C10($index))
		$varPtr->:=0
		$varPtr:=Get pointer:C304("vtACT_SRlc_mPalabraLetra"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRlc_apeNom"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRlc_ideUnico"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRlc_domicilio"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRlc_comuna"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRlc_ciudad"+String:C10($index))
		$varPtr->:=""
		$varPtr:=Get pointer:C304("vtACT_SRlc_codFamilia"+String:C10($index))
		$varPtr->:=""
End case 