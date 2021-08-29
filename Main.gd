extends Node2D

# Called when the node enters the scene tree for the first time.

var arreglo = [5,321,87,98,322,67,21,54,33,52,1,65,48,7]

func _ready():
	print(arreglo)
	arreglo = OrdenamientoPorMonticulos(arreglo)
	print(arreglo)
	pass # Replace with function body.



func Intercambiar (array, i, j ):
	var tmp = array[i]
	array[i] = array[j]
	array[j] = tmp
	return array
	
func OrdenacionPorSeleccion(array):	
	var k = 0
	var n = len(array)
	
	for i in range(n):
		for j in range(i+1,n):
			k = i
			if(array[j]<array[k]):
				k=j
				if(k!=i):
					array = Intercambiar(array, i,k)
	return array

func OrdenacionPorInsercion(array):
	var n = len(array)
	var j
	var tmp
	
	for p in range(1, n):
		tmp = array[p];
		j = p-1
		while ((j>=0) and (tmp < array[j])):
			array[j+1] = array[j]
			j-=1
		array[j+1] = tmp
	return array

func OrdenacionShell(array):
	var n = len(array)
	var incr = n/2	
	var j
	var tmp
	
	while (incr>0):
		for p in range(incr+1, n):
			tmp = array[p]
			j = p - incr
			while((j>=0) && (tmp < array[j])):
				array[j+incr] = array[j]
				j-= incr
			array[j+incr] = tmp
		incr /= 2
	return array

func FiltradoDesc (array, i, n):
#Queremos que se repete el orden MAX del monticulo 	
	var tmp = array[i]	
	var hijo = 2*i

	if((hijo < n) and (array[hijo+1] > array[hijo])):
		hijo+=1

	while((hijo < n) && (tmp < array[hijo])):
	#Se elige el hijo correcto
		if((hijo < n) and (array[hijo+1] > array[hijo])):
			hijo +=1
		
		array[i] = array[hijo]
		i = hijo
		hijo = 2*i
		array[i] = tmp
		
	return array

func OrdenamientoPorMonticulos(array):
	var n = len(array)
	
	#se insertan los datos en el monticulo
	for i in range(n/2, -1 , -1):
		array = FiltradoDesc(array, i, n)
	
	for i in range(n-1, 0, -1):
		array =  Intercambiar(array,0,i)
		array = FiltradoDesc(array, 0, i-1)
		
	return array
