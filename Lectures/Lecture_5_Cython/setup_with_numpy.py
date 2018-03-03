from distutils.core import setup
from Cython.Build import cythonize
import numpy

setup(
    name = "My module app",
    ext_modules = cythonize('my_module_with_numpy.pyx',include_path = [numpy.get_include()]),
)
