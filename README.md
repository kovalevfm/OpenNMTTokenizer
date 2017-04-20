# OpenNMTTokenizer python wrapper for OpenNMT Tokenizer
## Build:
```bash
python setup.py build_ext --inplace
```
## Usage:
```python
import OpenNMTTokenizer
tokenizer = OpenNMTTokenizer.Tokenizer(mode='aggressive', case_feature=True, joiner_annotate=True)
words, features = tokenizer.tokenize('Some text')
print  tokenizer.detokenize(words, features)
```

## Tokenizer parameters
See original OpenNMT documentation on http://opennmt.net/OpenNMT/options/tokenize/
