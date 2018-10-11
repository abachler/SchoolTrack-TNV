//%attributes = {}


  //WS_LEG_Send_ConoVtas
C_TEXT:C284(vt_Fecha;vt_Grado;vt_promo;vt_grado_c;vt_fecha_c)
_O_C_INTEGER:C282(vi_status;vi_rol;vi_pro_m;vi_pro_f;vi_sol_m;vi_sol_f;vi_exa_m;vi_exa_f;vi_adm_m;vi_adm_f;vi_ins_m;vi_ins_f;vi_rei_m;vi_rei_f;vi_tot_m;vi_tot_f;vi_baj_m;vi_baj_f;vi_atipicos)

SOAP DECLARATION:C782(vt_Fecha;Is text:K8:3;SOAP input:K46:1;"FechaIn")
SOAP DECLARATION:C782(vt_Grado;Is text:K8:3;SOAP input:K46:1;"GradoIn")

SOAP DECLARATION:C782(vi_status;Is integer:K8:5;SOAP output:K46:2;"Estatus")
SOAP DECLARATION:C782(vi_rol;Is integer:K8:5;SOAP output:K46:2;"Colegio")
SOAP DECLARATION:C782(vt_grado_c;Is text:K8:3;SOAP output:K46:2;"Grado")
SOAP DECLARATION:C782(vt_fecha_c;Is text:K8:3;SOAP output:K46:2;"FechaDeReporte")
SOAP DECLARATION:C782(vt_promo;Is text:K8:3;SOAP output:K46:2;"Promocion")
SOAP DECLARATION:C782(vi_pro_m;Is integer:K8:5;SOAP output:K46:2;"Prospecto_m")
SOAP DECLARATION:C782(vi_pro_f;Is integer:K8:5;SOAP output:K46:2;"Prospecto_f")
SOAP DECLARATION:C782(vi_sol_m;Is integer:K8:5;SOAP output:K46:2;"Solicitante_m")
SOAP DECLARATION:C782(vi_sol_f;Is integer:K8:5;SOAP output:K46:2;"Solicitante_f")
SOAP DECLARATION:C782(vi_exa_m;Is integer:K8:5;SOAP output:K46:2;"Examinado_m")
SOAP DECLARATION:C782(vi_exa_f;Is integer:K8:5;SOAP output:K46:2;"Examinado_f")
SOAP DECLARATION:C782(vi_adm_m;Is integer:K8:5;SOAP output:K46:2;"Admitido_m")
SOAP DECLARATION:C782(vi_adm_f;Is integer:K8:5;SOAP output:K46:2;"Admitido_f")
SOAP DECLARATION:C782(vi_ins_m;Is integer:K8:5;SOAP output:K46:2;"Inscrito_m")
SOAP DECLARATION:C782(vi_ins_f;Is integer:K8:5;SOAP output:K46:2;"Inscrito_f")
SOAP DECLARATION:C782(vi_rei_m;Is integer:K8:5;SOAP output:K46:2;"Reinscrito_m")
SOAP DECLARATION:C782(vi_rei_f;Is integer:K8:5;SOAP output:K46:2;"Reinscrito_f")
SOAP DECLARATION:C782(vi_tot_m;Is integer:K8:5;SOAP output:K46:2;"Total_m")
SOAP DECLARATION:C782(vi_tot_f;Is integer:K8:5;SOAP output:K46:2;"Total_f")
SOAP DECLARATION:C782(vi_baj_m;Is integer:K8:5;SOAP output:K46:2;"Bajas_m")
SOAP DECLARATION:C782(vi_baj_f;Is integer:K8:5;SOAP output:K46:2;"Bajas_f")
SOAP DECLARATION:C782(vi_atipicos;Is integer:K8:5;SOAP output:K46:2;"Atipicos")


ARRAY TEXT:C222($at_conostxt;0)
C_TEXT:C284($vt_Ciclo;$vt_Fecha;$vt_eventlog)
C_LONGINT:C283($i;$fia;$num_grado)

$folderPath:=ACTabc_CreaRutaCarpetas ("STMXCV"+Folder separator:K24:12)
DOCUMENT LIST:C474($folderPath;$at_conostxt)

If (vt_Fecha="")
	$fia:=Find in array:C230($at_conostxt;"ErrorCV.txt")
	$vl_num:=Size of array:C274($at_conostxt)
	$vt_nomarch:=""
	If ($vl_num>0)
		If ($fia=-1)
			$vt_nomarch:=$at_conostxt{$vl_num}
		Else 
			If ($vl_num>1)
				$vt_nomarch:=$at_conostxt{$vl_num-1}
			End if 
		End if 
	End if 
	$vt_Fecha:=Substring:C12($vt_nomarch;1;10)
Else 
	$vt_Fecha:=vt_Fecha
End if 

