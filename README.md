# The ULTRAFRENCH Language
If you don’t know what ULTRAFRENCH is, watch [this video](https://www.youtube.com/watch?v=FCQYPzJgy0Q) first.

If you came here looking for the ULTRAFRENCH grammar, an up-to-date version is available at https://www.nguh.org/static/UF-GRAMMAR.pdf. It is updated practically every time a commit is pushed to this repository.

This repository houses the grammar and dictionary definition file for the ULTRAFRENCH language, as well as the ULTRAFRENCHER, a program that generates a Typst file from the dictionary definitions, and which can convert between IPA and the ULTRAFRENCH orthography.

Specifically,
- The entire grammar is contained in [GRAMMAR.typ](GRAMMAR.typ).
- The dictionary is contained in [DICTIONARY/DICTIONARY.dict.txt](DICTIONARY/DICTIONARY.dict.txt).
- A list of sound changes to convert French to UF is contained in [LEXURGY.lsc](LEXURGY.lsc).
- The ULTRAFRENCHER is contained in [main.cc](ULTRAFRENCHER/src/main.cc).

## Building the grammar
This project has several dependencies:
- CMake 3.28 or later;
- An up-to-date C++ compiler (Clang 21 is used by the project authors);
- Typst.

To compile the grammar to a PDF document, first build the ULTRAFRENCHER by running the following
commands in the [ULTRAFRENCHER](ULTRAFRENCHER) directory.
```bash
$ cd ULTRAFRENCHER
$ cmake -S . -B out
$ cmake --build out
```
For Unix systems, various scripts to generate the dictionary and build the grammar can be found in the [SCRIPTS](SCRIPTS) directory. To build both the grammar and dictionary, run
```bash
./SCRIPTS/BUILD.sh
```

No-one working on this project uses Windows, so if you do, figure it out yourself.
