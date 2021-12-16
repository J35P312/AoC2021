def recursive(pair,rules):
	return( "".join([pair[0],rules[pair]]))

def main(str input, int itterations):
	cdef str line
	cdef bint first = True

	cdef str polymer
	cdef dict rules={}
	stuff=set([])
	for line in open(input):
		if first:
			polymer=line.strip()
			first=False
			continue

		if not "->" in line:
			continue
		content=line.strip().split(" -> ")
		rules[content[0]]=content[1]
		stuff.add(content[1])
	print(len(stuff))

	print(rules)
	print()
	print(polymer)
	
	for j in range(0,itterations):
		new_polymer=[]
		for i in range(0,len(polymer)-1):
			res=recursive(polymer[i:i+2],rules)
			new_polymer.append(res)
		new_polymer.append(polymer[-1])
		polymer="".join(new_polymer)
		#print(polymer)
	counts=[]
	for l in stuff:
		counts.append(polymer.count(l))
		
	print(max(counts)-min(counts))

