from libcpp.vector cimport vector
import cython

def main(f):
	cdef int increase=0

	cdef vector[int] data
	cdef vector[int] vals
	cdef vector[int] tmp

	cdef str line

	for line in open(f):
		data.push_back( int( line.strip() ) )			
		
	print(increase)
	
	cdef int i
	for i in range( 0,int(data.size())-2 ) :
		vals.push_back( sum(data[i:i+3])  )

	for i in range( 0,int(vals.size())-1 ) :
		if vals[i] < vals[i+1]:
			increase+=1
			

	print(increase)
	
