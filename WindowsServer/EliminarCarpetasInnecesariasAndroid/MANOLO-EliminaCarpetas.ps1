function eliminar(){
    Clear-Host
    # Localizacion actual del ejecutable
    $dir=Get-Location 
    # Impresion de la direccion actual
    Write-Host "Carpeta de trabajo: $dir"
        # Elimina de forma recursiva las carpetas solicitadas en todas las subcarpetas existentes en 
        # la direccion actual donde ejecutamos el PS1.
        Remove-Item -Path "*\.idea" -Recurse -Force
        # Para ver que todo se va haciendo, solicitamos que escriba por pantalla cuando termine de 
        # borrar las carpetas.
        Write-Host "Borrando .IDEA de TODOS los ficheros" -foregroundcolor green
        Remove-Item -Path "*\.gradle" -Recurse -Force
        Write-Host "Borrando .GRADLE de TODOS los ficheros" -foregroundcolor green
        Remove-Item -Path "*\build" -Recurse -Force
        Write-Host "Borrando BUILD de TODOS los ficheros" -foregroundcolor green
        Remove-Item -Path "*\app\build" -Recurse -Force
        Write-Host "Borrando BUILD de la carpeta AAP de TODOS los ficheros" -foregroundcolor green
 
    # Si por un casual tenemos en el directorio actual las carpetas que buscamos para eliminar,
    # también las elimina, si ya no han sido borradas previamente
    Remove-Item -Path ".idea" -recurse
    Write-Host "\.idea -- ELIMINADO DEL SISTEMA" -foregroundcolor green
    Remove-Item -Path ".gradle" -recurse
    Write-Host "\.gradle -- ELIMINADO DEL SISTEMA" -foregroundcolor green
    Remove-Item -Path "\app\build" -recurse
    Write-Host "\app\build -- ELIMINADO DEL SISTEMA" -foregroundcolor green
    Remove-Item -Path "\build" -recurse
    Write-Host "\build -- ELIMINADO DEL SISTEMA" -foregroundcolor green
    pause
}
function salir(){ # Mensaje que aparece al terminar el ejecutable
    Clear-Host
    write-host "Saliendo del menu del administrador ..."
    pause
    exit
}

do { # Breve mensaje descriptivo del funcionamiento del programa
Write-Host "-----------------------------------"
Write-Host "|         Descripción:            |"
Write-Host "-----------------------------------"
Write-Host "                                   "
Write-Host "  Script que elimina las carpetas: "
Write-Host "   > \.idea                        "
Write-Host "   > \.gradle                      "
Write-Host "   > \app\build                    "
Write-Host "   > \build                        "
Write-Host "-----------------------------------"
$confirmar= Read-Host "Pulse C para confirmar o S para salir" # Solicitamos confirmacion antes de hacer nada
Write-Host ""

Switch( $confirmar ){
    C { eliminar }
    c { eliminar }
    s { salir }
    S { salir }
    default { write-host "Por favor, elige una opcion correcta" -foregroundcolor red }
}
pause
} until ( $confirmar -eq "s" )
