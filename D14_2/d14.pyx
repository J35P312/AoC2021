import numpy
import math
import cython
cimport numpy
import copy

@cython.boundscheck(False)
@cython.wraparound(False)

#ctypedef numpy.int8_ DTYPE_t


def solve(polymer,itterations,letters,rules):

	cdef long total_elements=len(polymer)
	cdef long j
	for _ in range(0,itterations):
		total_elements+=(total_elements-1)
		
	#cdef list all_elements=[]
	small=0
	#all_elements=[small] * total_elements

	#cdef char all_elements[total_elements]
	cdef numpy.ndarray all_elements=numpy.zeros(total_elements,dtype='U1')
	all_elements[0]=polymer[0]
	cdef long i
	for i in range(1,len(polymer)):

		p=i
		for j in range(itterations):
			p+=p

		all_elements[p]=polymer[i]

	cdef long parent_1
	cdef long parent_2
	cdef long child
	cdef int elements_current_loop =len(polymer)
	cdef int added =len(polymer)
	cdef long pow
 
	for j in range(1,itterations+1):
		elements_current_loop+=(elements_current_loop-1)

		#print(j,elements_current_loop,added)

		pow=int(math.pow(2,itterations-(j-1)))
		for i in range(1,elements_current_loop-added+1):

			parent_1=pow*(i-1)
			parent_2=pow*(i)
			child=(parent_1+parent_2)/2

			all_elements[child]=rules[ all_elements[parent_1] ] [ all_elements[parent_2] ]

		added=elements_current_loop
	counts=[]
	#print(all_elements)

	for i in range(0,len(letters)):
		counts.append(numpy.count_nonzero(all_elements == letters[i] ) )
		
	return(counts,all_elements)


def main(str input, int it):
	cdef str line
	cdef bint first = True

	cdef str polymer
	cdef dict rules={}
	cdef set stuff=set([])
	for line in open(input):
		if first:
			polymer=line.strip()
			first=False
			continue

		if not "->" in line:
			continue
		content=line.strip().split(" -> ")
		if not content[0][0] in rules:
			rules[content[0][0]]={}
		
		rules[content[0][0]][content[0][1]]=content[1]
		stuff.add(content[1])

	letters=list(stuff)

	l_to_pos={}
	for i in range(0,len(letters)):
		l_to_pos[letters[i]]=i

	print(len(stuff))

	print(rules)
	print()
	print(polymer)
	
	counts=[]
	for letter in letters:
		counts.append(0)

	if it < 20:
		counts_new,new_polymer=solve(polymer,it,letters,rules)
		for j in range(0,len(counts_new)):
			counts[j]+=counts_new[j]


	else:
		counts_new,new_polymer=solve(polymer,18,letters,rules)

		new_polymer="".join(list(new_polymer))
		it=it-18
		analyzed={}

		for i in range(0,len(new_polymer)-1):

			if i != len(new_polymer)-2:
				counts[ l_to_pos[new_polymer[i+1]] ]+=-1

			if new_polymer[i] in analyzed:
				if new_polymer[i+1] in analyzed[new_polymer[i]]:
					for j in range(0,len(counts_new)):
						counts[j]+=analyzed[new_polymer[i]][new_polymer[i+1]][j]
					continue

			counts_new,tmp=solve(new_polymer[i:i+2],it,letters,rules)
			for j in range(0,len(counts_new)):
				counts[j]+=counts_new[j]

			if not new_polymer[i] in analyzed:
				analyzed[new_polymer[i]]={}

			if not new_polymer[i+1] in analyzed[new_polymer[i]]:
				analyzed[new_polymer[i]][new_polymer[i+1]]=copy.copy(counts_new)

	print(max(counts)-min(counts))
	#counts_new=solve(polymer,itterations,letters,rules)
	#print(counts_new)
	#print(max(counts_new)-min(counts_new))
