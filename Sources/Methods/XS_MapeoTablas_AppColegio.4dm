//%attributes = {}
  // XS_MapeoTablas_AppColegio()
  // Por: Alberto Bachler K.: 29-08-14, 12:41:07
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283(<>lApplicationCustomerTable)

<>lApplicationCustomerTable:=Table:C252(->[Colegio:31])


ARRAY POINTER:C280(<>aXS_DLTable;0)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]ID_Organizacion:17)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Código_Pais:26)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Razon_Social:21)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Denominacion_Fantasia:28)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Representante_Legal:22)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Direccion:2)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Comuna:3)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Ciudad:4)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Codigo_Postal:6)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Provincia_o_Distrito:5)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Pais:25)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Telefono:7)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Fax:8)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Email:20)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]WebSite:24)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Logo:9)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Región:27)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Giro:29)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]Moneda:30)
APPEND TO ARRAY:C911(<>aXS_DLTable;->[xShell_ApplicationData:45]UUID:31)

ARRAY POINTER:C280(<>aApplicationTableLinks;0)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Rol Base Datos:9)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Codigo_Pais:31)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]RazonSocial:38)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Nombre_Colegio:1)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]RepresentanteLegal_Nombre:39)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Administracion_Direccion:41)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Administracion_Comuna:42)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Administracion_Ciudad:43)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]CodigoPostal:24)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Provincia:5)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Pais:21)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Administracion_Telefono:45)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Administracion_Fax:46)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Administracion_EMail:47)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]webSite:26)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Logo:37)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Region:14)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Giro:48)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]Moneda:49)
APPEND TO ARRAY:C911(<>aApplicationTableLinks;->[Colegio:31]UUID:58)



