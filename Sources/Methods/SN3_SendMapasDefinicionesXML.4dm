//%attributes = {}
  //SN3_SendMapasDefinicionesXML

C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)

$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 

READ ONLY:C145([MPA_AsignaturasMatrices:189])
READ ONLY:C145([MPA_ObjetosMatriz:204])
READ ONLY:C145([MPA_DefinicionEjes:185])
READ ONLY:C145([MPA_DefinicionDimensiones:188])
READ ONLY:C145([MPA_DefinicionCompetencias:187])

$currentErrorHandler:=SN3_SetErrorHandler ("set")

$iterator:=1
$iterateTo:=Records in table:C83([MPA_AsignaturasMatrices:189])+Records in table:C83([MPA_ObjetosMatriz:204])+Records in table:C83([MPA_DefinicionEjes:185])+Records in table:C83([MPA_DefinicionDimensiones:188])+Records in table:C83([MPA_DefinicionCompetencias:187])

If ($iterateTo>0)
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_DefinicionMapas;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_DefinicionMapas;"matrices";$todos;$useArrays)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($iterateTo)+__ (" registros de definición de mapas de aprendizaje..."))
	ALL RECORDS:C47([MPA_AsignaturasMatrices:189])
	ARRAY LONGINT:C221($arrayRN;0)
	LONGINT ARRAY FROM SELECTION:C647([MPA_AsignaturasMatrices:189];$arrayRN;"")
	For ($i;1;Size of array:C274($arrayRN))
		KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$arrayRN{$i};False:C215)
		SAX_CreateNode ($refXMLDoc;"matriz")
		SAX_CreateNode ($refXMLDoc;"idmatriz";True:C214;String:C10([MPA_AsignaturasMatrices:189]ID_Matriz:1))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterator/$iterateTo)
		$iterator:=$iterator+1
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	
	SAX_CreateNode ($refXMLDoc;"objectosmatrices")
	
	ARRAY LONGINT:C221($arrayRN;0)
	ALL RECORDS:C47([MPA_ObjetosMatriz:204])
	LONGINT ARRAY FROM SELECTION:C647([MPA_ObjetosMatriz:204];$arrayRN;"")
	For ($i;1;Size of array:C274($arrayRN))
		KRL_GotoRecord (->[MPA_ObjetosMatriz:204];$arrayRN{$i};False:C215)
		SAX_CreateNode ($refXMLDoc;"objeto")
		SAX_CreateNode ($refXMLDoc;"idmatriz";True:C214;String:C10([MPA_ObjetosMatriz:204]ID_Matriz:1))
		SAX_CreateNode ($refXMLDoc;"ideje";True:C214;String:C10([MPA_ObjetosMatriz:204]ID_Eje:3))
		SAX_CreateNode ($refXMLDoc;"iddimension";True:C214;String:C10([MPA_ObjetosMatriz:204]ID_Dimension:4))
		SAX_CreateNode ($refXMLDoc;"idcompetencia";True:C214;String:C10([MPA_ObjetosMatriz:204]ID_Competencia:5))
		SAX_CreateNode ($refXMLDoc;"tipo";True:C214;String:C10([MPA_ObjetosMatriz:204]Tipo_Objeto:2))
		SAX_CreateNode ($refXMLDoc;"fechaestimadalogro";True:C214;SN3_MakeDateInmune2LocalFormat ([MPA_ObjetosMatriz:204]FechaEstimadaLogro:26))
		SAX_CreateNode ($refXMLDoc;"periodos";True:C214;String:C10([MPA_ObjetosMatriz:204]Periodos:7))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterator/$iterateTo)
		$iterator:=$iterator+1
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	
	SAX_CreateNode ($refXMLDoc;"definicionejes")
	
	ARRAY LONGINT:C221($arrayRN;0)
	ALL RECORDS:C47([MPA_DefinicionEjes:185])
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionEjes:185];$arrayRN;"")
	For ($i;1;Size of array:C274($arrayRN))
		KRL_GotoRecord (->[MPA_DefinicionEjes:185];$arrayRN{$i};False:C215)
		SAX_CreateNode ($refXMLDoc;"eje")
		SAX_CreateNode ($refXMLDoc;"iddefeje";True:C214;String:C10([MPA_DefinicionEjes:185]ID:1))
		SAX_CreateNode ($refXMLDoc;"ejedesc";True:C214;[MPA_DefinicionEjes:185]Nombre:3;True:C214)
		SAX_CreateNode ($refXMLDoc;"ordeneje";True:C214;String:C10([MPA_DefinicionEjes:185]OrdenamientoNumerico:9))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterator/$iterateTo)
		$iterator:=$iterator+1
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	
	SAX_CreateNode ($refXMLDoc;"definiciondimensiones")
	
	ARRAY LONGINT:C221($arrayRN;0)
	ALL RECORDS:C47([MPA_DefinicionDimensiones:188])
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionDimensiones:188];$arrayRN;"")
	For ($i;1;Size of array:C274($arrayRN))
		KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$arrayRN{$i};False:C215)
		SAX_CreateNode ($refXMLDoc;"dimension")
		SAX_CreateNode ($refXMLDoc;"iddefdimension";True:C214;String:C10([MPA_DefinicionDimensiones:188]ID:1))
		SAX_CreateNode ($refXMLDoc;"idejedep";True:C214;String:C10([MPA_DefinicionDimensiones:188]ID_Eje:3))
		SAX_CreateNode ($refXMLDoc;"dimensiondesc";True:C214;[MPA_DefinicionDimensiones:188]Dimensión:4;True:C214)
		SAX_CreateNode ($refXMLDoc;"ordendimension";True:C214;String:C10([MPA_DefinicionDimensiones:188]OrdenamientoNumérico:20))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterator/$iterateTo)
		$iterator:=$iterator+1
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	
	SAX_CreateNode ($refXMLDoc;"definicioncompetencias")
	
	ARRAY LONGINT:C221($arrayRN;0)
	ALL RECORDS:C47([MPA_DefinicionCompetencias:187])
	LONGINT ARRAY FROM SELECTION:C647([MPA_DefinicionCompetencias:187];$arrayRN;"")
	For ($i;1;Size of array:C274($arrayRN))
		KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$arrayRN{$i};False:C215)
		SAX_CreateNode ($refXMLDoc;"competencia")
		SAX_CreateNode ($refXMLDoc;"iddefcompetencia";True:C214;String:C10([MPA_DefinicionCompetencias:187]ID:1))
		SAX_CreateNode ($refXMLDoc;"idejedepcomp";True:C214;String:C10([MPA_DefinicionCompetencias:187]ID_Eje:2))
		SAX_CreateNode ($refXMLDoc;"iddimdepcomp";True:C214;String:C10([MPA_DefinicionCompetencias:187]ID_Dimension:23))
		SAX_CreateNode ($refXMLDoc;"competenciadesc";True:C214;[MPA_DefinicionCompetencias:187]Competencia:6;True:C214)
		SAX_CreateNode ($refXMLDoc;"ordencompetencia";True:C214;String:C10([MPA_DefinicionCompetencias:187]OrdenamientoNumerico:25))
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$iterator/$iterateTo)
		$iterator:=$iterator+1
	End for 
	SAX CLOSE XML ELEMENT:C854($refXMLDoc)
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_DefinicionMapas;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($iterateTo)+" registros de definición de mapas de aprendizaje..")
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de definición de mapas de aprendizaje no pudo ser gene"+"rado.";Error)
	End if 
End if 
SN3_SetErrorHandler ("clear";$currentErrorHandler)

