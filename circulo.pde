import processing.serial.*; // Importamos la libreria que se ocupa de la lectura del puerto serie
Serial myPort; // Objeto Serial para inicializar el puerto serie
String buf = ""; // Cadena de texto, mas de una letra, en este caso esta vacia
int val; // Variable donde recibo el valor que me envia arduino
float diametro; // Diametro de mi circunferencia
void setup(){
size(512,512); // Tamaño de la ventana de visualización
smooth(); // Suavizado de los bordes
//imprimo solo una vez la lista de nombres de puertos series que tiene mi ordenador para ver donde
//puedo leer
println(Serial.list());
// Puerto donde está conectado Arduino para poder leer los datos
String portName = "COM3";
// Asigno a mi objeto Serial el puerto que está conectado a Arduino y con la misma velocidad
myPort = new Serial(this, portName, 9600);
}
void draw(){
//si el puerto esta disponible...sirve para que no se sature la ventana de processing
if ( myPort.available() > 0) {
val = myPort.read(); //en la variable val, escribe lo que estás leyendo en el puerto
if(val != 10) { //si val es distinto de 10, o sea...detecto donde cambio de linea con el return (10)
buf += char(val); //...entonces...guardo el valor como una cadena de texto
}else{
diametro = float(buf); //y si no....el diametro vale 1023 menos la transfomarcion de buf, ahora
//como float...
buf = ""; //vacio la variable buf...este doble cambio de la variable es un truco para que
//funcione bien en processing
}
//si no esta disponible...no hagas nada
}
background(255); // Fondo de pantalla blanco
noStroke(); // No dibujaremos Bordes
fill(255,0,0); // Relleno de color Rojo
ellipse(width/2,height/2,diametro/2,diametro/2); // Circunferencia en mitad de la pantalla
println(diametro); // Imprimimos en el Puerto Serie el diámetro
}
