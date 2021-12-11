from libcpp.vector cimport vector
import cython

def main(str f):

	cdef vector[int] pos = [0,0]
	cdef int aim =0


	cdef str line

	for line in open(f):
		content=line.strip().split()

		if content[0] == "forward":
			pos[0]+=int(content[1])
			pos[1]+=int(content[1])*aim
		else:
			if content[0] == "down":
				aim+=int(content[1])
			else:
				aim+=-int(content[1])
	print(pos)
	print(pos[1]*pos[0])
