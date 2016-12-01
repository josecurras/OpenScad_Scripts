echo(version=version());
// Llamadas recursivas a modulos (funciones) pueden generar geometrías complejas, 
// epecialmente ojetos de estilo fractal
// El ejemplo usa una llamada recursiva al modulo tree ("arbol") para generar un arbol aleatorio 
// como se describe en http://natureofcode.com/book/chapter-8-fractals/


levels = 6; // numero de niveles de recursión

len = 80; // longitud del primer segmento
thickness = 6; // grosor del tablero

// 
identity = [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

// random generator
function rnd(s, e) = rands(s, e, 1)[0];

// matriz de traslación
function mt(x, y) = [ [ 1, 0, 0, x ], [ 0, 1, 0, y ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];


// matriz de rotación sobre el eje z donde a es el águlo.
function mr(a) = [ [ cos(a), -sin(a), 0, 0 ], [ sin(a), cos(a), 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

module tree(length, thickness, count, m = identity) {
    color([0, 1 - (0.8 / levels * count), 0])
        multmatrix(m)
            square([thickness*4, length],false);

    if (count > 0) {
        angulo = rnd(80, 85);
        union(){
        tree(rnd(0.4, 0.5) * length, 0.8 * thickness, count - 1, m * mt(0, length) * mr(angulo));
        tree(rnd(0.4, 0.5) * length, 0.8 * thickness, count - 1, m * mt(0, length) * mr(-angulo));
        tree( length, 0.7 * thickness, count - 1, m * mt(0, length));
        }        
    }
}

tree(len, thickness, levels);
