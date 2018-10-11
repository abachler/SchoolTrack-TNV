//%attributes = {}
  //SRcust_SetAvisosVariables

dhSR_InitVariables 

_O_ARRAY STRING:C218(255;asSRVariables;0)
_O_ARRAY STRING:C218(255;asSRVariables;1000)  //redimensionar si se necesitan más variables, los elementos en exceso se eliminan después de asignar las variables propias al alumno (SRcust_SetStudentVariables_XX)

AT_Inc (0)
asSRVariables{AT_Inc }:="1;Variables sistema"
asSRVariables{AT_Inc }:="1;Fecha de impresión;sRDate;1"
asSRVariables{AT_Inc }:="1;Hora de impresión;sRTime;1"
asSRVariables{AT_Inc }:="1;Número de página;sRPage;1"
asSRVariables{AT_Inc }:="2;Datos del colegio"
asSRVariables{AT_Inc }:="2;Nombre del colegio;<>gCustom;1"
asSRVariables{AT_Inc }:="2;Director;<>gRector;1"
asSRVariables{AT_Inc }:="2;Dirección;<>gDireccion;1"
asSRVariables{AT_Inc }:="2;Comuna;<>gComuna;1"
asSRVariables{AT_Inc }:="2;Ciudad;<>gCiudad;1"
asSRVariables{AT_Inc }:="2;Provincia;<>gProvincia;1"
asSRVariables{AT_Inc }:="2;Región;<>gRegion;1"
asSRVariables{AT_Inc }:="2;RUT del colegio;<>gRut;1"
asSRVariables{AT_Inc }:="2;Rol de base de datos;<>gRolBD;1"
asSRVariables{AT_Inc }:="2;Año escolar;<>gYear;1"
asSRVariables{AT_Inc }:="2;Representante legal;<>gRepLegalNombre;1"
asSRVariables{AT_Inc }:="2;RUT representante legal;<>gRepLegalRUT;1"
asSRVariables{AT_Inc }:="2;Giro;<>gGiro;1"

If (vlSR_RegXPagina=0)
	vlSR_RegXPagina:=1
End if 
If (vlSR_RegXPagina>1)
	cb_UsarCategorias:=1
