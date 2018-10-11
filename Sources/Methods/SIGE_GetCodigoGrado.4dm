//%attributes = {}
  //SIGE_GetCodigoGrado 
C_LONGINT:C283($1;$2;$0;$cod_enseñanza;$codigo_grado)

$cod_enseñanza:=$1
$nonivel:=$2

Case of 
	: ($cod_enseñanza=10)  //Educación Parvularia
		$cod_enseñanza:=$nonivel+6
	: ($cod_enseñanza=110)  //Enseñanza Básica
		$cod_enseñanza:=$nonivel
	: ($cod_enseñanza=310)  //Enseñanza Media Humanista-Científica niños y jóvenes
		
End case 
