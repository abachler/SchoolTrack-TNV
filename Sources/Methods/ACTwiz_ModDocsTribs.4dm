//%attributes = {}
  //ACTwiz_ModDocsTribs

If (USR_GetMethodAcces (Current method name:C684))
	LOG_RegisterEvt ("Inicio de Asistente para la Modificación de Documentos Tributarios")
	WDW_OpenFormWindow (->[xxSTR_Constants:1];"WizardBoletas";0;4;__ ("Modificación de Documentos Tributarios"))
	DIALOG:C40([xxSTR_Constants:1];"WizardBoletas")
	CLOSE WINDOW:C154
	AT_Initialize (->alACT_WDTNumero;->atACT_WDTApdo;->atACT_WDTEstado;->adACT_WDTFecha;->arACT_WDTAfecto;->arACT_WDTIVA;->arACT_WDTTotal;->abACT_WDTNulas;->alACT_WDTRecNums;->asACT_WDT_Duplis;->asACT_WDT_Dates;->asACT_WDT_Sincro;->alACT_WDTAnular;->abACT_WDTModificada;->alACT_WDTEliminar)
	LOG_RegisterEvt ("Fin de Asistente para la Modificación de Documentos Tributarios")
End if 