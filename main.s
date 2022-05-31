/**
* Universidad del Valle de Guatemala
* Laboratorio 10 - Organización de computadoras y Assembler
* "Corrimiento de bits activos" Temario 1
* Carnets: 21242, 21096, 20289
**/ 

// Desarrollar un programa en assembler ARM, generar la secuencia mostrada en la siguiente figura por medio
// del control de puertos GPIO. El cambio de estado se realizará cada 1.5 segundos.

// Figura:
// 1 - (1, 2) - 3 - (3, 4) - 5 - (5, 6) - 7 - (7, 8)

.data
.balign 4

    error: .asciz "Se ha producido un error.\n"
    mensaje: .asciz "Ingresa una tecla. \n"
    mensaje2: .asciz "Esperando al boton \n"
    mensaje3: .asciz "Ultimo jugador: \n"
    key: .asciz "n"
    key2: .asciz "n"
    formato: .asciz "%s"
    puntuacionTecla: .word 0
    puntuacionBoton: .word 0

    ultimoJugador: .asciz "jugador0"
    jugador1: .asciz "jugador1"
    jugador2: .asciz "jugador2"

    e1: .int 1
    e2: .int 2
    e3: .int 3
    e4: .int 4
    e5: .int 5
    e6: .int 6
    e7: .int 7
    e8: .int 8

    estadoactual: .int 1



.text
    .global main
    .extern wiringPiSetup
    .extern pinMode
    .extern digitalWrite
    .extern digitalRead
    .extern delay


main:   push 	{ip, lr}
    bl wiringPiSetup
    mov r1, #-1
    cmp r0, r1
    bne init

    ldr r0, =error
    bl printf
    b end

init:

    // GPIO 0 | wPi - 0 | primer bit
    // GPIO 1 | wPi - 1 | segundo bit
    // GPIO 2 | wPi - 2 | tercer bit
    // GPIO 3 | wPi - 3 | cuarto bit
    // GPIO 4 | wPi - 4 | quinto bit
    // GPIO 5 | wPi - 5 | sexto bit
    // GPIO 6 | wPi - 6 | septimo bit
    // GPIO 7 | wPi - 7 | octavo bit
    // GPIO 21| wPi - 21| INPUT
    // GPIO 25| wPi - 25| INPUT

    mov r0, #0 // as output
    mov r1, #1
    bl pinMode

    mov r0, #1
    mov r1, #1
    bl pinMode

    mov r0, #2
    mov r1, #1
    bl pinMode

    mov r0, #3
    mov r1, #1
    bl pinMode

    mov r0, #4
    mov r1, #1
    bl pinMode

    mov r0, #5
    mov r1, #1
    bl pinMode

    mov r0, #6
    mov r1, #1
    bl pinMode

    mov r0, #7
    mov r1, #1
    bl pinMode

    mov r0, #21 // as input
    mov r1, #0
    bl pinMode

    mov r0, #25 
    mov r1, #0
    bl pinMode


    // esperar cambio de estado
    bl myLoopTecla
    mov r0, #1500
    bl delay

    estado1:
        // primer estado
        mov r0, #0 // wpi 0 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e2
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay

    estado2:

        // segundo estado
        mov r0, #1 // wpi 1 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e3
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]


        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay

    estado3:

        // tercer estado
        mov r0, #0 // wpi 0 "off"
        mov r1, #0
        bl digitalWrite

        mov r0, #1 // wpi 1 "off"
        mov r1, #0
        bl digitalWrite

        mov r0, #2 // wpi 2 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e4
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay

    estado4:
        // cuarto estado
        mov r0, #3 // wpi 3 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e5
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]


        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay

        
    estado5:
        // quinto estado
        mov r0, #2 // wpi 2 "off"
        mov r1, #0
        bl digitalWrite

        mov r0, #3 // wpi 3 "off"
        mov r1, #0
        bl digitalWrite

        mov r0, #4 // wpi 4 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e6
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay

    estado6:
        // sexto estado
        mov r0, #5 // wpi 5 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e7
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay

    estado7:
        
        // septimo estado
        mov r0, #4 // wpi 4 "off"
        mov r1, #0
        bl digitalWrite

        mov r0, #5 // wpi 5 "off"
        mov r1, #0
        bl digitalWrite

        mov r0, #6 // wpi 6 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e8
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        // esperar cambio de estado
        bl myLoopTecla
        mov r0, #1500
        bl delay
    
    estado8:
        // octavo estado
        mov r0, #7 // wpi 7 "on"
        mov r1, #1
        bl digitalWrite

        // cargar siguiente estado en estado actual
        ldr r0, =e1
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

    
    finJuego:
        ldr r0, =mensaje3
        bl printf

        ldr r0, =ultimoJugador
        bl printf

        ldr r0, =formato
        ldr r1, =key2
        bl scanf

        ldr r3, =key2
        ldrb r3, [r3]

        // comparar r1 con key2, si key2 es igual a "q" en hexadecimal, terminar
        mov r2, #0x71
        cmp r2, r2
        beq end

        //Lectura del sensor para ir a init o end
        mov r0, #25	 		
        bl 	digitalRead
        cmp	r0, #0
        bne init
        
        mov r0, #5000
        bl delay
        b end


myLoopBoton:
    ldr r0, =mensaje2
    bl printf
    
    mov r0, #21
    bl digitalRead

    cmp r0, #1 // si el boton es presionado, r0 = 1. 
    beq sumaBoton
    
    b myLoopTecla
    
sumaBoton:
    ldr r0, =puntuacionBoton
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]

    ldr r0, =ultimoJugador //"  "
    ldr r1, =jugador2 // "jugador2"
    ldr r1 ,[r1]
    str r1, [r0]

    // identificando estado actual
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #1
    beq estado1
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #2
    beq estado2
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #3
    beq estado3
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #4
    beq estado4
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #5
    beq estado5
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #6
    beq estado6
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #7
    beq estado7
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #8
    beq estado8


sumaTecla:
    ldr r0, =puntuacionTecla
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]

    ldr r0, =ultimoJugador //"  "
    ldr r1, =jugador1 // "jugador1"
    ldr r1 ,[r1]
    str r1, [r0]

    // identificando estado actual
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #1
    beq estado1
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #2
    beq estado2
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #3
    beq estado3
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #4
    beq estado4
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #5
    beq estado5
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #6
    beq estado6
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #7
    beq estado7
    ldr r0, =estadoactual
    ldr r0, [r0]
    cmp r0, #8
    beq estado8

myLoopTecla:

    ldr r0, =mensaje
    bl printf

    ldr r0, =formato
    ldr r1, =key
    bl scanf

    ldr r2, =key
    ldrb r2, [r2] // r2 = first byte of key "y"

    cmp r2, #0x79 // 'y'
    beq sumaTecla

    b myLoopBoton

end:
    pop {ip, pc}

