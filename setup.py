from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()


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

setup(
    name='OpenNMTTokenizer',
    version='0.0.1',
    description='Python wrapper for OpenNMT cpp tokenizer',
    long_description=long_description,
    url='https://github.com/kovalevfm/OpenNMTTokenizer',
    license='MIT',
    author='Fedor Kovalev',
    author_email='kovalevfm@gmail.com',
    ext_modules = cythonize(extensions),
)
