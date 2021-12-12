from libcpp.vector cimport vector
import cython
import numpy
cimport numpy
t=0
def main(str f):
	cdef str line
	cdef int w
	for line in open(f):
		w=len(line.strip())
		break

	cdef numpy.ndarray ones = numpy.zeros(w)
	
	cdef list gamma = []
	cdef list epsilon = []

	cdef int t =0

	for line in open(f):
		t+=1
		for i in range(0,len(line.strip())):
			if line[i] == "1":
				ones[i] +=1


	print(ones)
	cdef int bit
	for bit in ones:
		if bit >= t/2:
			gamma.append("1")
			epsilon.append("0")
		else:
			gamma.append("0")
			epsilon.append("1")
	
	print(epsilon)
	print(gamma)
	print( int("".join(epsilon), 2)*int("".join(gamma), 2)  )
