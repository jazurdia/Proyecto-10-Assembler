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


.text
    .global main
    .global init
    .extern wiringPiSetup
    .extern pinMode
    .extern digitalWrite
    .extern digitalRead
    .extern delay
    .extern 


main:   push 	{ip, lr}
    bl wiringPiSetup
    mov r1, #-1
    cmp r0, r1
    bne init

    ldr r0, =error
    bl printf
    b end


end:
    pop {ip, pc}

