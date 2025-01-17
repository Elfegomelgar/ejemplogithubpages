import { parse } from './operaciones.js'

//npx peggy .\operaciones.pegjs --format es

const editor = document.getElementById('editor')
const btn = document.getElementById('btn')
const ast = document.getElementById('ast')
const salida = document.getElementById('salida')

const recorrer = nodo => {
    if (nodo.tipo === 'numero') return nodo.valor
    if (nodo.tipo === 'parentesis') return recorrer(nodo.exp)

    const num1 = (nodo.izq && recorrer(nodo.izq)) || 0
    const num2 = recorrer(nodo.der)

    switch (nodo.tipo) {
        case "+":  
            return num1 + num2;
        case "-":  
            return num1 - num2;
        case "*":  
            return num1 * num2;  
        case "/":  
            return num1 / num2;   
        default:
            break;
    }
}

btn.addEventListener('click', e => {
    const codigoFuente = editor.value
    const arbol = parse(codigoFuente)

    ast.innerHTML  = JSON.stringify(arbol, null, 2)
    const resultado = recorrer(arbol)
    salida.innerHTML = resultado
} )