//%attributes = {}
  // CIM_VerifyDataFile_callback()
  // Por: Alberto Bachler: 11/01/13, 11:51:47
  //  ---------------------------------------------
  // Método callback llamado por CIM_VerifyDataFile
  // Muestra un mensaje de progreso y retorna errores cuando los hay
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
C_LONGINT:C283($5)
If (False:C215)
	C_LONGINT:C283(CIM_VerifyDataFile_callback ;$0)
	C_LONGINT:C283(CIM_VerifyDataFile_callback ;$1)
	C_LONGINT:C283(CIM_VerifyDataFile_callback ;$2)
	C_TEXT:C284(CIM_VerifyDataFile_callback ;$3)
	C_LONGINT:C283(CIM_VerifyDataFile_callback ;$4)
	C_LONGINT:C283(CIM_VerifyDataFile_callback ;$5)
End if 

C_BOOLEAN:C305(vb_BDDañada)
vb_BDDañada:=False:C215

Case of 
	: ($1=1)
		  //
		If (Application type:C494=4D Server:K5:6)
			If ((vt_client#"") & (vl_ClientProgressProcessID>0))
				EXECUTE ON CLIENT:C651(vt_client;"IT_Progress";0;vl_ClientProgressProcessID;$4/100;$3)
			End if 
			IT_Progress (0;vl_ServerProgressProcessID;$4/100;$3)
		Else 
			IT_Progress (0;vl_ServerProgressProcessID;$4/100;$3)
		End if 
		
	: ($1=2)
		  // fin de verificación de tabla o index
		
	: ($1=3)
		Case of 
			: ($2=4)
				APPEND TO ARRAY:C911(at_DataFileError;$3+": Tabla Nº "+String:C10($4))
			: ($2=8)
				APPEND TO ARRAY:C911(at_DataFileError;$3+": Indice Nº "+String:C10($4))
			: ($2=0)
				APPEND TO ARRAY:C911(at_DataFileError;$3+": Objeto indeterminado "+String:C10($4))
			: ($2=16)
				APPEND TO ARRAY:C911(at_DataFileError;$3+": Objeto de estructura "+String:C10($4))
		End case 
		
	: ($1=4)
		Case of 
			: (Application type:C494=4D Server:K5:6)
				IT_Progress (-1;vl_ServerProgressProcessID)
				If (vt_client#"")
					EXECUTE ON CLIENT:C651(vt_client;"IT_Progress";-1;vl_ClientProgressProcessID)
				End if 
				
			: ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Volume desktop:K5:2))
				IT_Progress (-1;vl_ServerProgressProcessID)
		End case 
		
	: ($1=5)
		APPEND TO ARRAY:C911(at_DataFileError;$3)
End case 

