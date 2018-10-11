//%attributes = {}
  //ACTfdp_CargaFormasDePago

C_LONGINT:C283($vl_formasColegio;$vl_formasDePagoXDef)
ARRAY TEXT:C222(<>atACT_FormasDePago2D;0;0)

READ ONLY:C145([ACT_Formas_de_Pago:287])
QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1>0)
  //$vl_formasDePagoXDef:=15
  //$vl_formasDePagoXDef:=16
  //$vl_formasDePagoXDef:=17
  //$vl_formasDePagoXDef:=18
  //$vl_formasDePagoXDef:=19
$vl_formasDePagoXDef:=20  //20170526 RCH Se agrega Servipag
$vl_formasColegio:=Records in selection:C76([ACT_Formas_de_Pago:287])

ARRAY TEXT:C222(<>atACT_FormasDePago2D;7;$vl_formasDePagoXDef+$vl_formasColegio)

<>atACT_FormasDePago2D{1}{1}:="-2"
<>atACT_FormasDePago2D{2}{1}:="En el colegio"
<>atACT_FormasDePago2D{3}{1}:=__ ("En el colegio")
<>atACT_FormasDePago2D{4}{1}:=""
<>atACT_FormasDePago2D{5}{1}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{1}:="0"  // visible en conf
<>atACT_FormasDePago2D{7}{1}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{2}:="-3"
<>atACT_FormasDePago2D{2}{2}:="Efectivo"
<>atACT_FormasDePago2D{3}{2}:=__ ("Efectivo")
<>atACT_FormasDePago2D{4}{2}:="EF"
<>atACT_FormasDePago2D{5}{2}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{2}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{2}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{3}:="-4"
<>atACT_FormasDePago2D{2}{3}:="Cheque"
<>atACT_FormasDePago2D{3}{3}:=__ ("Cheque")
<>atACT_FormasDePago2D{4}{3}:="CH"
<>atACT_FormasDePago2D{5}{3}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{3}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{3}:="Al día"  // estado por defecto

  // se paso a estado del cheque
  //<>atACT_FormasDePago2D{1}{4}:="-5"
  //<>atACT_FormasDePago2D{2}{4}:="Cheque a fecha"
  //<>atACT_FormasDePago2D{3}{4}:=__ ("Cheque a fecha")
  //<>atACT_FormasDePago2D{4}{4}:="CHF"
  //<>atACT_FormasDePago2D{5}{4}:="0"  // permite ingreso de pago
  //<>atACT_FormasDePago2D{6}{4}:="1"  // visible en conf

<>atACT_FormasDePago2D{1}{5}:="-6"
<>atACT_FormasDePago2D{2}{5}:="Tarjeta de Crédito"
<>atACT_FormasDePago2D{3}{5}:=__ ("Tarjeta de Crédito")
<>atACT_FormasDePago2D{4}{5}:="TC"
<>atACT_FormasDePago2D{5}{5}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{5}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{5}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{6}:="-7"
<>atACT_FormasDePago2D{2}{6}:="Tarjeta de Débito"
<>atACT_FormasDePago2D{3}{6}:=__ ("Tarjeta de Débito")
<>atACT_FormasDePago2D{4}{6}:="TD"
<>atACT_FormasDePago2D{5}{6}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{6}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{6}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{7}:="-8"
<>atACT_FormasDePago2D{2}{7}:="Letra"
<>atACT_FormasDePago2D{3}{7}:=__ ("Letra")
<>atACT_FormasDePago2D{4}{7}:="LT"
<>atACT_FormasDePago2D{5}{7}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{7}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{7}:="Aceptada|0"  // estado por defecto

<>atACT_FormasDePago2D{1}{8}:="-9"
<>atACT_FormasDePago2D{2}{8}:="PAT"
<>atACT_FormasDePago2D{3}{8}:=__ ("PAT")
<>atACT_FormasDePago2D{4}{8}:="TCA"
<>atACT_FormasDePago2D{5}{8}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{8}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{8}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{9}:="-10"
<>atACT_FormasDePago2D{2}{9}:="PAC"
<>atACT_FormasDePago2D{3}{9}:=__ ("PAC")
<>atACT_FormasDePago2D{4}{9}:="TDA"
<>atACT_FormasDePago2D{5}{9}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{9}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{9}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{10}:="-11"
<>atACT_FormasDePago2D{2}{10}:="Cuponera"
<>atACT_FormasDePago2D{3}{10}:=__ ("Cuponera")
<>atACT_FormasDePago2D{4}{10}:="CU"
<>atACT_FormasDePago2D{5}{10}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{10}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{10}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{11}:="-12"
<>atACT_FormasDePago2D{2}{11}:="Nota de Crédito"
<>atACT_FormasDePago2D{3}{11}:=__ ("Nota de Crédito")
<>atACT_FormasDePago2D{4}{11}:="NC"
<>atACT_FormasDePago2D{5}{11}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{11}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{11}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{12}:="-13"
<>atACT_FormasDePago2D{2}{12}:="Transferencia Bancaria"
<>atACT_FormasDePago2D{3}{12}:=__ ("Transferencia Bancaria")
<>atACT_FormasDePago2D{4}{12}:="TF"
<>atACT_FormasDePago2D{5}{12}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{12}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{12}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{13}:="-14"
<>atACT_FormasDePago2D{2}{13}:="Depósito"
<>atACT_FormasDePago2D{3}{13}:=__ ("Depósito")
<>atACT_FormasDePago2D{4}{13}:="DE"
<>atACT_FormasDePago2D{5}{13}:="1"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{13}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{13}:=""  // estado por defecto

