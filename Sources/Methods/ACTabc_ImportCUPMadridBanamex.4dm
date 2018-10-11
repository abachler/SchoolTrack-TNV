//%attributes = {}
  // Método: ACTabc_ImportCUPMadridBanamex
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 04-03-10, 19:11:34
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




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
ARRAY DATE:C224(ad_fechaVcto;0)

C_TEXT:C284($vt_fechaCondensada;$vt_fechaDDMMAA)
C_LONGINT:C283($i;$vl_pos;$vl_cont;$vl_yearActual)
C_TEXT:C284($vt_refCompleta;$vt_num;$vt_monto)
C_REAL:C285($vr_suma)
C_BOOLEAN:C305($vb_disminuyeDecena)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto)
	$vt_monto:=ST_GetWord ($text;9;",")
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($vt_monto;1;Length:C16($vt_monto)-3)+<>tXS_RS_DecimalSeparator+Substring:C12($vt_monto;Length:C16($vt_monto)-1))
	aRUT{Size of array:C274(aRUT)}:=ST_GetWord ($text;11;",")
	aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	$vt_fechaCondensada:=ST_GetWord ($text;4;",")
	
	C_LONGINT:C283($vl_Agno;$vl_Mes;$vl_Dia;$vl_unidadArchivo;$vl_year)
	C_TEXT:C284($vt_yearActual;$vt_year)
	C_LONGINT:C283($vl_unidadMil;$vl_centena;$vl_decena;$vl_unidad;$vl_fechaCondensada)
	
	If (Length:C16($vt_fechaCondensada)=5)
		$vl_mes:=Num:C11(Substring:C12($vt_fechaCondensada;1;2))
		$vl_unidadArchivo:=Num:C11(Substring:C12($vt_fechaCondensada;3;1))
	Else 
		$vl_mes:=Num:C11(Substring:C12($vt_fechaCondensada;1;1))
		$vl_unidadArchivo:=Num:C11(Substring:C12($vt_fechaCondensada;2;1))
	End if 
	$vt_year:=String:C10(Year of:C25(Current date:C33(*)))
	If ($vl_unidadArchivo=9)
		If (Substring:C12($vt_year;4;1)="0")
			If (Num:C11(Substring:C12($vt_year;3;1))>0)
				$vt_year:=Substring:C12($vt_year;1;2)+String:C10(Num:C11(Substring:C12($vt_year;3;1))-1)+"9"
			Else 
				$vt_year:=Substring:C12($vt_year;1;2)+String:C10(Num:C11(Substring:C12($vt_year;3;1))-1)+"9"
			End if 
		Else 
			$vt_year:=Substring:C12($vt_year;1;3)+"9"
		End if 
	End if 
	$vl_year:=Num:C11($vt_year[[1]]+$vt_year[[2]]+$vt_year[[3]]+String:C10($vl_unidadArchivo))
	
	$vl_fechaCondensada:=Num:C11(ST_GetWord ($text;3;","))
	$vl_Dia:=($vl_fechaCondensada-((($vl_year-1988)*372)+(($vl_mes-1)*31)))+1
	
	ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear ($vl_Dia;$vl_mes;$vl_year)
	aDescCodigo{Size of array:C274(aDescCodigo)}:=""
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aMontoMora{Size of array:C274(aMontoMora)}:=0
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
  //AT_Delete (Size of array(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto)
<>vRUTField:=Field:C253(->[Alumnos:2]Codigo_interno:6)
<>vRUTTable:=Table:C252(->[Alumnos:2])
<>vLabelLink:="CodAlumno"
CLOSE DOCUMENT:C267($ref)