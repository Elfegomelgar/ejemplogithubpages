
Expresion = Suma

/*
Suma
  = num1:Multiplicacion "+" num2:Suma { return { tipo: "suma", num1, num2 } }
  / Multiplicacion

Multiplicacion
    = num1:Numero "*" num2:Multiplicacion { return { tipo: "multiplicacion", num1, num2 } }
    / Numero

Numero
    = [0-9]+("." [0-9]+)? { return { tipo: "numero", valor: parseFloat(text(), 10) } }
*/

/*
Suma = izq:Multiplicacion expansion:(ExpansionSuma)* {
  return expansion.reduce( 
    (operacionAnterior, operacionActual) => {
      const {tipo, der} = operacionActual
      return { tipo, izq: operacionAnterior, der}
    },
    izq
  )
}

ExpansionSuma = "+" der:Multiplicacion { return { tipo: "+", der } }

Multiplicacion = izq:Numero expansion:(ExpansionMultiplicacion)* {
  return expansion.reduce( 
    (operacionAnterior, operacionActual) => {
      const {tipo, der} = operacionActual
      return { tipo, izq: operacionAnterior, der}
    },
    izq
  )
}

ExpansionMultiplicacion = "*" der:Numero  { return { tipo: "*", der } }

Numero = [0-9]+("." [0-9]+)? { return { tipo: "numero", valor: parseFloat(text(), 10) } }

*/


Suma = izq:Multiplicacion expansion:(
  op:("+" / "-") der:Multiplicacion { return { tipo: op, der } }
)* {
  return expansion.reduce( 
    (operacionAnterior, operacionActual) => {
      const {tipo, der} = operacionActual
      return { tipo, izq: operacionAnterior, der}
    },
    izq
  )
}

Multiplicacion = izq:Unaria expansion:(
  op:("*" / "/") der:Numero  { return { tipo: op, der } }
)* {
  return expansion.reduce( 
    (operacionAnterior, operacionActual) => {
      const {tipo, der} = operacionActual
      return { tipo, izq: operacionAnterior, der}
    },
    izq
  )
}

Unaria = "-" num:Numero { return { tipo: "-", der: num }}
  / Numero



Numero = [0-9]+("." [0-9]+)? { return { tipo: "numero", valor: parseFloat(text(), 10) } }
  / "(" exp:Expresion ")" { return { tipo: "parentesis", exp } }