<>atACT_FormasDePago2D{1}{14}:="-15"
<>atACT_FormasDePago2D{2}{14}:="Por caja"
<>atACT_FormasDePago2D{3}{14}:=__ ("Por caja")
<>atACT_FormasDePago2D{4}{14}:=""
<>atACT_FormasDePago2D{5}{14}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{14}:="0"  // visible en conf
<>atACT_FormasDePago2D{7}{14}:=""  // estado por defecto

  // se agregan los pagares a esta tabla para utilizar la tabla con estados de las formas de pago
<>atACT_FormasDePago2D{1}{15}:="-16"
<>atACT_FormasDePago2D{2}{15}:="Pagarés"
<>atACT_FormasDePago2D{3}{15}:=__ ("Pagarés")
<>atACT_FormasDePago2D{4}{15}:=""
<>atACT_FormasDePago2D{5}{15}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{15}:="0"  // visible en conf
<>atACT_FormasDePago2D{7}{15}:="Vigente|-103"  // estado por defecto

  //20121124 RCH se agrega la "contabilidad" para los archivos de transferencia
<>atACT_FormasDePago2D{1}{16}:="-17"
<>atACT_FormasDePago2D{2}{16}:="Contabilidad"
<>atACT_FormasDePago2D{3}{16}:=__ ("Contabilidad")
<>atACT_FormasDePago2D{4}{16}:=""
<>atACT_FormasDePago2D{5}{16}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{16}:="0"  // visible en conf
<>atACT_FormasDePago2D{7}{16}:=""  // estado por defecto

  //20130809 RCH
<>atACT_FormasDePago2D{1}{17}:="-18"
<>atACT_FormasDePago2D{2}{17}:="Webpay"
<>atACT_FormasDePago2D{3}{17}:=__ ("Webpay")
<>atACT_FormasDePago2D{4}{17}:=""
<>atACT_FormasDePago2D{5}{17}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{17}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{17}:=""  // estado por defecto

  //20141006 RCH
<>atACT_FormasDePago2D{1}{18}:="-19"
<>atACT_FormasDePago2D{2}{18}:="Pago Web"
<>atACT_FormasDePago2D{3}{18}:=__ ("Pago Web")
<>atACT_FormasDePago2D{4}{18}:=""
<>atACT_FormasDePago2D{5}{18}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{18}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{18}:=""  // estado por defecto

  //20160119 ASM
<>atACT_FormasDePago2D{1}{19}:="-20"
<>atACT_FormasDePago2D{2}{19}:="Pago en línea - Payworks"
<>atACT_FormasDePago2D{3}{19}:=__ ("Pago en línea - Payworks")
<>atACT_FormasDePago2D{4}{19}:=""
<>atACT_FormasDePago2D{5}{19}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{19}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{19}:=""  // estado por defecto

  //20170526 RCH
<>atACT_FormasDePago2D{1}{20}:="-21"
<>atACT_FormasDePago2D{2}{20}:="Servipag"
<>atACT_FormasDePago2D{3}{20}:=__ ("Servipag")
<>atACT_FormasDePago2D{4}{20}:=""
<>atACT_FormasDePago2D{5}{20}:="0"  // permite ingreso de pago
<>atACT_FormasDePago2D{6}{20}:="1"  // visible en conf
<>atACT_FormasDePago2D{7}{20}:=""  // estado por defecto

$vl_formasDePagoXDef:=$vl_formasDePagoXDef+1
READ ONLY:C145([ACT_Formas_de_Pago:287])
QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1>0)
ORDER BY:C49([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;>)
While (Not:C34(End selection:C36([ACT_Formas_de_Pago:287])))
	<>atACT_FormasDePago2D{1}{$vl_formasDePagoXDef}:=String:C10([ACT_Formas_de_Pago:287]id:1)
	<>atACT_FormasDePago2D{2}{$vl_formasDePagoXDef}:=[ACT_Formas_de_Pago:287]forma_de_pago_old:2
	<>atACT_FormasDePago2D{3}{$vl_formasDePagoXDef}:=[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9
	<>atACT_FormasDePago2D{4}{$vl_formasDePagoXDef}:=[ACT_Formas_de_Pago:287]codigo_ingreso:3
	<>atACT_FormasDePago2D{5}{$vl_formasDePagoXDef}:=String:C10(Num:C11([ACT_Formas_de_Pago:287]permite_ingreso_pago:11))  // permite ingreso de pago
	<>atACT_FormasDePago2D{6}{$vl_formasDePagoXDef}:=String:C10(Num:C11([ACT_Formas_de_Pago:287]visible_en_conf:12))  // visible en conf
	<>atACT_FormasDePago2D{7}{$vl_formasDePagoXDef}:=[ACT_Formas_de_Pago:287]estado:13  // estado por defecto
	NEXT RECORD:C51([ACT_Formas_de_Pago:287])
	$vl_formasDePagoXDef:=$vl_formasDePagoXDef+1
End while 

$size:=Size of array:C274(<>atACT_FormasDePago2D)
$size2:=Size of array:C274(<>atACT_FormasDePago2D{1})