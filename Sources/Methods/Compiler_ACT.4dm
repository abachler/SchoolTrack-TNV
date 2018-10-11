//%attributes = {}
  //Compiler_ACT

C_LONGINT:C283(hl_TramosIngreso)
C_BOOLEAN:C305(vbACT_EmisionMasivaBoletas;<>vbACT_NoCCTrigger)
C_REAL:C285(<>vrACT_TasaIVA;<>vrACT_FactorIVA;<>vrACT_TasaInterés;<>vrACT_MultaRetardo)
C_TEXT:C284(vtACT_BancoID;vtACT_BancoNombre;vtACT_BancoAgencia;vtACT_BancoCuenta;vtACT_BancoRutTitular;vtACT_BancoTitular;vtACT_TCTipo;vtACT_TCBanco;vtACT_TCNumero;vtACT_TCCodigo;vtACT_TCRutTitular;vtACT_TCTitular;vtACT_TCMesVencimiento;vtACT_TCAgnoVencimiento;vtACT_TDCodigo)
C_TEXT:C284(<>vsACT_Direccion;<>vsACT_Comuna;<>vsACT_Ciudad;<>vsACT_CPostal;<>vsACT_Telefono;<>vsACT_Fax;<>vsACT_Email;<>vsACT_RepLegal;<>vsACT_RazonSocial)
_O_C_STRING:C293(80;<>vsACT_RUTRepLegal;<>vsACT_RUT)
C_LONGINT:C283(cb_GenerarAvisoAuto;bBoletasAgregadas;cb_BoletaPorItem;bAvisoApoderado;bAvisoAlumno;fFechaPago;fFechaRegistro;cb_GenerarBoletaCaja;cb_SeqBoletaPorUsuario)
C_LONGINT:C283(cb_GenerarDeudaAuto;dDeudaTodo;dDeudaMes;mMesComenzado;mMesVencido;viACT_DiaDeuda;viACT_DiaVencimiento;viACT_DiasRetardo)
C_TEXT:C284(vs_labelDiaDeuda)
C_LONGINT:C283(gGroupByFamily;gGroupByGardian;oOrderbyBirthDate;oOrderByClass;nOrdenAscendiente;cbUsarDescuentosFamilia;nOrdenDescendiente;cbUsarDescuentosIngresos)
C_REAL:C285(vr_Hijo1;vr_Hijo2;vr_Hijo3;vr_Hijo4;vr_Hijo5;vr_Hijo6;vr_Hijo7;vr_Hijo8;vr_Hijo9;vr_Hijo10;vr_Hijo11;vr_Hijo12;vr_Hijo13;vr_Hijo14;vr_Hijo15;vr_Hijo16;vr_Hijo17)
C_REAL:C285(vr_Tramo1;vr_Tramo2;vr_Tramo3;vr_Tramo4;vr_Tramo5;vr_Tramo6;vr_Tramo7;vr_Tramo8;vr_Tramo9;vr_Tramo10;vr_Tramo11;vr_Tramo12;vr_Tramo13;vr_Tramo14;vr_Tramo15;vr_Tramo16)
C_REAL:C285(<>vrACT_FactorIVA;<>vrACT_TasaIVA;<>vrACT_TasaInterés;<>vrACT_MultaRetardo)
C_DATE:C307(<>vdACT_InicioEjercicio;<>vdACT_TerminoEjercicio)
ARRAY REAL:C219(arACT_ValorUFstored;0)
ARRAY REAL:C219(arACT_ValorUF;0)
ARRAY REAL:C219(arACT_VariacionIPC;0)
ARRAY REAL:C219(arACT_UFReferencia;0)
ARRAY INTEGER:C220(aiACT_YearIPC;0)
ARRAY TEXT:C222(atACT_MesIPC;0)
ARRAY TEXT:C222(atACT_TipoTarjeta;0)
ARRAY TEXT:C222(atACT_NombreMoneda;0)
ARRAY REAL:C219(arACT_ValorMoneda;0)
ARRAY TEXT:C222(<>atACT_FreqFacturacion;0)
ARRAY REAL:C219(<>arACT_FreqDescuento;0)
ARRAY TEXT:C222(atACT_BankID;0)
ARRAY TEXT:C222(atACT_BankName;0)
ARRAY LONGINT:C221(aLong1;0)

  //Arreglos para config de docs tributarios
ARRAY TEXT:C222(atACT_Categorias;0)
ARRAY PICTURE:C279(apACT_ReqDatos;0)
ARRAY BOOLEAN:C223(abACT_ReqDatos;0)
ARRAY LONGINT:C221(alACT_IDsCats;0)
ARRAY TEXT:C222(atACT_Cats;0)
ARRAY TEXT:C222(atACT_NombreDoc;0)
ARRAY TEXT:C222(atACT_Tipo;0)
ARRAY PICTURE:C279(apACT_Afecta;0)
ARRAY LONGINT:C221(alACT_Proxima;0)
ARRAY TEXT:C222(atACT_Impresora;0)
ARRAY TEXT:C222(atACT_ModeloDoc;0)
ARRAY LONGINT:C221(alACT_IDDT;0)
ARRAY LONGINT:C221(alACT_IDCat;0)
ARRAY BOOLEAN:C223(abACT_Afecta;0)
ARRAY BOOLEAN:C223(abACT_PorDefecto;0)
ARRAY PICTURE:C279(apACT_PorDefecto;0)

C_LONGINT:C283(vlACT_Milisegundos)