$vl_aai:=Year of:C25(PERIODOS_InicioAñoSTrack )
$vl_aaf:=Year of:C25(PERIODOS_FinAñoPeriodosSTrack )

If ($vl_aai#$vl_aaf)
	$vt_ciclo:=String:C10($vl_aaf)+"-"+String:C10($vl_aaf+1)
Else 
	$vt_ciclo:=String:C10($vl_aaf)
End if 

C_BOOLEAN:C305($vb_archivo;$vb_grado)
$num_grado:=Num:C11(Substring:C12(vt_grado;2))

If ($num_grado>Size of array:C274(<>aNivNo))
	$fia:=-1
Else 
	$fia:=Find in array:C230(<>al_NumeroNivelesActivos;<>aNivNo{$num_grado})
End if 

If ($fia#-1)
	$vb_grado:=True:C214
End if 

$at_conostxt{0}:=$vt_Fecha+"-"+$vt_ciclo
ARRAY LONGINT:C221($DA_Return;0)
AT_SearchArray (->$at_conostxt;">>";->$DA_Return)

If (Size of array:C274($DA_return)>0)
	$vb_archivo:=True:C214
End if 

$archivo:=$folderPath+$vt_Fecha+"-"+$vt_ciclo+"-"+vt_grado+".txt"  //nombre del xml que enviaremos

vi_rol:=Num:C11(<>gRolBd)
vt_grado_c:=vt_Grado
vt_fecha_c:=vt_Fecha
vt_promo:=$vt_ciclo

Case of 
	: (Not:C34($vb_archivo))
		vi_status:=1
	: (($vb_archivo) & (Not:C34($vb_grado)))
		vi_status:=2
	Else 
		ARRAY TEXT:C222($array_tags;0)
		APPEND TO ARRAY:C911($array_tags;"vi_status")
		APPEND TO ARRAY:C911($array_tags;"vi_rol")
		APPEND TO ARRAY:C911($array_tags;"vt_grado_c")
		APPEND TO ARRAY:C911($array_tags;"vt_fecha_c")
		APPEND TO ARRAY:C911($array_tags;"vt_promo")
		APPEND TO ARRAY:C911($array_tags;"vi_pro_m")
		APPEND TO ARRAY:C911($array_tags;"vi_pro_f")
		APPEND TO ARRAY:C911($array_tags;"vi_sol_m")
		APPEND TO ARRAY:C911($array_tags;"vi_sol_f")
		APPEND TO ARRAY:C911($array_tags;"vi_exa_m")
		APPEND TO ARRAY:C911($array_tags;"vi_exa_f")
		APPEND TO ARRAY:C911($array_tags;"vi_adm_m")
		APPEND TO ARRAY:C911($array_tags;"vi_adm_f")
		APPEND TO ARRAY:C911($array_tags;"vi_ins_m")
		APPEND TO ARRAY:C911($array_tags;"vi_ins_f")
		APPEND TO ARRAY:C911($array_tags;"vi_rei_m")
		APPEND TO ARRAY:C911($array_tags;"vi_rei_f")
		APPEND TO ARRAY:C911($array_tags;"vi_tot_m")
		APPEND TO ARRAY:C911($array_tags;"vi_tot_f")
		APPEND TO ARRAY:C911($array_tags;"vi_baj_m")
		APPEND TO ARRAY:C911($array_tags;"vi_baj_f")
		APPEND TO ARRAY:C911($array_tags;"vi_atipicos")
		
		ARRAY BOOLEAN:C223($array_tags_type;0)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;True:C214)
		APPEND TO ARRAY:C911($array_tags_type;True:C214)
		APPEND TO ARRAY:C911($array_tags_type;True:C214)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		APPEND TO ARRAY:C911($array_tags_type;False:C215)
		
		USE CHARACTER SET:C205("MacRoman";1)
		C_TIME:C306($ref)
		C_TEXT:C284($delimiter;$text)
		$delimiter:=ACTabc_DetectDelimiter ($archivo)
		$ref:=Open document:C264($archivo;"";Read mode:K24:5)
		
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		$x:=0
		While ($text#"")
			$x:=$x+1
			$ptr:=Get pointer:C304($array_tags{$x})
			
			If ($array_tags_type{$x})
				$ptr->:=ST_GetWord ($text;1;"\r")
			Else 
				$ptr->:=Num:C11(ST_GetWord ($text;1;"\r"))
			End if 
			RECEIVE PACKET:C104($ref;$text;$delimiter)
		End while 
		
		CLOSE DOCUMENT:C267($ref)
		USE CHARACTER SET:C205(*;0)
		
		$vt_eventlog:="Cono de Ventas Legionarios de Cristo, archivo enviado: "+$archivo
		LOG_RegisterEvt ($vt_eventlog;-1;-1;<>lUSR_CurrentUserID;"Schootrack")
End case 