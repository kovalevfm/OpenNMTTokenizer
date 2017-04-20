from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp cimport bool


cdef extern from "Tokenizer/include/onmt/Tokenizer.h" namespace "onmt":
    cdef cppclass CTokenizer "onmt::Tokenizer":
        cppclass Mode:
            Mode() except +
        CTokenizer(Mode mode, string bpe_model_path, bool case_feature, bool joiner_annotate,
                  bool joiner_new, string joiner, bool with_separators) except +
        CTokenizer(bool case_feature, string joiner) except +
        void tokenize(string text, vector[string] words, vector[vector[string]] features)
        string detokenize(vector[string] words, vector[vector[string]] features)


cdef extern from "Tokenizer/include/onmt/Tokenizer.h" namespace "onmt::Tokenizer::Mode":
    cdef CTokenizer.Mode Conservative
    cdef CTokenizer.Mode Aggressive

cdef extern from "Tokenizer/include/onmt/Tokenizer.h" namespace "onmt::Tokenizer":
    cdef string joiner_marker


cdef class Tokenizer:
    cdef CTokenizer* c_tokenizer
    def __cinit__(self, mode=None, bpe_model_path=None, case_feature=None, joiner_annotate=None,
                  joiner_new=None, joiner=None, with_separators=None):
        if mode and mode not in ("conservative", "aggressive"):
            raise Exception("mode has to be conservative or aggressive")
        cdef CTokenizer.Mode c_mode = Conservative if (not mode or mode == "conservative") else Aggressive
        cdef string c_bpe_model_path = bpe_model_path or ""
        cdef bool c_case_feature = case_feature or False
        cdef bool c_joiner_annotate = joiner_annotate or False
        cdef bool c_joiner_new = joiner_new or False
        cdef string c_joiner = joiner or joiner_marker
        cdef bool c_with_separators = with_separators or False
        self.c_tokenizer = new CTokenizer(c_mode, c_bpe_model_path, c_case_feature, c_joiner_annotate,
                                         c_joiner_new, c_joiner, c_with_separators)
    def tokenize(self, text):
        cdef vector[string] c_words
        cdef vector[vector[string]] c_features
        self.c_tokenizer.tokenize(text, c_words, c_features)
        return c_words, c_features
    def detokenize(self, words, features):
        cdef vector[string] c_words = words
        cdef vector[vector[string]] c_features = features
        cdef string text
        text = self.c_tokenizer.detokenize(c_words, c_features)
        return text
