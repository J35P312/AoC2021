from setuptools import setup
from Cython.Build import cythonize
import numpy

setup(ext_modules = cythonize(
           "d14.pyx",               
           language="c++",),
           include_dirs=[numpy.get_include()])

