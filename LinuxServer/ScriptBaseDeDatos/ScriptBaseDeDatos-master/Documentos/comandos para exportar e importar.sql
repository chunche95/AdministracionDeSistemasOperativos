
create directory midirectorio as '/home/alumno/backups';
 expdp multas/multas directory=midirectorio schemas=multas dumpfile=multas.dmp logfile=multas.log
 impdp multas/multas directory=midirectorio schemas=multas dumpfile=multas.dmp logfile=multas.log

expdp BERMUDEZ/6977@10.1.35.211/asir directory=/importar-exportar/BERMUDEZ dumpfile=exportacion-1-bermudez.dmp logfile=exportacion-1-bermudez.log

impdp BERMUDEZ/6977 directory=/importar-exportar/BERMUDEZ schemas=bermudez dumpfile=multas.dmp logfile=multas.log
