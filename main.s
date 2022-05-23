/**
* Universidad del Valle de Guatemala
* Laboratorio 10 - Organización de computadoras y Assembler
* "Corrimiento de bits activos" Temario 1 - Manejo de puertos GPIO y Sensores
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
    key: .asciz "n"
    formato: .asciz "%s"
    puntuacionTecla: .word 0
    puntuacionBoton: .word 0


.text
    .global main
    .extern wiringPiSetup
    .extern pinMode
    .extern digitalWrite
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
    
    bl mySet







    

    //Lectura en el wpi 25 para determinar si va a "init" o "end".
    
    mov r0, #25				
	bl 	digitalRead				
	cmp	r0, #0
	bne init
    
    mov r0, #5000
    bl delay
    b end

mySet:
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


myDelay:
    mov r0, #1500
    bl delay


myCambioDeEstado:
    bl myLoopTecla
    bl myDelay

myLoopBoton:
    ldr r0, =mensaje2
    bl printf
    
    mov r0, #21
    bl digitalRead

    cmp r0, #1 // si el boton es presionado, r0 = 1. 
    beq sumaBoton
    bne myLoopTecla
    
sumaBoton:
    ldr r0, =puntuacionBoton
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]

    bl myCambioDeEstado

sumaTecla:
    ldr r0, =puntuacionTecla
    ldr r1, [r0]
    add r1, #1
    str r1, [r0]
    
    bl myCambioDeEstado

myLoopTecla:

    ldr r0, =mensaje
    bl printf

    ldr r0, =formato
    ldr r1, =key
    bl scanf

    ldrb r2, [r1] // r2 = first byte of key "y"

    cmp r2, #0x79 // 'y'
    beq sumaTecla

    bne myLoopBoton

end:
    pop {ip, pc}

