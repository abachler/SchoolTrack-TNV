ACTcfg_OpcionesListaMatrices ("Guardar")

$b_asignarMatriz:=False:C215
C_TEXT:C284($t_set)
$t_set:="cuentasActivas"
READ ONLY:C145([ACT_CuentasCorrientes:175])
QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Estado:4=True:C214)
CREATE SET:C116([ACT_CuentasCorrientes:175];$t_set)

READ ONLY:C145([ACT_MatricesAsignacionAut:289])
QUERY:C277([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]Inactiva:5=False:C215)
ORDER BY:C49([ACT_MatricesAsignacionAut:289];[ACT_MatricesAsignacionAut:289]orden:6;>)

REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
ACTcfg_OpcionesListaMatrices ("AplicaMatrices";->$b_asignarMatriz)

CREATE SET:C116([ACT_CuentasCorrientes:175];"cuentasAfectadas")

DIFFERENCE:C122($t_set;"cuentasAfectadas";"cuentasNoAfectadas")
USE SET:C118("cuentasNoAfectadas")

ACTcfg_OpcionesListaMatrices ("MuestraAlumnos";->$t_set)

SET_ClearSets ($t_set;"cuentasAfectadas";"cuentasNoAfectadas")