End if 
$index:=3
For ($j;1;vlSR_RegXPagina)
	asSRVariables{AT_Inc }:=String:C10($index)+";(-"
	$index:=$index+1
	asSRVariables{AT_Inc }:=String:C10($index)+";Datos del Aviso de Cobranza "+String:C10($j)
	asSRVariables{AT_Inc }:=String:C10($index)+";Número Aviso;vlACT_SRac_IDAviso"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Mes Aviso [Número];vlACT_SRac_MesNum"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Mes Aviso [Texto];vtACT_SRac_MesText"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Año Aviso;vlACT_SRac_AñoAviso"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Fecha Aviso;vdACT_SRac_FechaAviso"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Fecha de Vencimiento;vdACT_SRac_FechaVencimiento"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";2da Fecha de Pago;vdACT_SRac_2FechaPago"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";3ra Fecha de Pago;vdACT_SRac_3FechaPago"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";4ta Fecha de Pago;vdACT_SRac_4FechaPago"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Observaciones;vtACT_SRac_Observaciones"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Exento;vrACT_SRac_MontoExento"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Afecto;vrACT_SRac_MontoAfecto"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto IVA;vrACT_SRac_MontoIVA"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Total;vrACT_SRac_Total"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Total [Texto];vtACT_SRac_TotalText"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto a Pagar;vrACT_SRac_MontoAPagar"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto a Pagar [Texto];vtACT_SRac_MontoAPagarText"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Neto;vrACT_SRac_MontoNeto"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Intereses;vrACT_SRac_Intereses"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Saldo Anterior;vrACT_SRac_SaldoAnterior"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Saldo Anterior Intereses;vrACT_SRac_InteresesAnteriores"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Saldo Anterior Cargos;vrACT_SRac_CargosAnteriores"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Total a la 2da Fecha de Pago;vrACT_SRac_Tot2Fecha"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Total a la 3ra Fecha de Pago;vrACT_SRac_Tot3Fecha"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Total a la 4ta Fecha de Pago;vrACT_SRac_Tot4Fecha"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Montos Pagados;vrACT_SRac_MontoPagado"+String:C10($j)+";1"
	If (<>gCountryCode="mx")
		SRACTacmx_LoadVarsPagosRef ("CargaVariablesModeloInforme";->$index;->$j)
	End if 
	$index:=$index+1
	asSRVariables{AT_Inc }:=String:C10($index)+";Detalle del Aviso "+String:C10($j)
	If (vlSR_RegXPagina=1)
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Glosa;atACT_CGlosaImpresion"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Cuenta Corriente;atACT_CAlumno"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Curso Cuenta Corriente;atACT_CAlumnoCurso"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Nivel Cuenta Corriente;atACT_CAlumnoNivelNombre"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Monto;arACT_CMontoNeto"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Monto en Moneda;atACT_MonedaSimbolo"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Afecto a IVA;asACT_Afecto"+String:C10($j)+";2"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Etiqueta Columna Glosa;vEtiquetaColGlosa;1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Etiqueta Columna Cuentas;vEtiquetaColCta;1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Etiqueta Columna Cursos;vEtiquetaColCurso;1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Etiqueta Columna Niveles;vEtiquetaColNivel;1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Etiqueta Columna Montos;vEtiquetaColMonto;1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Cargos: Etiqueta Columna Afecto a IVA;vEtiquetaColAfecto;1"
	End if 
	If (cb_UsarCategorias=1)
		If (Records in table:C83([xxACT_ItemsCategorias:98])>0)
			READ ONLY:C145([xxACT_ItemsCategorias:98])
			ALL RECORDS:C47([xxACT_ItemsCategorias:98])
			FIRST RECORD:C50([xxACT_ItemsCategorias:98])
			$i:=1
			While (Not:C34(End selection:C36([xxACT_ItemsCategorias:98])))
				asSRVariables{AT_Inc }:=String:C10($index)+";Etiqueta Categoría "+[xxACT_ItemsCategorias:98]Nombre:1+";atACT_NombreCategoria;3;"+String:C10($i)
				asSRVariables{AT_Inc }:=String:C10($index)+";Total Categoría "+[xxACT_ItemsCategorias:98]Nombre:1+";arACT_MontoCategoria"+String:C10($j)+";3;"+String:C10($i)
				$i:=$i+1
				NEXT RECORD:C51([xxACT_ItemsCategorias:98])
			End while 
		Else 
			asSRVariables{AT_Inc }:=String:C10($index)+";(No hay categorías definidas;test;1"
		End if 
	End if 
	$index:=$index+1
	asSRVariables{AT_Inc }:=String:C10($index)+";Datos del Apoderado Aviso "+String:C10($j)
	asSRVariables{AT_Inc }:=String:C10($index)+";Apellidos y Nombres;vtACT_SRac_ApdoNombre"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional;vtACT_SRac_IDNacApdo"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional 2;vtACT_SRac_IDNac2Apdo"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional 3;vtACT_SRac_IDNac3Apdo"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Comuna Envío Correspondencia;vtACT_SRac_ComunaEC"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Ciudad Envío Correspondencia;vtACT_SRac_CiudadEC"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Código postal Envío Correspondencia;vtACT_SRac_CodPostalEC"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Dirección Envío Correspondencia;vtACT_SRac_DirEC"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Dirección Personal;vtACT_SRac_DirPersonal"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Dirección Profesional;vtACT_SRac_DirProfesional"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Email;vtACT_SRac_EmailPersonal"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Códigos de Familia;vtACT_SRac_CodigoFamilias"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Nombres de Familia;vtACT_SRac_NombreFamilias"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Modo de Pago;vtACT_SRac_MododePago"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Saldo Disponible;vrACT_SRac_SaldoApdo"+String:C10($j)+";1"
	
	If (cb_SepararCargosXPct=1)
		$index:=$index+1
		asSRVariables{AT_Inc }:=String:C10($index)+";Datos del Responsable asociado al Aviso "+String:C10($j)
		asSRVariables{AT_Inc }:=String:C10($index)+";Apellidos y Nombres;atACT_SRac_RespNombre"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional;atACT_SRac_IDNacResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional 2;atACT_SRac_IDNac2Resp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional 3;atACT_SRac_IDNac3Resp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Comuna Envío Correspondencia;atACT_SRac_ComunaECResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Ciudad Envío Correspondencia;atACT_SRac_CiudadECResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Código postal Envío Correspondencia;atACT_SRac_CodPostalECResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Dirección Envío Correspondencia;atACT_SRac_DirECResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Dirección Personal;atACT_SRac_DirPersonalResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Dirección Profesional;atACT_SRac_DirProfesionalResp"+String:C10($j)+";1"
		asSRVariables{AT_Inc }:=String:C10($index)+";Email;atACT_SRac_EmailPersonalResp"+String:C10($j)+";1"
	End if 
	
	$index:=$index+1
	asSRVariables{AT_Inc }:=String:C10($index)+";Cuenta Corriente Aviso "+String:C10($j)+" [Sólo si fue emitido por cta. cte.]"
	asSRVariables{AT_Inc }:=String:C10($index)+";Apellidos y Nombres;vtACT_SRac_NombreCta"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Identificador Nacional;vtACT_SRac_IDNacCta"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Nivel;vtACT_SRac_NivelCta"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Curso;vtACT_SRac_CursoCta"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Código;vtACT_SRac_CodigoCta"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Saldo Disponible;vrACT_SRac_SaldoCta"+String:C10($j)+";1"
	$index:=$index+1
	asSRVariables{AT_Inc }:=String:C10($index)+";Datos del Dcto Tributario"+String:C10($j)+" [Sólo si fue emitido por avisos]"
	asSRVariables{AT_Inc }:=String:C10($index)+";Número Documento Tributario;vtACT_SRac_IDDT"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Estado Documento Tributario;vtACT_SRac_EstadoDT"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Fecha de Emisión;vtACT_SRac_FechaEmisionDT"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Emitido Por;vtACT_SRac_EmitidoPor"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Afecto;vtACT_SRac_Afecto"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto IVA;vtACT_SRac_IVA"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Total;vtACT_SRac_TotalDT"+String:C10($j)+";1"
	asSRVariables{AT_Inc }:=String:C10($index)+";Monto Total Texto;vtACT_SRac_TotalTextDT"+String:C10($j)+";1"
	$index:=$index+1
End for 

For ($i;Size of array:C274(asSRVariables);1;-1)
	If (asSRVariables{$i}="")
		DELETE FROM ARRAY:C228(asSRVariables;$i;1)
	End if 
End for 

$err:=SR Variables (xReportData;"asSRVariables")