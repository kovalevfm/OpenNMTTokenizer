from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

sourcefiles = ["OpenNMTTokenizer.pyx",
               "Tokenizer/src/BPE.cc",
               "Tokenizer/src/CaseModifier.cc",
               "Tokenizer/src/ITokenizer.cc",
               "Tokenizer/src/SpaceTokenizer.cc",
               "Tokenizer/src/Tokenizer.cc",
               "Tokenizer/src/unicode/Data.cc",
               "Tokenizer/src/unicode/Unicode.cc"]

extensions = [Extension("OpenNMTTokenizer", sourcefiles,
                        language="c++",
                        extra_compile_args=["-std=c++11"],
                        include_dirs=["Tokenizer/include"])]

setup(ext_modules = cythonize(extensions))
