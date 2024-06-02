#!/usr/bin/env python3

# I don’t particularly like Python, but it’s the only language
# I know that has a Wiktionary parser.
from wiktionaryparser import WiktionaryParser
import sys, re

if len(sys.argv) < 1:
    print('Usage: python GETPRONUNCIATIONS.py <word>')
    exit(1)

parser = WiktionaryParser()
for word in sys.argv[1:]:
    entry = parser.fetch(word, 'french')
    for e in entry:
        pron = e['pronunciations']['text']
        alternatives = []
        for p in pron:
            # Filter out pronunciations.
            matches = [entry[1:-1].replace('.', '') for entry in re.findall(r'/.*?/', p)]

            # Keep the longest pronunciation.
            if len(matches) > 0:
                longest = max(matches, key=len)
                alternatives.append(longest)

        # Print the longest pronunciation.
        if len(alternatives) > 0:
            print(max(alternatives, key=len))
