﻿function mostrarMenu 
{ 
     param ( 
           [string]$Titulo = 'Opciones del Menu' 
     ) 
     cls 
     Write-Host "================ $Titulo================" 
      
     
     Write-Host "1) Primera Opción" 
     Write-Host "2) Segunda Opción" 
     Write-Host "3) Tercera Opción" 
     Write-Host "S) Presiona 'S' para salir" 
}

do 
{ 
     mostrarMenu 
     $input = Read-Host "Elegir una Opción" 
     switch ($input) 
     { 
           '1' { 
                cls 
                'Primera Opción' 
           } '2' { 
                cls 
                'Segunda Opción' 
           } '3' { 
                cls 
                'Tercera Opción' 
           } 's' { 
                return 
           }  
     } 
     pause 
} 
until ($input -eq 's')