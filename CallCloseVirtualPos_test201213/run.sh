#!/usr/bin/bash
#consultar fecha minima y maxima
strconex=boton_pago/digitel412@bus412_desa
out1=`sqlplus -s $strconex @/appsintdev/digitel/applications/CallCloseVirtualPos/fechas.sql`

arch=newfile.txt
strconex=boton_pago/digitel412@cfglobd07:1521:dbdesa
if [ -f /appsintdev/digitel/applications/CallCloseVirtualPos/$arch ]
then
	rm /appsintdev/digitel/applications/CallCloseVirtualPos/$arch
fi

echo $out1 | while read a
do
	echo $a | cut -d'|' -f1 >> /appsintdev/digitel/applications/CallCloseVirtualPos/$arch
	echo $a | cut -d'|' -f2 >> /appsintdev/digitel/applications/CallCloseVirtualPos/$arch
done

fechai=`head -n 1 /appsintdev/digitel/applications/CallCloseVirtualPos/$arch`
fechaf=`tail -1 /appsintdev/digitel/applications/CallCloseVirtualPos/$arch`

#echo $fechai
#echo $fechaf
#echo /servwebdev/jdk1.6.0_25/bin/java -jar /appsintdev/digitel/applications/CallCloseVirtualPos/CallCloseVirtualPos.jar $fechai $fechaf

rm /appsintdev/digitel/applications/CallCloseVirtualPos/$arch


#Comando para ejecutar el jar
out2=`/servwebdev/jdk1.6.0_25/bin/java -jar /appsintdev/digitel/applications/CallCloseVirtualPos/CallCloseVirtualPos.jar $fechai $fechaf`

echo $out2

if [ $out2 != 0 ]
then
	echo hay error	
	exit 1
else
	echo no hay error
	exit 0
fi