#!/bin/bash

ip=$(hostname -I | cut -d ' ' -f '1')

# Borramos el log anterior
archivos/person2.lst


# Lanzamos el script
sqlplus person/person@$ip/asir<<EOF
spool archivos/person2
select * from pruebas;
EOF

echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>archivos/person1.lst
echo "        TRAS LA INSERCIÓN DE LOS NUEVOS DATOS FANTASMAS      ">>archivos/person1.lst
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst
echo "+++++          ++++++++++        +++++++++++        +++++++++">>archivos/person1.lst
echo "++++++        ++++++++++++      +++++++++++++      ++++++++++">>archivos/person1.lst
echo "++++++++    +++++++++++++++    +++++++++++++++    +++++++++++">>archivos/person1.lst
echo "+++++++++  +++++++++++++++++  +++++++++++++++++  ++++++++++++">>archivos/person1.lst

# Añadimos el contenido a person1.lst
cat archivos/person2.lst >> archivos/person1.lst
sleep 5
rm archivos/person2.lst