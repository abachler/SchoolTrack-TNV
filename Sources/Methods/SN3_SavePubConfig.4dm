//%attributes = {}
  //SN3_SavePubConfig

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_LONGINT:C283($1;$nivel)
C_BOOLEAN:C305($creaMarcas;$2;$testACT;$b_continuar)
C_BLOB:C604($data)

$nivel:=$1
$testACT:=True:C214
If (Count parameters:C259=2)
	$testACT:=$2
End if 

SET BLOB SIZE:C606($data;0)
SN3_BuildConfigXML (->$data)

READ WRITE:C146([SN3_PublicationPrefs:161])
QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=$nivel)
If (Records in selection:C76([SN3_PublicationPrefs:161])=0)
	CREATE RECORD:C68([SN3_PublicationPrefs:161])
	[SN3_PublicationPrefs:161]Nivel:1:=$nivel
	[SN3_PublicationPrefs:161]xData:2:=$data
	COMPRESS BLOB:C534([SN3_PublicationPrefs:161]xData:2)
	SAVE RECORD:C53([SN3_PublicationPrefs:161])
Else 
	If (BLOB_CompareBlobs (->[SN3_PublicationPrefs:161]xData:2;->$data)=0)
		SET BLOB SIZE:C606([SN3_PublicationPrefs:161]xData:2;0)
		[SN3_PublicationPrefs:161]xData:2:=$data
		COMPRESS BLOB:C534([SN3_PublicationPrefs:161]xData:2)
		SAVE RECORD:C53([SN3_PublicationPrefs:161])
	End if 
End if 
If ($testACT)
	
	  //MONO 20-06-2018: Atributos de publicación que afectan a todos los niveles
	$b_continuar:=(vlSN3_CurrDataType=SN3_DTi_DTrib) | (vlSN3_CurrDataType=SN3_DTi_Pagos) | (vlSN3_CurrDataType=SN3_DTi_AvisosCobranza)
	$b_continuar:=$b_continuar | (vlSN3_CurrDataType=45000) | (vlSN3_CurrDataType=45501) | (vlSN3_CurrDataType=46000)  //45000 comunicaciones,  45501 Home noticias, 46000 Informes
	$b_continuar:=$b_continuar | (vlSN3_CurrDataType=AccountTrack)  //Opción general de ACT Apod Acad ve lo mismo que el de Cta.
	
	If ($b_continuar)
		READ ONLY:C145([SN3_PublicationPrefs:161])
		QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=vlSN3_CurrConfigLevel)
		$data:=[SN3_PublicationPrefs:161]xData:2
		UNLOAD RECORD:C212([SN3_PublicationPrefs:161])
		COPY ARRAY:C226(aiADT_NivNo;$niveles)
		$index:=Find in array:C230($niveles;vlSN3_CurrConfigLevel)
		DELETE FROM ARRAY:C228($niveles;$index)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Copiando la configuración a todos los niveles..."))
		For ($i;1;Size of array:C274($niveles))
			QUERY:C277([SN3_PublicationPrefs:161];[SN3_PublicationPrefs:161]Nivel:1=$niveles{$i})
			If (Records in selection:C76([SN3_PublicationPrefs:161])=0)
				SN3_InitPubVariables 
				SN3_SavePubConfig ($niveles{$i};False:C215)
			End if 
			SN3_ParseConfigXML (->$data)
			SN3_ModifyXMLEntry ($niveles{$i};vlSN3_CurrDataType)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($niveles))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	End if 
End if 

