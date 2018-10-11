//%attributes = {}
  //ACTdte_GeneraDTE
C_TEXT:C284($t_rut)

  //$vt_idTipoSII:=$ptr1->
$vt_idTipoSII:=$1

KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Boletas:181]ID_Apoderado:14)
KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21)

$vb_esNC:=True:C214

$vt_text:=""
$vt_textFinal:=""
  //$ref:=ACTabc_CreaArchivo ("documentos";$vt_fileName;"DTE")
  //If ($ref#?00:00:00?)
  //$vt_retorno:=vtACT_document

$vt_separador:=";"
$vt_fechaValida:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]FechaEmision:3)

$vt_text:=ACTdte_GeneraArchivo ("GeneraEncabezado";->$vt_separador;->$vt_idTipoSII)
  //IO_SendPacket ($ref;$vt_text)
$vt_textFinal:=$vt_textFinal+$vt_text

C_TEXT:C284($vt_td1;$vt_v2;$vt_fd3;$vt_fde4;$vt_idnr5;$vt_tdd6;$vt_idttdb7;$vt_tdi8;$vt_idsp9;$vt_idmb10;$vt_fdp11;$vt_fdc12;$vt_mc13;$vt_si14;$vt_pd15;$vt_ph16;$vt_mdp17;$vt_tcp18;$vt_ncdp19;$vt_bp20;$vt_tdpc21;$vt_tdpg22;$vt_tdpd23;$vt_fdv24;$vt_re25;$vt_rse26;$vt_ge27;$vt_ce28;$vt_cte29;$vt_fa30;$vt_fa31;$vt_s32;$vt_cdsds33;$vt_do34;$vt_co35;$vt_co36;$vt_cdv37;$vt_rm38;$vt_rr39;$vt_cir40;$vt_rsr41;$vt_nire42;$vt_nre43)
C_TEXT:C284($vt_gr44;$vt_cr45;$vt_ccr46;$vt_dr47;$vt_cr48;$vt_cr49;$vt_dp50;$vt_cp51;$vt_cp52;$vt_rs53;$vt_pdvqt54;$vt_rt55;$vt_rc56;$vt_nc57;$vt_dd58;$vt_cd59;$vt_cd60;$vt_mn61;$vt_me62;$vt_mbac63;$vt_mmc64;$vt_ti65;$vt_i66;$vt_ip67;$vt_it68;$vt_inr69;$vt_ceec70;$vt_gde71;$vt_mt72;$vt_mnf73;$vt_mp74;$vt_sa75;$vt_vap76;$vt_com77;$vt_tdc78;$vt_mnom79;$vt_meom80;$vt_mbfcom81;$vt_mbmcom82;$vt_iom83;$vt_inrom84;$vt_mtom85)
$vt_td1:=$vt_idTipoSII
$vt_v2:="1.0"
$vt_fd3:=""
$vt_fde4:=$vt_fechaValida
$vt_idnr5:=""
$vt_tdd6:=""
$vt_idttdb7:=""
$vt_tdi8:=""
$vt_idsp9:=""
$vt_idmb10:="1"
  //$vt_fdp11:=ST_Boolean2Str ([ACT_Boletas]ID_Estado=3;"1";"2")  //si esta pagada 1. sino 2
  //$vt_fdc12:=$vt_fechaValida
$vt_fdp11:=""
$vt_fdc12:=""
$vt_mc13:=""
$vt_si14:=""
$vt_pd15:=""
$vt_ph16:=""
$vt_mdp17:=""
$vt_tcp18:=""
$vt_ncdp19:=""
$vt_bp20:=""
$vt_tdpc21:=""
$vt_tdpg22:=""
$vt_tdpd23:=""
$vt_fdv24:=""
$vt_re25:=ACTdte_GeneraArchivo ("GetRutConFormato";->[ACT_RazonesSociales:279]RUT:3)
$vt_rse26:=ST_GetStringByLen ([ACT_RazonesSociales:279]razon_social:2;100)
$vt_ge27:=ST_GetStringByLen ([ACT_RazonesSociales:279]giro:18;80)
$vt_ce28:=""
$vt_cte29:=""
$vt_fa30:=""
$vt_fa31:=""
$vt_s32:=""
$vt_cdsds33:=""
  //$vt_do34:=ST_GetStringByLen ([ACT_RazonesSociales]direccion;70)
$vt_do34:=ST_GetStringByLen (Replace string:C233([ACT_RazonesSociales:279]direccion:7;";";",");70)
$vt_co35:=ST_GetStringByLen ([ACT_RazonesSociales:279]comuna:8;20)
$vt_co36:=ST_GetStringByLen ([ACT_RazonesSociales:279]ciudad:10;20)
$vt_cdv37:=""
$vt_rm38:=""
  //$vt_rr39:=ACTdte_GeneraArchivo ("GetRutConFormato";$ptrRut)
$t_rut:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([Personas:7]RUT:6);String:C10([ACT_Terceros:138]RUT:4))
$vt_rr39:=ACTdte_GeneraArchivo ("GetRutConFormato";->$t_rut)
$vt_cir40:=ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([Personas:7]No:1);String:C10([ACT_Terceros:138]Id:1))
  //$vt_rsr41:=ST_GetStringByLen ($ptrRazonSocial->;100)
$vt_rsr41:=ST_GetStringByLen (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([Personas:7]Apellidos_y_nombres:30);String:C10([ACT_Terceros:138]Nombre_Completo:9));100)

  //20170218 RCH
