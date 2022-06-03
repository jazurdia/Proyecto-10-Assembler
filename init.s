/**
* Universidad del Valle de Guatemala
* Proyecto 3 - Organización de computadoras y Assembler
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
    mensajeBoton: .asciz "Puntuacion del jugador 2: %d \n"
    mensajeTecla: .asciz "Puntuacion del jugador 1: %d \n"
    mensajeGano1: .asciz "Gano el jugador 1 \n"
    mensajeGano2: .asciz "Gano el jugador 2 \n"
    key: .asciz "n"
    key2: .asciz "n"
    formato: .asciz "%s"
    puntuacionTecla: .word 0
    puntuacionBoton: .word 0

    ultimoJugador: .asciz "jugador0"
    jugador1: .asciz "Ultimo movimiento de jugador1 \n"
    jugador2: .asciz "Ultimo movimiento de jugador2 \n"

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
    .global init
    .extern wiringPiSetup
    .extern pinMode
    .extern digitalWrite
    .extern digitalRead
    .extern delay


init:

    // GPIO 0 | wPi - 0 | primer bit
    // GPIO 1 | wPi - 1 | segundo bit
    // GPIO 2 | wPi - 2 | tercer bit
    // GPIO 3 | wPi - 3 | cuarto bit
    // GPIO 4 | wPi - 4 | quinto bit
    // GPIO 5 | wPi - 5 | sexto bit
    // GPIO 6 | wPi - 6 | septimo bit
    // GPIO 7 | wPi - 7 | octavo bit
    //        | wPi - 22| luz jugador 1
    //        | wPi - 23| luz jugador 2
    // GPIO 21| wPi - 21| INPUT
    // GPIO 25| wPi - 25| INPUT


    ldr r3, =puntuacionTecla
    ldr r4, = puntuacionBoton
    mov r5, #0
    str r5,[r3]
    str r5, [r3]

    push {lr}
    mov r0, #0 // as output
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #1
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #2
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #3
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #4
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #5
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #6
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #7
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #22 // luz jugador 1
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #23 // luz jugador 2
    mov r1, #1
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #21 // as input
    mov r1, #0
    bl pinMode
    pop {lr}

    push {lr}
    mov r0, #25 
    mov r1, #0
    bl pinMode
    pop {lr}


    // esperar cambio de estado
    push {lr}
    bl myLoopTecla
    pop {lr}

    push {lr}
    mov r0, #1500
    bl delay
    pop {lr}

    estado1:
        push {lr}
        // primer estado
        mov r0, #0 // wpi 0 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e2
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}
        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}

        mov pc,lr

    estado2:
        push {lr}
        // segundo estado
        mov r0, #1 // wpi 1 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e3
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}

        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}

        mov pc, lr

    estado3:

        push {lr}
        // tercer estado
        mov r0, #0 // wpi 0 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #1 // wpi 1 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #2 // wpi 2 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e4
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}

        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}
        mov pc, lr

    estado4:

        push {lr}
        // cuarto estado
        mov r0, #3 // wpi 3 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e5
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}

        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}
        mov pc,lr

        
    estado5:

        push {lr}
        // quinto estado
        mov r0, #2 // wpi 2 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #3 // wpi 3 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #4 // wpi 4 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e6
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}

        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}
        mov pc,lr

    estado6:
        push {lr}
        // sexto estado
        mov r0, #5 // wpi 5 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e7
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}

        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}
        mov pc,lr

    estado7:
        push {lr}
        // septimo estado
        mov r0, #4 // wpi 4 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #5 // wpi 5 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #6 // wpi 6 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e8
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

        push {lr}
        // esperar cambio de estado
        bl myLoopTecla
        pop {lr}

        push {lr}
        mov r0, #1500
        bl delay
        pop {lr}
        mov pc,lr
    
    estado8:
        push {lr}
        // octavo estado
        mov r0, #7 // wpi 7 "on"
        mov r1, #1
        bl digitalWrite
        pop {lr}

        // cargar siguiente estado en estado actual
        ldr r0, =e1
        ldr r0, [r0]
        ldr r1, =estadoactual
        str r0, [r1]

    
    finJuego:
        //ldr r0, =mensaje3
        //bl printf


        push {lr}
        ldr r0, =mensajeTecla
        ldr r1, =puntuacionTecla
        ldr r1,[r1]
        bl printf
        pop {lr}


        push {lr}
        ldr r0, =mensajeBoton        
        ldr r1, =puntuacionBoton
        ldr r1,[r1]
        bl printf
        pop {lr}

        ldr r2, =puntuacionTecla
        ldr r2, [r2]
        ldr r3, =puntuacionBoton
        ldr r3, [r3]

        push {lr}
        cmp r2, r3
        bge ganoJ1
        blt ganoJ2
        pop {lr}

        //finJuego2:
        push {lr}
        mov r0, #7 // wpi 7 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        mov r0, #8 // wpi 8 "off"
        mov r1, #0
        bl digitalWrite
        pop {lr}

        push {lr}
        ldr r0, =formato
        ldr r1, =key2 // pedir en teclado "q"
        bl scanf
        pop {lr}

        ldr r3, =key2 // cargar primer bit como programación defensiva.
        ldrb r3, [r3]

        // comparar r1 con key2, si key2 es igual a "q" en hexadecimal, terminar
        push {lr}
        mov r2, #0x71
        cmp r3, r2
        beq init
        pop {lr}

        //Lectura del sensor para ir a init o end
        push {lr}
        mov r0, #25	 		
        bl 	digitalRead
        pop {lr}

        push {lr}
        cmp	r0, #0
        bne init
        pop {lr}
        
        push {lr}
        mov r0, #5000
        bl delay
        pop {lr}
        mov pc,lr


myLoopBoton: // jugador 2
    push {lr}
    ldr r0, =mensaje2
    bl printf
    pop {lr}
    
    push {lr}
    mov r0, #21
    bl digitalRead
    pop {lr}

    push {lr}
    cmp r0, #1 // si el boton es presionado, r0 = 1. 
    beq sumaBoton
    pop {lr}
    
    push {lr}
    bl myLoopTecla
    pop {lr}
    mov pc,lr
    
sumaBoton: // jugador 2
    
    ldr r0, =puntuacionBoton
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]

    push {lr}
    ldr r0, =mensajeBoton
    ldr r1, =puntuacionBoton
    ldr r1,[r1]
    bl printf
    pop {lr}

    push {lr}
    ldr r0, =jugador2 // mostrar que pulsó el jugador 2
    bl printf
    pop {lr}

    push {lr}
    mov r0, #23 // encender led de jugador 2
    mov r1, #1
    bl digitalWrite 
    pop {lr}

    push {lr}
    mov r0, #1500
    bl delay
    pop {lr}

    push {lr}
    mov r0, #23 // apagar led de jugador 2
    mov r1, #0
    bl digitalWrite
    pop {lr}

    

    // identificando estado actual
    push {lr}
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
    pop {lr}
    mov pc,lr


sumaTecla: // jugador 1
    ldr r0, =puntuacionTecla
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]

    push {lr}
    ldr r0, =mensajeTecla
    ldr r1, =puntuacionTecla
    ldr r1,[r1]
    bl printf
    pop {lr}

    push {lr}
    ldr r0, =jugador1 // mostrar que pulsó el jugador 2
    bl printf
    pop {lr}

    push {lr}
    mov r0, #22 // encender led de jugador 2
    mov r1, #1
    bl digitalWrite 
    pop {lr}

    push {lr}
    mov r0, #1500
    bl delay
    pop {lr}

    push {lr}
    mov r0, #22 // apagar led de jugador 2
    mov r1, #0
    bl digitalWrite
    pop {lr}

    push {lr}
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
    pop {lr}
    mov pc,lr

myLoopTecla: // jugador 1

    push {lr}
    ldr r0, =mensaje
    bl printf
    pop {lr}

    push {lr}
    ldr r0, =formato
    ldr r1, =key
    bl scanf
    pop {lr}

    ldr r2, =key
    ldrb r2, [r2] // r2 = first byte of key "y"

    push {lr}
    cmp r2, #0x79 // 'y'
    beq sumaTecla
    pop {lr}

    push {lr}
    bl myLoopBoton
    pop {lr}
    mov pc,lr

ganoJ1:
    push {lr}
    ldr r0, =mensajeGano1
    bl printf
    pop {lr}

    push {lr}
    ldr r0, =puntuacionTecla
    bl printf
    pop {lr}

    push {lr}
    mov r0, #22
    mov r1, #1
    bl digitalWrite
    pop {lr}

    push {lr}
    mov r0, #1500
    bl delay
    pop {lr}

    push {lr}
    mov r0, #22
    mov r1, #0
    bl digitalWrite
    pop {lr}

    mov pc,lr

ganoJ2:
    push {lr}
    ldr r0, =mensajeGano2
    bl printf
    pop {lr}

    push {lr}
    mov r0, #23
    mov r1, #1
    bl digitalWrite
    pop {lr}

    push {lr}
    mov r0, #1500
    bl delay
    pop {lr}

    push {lr}
    mov r0, #23
    mov r1, #0
    bl digitalWrite
    pop {lr}

    mov pc, lr


