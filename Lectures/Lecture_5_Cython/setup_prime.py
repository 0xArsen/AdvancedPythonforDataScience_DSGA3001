from distutils.core import setup
from Cython.Build import cythonize

setup(
    name = "External primes app",
    ext_modules = cythonize('external_prime_module.pyx'),
)
