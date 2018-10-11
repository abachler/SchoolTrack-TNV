//%attributes = {}
  // CIM_CompactDataFile_callback()
  // Por: Alberto Bachler: 11/01/13, 11:52:29
  //  ---------------------------------------------
  // Método callback llamado por CIM_CompactDataFile
  // Muestra un mensaje de progreso y retorna errores cuando los hay
  //
  //  ---------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)
If (False:C215)
	C_LONGINT:C283(CIM_CompactDataFile_callback ;$0)
	C_LONGINT:C283(CIM_CompactDataFile_callback ;$1)
	C_LONGINT:C283(CIM_CompactDataFile_callback ;$2)
	C_TEXT:C284(CIM_CompactDataFile_callback ;$3)
	C_LONGINT:C283(CIM_CompactDataFile_callback ;$4)
	C_LONGINT:C283(CIM_CompactDataFile_callback ;$5)
End if 
ARRAY TEXT:C222(at_DataFileError;0)

Case of 
	: ($1=1)
		  //If (Not(Progress Stopped (vl_ServerProgressProcessID)))
		  //Progress SET PROGRESS (vl_ServerProgressProcessID;$4/100;$3;True)
		  //End if 
		  //If (Application type=4D Server)
		  //Progress SET PROGRESS (vl_ServerProgressProcessID;$4/100)
		  //Progress SET MESSAGE (vl_ServerProgressProcessID;$3)
		IT_Progress (0;vl_ServerProgressProcessID;$4/100;$3)
		  //Else 
		  //Progress SET PROGRESS (vl_ServerProgressProcessID;$4/100)
		  //Progress SET MESSAGE (vl_ServerProgressProcessID;$3)
		  //  //IT_Progress (0;vl_ServerProgressProcessID;$4/100;$3)
		  //End if 
		<>r_AvanceCompactacion:=$4/100
		<>t_EtapaCompactacion:=$3
		
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
				  //If (Not(Progress Stopped (vl_ServerProgressProcessID)))
				  //Progress QUIT (vl_ServerProgressProcessID)
				  //End if 
				
			: ((Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Volume desktop:K5:2))
				IT_Progress (-1;vl_ServerProgressProcessID)
				  //If (Not(Progress Stopped (vl_ServerProgressProcessID)))
				  //Progress QUIT (vl_ServerProgressProcessID)
				  //End if 
		End case 
		
	: ($1=5)
		APPEND TO ARRAY:C911(at_DataFileError;$3)
End case 

