#let card-width = 10cm
#let card-height = 5.1cm

#set text(font: "Minion 3", fill: white, number-type: "old-style")
#set page(fill: rgb("2D2A2E"), width: card-width + 1cm, height: card-height + 1cm, margin: .5cm)

#let braces-to-smallcaps(s) = {
    let parts = ()
    while true {
        let lbrace = s.position("{")
        if lbrace == none {
            parts.push([#s])
            break
        }

        parts.push(s.slice(0, lbrace))
        s = s.slice(lbrace + 1)

        let rbrace = s.position("}")
        assert(rbrace != none, message: "Unterminated } in gloss!")
        let text = s.slice(0, rbrace)
        parts.push([#smallcaps(text)])
        s = s.slice(rbrace + 1)
    }

    parts.join()
}

#let multigloss(separator: " ", x) = {
    let lines = x
        .split("\n")
        .map(x => x.trim())
        .filter(x => x.len() != 0)

    for (l1, l2) in lines.chunks(2, exact: true) {
        let text = l1.split(separator)
        let gloss = l2.split(separator)
        for (t, g) in text.zip(gloss) {
            box[#stack(dir: ttb, [#emph(t) #h(4pt)], [#braces-to-smallcaps(g) #h(4pt)], spacing: .5em)]
        }
    }
}

#box(stroke: white, inset: 6pt, width: card-width, height: card-height)[
    #align(center)[
        #v(.2em)
        _Syb’hérá srá dédv́ér dý ! evaú lnérd s’aúłau’r ! \
        — Ráhb’hes Ihic’hlávê c’hónývâ sýrá dý y’íb’hâ._
    ]

    #align(center)[
        #set text(size: 8pt)
        ‘Two fucking months have been poured out! it’s about time you nerds!’ \
        ‘—16 July famously following 16 February by two months.’
    ]

    #v(.5em)
    #set text(size: 8pt)
    #set par(leading: 1em)
    #multigloss(separator: "|", "
        sy-b’hér-á|s-rá|ḍédv́ér|dý|evaú|l-nérd|s’aúłau’r
        {pres.ant.3n.pass}-pour-{circ}|{acc.indef}-month|fucking|two|{voc.pl.2pron}|{abs.pl}-nerd|it’s.about.time.that

        ráh-b’hes|i\hic’hlávê|c’hónývâ|sý-rá|dý|y’íb’h-â
        {insv}-16.july|{acc}\16.february|famously|{gen.pl.indef}-month|two|follow-{ptcp}
    ")
]
