from libcpp.vector cimport vector
from libcpp.string cimport string
import cython
import numpy
cimport numpy



def filter(vector[string] v,int w,direction):
	cdef int i
	cdef int j
	cdef char symbol
	cdef vector[string] tmp

	for i in range(0,w):
		ones=0
		for j in range(0,int(v.size() )):
			if v[j][i:i+1].decode('UTF-8') == "1":
				ones+=1
		
		if (ones >= int(v.size())/2 and direction == 1) or (ones < int(v.size())/2 and direction == 0):
			symbol = "1"
		else:
			symbol = "0"

		for j in range(0,int(v.size() )):
			if v[j][i] == symbol:
				tmp.push_back(v[j])
		v=tmp	
		tmp.clear()

		if int( v.size() ) == 1:
			break
	return(v)

t=0
def main(str f):
	cdef str line
	cdef int w
	for line in open(f):
		w=len(line.strip())
		break

	cdef vector[string] input 

	cdef string lineb 
	for lineb in open(f,"rb"):
		input.push_back( lineb.strip() )

	cdef vector[string] ox = filter(input,w,1)
	cdef vector[string] co = filter(input,w,0)

	print(ox[0])
	print(co[0])
	print( int(co[0], 2)*int(ox[0], 2)  )
