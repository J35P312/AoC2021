from setuptools import setup
from Cython.Build import cythonize

setup(ext_modules = cythonize(
           "d2.pyx",               
           language="c++",
      ))

