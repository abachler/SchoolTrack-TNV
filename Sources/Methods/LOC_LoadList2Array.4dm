//%attributes = {}
  // LOC_LoadList2Array()
  // Por: Alberto Bachler K.: 07-08-15, 20:05:20
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)
C_POINTER:C301($2)

C_LONGINT:C283($i)
C_POINTER:C301($y_arreglo)
C_TEXT:C284($t_nombreLista)


If (False:C215)
	C_TEXT:C284(LOC_LoadList2Array ;$1)
	C_POINTER:C301(LOC_LoadList2Array ;$2)
End if 

$t_nombreLista:=$1
$y_arreglo:=$2

AT_Initialize ($y_arreglo)
Case of 
	: ($t_nombreLista="XS_Meses")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Enero"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Febrero"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Marzo"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Abril"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Mayo"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Junio"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Julio"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Agosto"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Septiembre"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Octubre"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Noviembre"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Diciembre"))
		
	: ($t_nombreLista="ACT_Hijos")
		For ($i;2;17)
			APPEND TO ARRAY:C911($y_arreglo->;"Hijo "+String:C10($i))
		End for 
		
	: ($t_nombreLista="ACT_Tramos")
		For ($i;1;16)
			APPEND TO ARRAY:C911($y_arreglo->;"Tramo "+String:C10($i))
		End for 
		
	: ($t_nombreLista="ACT_Cargas")
		For ($i;2;17)
			APPEND TO ARRAY:C911($y_arreglo->;ST_Num2Text ($i;False:C215;False:C215))
		End for 
		
	: ($t_nombreLista="ACT_FormasdePago")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Efectivo"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Cheque"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Tarjeta de crédito"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Tarjeta de débito"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Letra"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("PAC"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("PAT"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Cuponera"))
		
	: ($t_nombreLista="ACT_TramosIngreso")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("No informado"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Inferior a 100 mil"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Entre 101 mil y 150 mil"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Entre 151 mil y 200 mil"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Entre 201 mil y 300 mil"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Entre 301 mil y 400 mil"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Entre 401 mil y 600 mil"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Entre 601 mil y 1 millón"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Más de un millón"))
		
		
	: ($t_nombreLista="STR_VariablesEstadisticas")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Media"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Desviación standard"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Varianza"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Min"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Max"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Rango"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Coeficiente de varianza"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Valores significativos"))
		
	: ($t_nombreLista="STR_Interlocutores")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Alumno"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Apoderado"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Profesor Jefe"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Director(a) o Rector(a)"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Otro profesor"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Otra persona"))
		
	: ($t_nombreLista="XS_NombreDiasSemana")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Lunes"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Martes"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Miércoles"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Jueves"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Viernes"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Sábado"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Domingo"))
		
		
	: ($t_nombreLista="ACT_InformesEspeciales")
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Morosidad General;ACTmnu_InformesMorosidad"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Morosidad Detallado;ACTcc_InformeDeudores"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Morosidad Simple;ACTcc_InformeMorosidadSimple"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Emisión;ACTmnu_InformeFacturacion"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Libro de Ingresos;ACTmnu_LibroVentas"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Pagos por Cargo;ACTcc_InformePagados"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Pagos por Alumno;ACTmnu_InformeIngresosXAl"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Libro de Ventas Especial (hoja carta);ACTmnu_LibroVentasSub"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Listado de Pagos Detallados por Cargos;ACT_FiltroListadoDetalladoPagos"))
		APPEND TO ARRAY:C911($y_arreglo->;__ ("Informe de Pagos Anticipados;ACT_FiltroInformePagosAnticipad"))
		
End case 

  //APPEND TO ARRAY($y_arreglo->;__ (""))