If ($vt_rr39="")
	$vt_nire42:=Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Pasaporte:59;[ACT_Terceros:138]Pasaporte:25)
	$vt_nre43:=ACTdte_ObtieneCodigoPaisSII (Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Nacionalidad:7;[ACT_Terceros:138]Nacionalidad:27))
Else 
	$vt_nire42:=""
	$vt_nre43:=""
End if 

$vt_gr44:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;"Persona natural";[ACT_Terceros:138]Giro:8);40)
$vt_gr44:=Choose:C955($vt_gr44="";"No informado";$vt_gr44)
$vt_cr45:=""
$vt_ccr46:=""
$vt_dr47:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;Replace string:C233([Personas:7]Direccion:14;";";",");Replace string:C233([ACT_Terceros:138]Direccion:5;";";""));70)
$vt_cr48:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Comuna:16;[ACT_Terceros:138]Comuna:6);20)
$vt_cr49:=ST_GetStringByLen (ST_Boolean2Str ([ACT_Boletas:181]ID_Apoderado:14#0;[Personas:7]Ciudad:17;[ACT_Terceros:138]Ciudad:7);20)
$vt_dp50:=""
$vt_cp51:=""
$vt_cp52:=""
$vt_rs53:=""
$vt_pdvqt54:=""
$vt_rt55:=""
$vt_rc56:=""
$vt_nc57:=""
$vt_dd58:=""
$vt_cd59:=""
$vt_cd60:=""
  //$vt_mn61:=ST_Boolean2Str ([ACT_Boletas]Monto_IVA=0;String([ACT_Boletas]Monto_Total);String([ACT_Boletas]Monto_Afecto))
$vt_mn61:=ST_Boolean2Str ([ACT_Boletas:181]Monto_IVA:5=0;"";String:C10([ACT_Boletas:181]Monto_Afecto:4))
$vt_me62:=String:C10([ACT_Boletas:181]Monto_Exento:30)  //""  //ST_Boolean2Str ([ACT_Boletas]Monto_IVA=0;String([ACT_Boletas]Monto_Total);"")
$vt_mbac63:=""
$vt_mmc64:=""
$vt_ti65:=ST_Boolean2Str ([ACT_Boletas:181]Monto_IVA:5#0;String:C10(<>vrACT_TasaIVA);"")
$vt_i66:=ST_Boolean2Str ([ACT_Boletas:181]Monto_IVA:5#0;String:C10([ACT_Boletas:181]Monto_IVA:5);"")
$vt_ip67:=""
$vt_it68:=""
$vt_inr69:=""
$vt_ceec70:=""
$vt_gde71:=""
$vt_mt72:=String:C10([ACT_Boletas:181]Monto_Total:6)
$vt_mnf73:=""
$vt_mp74:=""
$vt_sa75:=""
$vt_vap76:=""
$vt_com77:=""
$vt_tdc78:=""
$vt_mnom79:=""
$vt_meom80:=""
$vt_mbfcom81:=""
$vt_mbmcom82:=""
$vt_iom83:=""
$vt_inrom84:=""
$vt_mtom85:=""

  //$vt_text:=$vt_td1+$vt_separador+$vt_v2+$vt_separador+$vt_fd3+$vt_separador+$vt_fde4+$vt_separador+$vt_idnr5+$vt_separador+$vt_tdd6+$vt_separador+$vt_idttdb7+$vt_separador+$vt_tdi8+$vt_separador+$vt_idsp9+$vt_separador+$vt_idmb10+$vt_separador+$vt_fdp11+$vt_separador+$vt_fdc12+$vt_separador+$vt_mc13+$vt_separador+$vt_si14+$vt_separador+$vt_pd15+$vt_separador+$vt_ph16+$vt_separador+$vt_mdp17+$vt_separador+$vt_tcp18+$vt_separador+$vt_ncdp19+$vt_separador+$vt_bp20+$vt_separador+$vt_tdpc21+$vt_separador+$vt_tdpg22+$vt_separador+$vt_tdpd23+$vt_separador+$vt_fdv24+$vt_separador+$vt_re25+$vt_separador+$vt_rse26+$vt_separador+$vt_ge27+$vt_separador+$vt_ce28+$vt_separador+$vt_cte29+$vt_separador+$vt_fa30+$vt_separador+$vt_fa31+$vt_separador+$vt_s32+$vt_separador+$vt_cdsds33+$vt_separador+$vt_do34+$vt_separador+$vt_co35+$vt_separador+$vt_co36+$vt_separador+$vt_cdv37+$vt_separador+$vt_rm38+$vt_separador+$vt_rr39+$vt_separador+$vt_cir40+$vt_separador+$vt_rsr41+$vt_separador+$vt_nire42+$vt_separador+$vt_nre43+$vt_separador+$vt_gr44+$vt_separador+$vt_cr45+$vt_separador+$vt_ccr46+$vt_separador+$vt_dr47+$vt_separador+$vt_cr48+$vt_separador+$vt_cr49+$vt_separador+$vt_dp50+$vt_separador+$vt_cp51+$vt_separador+$vt_cp52+$vt_separador+$vt_rs53+$vt_separador+$vt_pdvqt54+$vt_separador+$vt_rt55+$vt_separador+$vt_rc56+$vt_separador+$vt_nc57+$vt_separador+$vt_dd58+$vt_separador+$vt_cd59+$vt_separador+$vt_cd60+$vt_separador+$vt_mn61+$vt_separador+$vt_me62+$vt_separador+$vt_mbac63+$vt_separador+$vt_mmc64+$vt_separador+$vt_ti65+$vt_separador+$vt_i66+$vt_separador+$vt_ip67+$vt_separador+$vt_it68+$vt_separador+$vt_inr69+$vt_separador+$vt_ceec70+$vt_separador+$vt_gde71+$vt_separador+$vt_mt72+$vt_separador+$vt_mnf73+$vt_separador+$vt_mp74+$vt_separador+$vt_sa75+$vt_separador+$vt_vap76+$vt_separador+$vt_com77+$vt_separador+$vt_tdc78+$vt_separador+$vt_mnom79+$vt_separador+$vt_meom80+$vt_separador+$vt_mbfcom81+$vt_separador+$vt_mbmcom82+$vt_separador+$vt_iom83+$vt_separador+$vt_inrom84+$vt_separador+$vt_mtom85+$vt_separador+"\r"
  //ENCABEZADO
$vt_text:="ENC"+$vt_separador+$vt_td1+$vt_separador+$vt_v2+$vt_separador+$vt_fd3+$vt_separador+$vt_fde4+$vt_separador+$vt_idnr5+$vt_separador
$vt_text:=$vt_text+$vt_tdd6+$vt_separador+$vt_idttdb7+$vt_separador+$vt_tdi8+$vt_separador+$vt_idsp9+$vt_separador+$vt_idmb10+$vt_separador
$vt_text:=$vt_text+$vt_fdp11+$vt_separador+$vt_fdc12+$vt_separador+$vt_mc13+$vt_separador+$vt_si14+$vt_separador+$vt_pd15+$vt_separador
$vt_text:=$vt_text+$vt_ph16+$vt_separador+$vt_mdp17+$vt_separador+$vt_tcp18+$vt_separador+$vt_ncdp19+$vt_separador+$vt_bp20+$vt_separador
$vt_text:=$vt_text+$vt_tdpc21+$vt_separador+$vt_tdpg22+$vt_separador+$vt_tdpd23+$vt_separador+$vt_fdv24+$vt_separador+$vt_re25+$vt_separador
$vt_text:=$vt_text+$vt_rse26+$vt_separador+$vt_ge27+$vt_separador+$vt_ce28+$vt_separador+$vt_cte29+$vt_separador+$vt_fa30+$vt_separador
$vt_text:=$vt_text+$vt_fa31+$vt_separador+$vt_s32+$vt_separador+$vt_cdsds33+$vt_separador+$vt_do34+$vt_separador+$vt_co35+$vt_separador
$vt_text:=$vt_text+$vt_co36+$vt_separador+$vt_cdv37+$vt_separador+$vt_rm38+$vt_separador+$vt_rr39+$vt_separador+$vt_cir40+$vt_separador
$vt_text:=$vt_text+$vt_rsr41+$vt_separador+$vt_nire42+$vt_separador+$vt_nre43+$vt_separador+$vt_gr44+$vt_separador+$vt_cr45+$vt_separador
$vt_text:=$vt_text+$vt_ccr46+$vt_separador+$vt_dr47+$vt_separador+$vt_cr48+$vt_separador+$vt_cr49+$vt_separador+$vt_dp50+$vt_separador
$vt_text:=$vt_text+$vt_cp51+$vt_separador+$vt_cp52+$vt_separador+$vt_rs53+$vt_separador+$vt_pdvqt54+$vt_separador+$vt_rt55+$vt_separador
$vt_text:=$vt_text+$vt_rc56+$vt_separador+$vt_nc57+$vt_separador+$vt_dd58+$vt_separador+$vt_cd59+$vt_separador+$vt_cd60+$vt_separador
$vt_text:=$vt_text+$vt_mn61+$vt_separador+$vt_me62+$vt_separador+$vt_mbac63+$vt_separador+$vt_mmc64+$vt_separador+$vt_ti65+$vt_separador
$vt_text:=$vt_text+$vt_i66+$vt_separador+$vt_ip67+$vt_separador+$vt_it68+$vt_separador+$vt_inr69+$vt_separador+$vt_ceec70+$vt_separador
$vt_text:=$vt_text+$vt_gde71+$vt_separador+$vt_mt72+$vt_separador+$vt_mnf73+$vt_separador+$vt_mp74+$vt_separador+$vt_sa75+$vt_separador
$vt_text:=$vt_text+$vt_vap76+$vt_separador+$vt_com77+$vt_separador+$vt_tdc78+$vt_separador+$vt_mnom79+$vt_separador+$vt_meom80+$vt_separador
$vt_text:=$vt_text+$vt_mbfcom81+$vt_separador+$vt_mbmcom82+$vt_separador+$vt_iom83+$vt_separador+$vt_inrom84+$vt_separador+$vt_mtom85+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
$vt_textFinal:=$vt_textFinal+$vt_text

  //  //tabla de montos de pago
  //C_TEXT($vt_fp1;$vt_mdp2;$vt_gdp3)
  //$vt_fp1:=""
  //$vt_mdp2:=""
  //$vt_gdp3:=""
  //$vt_text:="TMP"+$vt_separador+$vt_fp1+$vt_separador+$vt_mdp2+$vt_separador+$vt_gdp3+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //telefono emisor
C_TEXT:C284($vt_nt1)
$vt_text:=""  //20160321 RCH
If ([ACT_RazonesSociales:279]telefono:11#"")  //20151204 RCH. Cuando no habia telefono, el nodo iba vacio y el SII respondia con un error: (ENV-3-0) Error en Schema - [0] LSX-00009: data missing for type "#simple"
	$vt_nt1:=[ACT_RazonesSociales:279]telefono:11
	$vt_text:="TEL"+$vt_separador+$vt_nt1+$vt_separador+"\r"
End if 
  //IO_SendPacket ($ref;$vt_text)
$vt_textFinal:=$vt_textFinal+$vt_text

  //ACT  ` actividades economicas emisor
ARRAY TEXT:C222($at_acteco;0)
AT_Text2Array (->$at_acteco;[ACT_Boletas:181]CL_acteco:28)
If (Size of array:C274($at_acteco)=0)
	APPEND TO ARRAY:C911($at_acteco;"")
End if 
C_TEXT:C284($vt_aede1)
For ($i;1;Size of array:C274($at_acteco))
	$vt_aede1:=$at_acteco{$i}
	$vt_text:="ACT"+$vt_separador+$vt_aede1+$vt_separador+"\r"
	  //IO_SendPacket ($ref;$vt_text)
	$vt_textFinal:=$vt_textFinal+$vt_text
End for 

  //  //impuesto y retenciones
  //C_TEXT($vt_tdiora1;$vt_tior2;$vt_mdior3)
  //$vt_tdiora1:="15"
  //$vt_tior2:="0"
  //$vt_mdior3:="0"
  //$vt_text:="IMP"+$vt_separador+$vt_tdiora1+$vt_separador+$vt_tior2+$vt_separador+$vt_mdior3+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //  //IMPOM
  //C_TEXT($vt_tdioraom1;$vt_tiorom2;$vt_mdiorom3)
  //$vt_tdioraom1:="15"
  //$vt_tiorom2:="0"
  //$vt_mdiorom3:="0"
  //$vt_text:="IMPOM"+$vt_separador+$vt_tdioraom1+$vt_separador+$vt_tiorom2+$vt_separador+$vt_mdiorom3+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //detalle
C_TEXT:C284($vt_nldd1;$vt_ide2;$vt_iar3;$vt_mbf4;$vt_mbmc5;$vt_puncf6;$vt_ndi7;$vt_ddi8;$vt_cdr9;$vt_udmdr10;$vt_pdr11;$vt_cdi12;$vt_fde13;$vt_fdv14;$vt_udm15;$vt_pdi16;$vt_pdd17;$vt_dm18;$vt_pd19;$vt_rm20;$vt_mdi21)

  //DESC
C_TEXT:C284($vt_tds1;$vt_vds2)


  //ARRAY REAL($arACT_ValorDcto;0)
$vr_sumaDetalle:=0
C_LONGINT:C283($vl_lineas)
C_POINTER:C301($ptr1;$ptr2)
C_REAL:C285($vr_montoItem)
$vl_lineas:=Num:C11(ACTcfg_OpcionesLineasDT ("ObtieneNumLineas"))
If ($vl_lineas>60)
	$vl_lineas:=60  //maximo 60 para el sii. En act el maximo es 20
End if 
$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
$vl_numLinea:=1
For ($i;1;$vl_lineas)
	
	$ptr1:=Get pointer:C304("vtACT_SRbol_DetalleCargo"+String:C10($i)+"1")
	$ptr2:=Get pointer:C304("vrACT_SRbol_MontoCargo"+String:C10($i)+"1")
	$ptr3:=Get pointer:C304("vrACT_SRbol_CantidadCargo"+String:C10($i)+"1")
	$ptr4:=Get pointer:C304("vrACT_SRbol_UnitarioCargo"+String:C10($i)+"1")
	$ptr5:=Get pointer:C304("vbACT_SRbol_Afecto"+String:C10($i)+"1")
	$ptr6:=Get pointer:C304("vrACT_SRbol_MontoDcto"+String:C10($i)+"1")
	$ptr7:=Get pointer:C304("vlACT_SRbol_IDCargo"+String:C10($i)+"1")  // id cargo
	$ptr8:=Get pointer:C304("vtACT_SRbol_unidadCargo"+String:C10($i)+"1")  // 
	If ($ptr1->#"")
		  //20120531 RCH Se asigna monto fuera del if...
		$vr_montoItem:=$ptr2->
		  //If (($ptr2->>0) | ($i=1))  // cuando es la primera linea siempre tiene que entrar
		If (($ptr2->>0) | ($i=1) | ($vt_idTipoSII="61"))  // 20131024 RCH Cuando es NC siempre entra para colocar los detalles.
			
			  //$vr_montoItem:=$ptr2->
			
			$vt_nldd1:=String:C10($vl_numLinea)
			$vt_ide2:=ST_Boolean2Str (($vt_idTipoSII="33") | ($vt_idTipoSII="61") | ($vt_idTipoSII="56");ST_Boolean2Str ($ptr5->;"";"1");"1")
			$vt_iar3:=""
			$vt_mbf4:=""
			$vt_mbmc5:=""
			$vt_puncf6:=""
			  //$vt_ndi7:=Substring($ptr1->;1;80)  // maximo 80 caracteres
			$vt_ndi7:=Substring:C12(Replace string:C233($ptr1->;";";"");1;80)  //20141007 RCH Si va un ; es considerada otra columna
			$vt_ddi8:=""
			
			If (r_enviaDesc=1)
				If (vtACT_TextoDescripcionFact#"")
					If ($ptr7->>=0)
						  //20160429 RCH
						  //KRL_FindAndLoadRecordByIndex (->[ACT_Cargos]ID;$ptr7)
						
						  //READ ONLY([ACT_CuentasCorrientes])
						  //READ ONLY([Alumnos])
						  //KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes]ID;->[ACT_Cargos]ID_CuentaCorriente)
						  //KRL_FindAndLoadRecordByIndex (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno)
						
						  //C_TEXT($t_mes;$t_year)
						  //If (Position("&car_mes&";vtACT_TextoDescripcionFact)>0)
						  //$t_mes:=<>atXS_MonthNames{[ACT_Cargos]Mes}
						  //Else 
						  //$t_mes:=""
						  //End if 
						  //If (Position("&car_year&";vtACT_TextoDescripcionFact)>0)
						  //$t_year:=String([ACT_Cargos]Año)
						  //Else 
						  //$t_year:=""
						  //End if 
						
						  //C_TEXT($t_apellidos_y_nombres;$t_curso;$t_rut;$t_nivel)
						  //If (Position("&al_ape&";vtACT_TextoDescripcionFact)>0)
						  //$t_apellidos_y_nombres:=[Alumnos]Apellidos_y_Nombres
						  //Else 
						  //$t_apellidos_y_nombres:=""
						  //End if 
						  //If (Position("&al_cur&";vtACT_TextoDescripcionFact)>0)
						  //$t_curso:=[Alumnos]Curso
						  //Else 
						  //$t_curso:=""
						  //End if 
						  //If (Position("&al_rut&";vtACT_TextoDescripcionFact)>0)
						  //$t_rut:=SR_FormatoRUT2 ([Alumnos]RUT)
						  //Else 
						  //$t_rut:=""
						  //End if 
						  //If (Position("&al_nivel&";vtACT_TextoDescripcionFact)>0)
						  //$t_nivel:=[Alumnos]Nivel_Nombre
						  //Else 
						  //$t_nivel:=""
						  //End if 
						
						  //If (($t_mes#"") | ($t_year#"") | ($t_apellidos_y_nombres#"") | ($t_curso#"") | ($t_rut#"") | ($t_nivel#""))
						  //$vt_ddi8:=vtACT_TextoDescripcionFact
						  //$vt_ddi8:=Replace string($vt_ddi8;"&car_mes&";$t_mes)
						  //$vt_ddi8:=Replace string($vt_ddi8;"&car_year&";$t_year)
						
						  //$vt_ddi8:=Replace string($vt_ddi8;"&al_ape&";$t_apellidos_y_nombres)
						  //$vt_ddi8:=Replace string($vt_ddi8;"&al_cur&";$t_curso)
						  //$vt_ddi8:=Replace string($vt_ddi8;"&al_rut&";$t_rut)
						  //$vt_ddi8:=Replace string($vt_ddi8;"&al_nivel&";$t_nivel)
						  //Else 
						  //$vt_ddi8:=" "  //20160429 RCH
						  //End if 
						$vt_ddi8:=ACTdte_LlenaDescripcion (r_enviaDesc;vtACT_TextoDescripcionFact;$i)
						
					End if 
				End if 
			End if 
			
			
			
			$vt_cdr9:=""
			$vt_udmdr10:=""
			$vt_pdr11:=""
			$vt_cdi12:=ST_Boolean2Str ($vr_montoItem>0;String:C10($ptr3->);"")
			  //$vt_cdi12:=Replace string($vt_cdi12;<>tXS_RS_DecimalSeparator;".")
			If ([ACT_Boletas:181]codigo_referencia:31=1)
				$vt_cdi12:=Replace string:C233($vt_cdi12;<>tXS_RS_DecimalSeparator;".")
			Else 
				$vt_cdi12:="1"  //20141009 RCH No es obligatorio para 61
			End if 
			$vt_fde13:=""
			$vt_fdv14:=""
			If ($ptr8->#"")
				$vt_udm15:=$ptr8->
			Else 
				$vt_udm15:=""
			End if 
			$vt_pdi16:=String:C10($ptr4->)
			
			  //20141009 RCH probar
			  //$vt_pdi16:=String(Round($ptr2->/$ptr3->;<>vlACT_Decimales))  //20141009 RCH Se calcula el precio unitario
			If ([ACT_Boletas:181]codigo_referencia:31=1)
				If ($ptr3->>0)
					  //20160224 RCH Había problema con los descuentos. Ticket 155262
					  //$vt_pdi16:=String(Round($ptr2->/$ptr3->;<>vlACT_Decimales))  //20141009 RCH Se calcula el precio unitario
					$vt_pdi16:=String:C10(Round:C94($ptr2->/$ptr3->;6))
				End if 
			Else 
				$vt_pdi16:=String:C10($ptr4->)  //20141009 RCH
			End if 
			  //20160224 RCH Había problema con los descuentos. Ticket 155262
			$r_monto:=Num:C11($vt_pdi16)
			$vt_pdi16:=Replace string:C233($vt_pdi16;<>tXS_RS_DecimalSeparator;".")
			
			  //If (($ptr7->#0) & ($ptr3->=1))
			  //KRL_FindAndLoadRecordByIndex (->[ACT_Cargos]ID;$ptr7)
			  //If ([ACT_Cargos]TasaIVA#0)
			  //If ($vr_montoItem=[ACT_Cargos]Monto_Neto)
			  //$vt_pdi16:=String([ACT_Cargos]Monto_Afecto)
			  //Else 
			  //$vt_pdi16:=String(Round($vr_montoItem/(1+([ACT_Cargos]TasaIVA/100));<>vlACT_Decimales))
			  //End if 
			  //Else 
			  //$vt_pdi16:=String($ptr4->)
			  //End if 
			  //Else 
			  //If ($ptr4->#0)
			  //TRACE
			  //  //20130312 RCH probar por cambio para soportar varias lineas afectas
			  //KRL_FindAndLoadRecordByIndex (->[ACT_Cargos]ID;$ptr7)
			  //$vt_pdi16:=String(String(Round($ptr4->/(1+([ACT_Cargos]TasaIVA/100));<>vlACT_Decimales)))
			  //Else 
			  //$vt_pdi16:=String(Round($vr_montoItem/$ptr3->;<>vlACT_Decimales))
			  //End if 
			  //End if 
			$vt_pdd17:=""
			
			  //20160224 RCH Problemas con descuentos al emitir NC. Ticket 155262.
			  //$vt_dm18:=ST_Boolean2Str ($vr_montoItem>0;String($ptr6->);"")
			$vt_dm18:=""
			
			$vt_pd19:=""
			$vt_rm20:=""
			  //$vt_mdi21:=String($ptr2->)
			  //$vt_mdi21:=String($vr_montoItem)
			
			  //20160224 RCH. Ticket 155262.
			  //$vr_montoItem:=$vr_montoItem-$ptr6->
			
			  //If (($ptr7->#0) & ($ptr3->>=1) & ([ACT_Cargos]TasaIVA#0))
			  //$vt_mdi21:=String(Round(Num($vt_pdi16)*Num($vt_cdi12);<>vlACT_Decimales))
			  //Else 
			$vt_mdi21:=String:C10(Round:C94($vr_montoItem;<>vlACT_Decimales))
			  //End if 
			
			
			  //If ((Num($vt_pdi16)*Num($ptr3->))#$ptr2->)  //20151026 RCH. Cuando habia decimal no calculaba correctamente
			  //$vt_cdi5:=""
			  //$vt_pdi7:=""
			  //End if 
			  //If ((Num($vt_pdi16)*Num($vt_cdi12))#(Num($vt_mdi21)+(Num($vt_dm18))))  //20151222 RCH
			If (($r_monto*Num:C11($vt_cdi12))#(Num:C11($vt_mdi21)+(Num:C11($vt_dm18))))  //20160224 RCH 
				$vt_cdi12:="1"
				$vt_pdi16:=$vt_mdi21
			End if 
			
			$vl_numLinea:=$vl_numLinea+1
			
			$vt_text:="DET"+$vt_separador+$vt_nldd1+$vt_separador+$vt_ide2+$vt_separador+$vt_iar3+$vt_separador+$vt_mbf4+$vt_separador+$vt_mbmc5+$vt_separador
			$vt_text:=$vt_text+$vt_puncf6+$vt_separador+$vt_ndi7+$vt_separador+$vt_ddi8+$vt_separador+$vt_cdr9+$vt_separador+$vt_udmdr10+$vt_separador
			$vt_text:=$vt_text+$vt_pdr11+$vt_separador+$vt_cdi12+$vt_separador+$vt_fde13+$vt_separador+$vt_fdv14+$vt_separador+$vt_udm15+$vt_separador
			$vt_text:=$vt_text+$vt_pdi16+$vt_separador+$vt_pdd17+$vt_separador+$vt_dm18+$vt_separador+$vt_pd19+$vt_separador+$vt_rm20+$vt_separador
			$vt_text:=$vt_text+$vt_mdi21+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //VALIDACION SUMA DETALLES
			$vr_sumaDetalle:=$vr_sumaDetalle+$ptr2->
		Else 
			  //DESC
			C_TEXT:C284($vt_tds1;$vt_vds2)
			$vt_tds1:="$"
			$vt_vds2:=""
			If ($ptr4->#0)
				$vt_vds2:=String:C10(Abs:C99($ptr4->))
			Else 
				$vt_vds2:=String:C10(Abs:C99(Round:C94($vr_montoItem/$ptr3->;<>vlACT_Decimales)))
			End if 
			If (Num:C11($vt_separador)>0)
				$vt_text:="DESC"+$vt_separador+$vt_tds1+$vt_separador+$vt_vds2+$vt_separador+"\r"
				  //IO_SendPacket ($ref;$vt_text)
				$vt_textFinal:=$vt_textFinal+$vt_text
			End if 
			  //Else 
			  //APPEND TO ARRAY($arACT_ValorDcto;$ptr2->)
		End if 
	Else 
		$i:=$vl_lineas
	End if 
End for 

  //codigos de items
  //C_TEXT($vt_tc1;$vt_cd2)
  //$vt_tc1:=""
  //$vt_cd2:=""
  //$vt_text:="ITEM"+$vt_separador+$vt_tc1+$vt_separador+$vt_cd2+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //subcantidades
  //C_TEXT($vt_cd1;$vt_cddls2)
  //$vt_cd1:=""
  //$vt_cddls2:=""
  //$vt_text:="SUB"+$vt_separador+$vt_cd1+$vt_separador+$vt_cddls2+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //Otra moneda
  //C_TEXT($vt_pom1;$vt_com2;$vt_fc3;$vt_dom4;$vt_rom5;$vt_miom6)
  //$vt_pom1:=""
  //$vt_com2:=""
  //$vt_fc3:=""
  //$vt_dom4:=""
  //$vt_rom5:=""
  //$vt_miom6:=""
  //$vt_text:="OMDET"+$vt_separador+$vt_pom1+$vt_separador+$vt_com2+$vt_separador+$vt_fc3+$vt_separador+$vt_dom4+$vt_separador+$vt_rom5+$vt_separador
  //$vt_text:=$vt_text+$vt_miom6+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //  //DESC
  //C_TEXT($vt_tds1;$vt_vds2)
  //$vt_tds1:=""
  //$vt_vds2:=""
  //$vt_text:="DESC"+$vt_separador+$vt_tds1+$vt_separador+$vt_vds2+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //  //Subrecargos
  //C_TEXT($vt_tr1;$vt_vdr2)
  //$vt_tr1:=""
  //$vt_vdr2:=""
  //$vt_text:="CAR"+$vt_separador+$vt_tr1+$vt_separador+$vt_vdr2+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //  //cod impuesto adicional ret
  //C_TEXT($vt_cior1)
  //$vt_cior1:=""
  //$vt_text:="IMPDET"+$vt_separador+$vt_cior1+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //  //subtotales informativos
  //C_TEXT($vt_ns1;$vt_g2;$vt_o3;$vt_sn4;$vt_si5;$vt_siaoe6;$vt_snaoe7;$vt_vs8)
  //$vt_ns1:=""
  //$vt_g2:=""
  //$vt_o3:=""
  //$vt_sn4:=""
  //$vt_si5:=""
  //$vt_siaoe6:=""
  //$vt_snaoe7:=""
  //$vt_vs8:=""
  //$vt_text:="SUBTOT"+$vt_separador+$vt_ns1+$vt_separador+$vt_g2+$vt_separador+$vt_o3+$vt_separador+$vt_sn4+$vt_separador+$vt_si5+$vt_separador
  //$vt_text:=$vt_text+$vt_siaoe6+$vt_separador+$vt_snaoe7+$vt_separador+$vt_vs8+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //  //LINDETSI
  //C_TEXT($vt_nlddsi1)
  //$vt_nlddsi1:=""
  //$vt_text:="LINDETSI"+$vt_separador+$vt_nlddsi1+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text

  //descuentos y recargos globales
C_TEXT:C284($vt_nldr1;$vt_tdm2;$vt_dddor3;$vt_ueqseev4;$vt_vddor5;$vt_vddorom6;$vt_ideofdr7)
C_REAL:C285(vrACTdte_dctoRecargo)
If (vrACTdte_dctoRecargo=0)
	  //$vt_nldr1:=""  //"1"
	  //$vt_tdm2:=""  //"D"
	  //$vt_dddor3:=""
	  //$vt_ueqseev4:=""  //"$"
	  //$vt_vddor5:=""  //String(AT_GetSumArray (->$arACT_ValorDcto))
	  //$vt_vddorom6:=""
	  //$vt_ideofdr7:=""
Else 
	  // una linea para el descuento afecto y otra para el descuento exento
	For ($x;1;2)
		If ($x=1)
			$vr_monto:=vrACTdte_DescuentoAfecto
			  //$vt_indicador:=""
			$vt_indicador:="2"  //20161107 RCH
		Else 
			$vr_monto:=vrACTdte_DescuentoExento
			$vt_indicador:="1"
		End if 
		If ($vr_monto#0)
			$vt_nldr1:="1"
			$vt_tdm2:=ST_Boolean2Str ($vr_monto>0;"R";"D")
			$vt_dddor3:=ST_Boolean2Str ($vr_monto>0;"Recargo global";"Descuento global")
			$vt_ueqseev4:="%"
			  //$vt_vddor5:=String(Abs(vrACTdte_DescuentoAfecto+vrACTdte_DescuentoExento+vrACTdte_DescuentoGlobal))
			$vt_vddor5:=String:C10(Abs:C99($vr_monto))
			$vt_vddorom6:=""
			$vt_ideofdr7:=$vt_indicador
			
			$vt_text:="DESCG"+$vt_separador+$vt_nldr1+$vt_separador+$vt_tdm2+$vt_separador+$vt_dddor3+$vt_separador+$vt_ueqseev4+$vt_separador+$vt_vddor5+$vt_separador
			$vt_text:=$vt_text+$vt_vddorom6+$vt_separador+$vt_ideofdr7+$vt_separador+"\r"
			  //IO_SendPacket ($ref;$vt_text)
			$vt_textFinal:=$vt_textFinal+$vt_text
			
			  //para validacion
			$vr_sumaDetalle:=$vr_sumaDetalle+$vr_monto
		End if 
	End for 
End if 

  //referencias globales
C_LONGINT:C283($vl_recNum;$vl_idDctoRel;$vl_idDcto;$vl_numLinea)
C_DATE:C307($vd_fechaValida)
$vl_recNum:=Record number:C243([ACT_Boletas:181])
$vl_idDctoRel:=[ACT_Boletas:181]ID_DctoAsociado:19
$vd_fechaValida:=KRL_GetDateFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]FechaEmision:3)
$vl_idDcto:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]ID_Documento:13)
$vl_numLinea:=1

C_TEXT:C284($vt_ndldr1;$vt_tddr2;$vt_igdr3;$vt_fdr4;$vt_roc5;$vt_fdr6;$vt_cr7;$vt_rdr8)
If ([ACT_Boletas:181]ID_Estado:20=7)  // 7 set de pruebas
	$vt_ndldr1:=String:C10($vl_numLinea)
	$vt_tddr2:="SET"
	$vt_igdr3:=""
	$vt_fdr4:="1"
	$vt_roc5:=""
	$vd_fecha:=Current date:C33(*)
	$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->$vd_fecha)
	$vt_cr7:=""
	$vt_rdr8:="CASO "+vt_variableCaso
	$vl_numLinea:=$vl_numLinea+1
	
	$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
	$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador+"\r"
	  //IO_SendPacket ($ref;$vt_text)
	$vt_textFinal:=$vt_textFinal+$vt_text
End if 

If ([ACT_Boletas:181]ID_DctoAsociado:19#0)
	$vt_ndldr1:=String:C10($vl_numLinea)
	  //$vt_tddr2:=ACTdte_GeneraArchivo ("FolioDesdeIdBolActual";->$vl_idDcto)
	If ([ACT_Boletas:181]ID_DctoAsociado:19#0)
		$vt_tddr2:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]codigo_SII:33)
		$vt_igdr3:=""
		$vt_fdr4:=String:C10(KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->$vl_idDctoRel;->[ACT_Boletas:181]Numero:11))
		$vt_roc5:=""
		$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->$vd_fechaValida)
		GOTO RECORD:C242([ACT_Boletas:181];$vl_recNum)
		$vt_cr7:=String:C10([ACT_Boletas:181]codigo_referencia:31)
		  //$vt_rdr8:=[ACT_Boletas]Observacion
		$vt_rdr8:=[ACT_Boletas:181]Referencia_Razon:40  //20141007 RCH Cuando se emite una NC se escribe este campo y controla el tamaño maximo.
		If ($vt_rdr8="")
			TRACE:C157
		End if 
	Else 
		$vt_tddr2:=[ACT_Boletas:181]Referencia_TipoDocumento:37
		$vt_igdr3:=""
		$vt_fdr4:=[ACT_Boletas:181]Referencia_FolioDocumento:38
		$vt_roc5:=""
		$vt_fdr6:=ACTdte_GeneraArchivo ("GetFechaValidaDesdeFecha";->[ACT_Boletas:181]Referencia_FechaDocumento:39)
		$vt_cr7:=String:C10([ACT_Boletas:181]codigo_referencia:31)
		$vt_rdr8:=[ACT_Boletas:181]Referencia_Razon:40
	End if 
	
	$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
	$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador+"\r"
	  //IO_SendPacket ($ref;$vt_text)
	$vt_textFinal:=$vt_textFinal+$vt_text
Else 
	  //If ($vl_numLinea=1)
	  //$vt_ndldr1:=""
	  //$vt_tddr2:=""
	  //$vt_igdr3:=""
	  //$vt_fdr4:=""
	  //$vt_roc5:=""
	  //$vt_fdr6:=""
	  //$vt_cr7:=""
	  //$vt_rdr8:=""
	  //
	  //$vt_text:="REF"+$vt_separador+$vt_ndldr1+$vt_separador+$vt_tddr2+$vt_separador+$vt_igdr3+$vt_separador+$vt_fdr4+$vt_separador+$vt_roc5+$vt_separador
	  //$vt_text:=$vt_text+$vt_fdr6+$vt_separador+$vt_cr7+$vt_separador+$vt_rdr8+$vt_separador+"\r"
	  //IO_SendPacket ($ref;$vt_text)
	  //$vt_textFinal:=$vt_textFinal+$vt_text
	  //End if 
End if 

  //  //comisiones y otros cargos
  //C_TEXT($vt_nl1;$vt_tm2;$vt_g3;$vt_tc4;$vt_vcn5;$vt_vce6;$vt_vicuoc7)
  //$vt_nl1:=""
  //$vt_tm2:=""
  //$vt_g3:=""
  //$vt_tc4:=""
  //$vt_vcn5:=""
  //$vt_vce6:=""
  //$vt_vicuoc7:=""
  //$vt_text:="COMOC"+$vt_separador+$vt_nl1+$vt_separador+$vt_tm2+$vt_separador+$vt_g3+$vt_separador+$vt_tc4+$vt_separador+$vt_vcn5+$vt_separador
  //$vt_text:=$vt_text+$vt_vce6+$vt_separador+$vt_vicuoc7+$vt_separador+"\r"
  //IO_SendPacket ($ref;$vt_text)
  //$vt_textFinal:=$vt_textFinal+$vt_text
  //CLOSE DOCUMENT($ref)

If ([ACT_Boletas:181]Monto_Total:6#$vr_sumaDetalle)
	TRACE:C157
	  //DELETE DOCUMENT($vt_retorno)
	$vt_retorno:=""
Else 
	$vt_retorno:=$vt_textFinal
End if 

  //End if 
  //Else 
  //$vt_retorno:=""
  //End if 
$0:=$vt_retorno