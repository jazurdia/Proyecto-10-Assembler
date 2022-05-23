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
    mensaje: .asciz "Funcia"


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

    // setting wpi 0 to 7 as output
    mov r0, #0 // wpi 0
    mov r1, #1
    bl pinMode

    mov r0, #1 // wpi 1
    mov r1, #1
    bl pinMode

    mov r0, #2 // wpi 2
    mov r1, #1
    bl pinMode

    mov r0, #3 // wpi 3
    mov r1, #1
    bl pinMode

    mov r0, #4 // wpi 4
    mov r1, #1
    bl pinMode

    mov r0, #5 // wpi 5
    mov r1, #1
    bl pinMode

    mov r0, #6 // wpi 6
    mov r1, #1
    bl pinMode

    mov r0, #7 // wpi 7
    mov r1, #1
    bl pinMode

    // setting wpi 8 as input
    mov r0, #21 // wpi 8
    mov r1, #0 // AS INPUT
    bl pinMode

    // setting wpi 8 as input
    mov r0, #25 // wpi 8
    mov r1, #0 // AS INPUT
    bl pinMode

    // waiting for r8 to be 1
    try:
        
        mov r0, #21 // wpi 21
        bl digitalRead
        
        cmp r0, #0
        beq try     
        mov r0, #1500
        bl delay         // r0 = r8                  


    // primer estado: wpi 0 "on", todos los demás "off"
    mov r0, #0 // wpi 0 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
    try0:
        mov r0, #21 // wpi 21
        bl digitalRead
        
        cmp r0, #0
        beq try0
    
    // cambio de estado
    mov r0, #1500
    bl delay

    // segundo estado: wpi 0 "on" y wpi 1 "on", todos los demás "off"
    mov r0, #1 // wpi 1 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
    try1:
        mov r0, #21 // wpi 21
        mov r1, #0
        bl digitalRead
        cmp r0, #1  
        bne try1
    
    // cambio de estado
    mov r0, #1500
    bl delay

    // tercer estado: wpi 2 "on", todos los demás "off"
    mov r0, #0 // wpi 0 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #1 // wpi 1 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #2 // wpi 2 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
    try2:
        mov r0, #21 // wpi 8
        mov r1, #0
        bl digitalRead
        cmp r0, #1  
        bne try2 

    // cambio de estado
    mov r0, #1500
    bl delay

    // cuarto estado: wpi 2 "on" y wpi 3 "on", todos los demás "off"
    mov r0, #3 // wpi 3 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
    try3:
        mov r0, #21 // wpi 8
        mov r1, #0
        bl digitalRead
        cmp r0, #1  
        bne try3

    // cambio de estado
    mov r0, #1500
    bl delay

    // quinto estado: wpi 4 "on", todos los demás "off"
    mov r0, #2 // wpi 2 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #3 // wpi 3 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #4 // wpi 4 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
    try4:
        mov r0, #21 // wpi 21
        mov r1, #0
        bl digitalRead
        cmp r0, #1  
        bne try4

    // cambio de estado
    mov r0, #1500
    bl delay

    // sexto estado: wpi 4 "on" y wpi 5 "on", todos los demás "off"
    mov r0, #5 // wpi 5 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
    try5:
        mov r0, #21 // wpi #21
        mov r1, #0
        bl digitalRead
        cmp r0, #1  
        bne try5 

    // cambio de estado
    mov r0, #1500
    bl delay

    // septimo estado: wpi 6 "on", todos los demás "off"
    mov r0, #4 // wpi 4 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #5 // wpi 5 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #6 // wpi 6 "on"
    mov r1, #1
    bl digitalWrite

    // waiting for r8 to be 1
        try6:
            mov r0, #21 // wpi #21
            mov r1, #0
            bl digitalRead
            cmp r0, #1  
            bne try6 
    
    // cambio de estado
    mov r0, #1500
    bl delay

    // octavo estado: wpi 6 "on" y wpi 7 "on", todos los demás "off"
    mov r0, #7 // wpi 7 "on"
    mov r1, #1
    bl digitalWrite

    // apagando luces. (no es un estado)

    mov r0, #5000
    bl delay

    mov r0, #6 // wpi 6 "off"
    mov r1, #0
    bl digitalWrite

    mov r0, #7 // wpi 7 "off"
    mov r1, #0
    bl digitalWrite

    //Lectura en el wpi 25 para determinar si va a "init" o "end".
    
    mov r0, #25				
	bl 	digitalRead				
	cmp	r0, #0
	bne init
    
    mov r0, #5000
    bl delay
    b end

end:
    pop {ip, pc}

