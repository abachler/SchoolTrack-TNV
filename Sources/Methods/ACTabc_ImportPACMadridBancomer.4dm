//%attributes = {}
  // Método: ACTabc_ImportPACMadridBancomer
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 29-06-10, 18:30:13
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  //ACTabc_ImportPACMadridBancomer
  //Bancomer
C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY REAL:C219(aMontoMora;0)
ARRAY LONGINT:C221(al_idAvisoAPagar;0)

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->al_idAvisoAPagar)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Replace string:C233(Replace string:C233(ST_GetWord ($text;4;"\t");",";<>tXS_RS_DecimalSeparator);".";<>tXS_RS_DecimalSeparator))
	aRUT{Size of array:C274(aRUT)}:=ST_GetWord ($text;5;"\t")
	
	QUERY:C277([Alumnos:2];[Alumnos:2]numero_de_matricula:51=aRUT{Size of array:C274(aRUT)})
	If (Records in selection:C76([Alumnos:2])=0)
		aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (aRUT{Size of array:C274(aRUT)};"0")
		QUERY:C277([Alumnos:2];[Alumnos:2]numero_de_matricula:51=aRUT{Size of array:C274(aRUT)})
	End if 
	KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
	If (Records in selection:C76([ACT_CuentasCorrientes:175])=1)
		aRUT{Size of array:C274(aRUT)}:=String:C10([ACT_CuentasCorrientes:175]ID:1)
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=Num:C11(ST_GetWord ($text;6;"\t"))
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
<>vRUTField:=Field:C253(->[ACT_CuentasCorrientes:175]ID:1)
<>vRUTTable:=Table:C252(->[ACT_CuentasCorrientes:175])
<>vLabelLink:="ID"
CLOSE DOCUMENT:C267($ref)