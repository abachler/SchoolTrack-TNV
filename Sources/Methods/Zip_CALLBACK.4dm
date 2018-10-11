//%attributes = {"invisible":true}
  // Zip_CALLBACK()
  //
  //
  // creado por: Alberto Bachler Klein: 26-07-16, 18:40:35
  // codigo original de Miyako
  // -----------------------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_REAL:C285($3)
C_REAL:C285($4)

C_REAL:C285($r_avance;$r_total)
C_TEXT:C284($t_rutaAbsoluta;$t_rutaRelativa)


If (False:C215)
	C_BOOLEAN:C305(Zip_CALLBACK ;$0)
	C_TEXT:C284(Zip_CALLBACK ;$1)
	C_TEXT:C284(Zip_CALLBACK ;$2)
	C_REAL:C285(Zip_CALLBACK ;$3)
	C_REAL:C285(Zip_CALLBACK ;$4)
End if 

$t_rutaRelativa:=$1
$t_rutaAbsoluta:=$2
$r_avance:=$3
$r_total:=$4

If (<>ZIP_ABORT)
	<>ZIP_STATUS:=0
Else 
	<>ZIP_STATUS:=($r_avance/$r_total)*1000
End if 

  //CALL PROCESS(-1)
POST OUTSIDE CALL:C329(vl_ZIPprocesoLLamante)

$0:=<>ZIP_ABORT