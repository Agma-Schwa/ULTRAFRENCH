#import "BASE/src/lib.typ" : *

// This doesn’t stop #s from working unlike #emph.
#let italic(x) = text(style: "italic", x)

#let examples(exs) = if exs.len() != 0 [
    #set block(below: .65em, above: .65em)
    #list(
        indent: .7em,
        body-indent: .3em,
        marker: $diamond.small$,
        spacing: .5em,
        ..exs.map(e => [#e.text #italic(e.comment)])
    )
]

#let dictionary-entry(entry) = block[
    #set par(hanging-indent: .5em, first-line-indent: 0pt)
    #set list(tight: true)
    #set enum(tight: true)
    #metadata(entry.word) <dict-entry>

    #text(size:13pt, weight: "semibold")[#entry.word]
    #italic(entry.pos)
    #if entry.etym != [] [[#entry.etym]]
    #if entry.forms != [] [#italic(entry.forms).]
    #if entry.prim_def.def != [] [
        #entry.prim_def.def
        #italic(entry.prim_def.comment)
    ]#parbreak()

    #examples(entry.prim_def.examples)
    #if entry.senses.len() != 0 {
        for (i, s) in entry.senses.enumerate() [
            #set par(first-line-indent: (amount: .2em, all: true))
            #text(weight: "semibold")[#(i+1).] #s.def #italic(s.comment)
            #parbreak()
            #examples(s.examples)
        ]
    }

    #v(.1em)
]

#let dictionary-reference(ref, word) = par(first-line-indent: 0pt)[
  #metadata(ref) <dict-entry>
  #text(size:13pt, weight: "semibold", ref) $arrow$ #word
]

#let lemma(x) = text(weight: "semibold", x)
#let sense(x) = [sense~#x]

