# ALU con Sumador Prefix

Este proyecto implementa una ALU en SystemVerilog con seis operaciones:

- Suma
- Resta
- AND
- OR
- Shift left
- Shift right

La ALU opera con dos operandos:
- **A**: conectado a `sw[7:0]`
- **B**: conectado a `sw[12:8]` (extendido con ceros a 8 bits)

También incluye un sumador tipo prefix con carry-in controlado por el botón central (`btnC`).

Las salidas se muestran en:
- **LEDs**: resultado de la suma
- **LED adicional**: muestra el carry out
- **Display de 7 segmentos**: muestra el resultado de la ALU

El módulo principal es `tt_um_oscar_alutop`.

Diseñado para el entorno Tiny Tapeout.
