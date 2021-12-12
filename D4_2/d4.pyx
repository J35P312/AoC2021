from libcpp.vector cimport vector
from libcpp.string cimport string
import cython
import numpy
cimport numpy

def winner(board,set selected,int w):
	cdef int r
	cdef int c

	cdef int score
	for r in range(0,w):
		score=0
		for c in range(0,w):
			if board[r][c] in selected:
				score+=1
		if score == w:
			return(True)

	for c in range(0,w):
		score=0
		for r in range(0,w):
			if board[r][c] in selected:
				score+=1
		if score == w:
			return(True)

	return(False)

def score(board,set selected,int w):
	cdef int r
	cdef int c

	cdef int score=0
	for r in range(0,w):
		for c in range(0,w):
			if not board[r][c] in selected:
				score+=board[r][c]
	return(score)

def main(str f):
	cdef list numbers=[]
	cdef str line

	cdef bint first=True
	cdef bint newboard=True

	cdef list boards=[]

	cdef int r
	cdef int w

	for line in open(f):
		if first:
			for n in line.strip().split(","):
				numbers.append(int(n))
			first=False
			continue

		if line.strip() == "":
			newboard=True
			continue


		if newboard:
			r=0
			w=len(line.strip().split())
			print(w)
			newboard=False
			boards.append(numpy.zeros([w,w]))
		cols=line.strip().split()

		for c in range(0,w):
			boards[-1][r][c]=cols[c]

		r+=1
		
	selected=set([])
	cdef int last_score
	winners=set([])
	cdef int b

	for n in numbers:
		selected.add(n)
		b=0
		for board in boards:
			if winner(board,selected,w):
				last_score=score(board,selected,w)*n
				winners.add(b)
				if len(winners) == len(boards):
					print(last_score)
					quit()
			b+=1
