//%attributes = {}
  //CFG_STR_CreaPeriodosEscolares
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_LONGINT:C283($i;$idConfig;$idInstitucion;$itemRef;$periodos)
C_TEXT:C284($nombre)

If (False:C215)
	C_LONGINT:C283(CFG_STR_CreaPeriodosEscolares ;$1)
	C_LONGINT:C283(CFG_STR_CreaPeriodosEscolares ;$2)
	C_LONGINT:C283(CFG_STR_CreaPeriodosEscolares ;$3)
End if 

$itemRef:=$1
$idConfig:=$2
$idInstitucion:=$3

Case of 
	: ($itemRef=1)  //semestres
		$nombre:=__ ("Período")
		$periodos:=2
		
	: ($itemRef=2)  //trimestres
		$nombre:=__ ("Período")
		$periodos:=3
		
	: ($itemRef=3)  //4 bimestres
		$nombre:=__ ("Período")
		$periodos:=4
		
	: ($itemRef=5)  //5 bimestres
		$nombre:=__ ("Período")
		$periodos:=5
		
	: ($itemRef=6)  //anual
		$periodos:=1
		$nombre:=__ ("Período único")
End case 

$idConfig:=[xxSTR_Periodos:100]ID:1
$idInstitucion:=0

If ($periodos>1)
	For ($i;1;$periodos)
		QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=$idConfig;*)
		QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]ID_Institucion:10=$idInstitucion;*)
		QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]NumeroPeriodo:1=$i)
		If (Records in selection:C76([xxSTR_DatosPeriodos:132])=0)
			CREATE RECORD:C68([xxSTR_DatosPeriodos:132])
			[xxSTR_DatosPeriodos:132]NumeroPeriodo:1:=$i
			[xxSTR_DatosPeriodos:132]Nombre:8:=$nombre+" "+String:C10($i)
			[xxSTR_DatosPeriodos:132]ID_Configuracion:9:=[xxSTR_Periodos:100]ID:1
			[xxSTR_DatosPeriodos:132]ID_Institucion:10:=0
			SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
		End if 
	End for 
Else 
	QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=$idConfig;*)
	QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]ID_Institucion:10=$idInstitucion;*)
	QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]NumeroPeriodo:1=1)
	If (Records in selection:C76([xxSTR_DatosPeriodos:132])=0)
		CREATE RECORD:C68([xxSTR_DatosPeriodos:132])
		[xxSTR_DatosPeriodos:132]NumeroPeriodo:1:=1
		[xxSTR_DatosPeriodos:132]Nombre:8:=$nombre
		[xxSTR_DatosPeriodos:132]ID_Configuracion:9:=[xxSTR_Periodos:100]ID:1
		[xxSTR_DatosPeriodos:132]ID_Institucion:10:=0
		SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
	End if 
End if 
QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=$idConfig;*)
QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]ID_Institucion:10=$idInstitucion;*)
QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]NumeroPeriodo:1>$periodos)
KRL_DeleteSelection (->[xxSTR_DatosPeriodos:132];False:C215)

QUERY:C277([xxSTR_DatosPeriodos:132];[xxSTR_DatosPeriodos:132]ID_Configuracion:9=$idConfig;*)
QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]ID_Institucion:10=$idInstitucion;*)
QUERY:C277([xxSTR_DatosPeriodos:132]; & [xxSTR_DatosPeriodos:132]NumeroPeriodo:1=1)
CFG_STR_PeriodosEscolares_NEW ("LeeListaPeriodos";String:C10(Record number:C243([xxSTR_DatosPeriodos:132])))
