#import "BASE/src/lib.typ" : *
#import "@preview/arborly:0.3.2": tree, a as tree-attr

// ============================================================================
//  Preamble
// ============================================================================
#show : setup
#let w(it) = emph(it)
#let L = super[L]
#let N = super[N]
#let pf(it) = [#s[pf] #w(it)]
#set list(spacing: 1em)
#gloss-show-numbers(false)

#let conjugation-table(caption: [], ..rows) = figure(
    caption: caption,
    placement: none,
    [
        #show : italic-table-body.with(cols: (0, 4))
        #show table.cell: it => if (it.x in (0, 4) and it.y != 0) { smallcaps(it) } else { it }
        #rowtable(
            table.header[ Active & Sg & Pl && Passive & Sg & Pl ],
            ..(1, 6).map(it => hlineat(it, end: 3)),
            ..(1, 6).map(it => hlineat(it, start: 4)),
            ..vlinesat(1, 2, 5, 6),
            align: (x, y) => {
                if x in (1, 5) and y in (6, 7) { center } else { left }
            },
            ..rows.pos()
        )
    ]
)

// ============================================================================
//  Frontmatter
// ============================================================================
#[
    #v(1fr)
    #set align(center)
    #v(60pt)
    #text(size: Large-size)[A Comprehensive Diachronic Grammar of Modern\ ULTRAFRENCH]

    #v(1em)
    #text(size: Large-size)[_Ŷrávér Réy’ác’hraúníc’hâ Rzaúsdâ Át’hebhaú Raúl_]

    #v(1em)
    #text(size: large-size, s[Ætérnal, Annwan, Agma Schwa])

    #v(.5em)
    #datetime.today().display("[day padding:none] [month repr:long] [year]")
    #v(2fr)
]

#table-of-contents()

#chapter([Glossary], "glossary", outlined: false)
#glossary(
    (s[abess],[abessive]),
    (s[abl],[ablative]),
    (s[abs],[absolutive]),
    (s[acc],[accusative]),
    (s[aci],[see @subsec:aci-pci]),
    (s[adess],[adessive]),
    (s[aff],[affirmative]),
    (s[all],[allative]),
    (s[antabl],[antablative]),
    (s[antall],[antallative]),
    (s[antess],[antessive]),
    (s[caus],[causal]),
    (s[circ],[circumfix]),
    (s[circabl],[circumablative]),
    (s[circess],[circumessive]),
    (s[circlat],[circumlative]),
    (s[citr],[citressive]),
    (s[com],[comitative]),
    (s[comp],[comparative]),
    (s[cond],[conditional]),
    (s[cons],[considerative]),
    (s[contr],[contrative]),
    (s[contress],[contressive]),
    (s[dat],[dative]),
    (s[def],[definite]),
    (s[del],[delative]),
    (s[den],[denying]),
    (s[distr],[distributive]),
    (s[ela],[elative]),
    (s[ess],[essive]),
    (s[exess],[exessive]),
    (s[fut],[future]),
    (s[gen],[genitive]),
    (s[gn],[gnomic]),
    (s[ill],[illative]),
    (s[indef],[indefinite]),
    (s[iness],[inessive]),
    (s[inf],[infinitive]),
    (s[instr],[instrumental]),
    (s[insv],[instructive]),
    (s[intress],[interessive]),
    (s[nd],[northern dialect]),
    (s[nom],[nominative]),
    (s[opt],[optative]),
    (s[orient],[orientative]),
    (s[part],[partitive]),
    (s[pass],[passive]),
    (s[pci],[see @subsec:aci-pci]),
    (s[perl],[perlative]),
    (s[pl],[plural]),
    (s[pres ant],[present anterior]),
    (s[pres],[present]),
    (s[pret],[preterite]),
    (s[pstela],[postela]),
    (s[pstess],[postessive]),
    (s[pstlat],[postlative]),
    (s[ptcp],[participle]),
    (s[sd],[standard dialect]),
    (s[sg],[singular]),
    (s[spress],[superessive]),
    (s[sprlat],[superlative]),
    (s[subess],[subessive]),
    (s[subj],[subjunctive]),
    (s[subl],[sublative]),
    (s[subst],[substitutive]),
    (s[superl],[superlative]),
    (s[surl],[surlative]),
    (s[transall],[transallative]),
    (s[transess],[transessive]),
    (s[transl],[translative]),
    (s[voc],[vocative]),
)

// ============================================================================
//  Mainmatter
// ============================================================================
#show : mainmatter
#chapter([Phonology and Evolution from\ Modern Pseudo-French], "phonology")
#let format-sound-changes(sound-changes, break-at: ()) = columns(2, {
    let num = 1
    for (i, (title, changes)) in sound-changes.enumerate() {
        if (i in break-at) { colbreak() }
        if title != [] { partitle(title) }
        enum(start: num, ..changes)
        num += changes.len()
    }
})

#rowtable(
    columns: 10,
    ..vlinesat(1, 2, 3, 4, 5, 8, 9),
    ..(1, 2, 3, 4, 5, 6, 7).map(y => table.hline(y: y, end: 6)),
    ..(1, 2, 3, 4, 5, 6, 7).map(y => table.hline(y: y, start: 7)),
    table.header[        & Labial & Coronal   & Palatal  & Velar & Glottal &&            & Front        & Back       ],
    [ Stop               & b, bʱ  & d         &          &       &         && Close      & i ĩ ĩ̃ i̥ y ẙ  & u ũ ũ̃ u̥    ],
    [ Nasal              &        & n         &          &       &         && Near-close & ʏ̃ ʏ̃̃      &                ],
    [ Fricative          & ɸ β    & s z, θ ð  & ɕ ʑ, (ç) & x     & h       && Close-mid  & e ẽ ẽ̃ e̥      & o o̥        ],
    [ Fric. (ʁ-coloured) & βʶ     & sʶ zʶ, ɮ̃ʶ & ɕʶ ʑʶ    &       &         && Mid        & #col2(align(center)[ə ə̥]) ],
    [ Trill              &        &           &          & ʀ     &         && Open-mid   & ɛ ɛ̃ ɛ̃̃      & ɔ̃ ɔ̃̃          ],
    [ Approximant        & ʋ̃      &           & ɥ ɥ̃, j̊   & ɰ ɰ̃   &         && Near-open  & #col2(align(center)[ɐ ɐ̥]) ],
    [ Lateral Fricative  &        & ɮ̃         & ʎ̝̃        &       &         && Open       &              & ɑ̃ ɑ̃̃        ],
)

#partitle[Legend]
Ṽ = nasalised vowel, Ṽ̃ = nasal vowel, V = any vowel (or, in conjunction with Ṽ/Ṽ̃, oral vowel)\
N = nasal consonant, C̃ = nasalised consonant (e.g. /ɰ̃/, but not true nasals), C = any consonant.

#[
#smallskip
#let sound-changes = (
    ([Preliminary Changes], (
        [g, w > ɰ ⟨r⟩],
        [œ, œ̃, ø > y, ʏ̃, ʏ̃],
        [ɔ > o],
        [u > v / \_o],
        [y > j / \_(\#)V],
        [V#sub[α] > $emptyset$ / \_\#V#sub[α]],
        [lj, lɥ > ʎ],
        [j > ɥ ⟨y’⟩],
        [ɰ > ɥ / \_i],
        [ʁʁ > ʀ],
        [sʁ, ʃʁ, zʁ, ʒʁ > sʶ, ʃʶ, zʶ, ʒʶ],
        [vʁ > vʶ],
        [ʁ > ɰ],
        [C > $emptyset$ / \#\_C],
        [C > $emptyset$ / C\_\#],
        [e, ẽ, ɛ, ɛ̃ > $emptyset$ / \#\_C],
        [k > x ⟨c’h⟩],
        [ʃ, ʃʶ, ʒ, ʒʶ > ɕ, ɕʶ, ʑ, ʑʶ],
        [nt > nθ],
        [t > ḍ [d] (‘hard /d/’)],
        [p > ḅ [b] (‘hard /b/’)],
        [f, v, vʶ > ɸ ⟨f⟩, β ⟨b’h⟩, βʶ ⟨v́⟩],
    )),
    ([Simplification],(
        [d, ḍ, b, ḅ > $emptyset$ / \_s],
    )),
    ([Great Nasal Shift],(
        [Ṽl > ɰ̃ ⟨w⟩],
        [V > Ṽ̃ / [NC̃ɥɰ]\_N\#],
        [V, Ṽ > Ṽ, Ṽ̃ / \_[NC̃ɥɰ], [NC̃ɥɰ]\_],
        [ə̃, ə̃̃, ã, ã̃, õ, õ̃ > ɛ̃, ɛ̃̃, ɑ̃, ɑ̃̃, ɔ̃, ɔ̃̃],
        [N, C̃ > $emptyset$ / V\_\#],
        [ɲ, ŋ > n],
        [V, Ṽ > $emptyset$ / N \_ N],
        [m, l, ʎ > ʋ̃ ⟨v⟩, ɮ̃ ⟨l⟩, ʎ̝̃ ⟨ḷ⟩],
        [ɮ̃ɰ, ɰɮ̃ > ɮ̃ʶ ⟨ł⟩],
    )),
    ([Intervocalic Lenition (/ V \_ V is implied)],(
        [x, s, z > h],
        [ɕ, ɮ̃, ʎ̝̃ > j̊ ⟨c̣⟩, ɥ̃, ɰ̃],
        [nθ > n],
        [d, ḍ, b, ḅ > ð ⟨d’h⟩, θ ⟨t’h⟩, β, bʱ ⟨bh⟩],
        [ɸ > β / V\_V],
    )),
    ([Late Changes],(
        [C[+stop, -alveolar]C#sub[α] > C#sub[α]],
        [C[+stop]C#sub[α];[+stop] > C#sub[α]],
        [h > $emptyset$ / hV\_],
        [ə > $emptyset$ / C\_C],
        [V[-nasalised, -nasal] > ə̥ / \_\#],
        [ɰɰ > ʀ],
        [eɛ̃ > ẽ],
    ))
)

#format-sound-changes(sound-changes)
#pagebreak()
]

== Pronunciation, Allophony, and Stress <subsec:pronunciation-allophony-and-stress>
There is not a lot of allophony in UF, save that /x/ is realised as [χ] around back vowels and [ɕ] elsewhere, e.g.
#w[c’húr] /xũɰ/ ‘to shrink’ is pronounced [χũˑˠ]. Furthermore, /h/ is [ç] before variants of /i/ and /y/, and [h] elsewhere.

The vast majority PF words are stressed on the last syllable of the root, e.g. #w[ad’hór] ‘to love’ /aˈðɔ̃ɰ/, but #w[b’had’hóré]
‘you (#s[pl]) love’ /βaˈðɔ̃.ɰɛ̃/. The stress is not indicated in writing, neither in actual texts, nor in this
grammar or in dictionaries. The main exception to this are names, which are generally stressed on the first syllable,
and receive secondary stress on the last syllable,#footnote[That is, unless the name ends in an obvious suffix, in which case the last
syllable before any such suffixes receives secondary stress; however, this is generally quite rare.] e.g. #w[Daúvníc’h] /ˈdɔ̃ʋ̃ˌnĩx/.

The only exception to this rule are certain particles and irregular verbs, some of which have irregular stress; for instance,
the forms of #w[eḍ] ‘to be’ are all stressed on the first syllable. Any such words that deviate from the norm will be pointed
out in this grammar and in dictionaries.

Oral vowels before the stressed syllable are often somewhat muted or reduced, albeit still audible, and stressed vowels are lengthened if they
are nasalised, e.g. the pronunciation of #w[ad’hór], which we just transcribed as /aˈðɔ̃ɰ/, is actually closer to [ɐ̯ˈðɔ̃ˑɰ].
Word-final voiceless #w[ẹ] is always /ə̥/. Finally, non-back vowels that are followed by /ɰ/ or /ɰ̃/ are retracted, e.g. #w[y’ẹ́rẹ́], the future
stem of #w[y’ẹ́] ‘forbid’, is phonemically /ɥẽˈɰẽ/, but pronounced [ɥɘ̃ˈɰẽ].

Oral vowels have a nasalised and nasal counterpart. /i/ and /u/ do not vary in quality when na\-sa\-lis\-ed.
/a/ is normally [ɐ], but becomes [ɑ] when nasalised or nasal. Similarly, /e/ becomes [ɛ],
/y/ becomes [ʏ], and /o/ becomes [ɔ]. Note that nasalised [ẽ] exists, but it’s
rare. The quality never changes when going from nasalised to nasal. The schwa has no nasal(lised) counterpart. Lastly, oral vowel
also have voiceless counterparts, whose quality is the same as that of the base vowel.

The difference between nasalised vowels and nasal vowels is that the former are merely coarticulated with nasalisation, whereas
the latter are completely and utterly _in the nose_—no air escapes through the mouth when a nasal vowel is articulated, and all
the air flows just through the nose. Middle UF and some modern dialects also distinguish between sinistral and dextral nasal
vowels,#footnote[Sinistral nasal vowels are articulated with the left nostril, and dextral nasal vowels with the right nostril.]
but this distinction is no longer present in the modern standard language.

Initial /ɰ/ is sometimes elided after words that end with /ɰ/.

== Orthography
The spelling of most UF sounds is indicated above; the less exotic consonants are spelt as
one might expect. In addition, UF employs a variety of diacritics—though some only in grammatical
material—to differentiate its many sounds with an otherwise unsatisfactory array of symbols.

=== Consonants
As one might expect, /b, d, n, ɸ, s, z, h/ are spelt ⟨b, d, n, f, s, z, h⟩, respectively.

Several fricatives are spelt with an apostrophe followed by a ⟨h⟩, viz. /x/ ⟨c’h⟩, /θ/ ⟨t’h⟩, /ð/ ⟨d’h⟩,
and /β/ ⟨b’h⟩. Apostrophes are also often used to mark shortened forms or that a vowel has been deleted, e.g. #w[t’hé],
the optative negation particle, is shortened to #w[t’h’] before vowels.

Conventional letters are used for rather unconventional sounds, mostly for diachronic reasons:
/l/ does not exist in UF, so ⟨l⟩ is either /ɮ̃/ or /ʎ̝̃/, ⟨v⟩ is /ʋ̃/, ⟨j⟩ is /ʑ/, ⟨c⟩ is /ɕ/, ⟨r⟩ is /ɰ/, ⟨w⟩ is /ɰ̃/. The vowel
/y/ is spelt ⟨y⟩, and its consonantal equivalent /ɥ/ as well as nasalised /ɥ̃/ are spelt with an apostrophe, that is
⟨y’⟩ and ⟨ý’⟩. The ʁ-fricated fricatives /βʶ, ɮ̃ʶ, sʶ, ɕʶ, ʑʶ, zʶ/
are spelt ⟨v́, ł, ś, ć, ȷ́, ź⟩, respectively.

Double consonant letters indicate a lengthened consonant; these are rare, but they can occur in any position. The only
exception to this is ⟨rr⟩, which is not /ɰː/, but rather /ʀ/. UF does not have phonemic vowel length (though recall
that phonetic lengthening occurs in some situations), so a double vowel letter is always pronounced as two separate vowels.

=== Hard #w[ḅ] and #w[ḍ]
The ‘hard’ voiced #w[ḅ], #w[ḍ] which are pronounced exactly like their regular counterparts, are normally also spelt ⟨b⟩ and
⟨d⟩. However, a dot below is commonly used in dictionaries and grammatical material to distinguish between the two
as they differ from one another in how they mutate.

In Early Modern UF (and Middle UF before it), such as in the writings of renowned poet and writer #s[Jac’h Yý’is Bèrtrá (J.#thinsp();Y.#thinsp();B.)
Snet’h], #w[ḅ] and #w[ḍ] sometimes retain their diachronic spellings of ⟨p(h)⟩ and ⟨t⟩—and #w[bh] is sometimes spelt
⟨p’h⟩ instead—though this is not consistent and often not applied word-internally or between vowels in general—even across multiple
words—where these sounds were already voiced even at the time.

For instance, Snet’h commonly writes e.g. #w[naut] ‘our’ for #w[nauḍ], but e.g. #w[labraúc] ‘they came up to’ for #w[laḅraúc], and not
#w[lapraúc] or #w[laphraúc], is found in the very same passage. This style is often imitated by writers who want to seem archaic, but failing to
understand the pronunciation of the time, they tend to use ⟨t⟩ and ⟨p(h)⟩ everywhere, even word-internally.

=== _rrr_
The sequence ⟨rrr⟩ could be /ʀɰ/ or /ɰʀ/. In grammatical material, this is disambiguated by writing either #w[rr-r], e.g.
#w[férr-rásvát’h] ‘a long, deep sleep’, or #w[r-rr], respectively, but in actual text, both are written #w[rrr].

=== Vowels
The vowels are mostly spelt as one might expect; nasalised vowels are indicated by an acute, and nasal vowels by a circumflex.
The variants of /i, y, u, a, e/ are spelt with ⟨i, y, u, a, e⟩ as their base letters. Nasal /ẽ/ and /ẽ̃/ as well as Schwa are
indicated by adding a dot below the ⟨e⟩ in grammars and dictionaries only.

Oral /ɛ/ is rare and is spelt ⟨è⟩. Word-initially and word-finally, a grave indicates that the vowel is voiceless. Word-final
/ə/ is always voiceless.#footnote[Thus, a word-final ⟨e⟩
can be /e/, such as in #w[vvaúríhe] /ʋ̃ːɔ̃ɰĩˈhe/ ‘to remember’, or /ə̥/, such as in #w[dale] /daɮ̃ə̥/ ‘table’. As a rule of thumb, it is
usually /e/ at the end of verb stems—but not verb forms in general—and /ə̥/ elsewhere. Fortunately they are differentiated by a
dot below in dictionaries and in this grammar: #w[vvaúríhe] vs #w[ḍalẹ].]

=== /o/

The vowel /o/ is spelt ⟨au⟩ or ⟨o⟩ for diachronic reasons; when ⟨au⟩ is accented, the acute or circumflex is added only to the
⟨u⟩.#footnote[The diphthong /au/ is spelt ⟨äu⟩, ⟨aü⟩, or with accents on both vowels.] Generally speaking, there is no consistent
rule as to which one is used in what circumstances, though ⟨au⟩ usually preferred (especially word-initially)—even if the
PF root was spelt with ⟨o⟩—except word-finally and after ⟨w⟩. As an exception to the exception, in verb affixes, #w[au] is quite
common word-finally. This notwithstanding, the sequence ⟨wau⟩ does not exist in UF.

The distinction between ⟨au⟩ and ⟨o⟩ sometimes used contrastively: e.g. #w[faúr] may mean ‘force’ or ‘form’; thus, when the
intended meaning is not obvious from context, the latter is usually spelt #w[fór] instead, e.g. #w[av́ár sb’haúr] ‘to have force’
as opposed to #w[av́ár sb’hór] ‘to have form’. However, #w[aḍrá faúr] ‘to take shape’, an idiom, is never spelt \*#w[aḍrá fór].

Lastly, note that ⟨áu⟩, which is rare, but occurs e.g. in the superlative case, is pronounced /ɑ̃u/.

=== Dot Below
A dot below or above a letter is commonly to indicate
a variety of different things, depending on the letter:
- a dot below in #w[ḅ], #w[ḍ] indicates that they are the ‘hard’ variants of the letter, which are pronounced
      the same, but lenited differently;

- a dot below in #w[ḷ] indicates that it is palatal /ʎ̝̃/ instead of alveolar /ɮ̃/;
- a dot below in #w[ẹ] indicates that it is a schwa;
- a dot below in #w[ẹ̀] indicates that it is /e̥/;
- a dot below nasalised #w[ẹ́], #w[ệ] indicates that they are /ẽ/, /ẽ̃/ instead of /ɛ̃/, /ɛ̃̃/;
- a dot below in #w[c̣] indicates that it is lenited /j̊/.


Thus, in non-grammatical writing, the following are indistinguishable:
- #w[l] can be palatal /ʎ̝̃/ or alveolar /ɮ̃/;

- #w[e] can be a schwa, or /e/;
- #w[é], #w[ê] can be /ɛ̃/, /ɛ̃̃/ or /ẽ/, /ẽ̃/;
- #w[c] can be /ɕ/ or /j̊/.

=== Hyphen <subsec:other-punct>
Elided initial /ɰ/ is indicated by omitting the #w[r] in writing and attaching the word to the previous one with a hyphen,
e.g. #w[-vá] ‘alas’.

UF seldom uses hyphens to separate or join words and instead prefers to spell them as one word instead; an exception
to this is that, starting in the late Early Modern UF period, affixes that end with a vowel are typically separated
from the word they are attached to with a hyphen if that word starts with (a variant of) the same vowel. For example,
the #s[def nom sg] of #w[el] ‘wing’ is #w[láel], but the plural is #w[lé-el], with #w[léel] only found in archaic
writing.

In poetry, as well as in the northern dialect, adjacent vowels may be contracted; an apostrophe is often used if both vowels are oral, e.g. #w[d’ec̣] for
#w[de-ec̣] #s[part pl] of ‘sin’, or #w[’ab’héy] ‘to the bees’. A grave and double grave are used instead to signify contracted
nasalised and nasal vowels, respectively, e.g. #w[lèl] for #w[lé-el]; coalescence is often inconsistent, e.g. both #w[làb’há]
and #w[lȁb’há] are found for #w[lá-áb’há] ‘the child’. Modern dialects that coalesce e.g. #w[lá-áb’há] often simply spell it
#w[lâb’há] instead.


=== Sentence Punctuation and Capitalisation
Only proper nouns (and often also any titles appertaining to them) as well as the first word of a sentence are capitalised.
Exclamation marks, question marks, semicolons, colons—but not commas or full stops—and the interrobang are separated from
the preceding word by a space.

The only punctuation mark that forces capitalisation of the following word is the full stop; capitalisation after other
punctuation marks, such as question marks and exclamation marks, is generally only done if what follows and what precedes
the mark is a full sentence. E.g. it is common to write a vocative followed by an exclamation mark, and the rest of the
sentence after that continues without capitalising the word after the exclamation mark.

== Lenition and Nasalisation
Certain morphological elements subject surrounding context to lenition or nasalisation. Nasalisation affects vowels,
which become more nasal (that is, (voiceless) oral vowels become nasalised, and nasalised vowels become nasal; nasal
vowels are unaffected), as well as #w[ḍ], which becomes #w[n], unless it would directly be preceded by another #w[n], in
which case it is simply deleted.

Lenition is more complicated; it affects only consonants and causes a softening similar to what happened diachronically
between vowels. All ʁ-fricated consonants simply lose their ʁ-frication, and a number of other consonants are also
affected by lenition (note the difference between #w[ḅ, ḍ] and #w[b, d] here). Double consonants are typically unaffected
by morphological lenition, e.g. #w[dír] ‘to say’, whose subjunctive stem is #w[díss], forms #w[aúdíssâ] (rougly ‘we
should have said’), not \*#w[aúdíhhâ].

#[
#show table.cell: it => if (it.x == 0) { align(right, strong(it)) } else { emph(it) }
#center-table(
    caption: [Consonants Affected by Lenition],
    hlineat(1),
    ..vlinesat(1, 4, 5, 6, 8, ..range(9, 17)),
    [ Consonant & c’h & s & z & sw     & c & b & f                        & ḅ   & d   & ḍ   & v́ & ł & ś & ć & ȷ́ & ź  ],
    [ Lenited & #col3[h] & ź & c̣ & #col2[b’h] & bh  & d’h & t’h & v & l & s & c & j & z ],
) <tab:lenition>
]


Affixes, lemmas, etc. that cause lenition or nasalisation are marked in this grammar and in the dictionary
by a superscript #L or #N, respectively, e.g. the accusative singular prefix, which causes lenition, is shown in
the declension table as #w[lá-#L].


== Diachrony and Derivation <subsec:diachrony-and-derivation>
The PF infinitive endings (#w[-ir] etc.) became progressively more vestigial in Middle UF and were eventually
often dropped completely in derivation, e.g. #w[auḍé] ‘obtain’ from earlier \*#w[auḅḍénír], later resulting in
a need for new infinitive affixes to be formed to distinguish infinitives from the base form, thus giving
rise to e.g. #w[dauḍé] ‘to obtain’.

The suffix #w[-t’he], #s[fut] #w[-ḍe], #s[subj] #w[-t’hes], is a productive derivational suffix that can be used to turn a
noun ‘X’ into a verb that roughly means ‘to use X’, e.g. #w[ac] ‘axe’ $arrow$ #w[act’he] ‘to cut with an axe’.

The prefix #w[raú(b’hc’h)-] can be prepended to the stem of a verb to turn it into a causative, additionally takes the
dative, e.g. #w[jraúb’hc’had’hór asaú]
‘I cause the man to love’. The #w[-b’hc’h-] is dropped if the word starts with a consonant, in which case it also
lenites, e.g. #w[raúd’hír] ‘make someone say’. This is rather archaic; the preferred way to express a causative in
modern UF is with the verb #w[rób’hoc’h].

The suffixes #w[-aû] and #w[#L;-vâ] can be appended to any verb that expresses an action with a result to denote that
result. Generally, the former is used if the result is an abstract concept, e.g. #w[iý’ývî] ‘illuminate’ $arrow$ #w[iý’ývîaû]
‘illumination’, and the latter for concrete objects, but this may vary depending on the verb in question and on dialect.

The suffix #w[-(é)raû] can be appended to a noun to denote a profession, specifically someone who regularly engages in
creating or constructing the noun in question, e.g. #w[ḍalẹ] ‘table’ $arrow$ #w[ḍaléraû] ‘carpenter’. The #w[é] is retained
if the noun ends with a consonant; it replaces word-final #w[ẹ], and is dropped itself if the word ends with any other vowel,
to which a level if nasalisation is added if possible.

The #s[indef orn] affix #w[vén-] can be attached to nouns to form something that behaves more or less like an adjective,
though this technically a case affix and not derivation; a more detailed description of this phenomenon is given
in @subsec:ornative.

#chapter([Nouns], "accidence")
This chapter covers nouns in the broad sense, i.e. nouns substantive, adjectives, adverbs, numerals, and pronouns.

== Declension <subsubsec:declension>
There are no adpositions in UF—a fact for which it compensates with a total of 50 cases. There are 2 declensions:
a definite declension and an indefinite declension. There is no grammatical gender distinction in nouns,#footnote[Some
nouns _do_ exhibit natural gender, but this is only relevant for verbal inflexion.] and there are no
morphologically separate articles.

Throughout this grammar—as well as in the dictionary—cases, number, and definiteness will be abbreviated and set in small-caps,
e.g. #s[def acc sg] for ‘definite accusative singular’.  See the glossary at the start of this grammar for an exaustive
list of these abbreviations.

For the sake of brevity, cases are assumed to be #s[def sg] unless otherwise stated, e.g. the #s[def acc sg] is written
as just #s[acc], and the #s[indef acc sg] and #s[def acc pl] as #s[acc indef] and #s[acc pl], respectively. Number and
definiteness are also omitted when they are irrelevant, e.g. in the dictionary, when a verb is stated to take an #s[acc]
argument, it can be in any number or definiteness, so long as it is accusative.

@tab:table-uf-declension below shows the most common cases of the definite and indefinite declensions. Cases
are divided into primary (@sec:decl-primary), secondary (@sec:decl-secondary), and tertiary
cases (@sec:decl-tertiary). There is also an extended set of affixes only used in stacking; for that, see @sec:declension-stacking.

Some of the case prefixes cause lenition or nasalisation in the initial consonant of the noun, e.g. #w[ḍalẹ] ‘table’ to
#s[def acc sg] #w[s’thalẹ]. Unlike verbal affixes, case prefixes never coalesce with the stem in the standard
dialect.#footnote[They do in the #s[nd], see @sec:nd-nouns.]
@tab:dale-declension shows the paradigm of #w[ḍale] ‘table’ in its #s[def] and #s[indef] forms; this, of course,
is a rather extreme example, as the initial #w[ḍ] means that it is subject to both lenition and nasalisation.

The diachrony of these forms is mostly from the PF definite and indefinite pronouns as well as from PF prepositions, though
some forms, such as the #s[acc], are borrowed from demonstratives instead (#s[def] from #pf[celui] and #s[indef] from
#pf[ce]); the #s[def part] forms are from the PF partitive article, and the indefinite forms are formed with an additional
#w[d-] by analogy to the definite forms. The locative cases are combinations of the articles and PF prepositions. The
#s[abl] is from #pf[loin de] ‘away from’. The diachrony of the #s[gen sg] is unclear.

// There are no ablative/allative variants of the citressive/transessive/contressive; there’s also
// no interelative as the elative is just used instead.
//
// Some ‘semi-secret’ or rather fairly irrelevant diachronic notes are given in comments, for anyone interested.
// Note: indef pl had a hypercorrected ‘s’ in PF ‘ces’, hence no lenition
#[
#let declension-table(caption, lbl, ..cells) = {
    pagebreak()
    v(-.4em)
    show : italic-table-body.with(cols: (0, 4))
    [
        #figure(caption: caption, rowtable(
            ..vlinesat(1, 2, 5, 6),
            ..(1, 9, 21).map(y => table.hline(y: y, end: 3)),
            ..(1, 9, 21).map(y => table.hline(y: y, start: 4)),
            align: left,
            row-gutter: -.32em,
            table.header[Definite & Sg & Pl && Indefinite & Sg & Pl #v(.3em)],
            ..cells.pos()
        ))
        #label(lbl)
    ]
}

#declension-table(
    [UF Declension],
    "tab:table-uf-declension",
    [Absolutive      & $emptyset$      & l-             && Absolutive    & $emptyset$-#N & $emptyset$-#L ],
    [Nominative      & lá-#L            & lé-#L          && Nominative    & ŷn-#N          & ý-#L           ],
    [Vocative        & $emptyset$-#L   & $emptyset$-#N && Vocative      & /              & /              ],
    [Partitive       & dy-#L            & dẹ-#L          && Partitive     & dŷn-#N         & dý-#L          ],
    [Accusative      & i-#L             & sý-#L          && Accusative    & s-#L           & s-             ],
    [Genitive        & á-#L             & abh-#L         && Genitive      & sý-#N          & sý-#L          ],
    [Dative          & as-#L            & a-#L           && Dative        & an-#N          & an-#L          ],
    [Instructive     & ráh-#L           & ráh-           && Instructive   & rút’hýn-#N     & rút’hýz-       #v(.3em)],

    [Essive          & ḅáł-             & ḅá-            && Essive        & ḅárýn-         & ḅárý-          ],
    [Abessive        & sá-#L            & sá-#N          && Abessive      & sáhýn-         & sáhý-          ],
    [Translative     & cáj-             & cájvâ-         && Translative   & cájŷn-         & cájvý-         ], // change(ments)
    [Exessive        & saú-             & saúr-          && Exessive      & saút’hŷn-      & saút’hý-       ], // sortir
    [Considerative   & słá-             & słé-           && Considerative & sý’óýn-        & sý’óý-         ],
    [Causal          & ah-#N            & áh-#N          && Causal        & ahýn-          & áhý-           ], // ‘à cause de’ / ‘ensemble’ both give ah-/áh-
    [Instrumental    & b’hel-           & b’he-          && Instrumental  & b’he(hý)(n)-   & b’heh-         ],
    [Comitative      & réd’h-           & ré-#L          && Comitative    & rén-           & réd’hý-        ], // près de
    [Contrative      & c’haú-#L         & c’haú-         && Contrative    & c’haút’hýn-    & c’haút’hý-     ], // contre
    [Substitutive    & ḷý-#L            & lḷý-#N         && Substitutive  & ḷýn-           & lḷýn-          ],
    [Distributive    & ca#L;-            & cac’h-         && Distributive  & cahýn-         & cahý-         ], // chaque
    [Ornative        & vé-#L            & véḍ-           && Ornative      & vé(t’hý)n-     & vét’hý-        #v(.3em)], // mettre

    [Illative        & ádá-             & ádé-           && Illative      & ádŷn-          & ádŷ-           ],
    [Inessive        & dwá-             & dwé-           && Inessive      & dáhŷn-         & dáhŷ-          ],
    [Elative         & órd-             & aúr-           && Elative       & órdŷn-         & aúrŷ-          ],
    [Allative        & b’hé-#L          & b’hér-         && Allative      & b’hŷn-#N       & b’hý-#L        ],
    [Adessive        & raú-             & raúc-          && Adessive      & raúcŷn-        & raúcý-         ], // proche
    [Ablative        & rê(d)-           & rês-           && Ablative      & rêdýn-         & rêdý-          ],
    [Postlative      & réh-#L           & réh-           && Postlative    & réhýn-#N       & réhyl-         ], // reculer
    [Postessive      & déry’            & dér-           && Postessive    & déry’ýn-       & déry’ý-        ],
    [Postelative     & dý’ab’h-         & dý’a-          && Postelative   & dý’ab’hýn-     & dý’ab’hý-      ], // de l’avant
    [Antallative     & rab’há-          & rab’h-         && Antallative   & rab’hŷn-       & rab’hŷ-        ], // ANTESS + ‘r-’ from PSTLAT
    [Antessive       & ab’há-           & ab’h-          && Antessive     & ab’hŷn-        & ab’hŷ-         ], // avant
    [Antablative     & dab’há-          & dab’h-         && Antablative   & dab’hŷn-       & dab’hŷ-        ], // ANTESS + ‘d-’ from PSTELA
    [Superlative     & áu-              & áud’h-         && Superessive   & án-            & ád’hý-         ], // en haut de (in UF, /ɑ̃o/ > /ɑ̃u/)
    [Superessive     & sýr-             & dẹ(h)-#L       && Superessive   & dẹhýn-         & sýrŷ-          ],
    [Delative        & áb’há-           & áb’h-          && Delative      & áb’hýn-        & áb’hŷ-         ], // en bas
    [Sublative       & c’huý’-          & c’hu-          && Sublative     & c’hýn-         & c’hý-          ], // couler
    [Subessive       & faú-             & fau-           && Subessive     & faúýn-         & faúý-          ], // fond
    [Surlative       & vaû-             & vaût’h-        && Surlative     & vaût’hýn-      & vaût’hý-       ], // monter
    [Interlative     & sér-             & sé-#L          && Interlative   & sérýn-         & sérý-          ], // insérer
    [Interessive     & aḍá-             & aḍé-           && Interessive   & aḍŷn-          & aḍŷ-           ], // entre
    [Circumlative    & ḍúr-#L;(d’h)-     & ḍúr-           && Circumlative  & ḍúrýn-         & ḍúrŷ-          ], // autour de
    [Circumessive    & auḍúr-#L;(d’h)-   & auḍúr-         && Circumlative  & auḍúrýn-       & auḍúrŷ-        ], // autour de
    [Circumablative  & rêt’húr-#L;(d’h)- & rêt’húr-       && Circumlative  & rêt’húrýn-     & rêt’húrŷ-      ], // loin de autour de
    [Citressive      & dẹh-             & dẹs-           && Citressive    & dẹhŷn-         & dẹsŷ-          ], // deçà
    [Transessive     & ḅár-             & ḅárd-          && Transessive   & ḅárŷn-         & ḅárŷ-          ], // par-delà
    [Transallative   & rébhár-          & reḅárd-        && Transallative & réhýnár-       & réhylá-        ], // POSTL + TRANSESS
    [Contressive     & át’h-#L          & át’h-          && Contressive   & át’hýn-        & át’hý-         ],
    [Orientative     & fér-             & férf-          && Orientative   & férýn-         & férý-          ], // faire face
    [Revertive       & det’h-           & det’hú-        && Revertive     & det’hýn-       & det’hý-        ], // détourner
    [Perlative       & lý’aú-#L;(d’h)-   & lý’aú-         && Perlative     & lý’ýn-         & lý’ý-          ], // le long de
)

#declension-table(
    [Paradigm of #w[ḍalẹ]],
    "tab:dale-declension",
    [Absolutive        & ḍalẹ             & lḍalẹ              && Absolutive      & ḍalẹ́            & ḍalẹ          ],
    [Nominative        & lát’halẹ         & lét’halẹ           && Nominative      & ŷnalẹ           & ýt’halẹ       ],
    [Vocative          & t’halẹ           & nalẹ               && Vocative        & /               & /             ],
    [Partitive         & dyt’halẹ         & dẹt’halẹ           && Partitive       & dŷnalẹ          & dýt’halẹ      ],
    [Accusative        & it’halẹ          & sýt’halẹ           && Accusative      & st’halẹ         & sḍalẹ         ],
    [Genitive          & át’halẹ          & abht’halẹ          && Genitive        & sýnalẹ          & sýt’halẹ      ],
    [Dative            & ast’halẹ         & at’halẹ            && Dative          & analẹ           & ant’halẹ      ],
    [Instructive       & ráht’halẹ        & ráhḍalẹ            && Instructive     & rút’hýnalẹ      & rút’hýzḍalẹ   #v(.3em)],

    [Essive            & ḅáłḍalẹ          & ḅáḍalẹ             && Essive          & ḅárýnḍale       & ḅárýḍale      ],
    [Abessive          & sát’halẹ         & sánalẹ             && Abessive        & sáhýnḍale       & sáhýḍale      ],
    [Translative       & cájḍalẹ          & cájvâḍalẹ          && Translative     & cájŷnḍalẹ       & cájvýḍalẹ     ],
    [Exessive          & saúḍalẹ          & saúrḍalẹ           && Exessive        & saút’hŷnḍalẹ    & saút’hýḍalẹ   ],
    [Considerative     & słáḍalẹ          & słéḍalẹ            && Considerative   & sý’óýnḍalẹ      & sý’óýḍalẹ     ],
    [Causal            & ahnalẹ           & áhnalẹ             && Causal          & ahýnḍalẹ        & áhýḍalẹ       ],
    [Instrumental      & b’helḍalẹ        & b’heḍalẹ           && Instrumental    & b’hehýḍalẹ      & b’hehḍalẹ     ],
    [Comitative        & réd’hḍalẹ        & rét’halẹ           && Comitative      & rénḍalẹ         & réd’hýḍalẹ    ],
    [Contrative        & c’haút’halẹ      & c’haúḍalẹ          && Contrative      & c’haút’hýnḍalẹ  & c’haút’hýḍalẹ ],
    [Substitutive      & ḷýt’halẹ         & lḷýnalẹ            && Substitutive    & ḷýnḍalẹ         & lḷýnḍalẹ      ],
    [Distributive      & cat’halẹ         & cac’hḍalẹ          && Distributive    & cahýnḍalẹ       & c’hahýḍalẹ    ],
    [Ornative          & vét’halẹ         & véḍḍalẹ            && Ornative        & vénḍalẹ         & vét’hýḍalẹ    #v(.3em)],

    [Illative          & ádáḍalẹ          & ádéḍalẹ            && Illative        & ádŷnḍalẹ        & ádŷḍalẹ       ],
    [Inessive          & dwáḍalẹ          & dwéḍalẹ            && Inessive        & dáhŷnḍalẹ       & dáhŷḍalẹ      ],
    [Elative           & órdḍalẹ          & aúrḍalẹ            && Elative         & órdŷnḍalẹ       & aúrŷḍalẹ      ],
    [Allative          & b’hét’halẹ       & b’hérḍalẹ          && Allative        & b’hŷnalẹ        & b’hýt’halẹ    ],
    [Adessive          & raúḍalẹ          & raúcḍalẹ           && Adessive        & raúcŷnḍalẹ      & raúcýḍalẹ     ],
    [Ablative          & rêḍalẹ           & rêsḍalẹ            && Ablative        & rêdýnḍalẹ       & rêdýḍalẹ      ],
    [Postlative        & réht’halẹ        & réhḍalẹ            && Postlative      & réhýnalẹ        & réhylḍalẹ     ],
    [Postessive        & déry’ḍalẹ        & dérḍalẹ            && Postessive      & déry’ýnḍalẹ     & déry’ýḍalẹ    ],
    [Postelative       & dý’ab’hḍalẹ      & dý’aḍalẹ           && Postelative     & dý’ab’hýnḍalẹ   & dý’ab’hýḍalẹ  ],
    [Antallative       & rab’háḍalẹ       & rab’hḍalẹ          && Antallative     & rab’hŷnḍalẹ     & rab’hŷḍalẹ    ],
    [Antessive         & ab’háḍalẹ        & ab’hḍalẹ           && Antessive       & ab’hŷnḍalẹ      & ab’hŷḍalẹ     ],
    [Antablative       & dab’háḍalẹ       & dab’hḍalẹ          && Antablative     & dab’hŷnḍalẹ     & dab’hŷḍalẹ    ],
    [Superlative       & áuḍalẹ           & áud’hḍalẹ          && Superessive     & ánḍalẹ          & ád’hýḍalẹ     ],
    [Superessive       & sýrḍalẹ          & dẹt’halẹ           && Superessive     & dẹhýnḍalẹ       & sýrŷḍalẹ      ],
    [Delative          & áb’háḍalẹ        & áb’hḍalẹ           && Delative        & áb’hýnḍalẹ      & áb’hŷḍalẹ     ],
    [Sublative         & c’huý’ḍalẹ       & c’huḍalẹ           && Sublative       & c’hýnḍalẹ       & c’hýḍalẹ      ],
    [Subessive         & faúḍalẹ          & fauḍalẹ            && Subessive       & faúýnḍalẹ       & faúýḍalẹ      ],
    [Surlative         & vaûḍalẹ          & vaût’hḍalẹ         && Surlative       & vaût’hýnḍalẹ    & vaût’hýḍalẹ   ],
    [Interlative       & sérḍalẹ          & sét’halẹ           && Interlative     & sérýnḍalẹ       & sérýḍalẹ      ],
    [Interessive       & aḍáḍalẹ          & aḍéḍalẹ            && Interessive     & aḍŷnḍalẹ        & aḍŷḍalẹ       ],
    [Circumlative      & ḍúrt’halẹ        & ḍúrḍalẹ            && Circumlative    & ḍúrýnḍalẹ       & ḍúrŷḍalẹ      ],
    [Circumessive      & auḍúrt’halẹ      & auḍúrḍalẹ          && Circumessive    & auḍúrýnḍalẹ     & auḍúrŷḍalẹ    ],
    [Circumablative    & rêt’húrt’halẹ    & rêt’húrḍalẹ        && Circumablative  & rêt’húrýnḍalẹ   & rêt’húrŷḍalẹ  ],
    [Citressive        & dẹhḍalẹ          & dẹsḍalẹ            && Citressive      & dẹhŷnḍalẹ       & dẹsŷḍalẹ      ],
    [Transessive       & ḅárḍalẹ          & ḅárdḍalẹ           && Transessive     & ḅárŷnḍalẹ       & ḅárŷḍalẹ      ],
    [Transallative     & rébhárḍalẹ       & reḅárdḍalẹ         && Transallative   & réhýnárḍalẹ     & réhyláḍalẹ    ],
    [Contressive       & át’ht’halẹ       & át’hḍalẹ           && Contressive     & át’hýnḍalẹ      & át’hýḍalẹ     ],
    [Orientative       & férḍalẹ          & férfḍalẹ           && Orientative     & férýnḍalẹ       & férýḍalẹ      ],
    [Revertive         & det’hḍalẹ        & det’húḍalẹ         && Revertive       & det’hýnḍalẹ     & det’hýḍalẹ    ],
    [Perlative         & lý’aút’halẹ      & lý’aúḍalẹ          && Perlative       & lý’ýnḍalẹ       & lý’ýḍalẹ      ],
)
]

== Primary Cases <sec:decl-primary>
In UF grammar, the term #w[cyḍ révy’ẹ́â] ‘primary case’ refers to the cases that are commonly used to mark complements
of verbs, i.e. the #s[abs, nom, acc, part, gen, dat], and participles, e.g. the #s[insv].

There are some general rules
as to what cases are used in what situations, but this can often depend on the verb in question, e.g. the subject of a verb
may be in the #s[abs], #s[nom], or even in the #s[acc] or #s[part], or some other case, though the first two are by far
the commonest. What cases are used with what verbs (in addition to the general rules below) is indicated for each verb
in the dictionary.

=== Absolutive
The #s[abs] is the base form of the noun, with the #s[abs def] being identical to the uninflected root, which is also
used as the citation form. It is used mainly in contexts where no case marking is otherwise assigned to noun. There is
an additional set of ‘augmented’ #s[abs] affixes; see @sec:declension-stacking for that.

#partitle[Verbs of Being and Becoming]
The #s[abs] is used for the subject and predicate noun of predicative sentences,
i.e. ‘X’ and ‘Y’ in ‘X is Y’, the subject of a sentence whose predicate is an adjective verb, and the subject of a verb
that carries a sense of being or becoming:

- #w[Aúsó ḍe *ráhó*.] ‘We are all fish.’
- #w[*Ráhó* sausc’hýr.] ‘The fish is dark.’
- #w[*Aú* sdẹb’hní cájŷnárb.] ‘The man turned into a tree.’
- #w[*Aý’èc’hsád* lẹy’abhá.] ‘He called himself Alexandre.’

Note that this use can lead to ambiguity, e.g. #w[vaût’há se ráhó] could mean ‘a mountain is a fish’ or ‘a fish is a
mountain’ (word order is irrelevant here). However, if the nouns have different number or the subject is gendered,
this is disambiguated since the verb will agree with the subject, e.g. #w[*Cár* le ráhó] ‘Charles is a fish’, as opposed to
#w[Cár se *ráhó*] ‘a/the fish is Charles’.

#partitle[Modifiers]
Additionally, the #s[abs] turns nouns into modifier nouns. The modifier is generally placed after the noun it modifies,
though this is only mandatory if ambiguity would arise otherwise.

- #w[abhárḍihyl *lývy’ér*] ‘of light particles’
- #w[ḍaléraû *véḍ* âférér] ‘made by a master carpenter’
- #w[lásásc’hríḍ *raúl*] ‘the Sanskrit language’

#partitle[Interjections]
The #s[abs] is also used in ‘sentences’ without a verb, such as interjections.

- #w[*Faúrḍ* ry’élâ !] ‘A cruel fate!’

=== Nominative
The #s[nom] is one of the most common cases in UF; its main and really only use is to mark the subject of an active sentence.

- #w[Seb’h dwásẹ #b[lá]raúb’hẹ.] ‘The robot was here.’
- #w[Lasẹhérélé au #b[lá]b’haúré au #b[lá]haul.] ‘The Sun and the North Wind were quarreling.’


The #s[indef nom sg] #w[ŷn-] prefix and some other forms nasalise nouns; as a reminder, this means that in
nouns starting with #w[ḍ], the #w[ḍ] is deleted, e.g. #w[ŷnalẹ] ‘a table’; it causes nasalisation in words
that start with a vowel e.g. #w[ehyó] ‘shield’ to #w[ŷnéhyó] ‘a shield’. As lenition, nasalisation too is
blocked in rarer forms, e.g. #s[indef iness] #w[dáhŷnḍalẹ] ‘on a table’.

=== Vocative
The vocative is a rare case that is used to address someone or something, e.g. #w[C̣ár !] ‘O Charles!’. The vocative
only occurs in the definite and usually with proper nouns.#footnote[The indefinite #s[voc]
does not exist, as that would be nonsense.] Note that the vocative is not marked by an affix, but
rather by mutation only, e.g. #w[C̣ár] from #w[Cár]. There is also an additional set of ‘augmented’ #s[voc] affixes;
see @sec:declension-stacking for that.

In novels and other literary media, vocatives are often italicised since they can otherwise be hard to distinguish
from absolutives in some cases.

=== Accusative and Partitive
These two cases, while often different in meaning, are almost identical in grammatical purpose: Their main use is to
mark the theme of a verb. Some verbs, e.g. #w[ub’hrá] ‘to be able to’ always take a #s[part], and others
always take an #s[acc]; there are a few verbs that can take either case, in which case the difference is one of semantics:
the #s[part] then indicates that an action is only performed partially or that it is incomplete. However, most verbs only
admit one of the two.

- #w[Jlí #b[s]liv́uhé.] ‘I peruse a book.’
- #w[Jlí #b[dŷn]liv́uhé.] ‘I read from a book.’ or ‘I am reading a book.’
- #w[Jlíé #b[i]liv́uhé.] ‘I’ve read the book (to completion).’
- #w[Jlíá #b[dy]liv́uhé.] ‘I was reading (from) the book.’

The #s[acc/part] are also used in a construction known as the #s[aci/pci] (see @subsec:aci-pci).

=== Genitive
The #s[gen] case is one of the more commonly used cases of UF. While its primary use is to indicate possession
or belonging, there are also a number of verbs that govern the #s[gen], and it also used to mark the standard of
comparison in a variety of constructions, as well as to denote the topic of conversation.

#partitle[Possession]
The possessor can precede or follow its possessee. Typically,
the #s[gen] directly follows the possessee, but if the possessee is qualified with adjectives, then the adjectives must follow the
possessee immediately, lest they end up qualifying the genitive instead, and thus, the genitive is placed either before the
noun, or after any adjectives. Possessive pronouns, instead typically precede the noun.

- #w[ḅárḍẹ sásy’élâ #b[á]raúl] ‘an essential part of the language’
- #w[c’haúnéhás #b[á]rráḍraúc ausc’hýrâ] ‘knowledge of the dark side’
- #w[#b[vaú] ḍalẹ] ‘my table’

#partitle[Comparison]
In comparisons, usually involving adjectives, the #s[gen] marks the standard of comparison (see @subsec:comparison).

- #w[aûlẹrá #b[á]raúvá] ‘no bigger than the moon’
- #w[Sẹh láisḍrár svaût lybhárdyt’há ihaúb’héc’h #b[á]y’aúý’á dẹrêfihasjú.] \
  ‘This tale shows that often persuation is more efficient than violence.’
- #w[Rá vy’í #b[daú].] ‘I am as tall as you.’
- #w[#b[Áy’ér] dŷncẹaû syb’hér.] ‘It is as hot as yesterday.’
- #w[sýrá dý] ‘by two months’

#partitle[Objects]
The #s[gen] is also used to mark the complement of certain verbs.

- #w[Lẹc’hlýr #b[sý]rjẹ.] ‘He sells comic books.’
- #w[#b[Daú] jady’ŷ.] ‘I bid you farewell.’
- #w[Ssívý’érá #b[sýn]árb.] ‘It was similar to a tree.’
- #w[vâhâ #b[sý]faúr] ‘lacking strength’
- #w[c’haúḅlérâ #b[sý]válfèzâ] ‘to be complacent in the presence of evildoers’

#partitle[Topic]
Another use of the #s[gen] is to mark that a particular action is performed with respect to something.

- #w[Llac’hrírá #b[sý]árb.] ‘She wrote about trees.’
- #w[Jlí #b[abh]ráy’á Ahehár.] ‘I read of Caesar’s travels.’
- #w[Aúḅály’aû #b[á]rývýr.] ‘We were talking about history.’

=== Dative
The #s[dat] case is used to indicate the indirect object of most ditransitive verbs. Some verbs may instead govern a different case,
such as the allative. Unlike most other cases, there actually are dative affixes (see @subsubsec:dative-affixes)
that are usually, but not always, used in place of separate pronouns.

#partitle[Indirect Objects]
The #s[dat] is used with a large number of ditransitive verbs.

- #w[Dyvérs jféré #b[as]aú.] ‘I thanked the man.’
- #w[Jv́ár#b[b’hẹ] sufb’h vaú.] ‘I owe you my life.’
- #w[Jdónẹ́#b[ḷẹ] iárb.] ‘I bestow upon him a tree.’


#partitle[Beneficiary]
Another use of the dative is to indicate a beneficiary or recipient in a more general sense.

- #w[Jsyfér #b[as]vẹ.] ‘I did it for me.’
- #w[Jsydíré #b[as]lẹ.] ‘I said it for his sake.’
- #w[#b[As]a c’hes sydír?] ‘For whom is it said?’

=== Instructive
The #s[insv] case is used for the ‘subject’#footnote[This can also be paired with a passive participle, in which case the
#s[insv] ends up denoting the patient.] of non-finite verbs—chiefly participles. Its main use is as part of the so-called _instructive
absolute_, in which a noun without any thematic role is combined with a participle—similarly to the _ablative absolute_ in
Latin or the _genitive absolute_ in Ancient Greek. In some cases (particularly in idioms), the participle can even be
omitted if it is obvious from context.

- #w[#b[Ráh]t’halẹ âdárér, raḅraúcó b’héárb.] ‘The table thrown, we approach the tree.’
- #w[#b[ráh]ráhut’h b’helvê] ‘(with) sword in hand’

Note that the #s[insv] is _not_ used for appositions, but rather to introduce an unrelated noun. For appositions and
titles, see @subsubsec:names-and-titles. For the use of participles as adjectives, see @subsec:participle-tense.

== Secondary Cases <sec:decl-secondary>
The ‘secondary cases’ (UF #w[lcyḍ dýzy’êâ]) are cases that elude broader classification; this category comprises anything
that is not a primary or locative case.

=== Essive
The #s[ess] case is used to mean ‘as X’, ‘like X’, ‘in the form of X’, or ‘in the role of X’. It can also be used to
communicate the state of mind or material of something. See also @subsec:ornative on the #s[orn] case below,
which can sometimes overlap with the #s[ess] in meaning. In Middle UF, and sometimes still in poetry, the #s[ess] may be
used interchangeably with the #s[iness] to indicate specifically an ongoing temporal state.

- #w[Lẹt’hiy’e dyt’halẹ #b[ḅárýn]y’éjúré.] ‘He uses the table as a chair.’
- #w[dáhŷnáẹ #b[ḅárýn]rê] ‘in a copper sky’
- #w[#b[ḅárýn]c’hánár âḅét’hýrér] ‘like a painted ship’
- #w[#b[ḅáł]víd’hẹ] ‘at noon’
- #w[Laḅraúc̣á #b[ḅárýn]suh b’hévẹ.] ‘He approached me with fear.’

The last example, #w[Laḅraúc̣á ḅárýnsuh b’hévẹ], specifically means ‘He was was afraid while he approached me’. Compare this
with a similar sentence that uses the #s[instr] instead, #w[Laḅraúc̣á b’hensuh b’hévẹ], which can also be translated as
‘He approached me with fear’.

The #s[instr] variant is more accurately translated
as ‘He was fear while approaching me’ (‘was fear’, _not_ ‘was in fear‘, as in he was fear itself). The #s[ess]
indicates that he was afraid, the #s[instr] that either he used fear in some manner to facilitate his approach
or that his approach caused me fear. More generally speaking, the #s[instr] always indicates a medium or tool by means
of which or utilising which something is accomplished.

=== Abessive
The #s[abess] case denotes the lack or absence of something.

- #w[#b[sá]-árb] ‘without the tree’
- #w[#b[sáhýn]vúb’hvâ] ‘without movement’

=== Translative
The #s[transl] case indicates the end or target state of a process or transformation.

- #w[Aú sdẹb’hní #b[cájŷn]árb.] ‘The man turned into a tree.’

=== Exessive
The #s[exess] case indicates a transition out of a state.

- #w[Aú sdẹb’hní #b[saút’hŷn]árb.] ‘The man ceased being a tree.’

=== Considerative
The #s[cons] case is a bit of a weird one and can be translated as ‘according to’, or ‘in the opinion of’, and is used to
express the opinion of the speaker or point out something as an opinion, belief, or hypothesis of someone or something.

- #w[#b[słé]rá ḍẹ c’hóný áb’hásy’ô] ‘according to all known laws of aviation’

=== Causal
The causal case indicates that something is the cause for something else.

- #w[#b[ah]ârb] ‘because of the tree’

=== Instrumental
The #s[instr] case is used to indicate the instrument or means using or by which an action is performed.

- #w[#b[b’he]ac] ‘with an axe’
- #w[#b[b’hen]c’hánár] ‘by boat’
- #w[#b[b’he]faúr lẹvú] ‘with much force’
- #w[#b[b’hel]c’hýr sérệ] ‘with a heavy heart’
- #w[Derâd’há sbhelbec daú #b[b’he]vê.] ‘You grabbed a shovel with your hands.’

The #w[hý] in the #s[indef instr sg] may be omitted arbitrarily, particularly in literary language; there
isn’t really any rule as to when this happens, but it is most common in words that start with a fricative. However, the #w[n]
is always retained if the #w[hý] is omitted, e.g. we have #w[b’henc’hánár] or sometimes #w[b’hehýc’hánár] ‘by boat’, but never
*#w[b’hehýnc’hánár] or *#w[b’hec’hánár]. The #w[n] in the #s[indef instr sg] is omitted according to the same rules
as the #w[d] in the #s[def abl sg].

=== Comitative
The #s[com] case is used to indicate that an action is performed together with someone else.
Since UF has no free personal pronouns in the #s[nom]/#s[acc]/#s[part], the #s[com] is often used when a coordination
with a personal pronoun in those cases would be required:

- #w[Jlýaublit’héré #b[ré]vau.] ‘I defeated them with you.’
- #w[Lẹsẹhérélá lábhabh #b[réd’h]vẹ] ‘My father and I were arguing.’ (lit. ‘Father was arguing with me.’)

Note however that in cases where the person or people the action is being performed with are acting on someone’s
orders, the #s[instr] is used instead of the #s[com]:

- #w[Lẹvárc̣á Sehár B’héraû’z #b[b’he]lejy’aû.] ‘Caesar marched his legions to Rome.’

=== Contrative
The #s[contr] case has the meaning of ‘against’.

- #w[n #b[c’hau]vẹ] ‘hate against me’

=== Substitutive
The #s[subst] case can generally be translated as ‘instead of’ or ‘in lieu of’. Diachronically, this case is
a fossilised form of #w[ḷý] ‘place’.

- #w[Sý’b’héḷý jad’hé #b[lḷý]vau.] ‘I went there instead of you.’

=== Distributive
The #s[distr] case can be translated as ‘per’ or ‘for each one’.

- #w[raút’h #b[cac’h]ly] ‘a loaf of bread for each of them’
- #w[réhèḍ #b[cahýn]db’hid’h] ‘income per capita’
- #w[b’hénvâ #b[cahýn]y’úr] ‘a daily occurrence’

=== Ornative <subsec:ornative>
The #s[orn] case indicates quality possessed by something or that something is endowed with. Nouns in the
#s[orn] function much like adjectives, and in a sense, the #s[indef orn] can instead be thought of as a
derivational marker that turns nouns into adjectives and which functions much like English _-ly_.

Traditionally,
the #s[indef orn] affix was #w[vét’hýn-], but since it is such a common case, it is usually shortened to #w[vén-]
in Modern UF, even in academic or literary writing.

- #w[aú #b[vén]faúr] ‘the powerful man’ (lit. ‘the man endowed with force’)
- #w[sehár #b[vén]c’húraû] ‘a king bearing a crown’

The #s[orn] can be similar in meaning to the #s[ess]; the exact difference between the two depends on the word:
for abstract concepts, the #s[orn] is generally preferred and denotes that the quality or concept in question
appertains to the object qualified by the #s[orn], whereas the #s[ess] indicates that the object serves as a
stand-in or is in some way equivalent to the concept.#footnote[The #s[ess] is sometimes also used in the former
sense in poetry, but such usage is rare and rather archaic.] Abstract concepts in the #s[orn] are generally
#s[indef].

- #w[#b[vén]b’hauý’ý] ‘voluminous’ (lit. ‘endowed with volume’; a euphemism for ‘overweight’)
- #w[vár #b[vén]aúrd] ‘an orderly march’

However, the #s[ess] is preferred in metaphors and figurative descriptions, as well as to indicate the (primary)
material that something is made of.

- #w[dáhŷnáẹ #b[ḅárýn]rê] ‘in a copper sky’
- #w[lvúr #b[ḅárý]vaût’há] ‘walls [which are] like mountains’
- #w[ḍalẹ #b[ḅárýn]rád’hyr] ‘the wooden table’

With concrete objects, the difference between the two becomes more obvious: a concrete object in the #s[orn]
signifies physical attachment or decoration, whereas an #s[ess] communicates likeness, resemblance, or
that an object is used as a stand-in for something else.

Note that word order can matter here: if the #s[ess] is separated from the noun it qualifies by an adjective,
it ends up qualifying the adjective instead. While this is technically also the case for the #s[orn], the two
interpretations are more likely to be semantically equivalent than in the #s[ess].

- #w[abhár ec’hlérâ #b[vén]aúr] ‘a glimmering house decorated with gold’
- #w[abhár #b[vén]aúr ec’hlérâ] ‘a house decorated with glimmering gold’
- #w[abhár ec’hlérâ #b[ḅárýn]aúr] ‘a house shining like gold (but not actually made of gold)’
- #w[abhár #b[ḅárýn]aúr ec’hlérâ] ‘a glimmering house made entirely of gold’

== Tertiary Cases <sec:decl-tertiary>
The latives and locatives, often also called #w[lcyḍ rrázy’êâ] ‘tertiary cases’, are cases that indicate the position of
or movement away from, towards, or in relation to an object.

=== Illative
The #s[ill] case indicates motion into or in some cases towards something.

- #w[#b[Ádá]t’hebhaú] ‘to France’
- #w[Jláb’hóhé #b[ádá-]árrih.] ‘I shoved him into the forest.’

=== Inessive
The #s[iness] indicates that an object is inside another. For objects which you tend to be on top of rather than inside
of, the #s[iness] typically means ‘on (top of)’, but can still mean ‘in’ depending on the context.

- #w[#b[dwá]vnásḍér] ‘in the castle’
- #w[#b[dwá]ḍalẹ] ‘on the table’
- #w[se jaý’aú #b[dwá]ḍalẹ] ‘the nail is in the table’
- #w[dẹsb’hé #b[dáhŷn]ríb’hy’ér] ‘to bathe in a river’
- #w[Ḍẹdévýr c’hes #b[dwá]raúvá?] ‘Do you live on the moon?’

Furthermore, the #s[iness] is used not only for places, but also time and abstract concepts. It generally means
‘while’ or ‘during’ in this context.

- #w[#b[dwá]víd’hẹ] ‘at noon’
- #w[#b[dwá]y’úr] ‘during the day’
- #w[sẹh #b[dwá]b’hizy’ô] ‘in this vision’
- #w[#b[dwá]dír « jad’hór »] ‘while saying “I love you”’#footnote[Lit. ‘in the saying of “I love you”’]

=== Elative
The #s[ela] expresses motion out of or down from something—whether the sense is ‘out of’ or ‘down from’ depends on the
same criteria as the #s[iness]: if the latter means ‘in’, the former means ‘out of’, and vice versa.

- #w[Jrét’hír ijaý’au #b[órd]ḍalẹ.] ‘I pull the nail out of the table.’
- #w[sy’b’hâ #b[órd]vérr] ‘rising from the ocean’

When paired with the #s[ill], the meaning of the two is often ‘from X to Y’, or, if the word is the same, ‘X after X’,
or ‘X and X again’, signifying repetition.

- #w[#b[órd]raúvá ádásaul] ‘from moon to sun’
- #w[#b[órd]y’úr ádáy’úr] ‘day after day’

=== Allative
The #s[all] indicates motion towards, but not inside of something. Note that this applies to concrete objects; for
abstract concepts, the #s[transl] is used instead.

- #w[#b[B’hé]t’hebhaú] ‘in the general direction of France’
- #w[#b[b’hé]d’hẹhẹ dẹnájẹ] ‘to swim to the surface’
- #w[Jrâhaút’hé #b[b’hŷn]âví y’ér.] ‘I met a friend yesterday.’
- #w[Laḅraúc̣á ḅárýnsuh #b[b’hé]vẹ.] ‘He approached me with fear.’

=== Adessive
The #s[adess] case denotes positioning near or next to, but _not_ inside of something. As a result, it can also
be used to mean ‘outside’.

- #w[abhár #b[raú]ríb’hy’ér] ‘the house by the river’

=== Ablative
The #s[abl] signifies motion away from or off an object.

- #w[#b[rê]vá] ‘away from the mast’
- #w[#b[rê]sol ḍauḍé] ‘to gain distance from the ground’

The #w[d] in the #s[def abl sg] and is omitted if the noun starts with a consonant, e.g. #w[rêḍalẹ] ‘from the table’; be
careful especially with words that start with #w[s], whose #s[abl sg] is often mistaken for a plural, e.g. #w[rêsol]
‘from the floor’, but #w[rêssol] ‘from the floors’.

=== Postessive
The #s[pstess] case indicates that an object is directly behind something else.

=== Postlative
The #s[pstlat] case indicates that an object is moving towards directly behind another object.

=== Postelative
The #s[pstela] case indicates motion away from behind an object.

=== Antallative
The #s[antall] case indicates motion towards in front of an object.

=== Antessive
The #s[antess] case denotes that an object is directly before or in front of something.

// Not ‘antelative’ because that could be ‘ante-lative’ or ‘ant-elative’.
=== Antablative
The #s[antabl] case denotes motion away from in front of an object.

=== Superlative
The #s[super] case—not to be confused with the superlative degree of comparison—indicates motion to the top of or on
top of an object.

- #w[#b[áu]ḍalẹ] ‘(towards) atop the table’

This case is one of the few places in the standard dialect where we can observe #w[áu] /ɑ̃u/ which is _not_ the
same as #w[aú] /ɔ̃/.

=== Superessive
The #s[spress] case means ‘above’. Note that it normally does _not_ mean
‘on’; for that, the #s[iness] is generally used instead. In rare cases, however, the #s[spress] _is_ used to mean
‘on’; this is mainly the case for nouns that refer to images, pictures, statues, and other forms of (artistic) imagery.

- #w[#b[sýr]ḍalẹ] ‘above the table’
- #w[#b[dẹhýn]rál] ‘on a canvas’
- #w[#b[dẹhýn]váj] ‘in a picture’

It can also be used figuratively with #w[eḍ] to indicate that someone is about to or in the process of doing something:

- #w[Vy’í sýrḅarḍ.] ‘I’m about to leave.’ (lit. ‘on the leaving’)
- #w[Sýrsẹ !] ‘[I’m] on it!’

The #w[h] in the #s[spress def pl] is omitted if the following sound is a consonant, e.g. #w[dẹhárb] ‘above the trees’
but #w[dẹt’halẹ] ‘above the tables’.

=== Delative
The #s[del] case denotes downwards motion.

=== Sublative
The #s[subl] case denotes motion down towards an object.

=== Subessive
The #s[subess] case denotes positioning below an object.

=== Surlative
The #s[sur] case denotes upwards motion.

=== Interessive
The #s[interess] case conveys the meaning of ‘among’ or ‘between’.

=== Circumablative
The #s[circabl] case denotes motion away from around something. It is a fairly rare case, but despite this, it sees common
use with verbs such as #w[ḅlyc̣] ‘to peel’.

- #w[Jḅlyc̣ #b[rêt’húr]bhaú.] ‘I peel the apple.’

// [TODO: Postelative (idea: ‘out of hiding’ from lit. ‘away from behind a bush’)]

=== Citressive
The #s[citr] case indicates that an object is on the near side of another object. When used with an expression of time,
it means ‘before’ or ‘ago’.

- #w[#b[dẹsŷ]y’éc’h dýsá] ‘two centuries ago’
- #w[#b[dẹh]ríb’hy’ér] ‘on this side of the river’

=== Transessive
The #s[transess] case indicates that an object is on the far side of or beyond another object. When used with an expression
of time, it means ‘after’.

- #w[#b[ḅárŷ]y’éc’h dýsá] ‘two centuries later’
- #w[#b[ḅárŷ]y’úr sèḍ] ‘after seven days’
- #w[#b[ḅár]ríb’hy’ér] ‘across/beyond the river’

Do not confuse this case with the #s[ess], e.g. in the #s[indef pl], we have
#s[transess] #w[ḅárŷn-] but #s[ess] #w[ḅárýn-].

=== Transallative
The #s[transall] case denotes motion to the far side of or to beyond another object.

- #w[#b[Rébhár]árrih jráy’á.] ‘I travel (to) beyond the forest.’

=== Contressive
The #s[contress] case denotes positioning opposite something.

- #w[abhár #b[át’h]árb] ‘the house opposite the tree’

=== Orientative
The #s[orient] case denotes that an object is facing towards something.

- #w[#b[fér]saul] ‘facing the sun’

=== Perlative
The #s[perl] case denotes motion along a path, across a plane, or through some medium or object. It can also
be used figuratively.

- #w[#b[lý’aú]c̣évê] ‘along the street’
- #w[#b[lý’aú]d’háẹ] ‘across the sky’
- #w[#b[lý’aú]vérr] ‘through the sea’
- #w[#b[lý’aú]leḍ] ‘by the book’#footnote[Lit. ‘by the letter’.]
- #w[Lẹréá #b[lý’ýn]ráhó.] ‘He wandered across a meadow.’

The formation #s[perl def sg] deserves some explanation: the #w[d’h] is dropped if the word starts with a consonant, in
which case the prefix causes lenition, e.g. #w[lý’aút’halẹ] ‘across the table’; conversely, it is retained if the word
starts with a vowel, e.g. #w[lý’aúd’háẹ] ‘across the sky’.

== Names, Titles, and Appositions <subsubsec:names-and-titles>
Proper nouns are declined in the definite form only. Unlike other nouns, the #s[nom] is almost always
unmarked, i.e. identical to the #s[abs], but this depends on the name:

- #w[Daúvníc’h] ‘Dominic (#s[abs])’
- #w[Daúvníc’h] ‘Dominic (#s[nom])’
- #w[Cár] ‘Charles (#s[abs])’
- #w[Lác̣ár] ‘Charles (#s[nom])’

Titles always follow the noun they qualify. When that noun is a proper noun, the title is declined instead of the name,
which remains unmarked, i.e. as if in the #s[abs]. The only exception is the #s[nom]: if the #s[nom] of a proper noun
is unmarked, then both the title and the noun itself are unmarked in the #s[nom]. If two titles are attached to the
same (proper) noun, _both_ are declined.

- #w[Snet’h C’haúfrér] ‘Brother Smyth’
- #w[Snet’h Ihaúfrér] ‘Brother Smyth (#s[acc])’
- #w[Snet’h Ihaúfrér Ihaj] ‘Brother Smyth the Wise (#s[acc])’

Appositions also follow these rules, except that if they modify a common noun, they _agree_ with
the case and number of the noun instead of being declined _instead_ of it. Note that this is different
from modifier nouns, which take the #s[abs] instead. Consider:

- #w[ashasḍaúr, ast’haléraû véḍ] ‘to the beaver, a master carpenter’
- #w[ashasḍaúr, ast’haléraû, asvéḍ] ‘to the beaver, a carpenter, a master’
In both phrases, the apposition #w[ḍaléraû] ‘carpenter’ is declined in the #s[dat]. In the first, #w[véḍ] ‘master’
is a modifier, not an apposition, and thus assumes #s[abs] case rather than #s[dat] case, while in the second, it
_is_ an apposition and thus assumes #s[dat] case as well.

== Declension Stacking <sec:declension-stacking>
UF nouns can be declined more than once by taking an inflected noun form and declining it again. Generally the inner
inflected form must be in one of a select few cases, particularly the #s[gen], #s[orn], and #s[ess]. This phenomenon is
referred to as _declension stacking_ or _case stacking_. In many cases, what is actually intended to be declined
is an implied ‘the one(s)’, or a noun that is omitted and obvious from context. The hyphens here are only for clarity;
they are not used in actual UF writing.

- #w[#b[B’hér-á-]c̣ár jrâhaút’hé.] ‘I met with Charles’ [family/children].’
- #w[Laráb’hérér #b[Lé-á-]hehár Lý’aúrýb’hihaú.] ‘Caesar’s [legions/soldiers] crossed the Rubicon.’
- #w[cabh #b[á-ḅárý-]vaût’há] ‘Giant’s Hat’#footnote[A species of mushroom.] (lit. ‘hat of the mountain-like one’)

Cases can be stacked more than once, though this is rather rare.

- #w[Jráré #b[dẹ-á-vé-]húraû.] ‘I saw the royals.’ (lit. ‘the ones of the one bearing the crown’)

Note that case affixes do _not_ agree with one another; rather, each affix individually agrees with whatever it
implicitly refers to. This last sentence serves as a good illustration of that: A king or queen generally has only single
crown, and thus #w[véhúraû] ‘bearing the crown’ is #s[def sg]. Likewise, the crown belongs to a single person, so
#w[ávéhúraû] is #s[def sg] as well. Finally, the royal family in question presumably has more than one member, so
#w[dẹávéhúraû] is #s[def pl].

The usual #s[abs] and #s[voc] affixes, excepting the #s[def abs pl], are not suitable for stacking since they are
largely unmarked or only marked by mutations. Because of this, there is a special set of #s[abs] and #s[voc]
affixes that are usually referred to as the _augmented_ #s[abs/voc] and which are only used in stacking:

#[
#show : italic-table-body.with(cols: (0, 4))
#center-table(
    caption: [Augmented #s[abs/voc] affixes.],
    align: left,
    table.hline(y: 1, end: 3),
    table.hline(y: 1, start: 4),
    ..vlinesat(1, 2, 5, 6),
    table.header[Definite   & Sg & Pl && Indefinite & Sg & Pl ],
    [Absolutive & sw-    & l-    && Absolutive & w-#N & ź-    ],
    [Vocative   & au-#L  & aú-   && Vocative   & /     & /     ],
) <tab:augmented-affixes>
]

Note that the augmented #s[def abs pl] is identical to the base #s[def abs pl]. In Middle and Early Modern UF, the
augmented affixes were sometimes used for emphasis or metre in poetry, but this is considered very archaic nowadays.

== Negation <subsubsec:noun-negation>
Nouns, as well as proper adjectives and adverbs (i.e. those which are not formed from an adjective verb) are negated
using the particle #w[aû], which may be separated from the noun by a hyphen for clarity, e.g. #w[aûádróid] or #w[aû-ádróid]
‘non-android’. Improper adjectives and adverbs are negated just like any other verb.

== Adjectives <sec:adjectives>
UF does not have many actual adjectives. Most words in UF are either nouns or verbs, and most ‘adjectives’ are just
participles, which can always be used like adjectives. Indeed, there are a lot of verbs whose meaning is something
along the lines of ‘to be X’, whose present participle behaves like the adjective ‘X’, e.g. #w[ḅẹt’hẹ] ‘to be small’
to #w[ḅẹt’hâ] ‘small’ (literally ‘being small’).

In general, any participle, whether passive or active, can be used as an adjective; in such a context, passives function
like true adjectives rather than verbs, i.e. whereas passive verb forms typically require the noun they modify to assume
some objective case, passive participles do not.

Adjectives generally—but not always—follow the noun they modify and are never inflected. There is no established order of adjectives.

- #w[váćár ḅérsâ] ‘piercing jaw’
- #w[Cár âdeb’haúrér] ‘Charles, the Devoured’
- #w[át’halẹ ḅẹt’hâ] ‘of the small table’

=== Tense of Adjectival Participles <subsec:participle-tense>
First, this section is about the tense of participles—of both adjective verbs and other verbs—that are used as adjectives;
when an adjective verb occurs as a finite form, it behaves just like any other verb.

Like most of the time in UF, the tense of the participle is relative to the frame of the conversation, not
the event described: Even if the event takes place in the past or future, e.g. #w[jráré slé lárâ] ‘I saw a large plain’,
the participle will still be present tense if the thing described continues to hold that quality. Thus, a past
participle, e.g. #w[jráré slé lárêr] ‘I saw a formerly-large plain’, indicates that the quality no longer applies to
the referent at the time of speaking.

Future participles, however, are a bit more complicated. There are generally two classes of adjective verbs: those that
describe properties that
could reasonably be known in advance, and those that describe properties that could not. This is a purely semantic distinction: e.g. #w[ad’hyl]
‘adult’ can refer to a future situation: if you know how old someone is and that they are not an adult yet, you
can reasonably conclude that they will be an adult at some future point in time and when; thus, e.g. #w[vaú áb’há ad’hylŷr]
‘my soon-to-be adult child’ is relative to the time of the utterance.

By contrast, a future participle of e.g. #w[cér] ‘dear’ cannot be relative to the time of utterance, as there is no way of
knowing whether something will be dear to you in advance. Thus, such a participle is only valid if the context is in
the past, in which case its sense is naturally that of a future-in-the-past, e.g. #w[jrâhaút’hé b’hŷnâví cérrŷvé] ‘I met a dear
friend of mine’ more literally means ‘I met someone who would become (lit. “will be”) a dear friend to me’, whereas
\##w[jrâhaúḍ b’hŷnâví cérrŷvé] ‘I meet a friend that will be dear to me’ is semantically invalid.

Such future participles specifically indicate that the property only started applying to the referent at some point in the
past after the context that the utterance refers to. The above example, #w[jrâhaút’hé b’hŷnâví cérrŷvé], indicates that at
the time of the meeting, the
person I met was not dear to me yet, whereas a present participle, #w[jrâhaút’hé b’hŷnâví cérâvé], would indicate that
they were already dear to me, and that we simply came together at that point in time.

Lastly, in hypothetical scenarios, future adjective-participles of the latter class can often be relative to the time of
utterance, e.g. consider optative #w[jaúy’ẹrâhaúḍrẹ́ vê b’hŷnâví cérrŷvé] ‘I hope that tomorrow, I will meet a friend that
will become dear to me’.

=== Adverbs
Adverbs are formed from adjectives in one of two ways. For adjectives that are not adjective verbs, #w[-(é)vâ] is added,
e.g. #w[c’haú] ‘holy’ becomes #w[c’haúvâ] ‘holily’; the #w[e] is only present if the adjective ends with a consonant. Adjectives that
are derived from adjective verbs instead replace the #w[-â] affix with #w[-vâ], e.g. #w[réâ] ‘true’ becomes #w[révâ] ‘truly’. This
form _never_ inserts an _e_.

=== Agent and Patient Nouns
The active and passive participles can be inflected as though they were nouns to form agent and
patient nouns, e.g. #w[lá-ad’hórâ] ‘the lover’ and #w[láhad’hór] ‘the loved one’. Be mindful of the fact
that this usage may be indistinguishable from a normal participle in the absolutive case.

Agent nouns often carry with them an innate constancy in that the quality they denote
is primarily understood to be inherently gnomic, for which reason they generally do not take the gnomic affix,
e.g. #w[válvêâ] ‘torturer’ first and foremost describes someone who is a torturer by profession. This notwithstanding,
in a context such as #w[ez válvêâ] ‘his torturer’, it may instead refer to a person that is merely doing the torturing in the
situation in question, but does not torture on a regular basis. Forms such as #w[válvêjâ], though attested, are rare in
literary language, and chiefly serve to emphasise the fact that the quality in question should be understood as gnomic
in a context where that may not be immediately obvious.

Notably, this is generally _not_ the case for patient nouns! E.g. #w[âválvê] ‘torturee’ would never be interpreted
as gnomic, as ‘being someone who is tortured frequently’ is not a particularly common property—and the same applies to
most other verbs.

// ‘lẹ-’: from PF ‘plus’. Comparative prefix.
=== Comparison<subsec:comparison>
Unlike in many other languages, there are 8 comparatives in UF, 4 positive and 4 negative: The affirming comparatives, so called
because they affirm the comparison (‘better, and also good’, ‘less hot, and also not very hot’); the denying comparatives, which deny the comparison
(‘better, but not good’, ‘less hot, but still hot’), the sufficient comparatives, which indicate that there is just (not) enough of something,
and the neutral comparatives, which do not make any statement about the comparison (‘better’, ‘less hot’).

To illustrate the difference between the three: We might say that an ant is ‘bigger’ than a grain of sand, but
an ant is still not big, all things considered. By contrast, an elephant may be ‘smaller’ than a mountain,
but that doesn’t mean that an elephant is small. Finally, a human is small enough to fit through a regular-sized
door.

In UF, the comparatives are expressed by a total of eight infixes, which are prefixed directly to the stem. For positive comparatives, the affirming
comparative prefix is #w[lẹ], the denying comparative prefix is #w[y’ŷ], the sufficient comparative prefix is #w[ah],
and the neutral comparative prefix is #w[rê]. Thus, we have #w[ḅẹt’hâ] ‘small’, #w[lẹḅẹt’hâ] ‘smaller, and also small’,
#w[y’ŷḅẹt’hâ] ‘smaller, but not small’, #w[ahḅẹt’hâ] ‘small enough’, and #w[rêḅẹt’hâ] ‘smaller’. Unlike other degrees
of comparison, the sufficient comparative is always regular.

For negative comparatives, the affirming comparative prefix is #w[laû], the denying comparative prefix is #w[y’aû], the sufficient
comparative prefix is #w[haû], and the neutral comparative prefix is #w[raû]. Diachronically, these resulted from a contraction of the positive prefixes and the
nominal negative marker #w[aû].

The comparative prefixes can also be applied to verbs, though they usually only make sense for the aforementioned
‘adjective verbs’, e.g. #w[jy’ŷḅẹt’hẹ] ‘I am smaller, but still big’. Note that these prefixes
might cause a verb’s forms to change from vocalic to consonantal, e.g. #w[ebhẹ] ‘to be thick’ (future stem #w[ebhrẹ])
is vocalic #w[náy’ebhraú] ‘we shall be thick’ in the positive, but consonantal #w[aúnraûy’ŷebhraû] ‘we shall be
thicker, but not thick’ in the negative comparative.

The affirming comparative can also be used absolutely, with the meaning of ‘to a large degree’. Thus,
we have #w[ḅẹt’hâ] ‘small’, and #w[lẹḅẹt’hâ] ‘tiny’; sometimes, this also leads to a slight change in meaning
or perception, e.g. #w[ebhâ] ‘thick’, but #w[lẹ-ebhâ] ‘thicc’.

The affirming and denying comparative can also mean ‘too X’ and ‘not X enough’, respectively; thus, #w[lẹḅẹt’hâ]
can also mean ‘too small’, and #w[y’ŷḅẹt’hâ] can also mean ‘not small enough’, though this meaning is somewhat
uncommon in isolation and most commonly found in constructions (see below).

The sufficient comparative can be combined with a clause in the subjunctive to express something along the lines
of ‘so X that ...’, expressing that someone’s faculty in X is sufficient to do something, e.g. #w[ahrá le lísá
...] ‘he was so big that he could ...’. #w[ah] can also be infixed between the case prefix and stem of a
noun, in which case it has the sense of ‘such’, e.g. #w[lyá sahc’haúnéhás] ‘he had such knowledge (that he could ...)’.

The superlative is formed with one of two prefixes: #w[ré#L] and #w[râdvâ]. Be careful not to confuse the former
with the neutral comparative #w[rê]! The two prefixes are largely interchangeable, however, the former is more
literary and also older. The latter is a more recent development to reduce potential ambiguity with the
neutral comparative. Note that #w[ré] lenites, whereas #w[râdvâ] does not. Thus, we have #w[rébhẹt’hâ] or
#w[râdvâḅẹt’hâ] ‘smallest’.

The negative superlative is formed with the prefix #w[râdvaû], which diachronically derives from #w[râdvâ] and #w[aû], similarly to the negative comparatives.

The standard of comparison (viz. the thing being compared against) is marked with the #s[gen] case, e.g. #w[rêrá ábhárb]
‘bigger than the trees’. It is usually definite if it is an abstract concept.

=== Constructions
The comparative can be used together with an infinitive, #s[aci], or #s[pci]. The affirming comparative here has the meaning
of ‘too X to ...’, and the denying comparative has the meaning of ‘not X enough to ...’. A good illustrative
example of this is the following UF proverb:

- #w[Láráhó slẹlúrá b’héd’hẹhẹ dẹnájẹ.]  ‘The fish was too bulky to swim to the surface’#footnote[
        This is a very common proverb (often also just _láráhó slẹlúr_ ‘The fish is too bulky’)
        and roughly means that something has gone too far or gone on for too long (‘Now you’ve done it’ or ‘Now
        it’s too late’). Variations of it exists; in the optative, for instance, this proverb means ‘Let’s not overdo this’.]

The comparative forms can also be prefixed to verbs, in which case they precede the stem directly and have the meaning
of ‘to X more’, etc., e.g. #w[jrêdír] ‘I say more’. In this sense, the affirming comparative is generally construed
as continuing an action, e.g. #w[jlẹdíré] ‘I continued saying’/‘I continued’/‘I said further’ (lit. ‘I said more, and a lot’
$approx$ ‘I said more after already having said a lot’), the denying as resuming or commencing an action after some of
inaction has passed, e.g. #w[jy’ŷdíré] ‘I finally said’ (literally ‘I said more, but not much’ $approx$ ‘I said (more)
after not having said much’). Finally, the sufficient comparative has the expected meaning, e.g. #w[ḍahférá] ‘You have done enough’.

== Pronouns
Pronouns in UF are a rather complicated subject matter since they are becoming increasingly vestigial. UF has
a set of personal pronouns which only exist in oblique cases; a set of simple possessive pronouns, a set of demonstrative
pronouns, as well as interrogative and relative pronouns.

=== Personal pronouns <subsubsec:personal-pronouns>
@tab:personal-pronouns below lists all forms of the UF personal pronouns.

#[
#show : italic-table-body.with(rows: (0, 1))
#center-table(
    caption: [Personal Pronouns],
    align: left,
    vlineat(1),
    vlineat(5),
    hlineat(1, start: 1),
    hlineat(2),
    [               & #table.cell(colspan: 4, align(center)[Sg]) & #table.cell(colspan: 3, align(center)[Pl]) ],
    [               & #s[1st] & #s[2nd]  & #s[3c] & #s[ 3n] & #s[1st] & #s[2nd] & #s[3rd] ],
    [ Absolutive    & vè  & t’hè  & lè  & sè        & aú    & vaú  & y   ],
    [ Vocative      & /   & et’hè & /   & /         & /     & evaú & /   ],
    [ Genitive      & vaú & ḍaú   & #col2[ez/z’/’z] & naúḍ  & vaúd & lýr ],
    [ Prepositional & vẹ  & t’hẹ  & lẹ  & sẹ        & aun   & vau   & ly ],
) <tab:personal-pronouns>
]

#partitle[Nominative and Accusative]
There are a few things that need to be noted here: there are no #s[nom] and #s[acc] pronouns; those
forms have been incorporated into the verb and cannot be used without a verb. For instance, when answering a question,
typically, either the same verb that was used to ask the question
is repeated or an appropriate form of the verb #w[fér] ‘to do’ is used, e.g. if asked #w[U c’hes ḍẹvad’hór ra ḍẹy’ad’hór?]
‘Do you love me or him?’, an UF speaker might respond with #w[ḍad’hór] ‘I love you’ or #w[ḍẹfér] ‘you’ (lit. ‘I do you’).

On that note, there are several ways of shortening the question itself: In sentences that contain the same verb with the same
affix twice, the second occurrence of that affix may be omitted, e.g. #w[U c’hes ḍẹvad’hór ra y’ad’hór?]; the verb #w[fér] may be used
to avoid repetition, e.g. #w[U c’hes ḍẹvad’hór ra y’fér?]; and, finally, the entire first occurrence of the verb sans the person markers may
be omitted, leaving said affixes stranded in the sentence, e.g. #w[U c’hes ḍẹv- ra y’ad’hór?]. This last option is generally
preferred since it it is the shortest option, but, of course, it is only possible if the first verb form contains only prefixes.

#partitle[Partitive]
The #s[part] forms of the personal pronoun are rather strange; generally, verbs that govern the #s[part] simply take regular
passive affixes instead. However, verbs that can be formed with both the #s[acc] and #s[part] as well as #s[pci]s employ
special partitive forms of the passive affixes that are constructed by infixing #w[-dy-] after the prefix part
of the corresponding passive affix—or before the suffix part if there is no prefix part:#footnote[The only passive forms that do
not have prefix parts are imperatives.]

- #w[jsylí] ‘I peruse it’
- #w[jsy#b[dy]lí] ‘I read from it’
- #w[lírá] ‘be perused!’
- #w[lí#b[dy]rá] ‘be read from!’

#partitle[Genitive]
The possessees of #s[gen] pronouns can be definite or indefinite, e.g. #w[vaú lát’halẹ] ‘my table’ vs #w[vaú ŷnalẹ] ‘a table
of mine’. In cases where the possession is obvious, e.g. family members in relation to one another, body parts, etc. the
#s[gen] pronoun is generally omitted:#footnote[With body parts, this use of the #[gen] is entirely obsolete in Modern UF,
and even in Early Modern UF outside of poetry.]

- #w[Lábhabh ladvnéhá(#b[\%’z]) ib’his.] ‘The father reprimanded his son.’
- #w[Lẹraúhy’b’há(#b[\*’z]) irá nés ádér.] ‘He raised his left arm up in the air.’
- #w[Svéc (#b[\*z’])órdraûc llarét’hírá.] ‘She pulled a strand of hair from her head.’

Most #s[gen] pronouns are not particularly special and behave just like regular genitives; the exception is the
#s[3sg] pronoun that is used for all three genders: its base form is #w[ez], e.g. #w[ez lát’halẹ] ‘his/her/its table’, but
after a word that ends with a vowel, the #w[e] is dropped, and it is instead written #w[’z], e.g. #w[ḍevvaúríhe’z st’halẹ] ‘to
remember a table of his/hers/its’. If the following word starts with a vowel, it is somtimes written #w[z’],#footnote[The
apostrophe in #w[z’] makes no sense in that position,
but it probably came about in imitation of similar forms that affix to the following word, e.g. the #s[opt] negation particle
#w[t’hé], which becomes #w[t’h’] before vowels.] e.g. #w[ḍevvaúríhe z’it’halẹ] ‘to remember his/her/its table’, though
#w[ḍevvaúríhe’z it’halẹ] is also common and preferred in traditional literature.

In Early Modern UF, #w[ez] was sometimes infixed between a case affix and the stem of its noun, e.g.
#w[dwá’zárb] ‘in his tree’.

#partitle[Prepositional]
The ‘prepositional’ form is not a case, but rather a form that case prefixes attach to to form all the other cases, e.g.
the #s[2sg instr] would be #w[b’helt’hẹ] ‘with you’. Note that personal pronouns use the _definite_ case prefixes of the
appropriate number. All remaining cases can be formed this way, but of course not the #s[abs, nom, acc, part, voc], and
#s[gen]. The prepositional form is never used in isolation.

=== Possessive Pronouns
UF does not really have possessive pronouns; instead, it has a series of possessive adjectives, which—just like most other
‘adjectives’—are really just a series of adjective verbs: #w[y’ê] ‘to be mine’, #w[dy’ê] ’to be yours (#s[sg]),
#w[sy’ê] ‘to be his/hers/its’, #w[naúḍ] ‘to be ours’, #w[vauḍ] ‘to be yours (#s[pl])’, and #w[lýrḍ] ‘to be theirs’. These verbs
are chiefly used as verbs, e.g. #w[ŷnalẹ sy’ê] ‘it is a table of mine’; for just expressing ‘my’ etc., the #s[gen] of the
corresponding possessive pronoun is used instead, as indicated above.

=== Demonstrative Pronouns
UF has three main demonstrative pronouns: #w[swi] ‘the one, that one, this one’, #w[sẹh] ‘this’, and #w[sý’ẹ] ‘that’. All
three are normally indeclinable and precede whatever they qualify: the first generally occurs in isolation, in which
case it is declined as a definite noun, or indeclinably with an adjective or pronoun, e.g. #w[swi ḅẹt’hâ] ‘the small one’
or #w[swi a lẹḅẹt’hẹ] ‘the one who is small’. The latter usually precede a definite noun, e.g. #w[sẹh lát’halẹ] ‘this table’,
and are themselves declined only when they occur in isolation. It is not possible to combine demonstratives with one another.

=== Relative Pronoun
The UF relative pronoun is #w[a] ‘which, who, that’. Its most obvious and direct use is to form relative
clauses and agrees in definiteness and number with the noun it qualifies, e.g. #w[lát’halẹ, ia jad’hór] ‘the
table that I love’ or #w[ŷnalẹ, sa jad’hór] ‘a table that I love’.

If the antecedent is too far away from the relative clause, it may be repeated in the relative clause,
usually in the definite, typically at the very beginning, in which case the relative pronoun follows it and is not inflected at
all, e.g. #w[lát’halẹ, it’halẹ a jad’hór] ‘the table, which table I love’. In literary language, this
construction is generally preferred over inflecting the relative pronoun if the two are far apart.

If there is no single antecedent (e.g. because it is ‘A and B’), or no antecedent at all (e.g. ‘that which’) then the
relative pronoun may be used on its own, and is always inflected in that case, e.g. #s[dat] #w[asa jad’hór] ‘to the
one I love’.

=== Interrogative Pronoun
The interrogative pronoun is the same as the relative pronoun, except that it is also followed by the
question particle #w[c’hes]. Unlike the relative pronoun, it is always declined. On its own, it takes
indefinite case when it refers to a thing, e.g. #w[Sa c’hes ḍad’hór ?] ‘What do you love?’, and definite
case when it refers to a person, e.g. #w[Ia c’hes ḍad’hór ?] ‘Whom do you love?’ For more information, see
@subsubsec:aches-who-what.

=== Reflexive Pronouns
The reflexive pronouns are formed by appending #w[-rá]#footnote[Likely a remnant of #pf[soi].] to the
personal pronouns, e.g. #w[vèrá] ‘myself’, #w[vaúrá] ‘of myself’. The reflexive pronouns don’t have #s[voc] forms,
but unlike the normal personal pronouns, they _do_ have #s[nom], #s[acc], and #s[part] forms that are formed
from the #s[abs], e.g. #w[ivèrá] ‘myself #s[acc]’.

Note that reflexivity is primarily expressed by using both an active and passive affix in the same person. The reflexive
pronouns are generally used to add emphasis. They can be combined with #w[dèl] for an even greater degree of emphasis.

- #w[Llẹlýad’hór.] ‘She loves herself.’
- #w[Llẹlýad’hór ilè.] ‘She loves herself very much.’
- #w[Llẹlýad’hór ilè dèl.] ‘She loves herself very much indeed.’

The reflexive pronouns are also employed for disambiguation, as well as in conjunctions—mainly when the pronouns already
incorporated into the verb are insufficient to convey the intended meaning (accurately). Note again that reflexive pronouns
are not needed if there is no other referrent that a passive affix could possibly refer to.

- #w[Llẹlýad’hór.] ‘She loves her (someone else).’
- #w[Llẹlýad’hór ilè.] ‘She loves herself.’
- #w[Llẹvad’hór au ilè.] ‘She loves me and herself.’

// [TODO, spatial and other correlatives]
// == Correlatives
// #w[nêbh-] = ‘-ever’

== Numerals <subsec:numerals>
A list of numerals is given in @tab:numerals below. UF has four sets of numerals:
cardinals, e.g. #w[dý] ‘two’; ordinals, e.g. #w[dýzy’ê] ‘second’; multipliers, e.g. #w[dub] ‘twice’;
and fractions, e.g. #w[déví] ‘half’.

#[
#show figure : set block(breakable: true)
#show : italic-table-body
#center-table(
    caption: [Numbers],
    align: left,
    ..hlinesat(1, 10, 20, 30, 40,),
    ..vlinesat(..range(1, 5)),
    table.header[ № &  Cardinal &  Ordinal &  Multiplier &  Fractional ],
    [    1      & ý               & révy’ẹ́             & séḅ               & áḍy’ẹ́           ],
    [    2      & dý              & dýzy’ê             & dub               & déví            ],
    [    3      & rrá             & rrázy’ê            & ríḅ               & y’ér            ],
    [    4      & c’haḍ           & c’haḍríy’ê         & c’hadrýḅ          & c’hár           ],
    [    5      & séc’h           & séc̣é               & c’hét’hyḅ         & c’hé            ],
    [    6      & sis             & sizy’ê             & sec’hsḍyḅ         & sic’hs          ],
    [    7      & sèḍ             & sèḍy’ê             & sèḍyḅ             & sè              ],
    [    8      & y’íḍ            & y’íḍy’ê            & auc’hḍyḅ          & auc’h           ],
    [    9      & nýt’h           & nýb’hy’ê           & nýḅ               & ny              ],
    [    10     & dis             & dizy’ê             & dehyḅ             & deh             ],
    [    11     & aúz             & aúzy’ê             & aúzyḅ             & auz             ],
    [    12     & duz             & duzy’ê             & duzyḅ             & duz             ],
    [    13     & réz             & rézy’ê             & rézyḅ             & rez             ],
    [    14     & c’hat’haúr      & c’hat’haúrzy’ê     & c’hat’haúrzyḅ     & c’hat’haurz     ],
    [    15     & c’héz           & c’hézy’ê           & c’hézyḅ           & c’hez           ],
    [    16     & sez             & sezy’ê             & sezyḅ             & sez             ],
    [    17     & dihèḍ           & dihèḍy’ê           & dihèḍyḅ           & dihè            ],
    [    18     & dizy’íḍ         & dizy’íḍy’ê         & dizy’íḍyḅ         & dizy’i          ],
    [    19     & diznýt’h        & diznýb’hy’ê        & diznýt’hyḅ        & diznyb’h        ],
    [    20     & b’hé            & b’héy’ê            & b’héḍyḅ           & b’he            ],
    [    21     & b’hé’d ý        & b’hé’d rév’yẹ́      & b’hé’d séḅ        & b’hé’d áḍy’ẹ́    ],
    [    30     & b’hé’d dis      & b’hé’d dizy’ê      & b’hé’d dehyḅ      & b’hé’d deh      ],
    [    31     & b’hé’d aúz      & b’hé’d aúzy’ê      & b’hé’d aúzyḅ      & b’hé’d auz      ],
    [    40     & dýb’hé          & dýb’héy’ê          & dýb’héḍyḅ         & dýb’he          ],
    [    50     & dýb’hé’d dis    & dýb’hé’d dizy’ê    & dýb’hé’d dehyḅ    & dýb’hé’d deh    ],
    [    60     & rráb’hé         & rráb’héy’ê         & rráb’héḍyḅ        & rráb’he         ],
    [    70     & rráb’hé’d dis   & rráb’hé’d dizy’ê   & rráb’hé’d dehyḅ   & rráb’hé’d deh   ],
    [    80     & c’haḍb’hé       & c’haḍb’héy’ê       & c’haḍb’héḍyḅ      & c’haḍb’he       ],
    [    90     & c’haḍb’hé’d dis & c’haḍb’hé’d dizy’ê & c’haḍb’hé’d dehyḅ & c’haḍb’hé’d deh ],
    [    100    & sá              & sáḍy’ê             & sáḍyḅ             & sáḍ             ],
    [    101    & sá’d ý          & sá’d rév’yẹ́        & sá’d séḅ          & sá’d áḍy’ẹ́      ],
    [    200    & dýsá            & dýsáḍy’ê           & dýsáḍyḅ           & dýsáḍ           ],
    [    300    & rásá            & rásáḍy’ê           & rásáḍyḅ           & rásáḍ           ],
    [    400    & c’hasá          & c’hasáḍy’ê         & c’hasáḍyḅ         & c’hasáḍ         ],
    [    500    & sésá            & sésáḍy’ê           & sésáḍyḅ           & sésáḍ           ],
    [    600    & sisá            & sisáḍy’ê           & sisáḍyḅ           & sisáḍ           ],
    [    700    & sèsá            & sèsáḍy’ê           & sèsáḍyḅ           & sèsáḍ           ],
    [    800    & y’ísá           & y’ísáḍy’ê          & y’ísáḍyḅ          & y’ísáḍ          ],
    [    900    & nýsá            & nýsáḍy’ê           & nýsáḍyḅ           & nýsáḍ           ],
    [    1 000  & víl             & víly’ê             & vílḍyḅ            & víláḍ           ],
    [    1 001  & víl ed ý        & víl ed rév’yẹ́      & víl ed séb        & vil ed áḍy’ẹ́    ],
    [    2 000  & dý víl          & dý víly’ê          & dý vílḍyḅ         & dý víláḍ        ],
    [    10 000 & dis víl         & dis víly’ê         & dis vílḍyḅ        & dis víláḍ       ],
    [    $10^6$ & víwaú           & víwaúy’ê           & víwaúḍyḅ          & víwaúḍ          ],
    [    $10^12$& dýwaú         & dýwaúy’ê           & dýwaúḍyḅ          & dýwaúḍ          ],
    [    $10^18$& ráwaú         & ráwaúy’ê           & ráwaúḍyḅ          & ráwaúḍ          ],
) <tab:numerals>
]

=== Compound Numbers and Abbreviations
The numbers 1–20 are irregular;
after that, ordinals are formed by adding #w[-y’ê] to the cardinal and multipliers by adding #w[-ḍyḅ] to the cardinal;
fractionals are more irregular: the tens lose nasalisation of the final vowel, e.g. #w[dýb’hé] ‘forty’ vs #w[dýb’he]
‘(a) fortieth’; in the hundreds and after, a final #w[-(á)ḍ] is added instead. Extra syllables added by non-cardinal
forms do not count as part of the stem for the purpose of stress.

After 20, numbers of different orders of magnitude are combined with the particle #w[ed], which is solely used for this
exact purpose. After a vowel, it is reduced to #w[’d], e.g. #w[sá’d ý] ‘101’ or #w[sá’d b’hé’d ý] ‘121’ from #w[sá] ‘100’,
#w[b’hé] ‘20’ and #w[ý] ‘one’. In non-cardinals, only the last part is of ordinal, multiplier,
or fractional form, e.g. #w[sá’d b’hé’d séḅ] ‘121 times’.

In writing, non-cardinals are frequently abbreviated, preferably with superscripts if possible. Ordinals are abbreviated
with #w[#super[y’ê]], e.g. #w[27#super[y’ê]] ‘27th’, except for numbers ending
with #w[révy’ẹ́] ‘first’, which are abbreviated with #w[#super[y’ẹ́]] instead, e.g. #w[21#super[y’ẹ́]] ‘21st’, as
well as numbers ending with #w[séc̣é] ‘fifth’, which are abbreviated with #w[#super[c̣é]] instead, e.g. #w[25#super[c̣é]]
‘25th’.

_Adverbial_ multipliers (sometimes also called _multiplicative_ numerals) shown in the table above are abbreviated with
subscripts if possible; those ending with #w[séḅ] ‘once’ to #w[nýḅ] ‘nine times’ are abbreviated with the last two letters of that
word, e.g. #w[23#sub[íḅ]] ‘23 times’. All other adverbial multipliers are abbreviated with #w[#sub[yḅ]], e.g. #w[31#sub[yḅ]]
‘31 times’.#footnote[Note that ‘31’ in UF is not actually ‘thirty-one’, but rather ‘twenty-eleven’, and thus doesn’t
end with ‘one’.] The derived _adjective_ multipliers (see @subsec:multipliers below) are instead abbreviated with a single
subscript #w[#sub[â]], e.g. #w[23#sub[â]] ‘23-fold’.

Fractions are typically abbreviated with the usual notation, e.g. #w[½], #w[¼], etc.

=== Cardinals
Cardinals are proper adjectives. That is, they are not inflected and follow the noun or noun phrase they qualify.

=== Ordinals
Ordinals are strange in that they can either be used in their base form, in which case they, too, act like proper
adjectives. In addition to that, however, they can also be inflected like adjective verbs to form e.g. #w[révy’ẹ́â] ‘primary’.

Similarly, ‘Firstly’/‘at first’, ‘secondly’, etc. are constructed from the ordinals using the usual adverb suffix, e.g.
#w[révy’ẹ́vâ] ‘at first’.

=== Multipliers <subsec:multipliers>
Multipliers are adverbs by default. The marker #w[-â], presumably a fossilised form of the #s[pres ptcp] affix,
is used to turn adverbial multipliers into adjectives, e.g. #w[dehyḅ] ‘ten times’ becomes #w[dehyḅâ] ‘tenfold’.

=== Fractions
Fractions don’t have any derived forms.



#chapter([Verbs], "verbs")
Verbs in UF are inflected for person, number, tense, aspect, mood, and voice. Verbal inflexion is mainly done
by means of concatenating a vast set of affixes. This chapter details these affixes, their meanings, uses,
forms, and restrictions in their use.

== Fundamental Forms
This section discusses the concept of active/passive affixes, a distinction that is found in every tense in UF, though
the affixes themselves often differ greatly between tenses, their present-tense forms, as well as their uses, and how
to combine them. Other fundamental aspects of the UF verb and forms that don’t really warrant their own section, such as
the dative affixes or the imperative, are also introduced here.

=== Active/Passive Affixes <subsubsec:active-passive-affixes>
The most fundamental affixes in UF are a set of active/subject/agent and passive/object/theme affixes (often referred to as the
‘active/passive affixes’) which can be used on their own or in combination
with one another, though at most one active and one passive affix may be combined in any one finite verb form.#footnote[Doubly
passive forms can occur in rare cases if infinitives are involved; see @subsubsec:pronominal-aci.]
@tab:active-passive-prefixes below lists those affixes.

#conjugation-table(
    caption: [Active (left) and passive (right) verbal affixes.],
    [#s[1st]  &j-     &aú-/r-/w- -(y’)ó      &&#s[1st]  &v-    &aú-/r-/w- ],
    [#s[2nd]  &ḍ(ẹ)-  &b’h(y)- -(y’)é        &&#s[2nd]  &ḍ(ẹ)- &b’h(y)-   ],
    [#s[3m]   &l(ẹ)-  &l(ẹ)-                 &&#s[3m]   &y’-   &lý-       ],
    [#s[3f]   &ll(a)- &ll(ẹ)-                &&#s[3f]   &y’-   &lý-       ],
    [#s[3n]   &s-     &l(a)-                 &&#s[3n]   &sy-   &lý-       ],
    [#s[inf]  &#col2[d(ẹ)-]                  &&#s[inf]  &#col2[à-/h-]     ],
    [#s[ptcp] &#col2[-â]                     &&#s[ptcp] &#col2[â-]        ],
) <tab:active-passive-prefixes>

Every finite verb form requires at least one finite affix. A verb form without any active, passive, or dative affix whatsoever
would not be a finite verb form and could thus never be the predicate of a sentence.#footnote[Excluding of course the fact
that infinitives could be considered to function as predicates of #s[aci]s and #s[pci]s (see @subsec:aci-pci).]
It is possible for a verb to only have a passive affix; however, this doesn’t mean the verb is necessarily passive in
meaning; see @subsec:passive for more about that.

A transitive verb that already has an active affix can take an additional passive affix onl if there is no explicit
direct object in the clause. In other words, while verbs
_do_ take active person marking even if there is an explicit subject e.g. #w[lávvâ llad’hór] ‘the mother loves’, they do
#w[not] take passive person marking if there is an explicit object, e.g. #w[lávvâ llvad’hór] ‘the
mother loves me’, vs #w[lávvâ llad’hór iáb’há] ‘the mother loves the child’, which has #w[llad’hór] ‘she loves’ instead of
#w[llẹsyad’hór] ‘she loves it’.

It is possible to combine both the active and passive infinitive marker to form a reflexive infinitive, e.g. #w[dẹhad’hór]
‘to love oneself’. Lastly, ditransitive verbs and verbs governing the dative case generally take a dative affix (see
@subsubsec:dative-affixes) iff there is no explicit indirect object.

A great degree of syncretism can be observed in the third-person forms. The gender distinction in the
#s[3sg] that diachronically resulted from gendered personal pronouns is almost non-existent in the
plural; the reason for this development is that those forms are derived from the old dative form, which lacked
this distinction altogether.

The #s[act 1pl, 2pl] forms are only distinguished from their passive counterparts by
the presence of additional suffixes in the former. The #s[3sg n] in the active and passive is derived from the PF
demonstrative #pf[ce] and its variants; the #s[3pl n] is derived from the other #s[3pl] forms.

#partitle[Usage Notes]
#[
#show grid.cell.where(x: 0): it => strong(smallcaps(it))
#grid(
    columns: 2,
    row-gutter: 1em,
    column-gutter: .5em,
    [2sg], [
        Watch out for the #s[2sg act], which in verbs that start with a vowel is indistinguishable from the #s[inf act] in
        actual writing, e.g. #w[ḍad’hór] ‘you love’ vs #w[dad’hór] ‘to love’; since the dot is omitted in writing, both forms
        look the same: #w[dad’hór]. Moreover, the #s[2sg pass] is identical to the #s[2sg act] in any case.

        Which form is intended can often be inferred from context: if the clause already has a finite verb, especially one
        that takes an infinitive or ACI, it is more likely to be an infinitive; by contrast, if it is the only (possibly finite)
        verb in the clause, then it is probably a #s[2sg]. Whether it is active or passive can then be deduced based on whether
        the verb is transitive and whether there is an explicit object in the clause.
    ],

    [1pl], [
        The #s[1pl] prefix varies if there is a vowel following it: if it is
        any vowel that is _not_ a variant of ‘o’, the prefix is realised as #w[r-] instead, e.g. #w[ad’hór] ‘love’ to
        #w[rad’hóró] ‘we love’. If the vowel a variant of ‘o’, the prefix is realised as #w[w-] instead, e.g. #w[aub’heír] ‘obey’
        to #w[wob’heíró] ‘we obey’.#footnote[Diachronically, the base form of this prefix is \*[o-], whence e.g.
        *#w[oad’hóró] > #w[rad’hóró] and *#w[oob’heíró] > #w[wob’heíró].] Note that this also leads to a change
        in spelling: stem-initial ⟨au⟩ is changed to ⟨o⟩.
    ],

    [1,2 pl], [
        The #w[y’] in the suffix parts of the #s[1pl, 2pl act] are dropped if the verb ends with a consonant, e.g. #w[ad’hór]
        to #w[b’hád’hóré], or if it ends with a vowel that is a variant of ‘o’ in the case of the #s[1pl] and ‘e’ in the case
        of the #s[2pl], in which cases the vowels are contracted and a level of nasalisation is added, e.g. #w[vvaúríhe]
        ‘to remember’ to #w[b’hyvvaúríhé] ‘you (#s[pl]) remember’ (not \*#w[b’hyvvaúríhy’é]). In all other cases, the #w[y’]
        is retained, e.g. #w[aúvvaúríhey’ó] ‘we remember’.
    ],

    [inf], [
        The #s[inf pass] prefix #w[à-] coalesces with any vowel following it: it becomes #w[á] if it
        is followed by a non-nasal variant of ‘a’, e.g. #w[ad’hór] to #w[ád’hór] ‘to be loved’; #w[â] if it is
        followed by a nasal variant of ‘a’, e.g. #w[ánvé] ‘give life to’ to #w[ânvé] ‘to be animated’; and #w[h-] if it is
        followed by any other vowel, e.g. #w[aub’heír] to #w[haub’heír] ‘to be obeyed’.

        In the present tense, the base form—and not the #s[inf]—of the verb is inflected to form gerunds, e.g. #w[ŷnád’hór] ‘a
        loving’, not \*#w[ŷndad’hór]. However, the #s[inf] _is_ used as the base form for gerunds in other tenses, e.g.
        #w[ŷndad’hórá] ‘a having loved’.
    ],

    [part], [
        The participle affixes are commonly used to form adjectives since the vast majority of adjectives in UF are actually
        ‘adjective verbs’ with a meaning of ‘to be X’. The participle can be used to convert such a verb back into a regular
        adjective, e.g. #w[lár] ‘to be wide’ to #w[lárâ] ‘wide’. Like the passive infinitive affix, the participle affixes
        coalesce with vowels and always form a maximally nasal vowel, e.g. #w[vvaúríhe] ‘to remember’ forms #w[vvaúríhê]
        ‘remembering’, and #w[ad’hór] forms #w[âd’hór] ‘being loved’. As with other coalescence rules, the #w[-â] instead
        _replaces_ final or initial #w[ẹ], and #w[ẹ] only: e.g. #w[ḅẹt’hẹ] ‘to be small’ becomes #w[ḅẹt’hâ] ‘being
        small’. Note that if the word already ends with a maximally nasal vowel, no coalescence occurs, e.g. #w[rê]
        ‘to be triune’ becomes #w[rêâ] ‘triune’.
    ],

    [_-ẹ-_], [
        The parenthesised vowels are used if the prefix is followed by a consonant, e.g. #w[dír] ‘say’ to #w[llẹ{]dír}
        ‘they (#s[f]) say’ and #w[b’hydíré] ‘you (#s[pl]) say’, but #w[ad’hór] to #w[llad’hór] ‘they (#s[f]) love’
        and #w[b’had’hóré] ‘you (#s[pl]) love’. The prefixes #w[aú-] and #w[à-] retain their main forms if followed
        by a consonant, e.g. #w[dír] ‘say’ to #w[aúdíró] ‘We say’ and #w[àdír] ‘to be said’.
    ],

    [_-y-_], [
        The exception to this is that #s[2pl] #w[b’h(y)-] drops the #w[y] if followed by a glide, e.g. #w[y’ír]
        ‘to hear’ to #w[b’hy’íré] ‘you (#s[pl]) hear’ (not \*#w[b’hyy’íré]).
    ]
)
]

#partitle[Combining Prefixes]
When multiple prefixes are used together, active prefixes precede passive prefixes, except that infinitive and participle
prefixes always come first, e.g. #w[ad’hór] ‘love’ to #w[jvad’hór] ‘I love myself’ (not \*#w[vjad’hór]) and #w[b’hy’ad’hóré]
‘you (#s[pl]) love him/her’, but #w[dẹvad’hór] ‘to love me’ and #w[àb’had’hóré] ‘to be loved by you (#s[pl])’. Recall that
at most one infinitive prefix and at most one participle affix may be used.

#partitle[Impersonal Forms]
UF does not use the #s[2nd] person in sentences such as ‘when _one_ considers / when _you_ consider that...’,
instead preferring the #s[1pl] (lit. ‘when _we_ consider that...’) to express such impersonal constructions.
There also is no expletive form or pronoun in UF; for verbs that don’t really have a subject, e.g. ‘rain’, the verb #w[b’hér]
is usually used instead, e.g. #w[dýḷẹ syb’hér] ‘it rains’.#footnote[See the dictionary entry for #w[b’hér] for a more
detailed explanation.]

#partitle[Gender]
UF verbs (and pronouns) inflect for gender in the #s[3sg] and sometimes in the #s[3pl]. This is _not_ grammatical gender,
but rather natural gender, as UF nouns no longer have grammatical gender. The #s[3n] is used if the gender of the referent or
complement is not known or indeterminable, or if gender-neutral expression is desired.

#partitle[Example Paradigms]
By way of illustration, consider the paradigm of the verb #w[ad’hór] as shown in @tab:adhor-paradigm below.
Since this word starts with a vowel, the parenthesised vowels in @tab:active-passive-prefixes above
are not used. Furthermore, since it starts with a non-nasal ‘a’-like vowel, the #w[aú-] prefix is realised as #w[r-]
and the #w[à-] prefix coalesces with the initial ‘a’ of the stem to form #w[á].

#conjugation-table(
    caption: [Paradigm of the Verb #w[ad’hór]],
    [1st&jad’hór&rad’hóró    &&1st&vad’hór&rad’hór],
    [2nd&ḍad’hór&b’had’hóré  &&2nd&ḍad’hór&b’had’hór],
    [3m&lad’hór&lad’hór      &&3m&y’ad’hór&lýad’hór],
    [3f&llad’hór&llad’hór    &&3f&y’ad’hór &lýad’hór],
    [3n&sad’hór&lad’hór      &&3n&syad’hór&lýad’hór],
    [#s[inf]&#col2[dad’hór]&&inf&#col2[ád’hór]],
    [#s[ptcp]&#col2[ad’hórâ]&&#s[ptcp]&#col2[âd’hór]],
) <tab:adhor-paradigm>

For comparison, the paradigm of the verb #w[vvaúríhe] ‘remember’ is shown in @tab:vvorihe-paradigm below.
Since it starts with a consonant, the parenthesised vowels in @tab:active-passive-prefixes are used, and any
prefixes that end with a vowel remain unchanged.

#conjugation-table(
    caption: [Paradigm of the Verb #w[vvaúríhe]],
    [1st&jvvaúríhe&aúvvaúríhey’ó &&1st&vvvaúríhe&aúvvaúríhe],
    [2nd&ḍẹvvaúríhe&b’hyvvóríhé  &&2nd&ḍẹvvaúríhe&b’hyvvaúríhe],
    [3m&lẹvvaúríhe&lẹvvaúríhe    &&3m&y’vvaúríhe&lývvaúríhe],
    [3f&llavvaúríhe&llẹvvaúríhe  &&3f&y’vvaúríhe&lývvaúríhe],
    [3n&svvaúríhe&lavvaúríhe    &&3n&syvvaúríhe&lývvaúríhe],
    [#s[inf]&#col2[dẹvvaúríhe]&&inf&#col2[àvvaúríhe]],
    [#s[ptcp]&#col2[vvaúríhê]&&#s[ptcp]&#col2[âvvaúríhe]],
) <tab:vvorihe-paradigm>


=== Dative Affixes <subsubsec:dative-affixes>
The dative affixes #w[-vé] ‘me, us’, #w[-b’hẹ] ‘you’, and #w[-ḷẹ] ‘him, her, it, them’ are used in conjunction with
ditransitive verbs and are invariant to tense, gender, number, and mood. A verb can only have one dative affix, and
the dative affix is always placed last after all other affixes and does not coalesce, lenite, or otherwise modify
the rest of the verb, e.g. #w[dedónẹ́] ‘to bestow’ to #w[dedónẹ́ḷẹ] ‘to bestow upon him’.

These affixes are generally not used if the #s[dat] assumes the sense of ‘for someone’, or ‘to someone’; for instance, while
#w[fúr] ‘to provide’ takes a #s[dat] as its indirect object, e.g. #w[jfúrb’hẹ] ‘I provide you (with something)’, the verb
#w[fér] ‘to do, make’ does not, and thus, it is not e.g. \*#w[jsyférvé], but rather #w[jsyfér asvẹ] ‘I did it for me/us’, where
#w[asvè] is the #s[dat] inflexion of the #s[1sg] pronoun.

Lastly, which one—the #s[dat] affixes or a #s[dat] pronoun—is ultimately used often depends on the verb in question. Some speakers prefer
one over the other with certain verbs, and some verbs regularly admit both, albeit with different meanings, e.g. #w[jsydíréḷẹ]
‘I said it to him’ vs #w[jsydíré aslẹ] ‘I said it for his sake’.

=== Passive <subsec:passive>
If the active affix of a finite verb omitted, the verb has to have at least a passive or dative marker.
Such a construction is the closest equivalent to a ‘passive voice’ in UF; there is no true distinct syntactical or
morphological passive. One difference between such a construction and how passive affixes are normally used, however, is
that in a ‘passive’ clause, the verb _does_ take a passive affix even if there is an explicit object.

- #w[Y’ad’hór ivvâ.] ‘The mother is loved.’
- #w[Sylí dýliv́uhé.] ‘The book is being read.’
- #w[Dyyl syc’hahé.] ‘The window has been broken.’

As a result, it is impossible to express the agent in the ‘passive’ by any
means other than reintroducing an active affix, which would render the form no longer a passive.#footnote[The closest
UF gets to an ‘agent in the passive’ is by forming a regular active, but placing the agent last in the clause.]

One more thing to note is that the UF active/passive distinction is sometimes less of a syntactic and more of a semantic
difference: the ‘active’ fundamentally corresponds to the _agent_, and the ‘passive’ to the _theme_. Thus, verbs
that only take a theme may translate as ‘active’ (or middle) in meaning despite being ‘passive’ in form:

- #w[Vv́ár dẹḅarḍ.] ‘I must leave.’

Traditional grammar calls such verbs ‘deponent verbs’. Such verbs are fairly rare; usually, a syntactic ‘passive’ has
passive meaning in the traditional sense. Intransitive verbs
especially tend to prefer ‘active’ affixes even if their complement is a theme rather than an agent.

Lastly, passive participles that are used as adjectives—like any other adjective—do _not_ govern any case and may
indeed appear next to even #s[nom] nouns (see @sec:adjectives).

=== The Gnomic <subsubsec:gnomic>
The gnomic tense is marked by the infix #w[-j(ú)-] after the stem: #w[ad’hór] ‘to love’ to #w[rad’hórjô] ‘We love (for ever)’.
The #w[ú] is omitted if the infix is followed by the vowel, in which case it causes nasalisation. The presence of the gnomic
is does not affect how verbs are negated.

The gnomic is used to express general truths, habitual actions, or timeless statements. It is more common in
literary language than in speech, which prefers to substitute the present tense instead. Northern dialects
of UF also tend to not make use of the gnomic at all.

=== Imperative
The imperative mood exists only in the present tense, and only in the second and third person. It is formed by
affixing the following suffixes to the stem.

#center-table(
    caption: [Imperative Affixes],
    align: left,
    hlineat(1, end: 3),
    hlineat(2, end: 3),
    hlineat(1, start: 4),
    hlineat(2, start: 4),
    ..(1, 2, 5, 6).map(vlineat),
    table.header[Active & Sg & Pl && Passive & Sg & Pl ],
    [#s[2nd] &_c’h(e)-_&_c’heb’h(y)-_            &&#s[2nd]& _-rá_ &_-nú_],
    [#s[3rd] &#col2(align(center,[_c’hel(ẹ)-_])) &&#s[3rd]& _-ḷẹ_ &_-b’hẹ_],
) <tab:imperative-affixes>

The diachrony of these forms is likely from subjunctive constructions with #pf[que] in the active
and from suffixed pronouns in the passive. Note that imperative affixes are added _in place_ of
present active/passive affixes, e.g. #w[c’hedír!] ‘speak!’, not \*#w[c’heḍẹdír]. As usual, the parenthesised
vowels are omitted if the verb form starts with a vowel, e.g. #w[c’had’hór!] ‘love!’.

Imperative affixes can be combined with active/passive affixes, though, as usual, an active imperative prefix
can only be paired with a passive present affix, and vice versa. Active imperative prefixes are always placed
first, e.g. #w[c’hevad’hór!] ‘love me!’, and passive affixes are placed last, e.g. #w[b’had’hórérá] ‘be loved by
us!’. The negation of the imperative uses the subjunctive and is explained in @subsubsec:negated-subjunctive.

== Past Tenses <subsec:tense-and-aspect-marking>
Uf has three past tenses, which are marked by additional sets of affixes that are appended to the verb in addition
to the active/passive affixes:

- the Present Anterior, which has a perfect or perfective aspect and is commonly used
      to describe events that are completed or extend to the present—particularly events that occurred recently, hence the name;
- the Preterite, which has an imperfective aspect and is used to describe events that are ongoing or habitual;
- the Preterite Anterior, which functions as a pluperfect.

=== Present Anterior and Preterite <subsubsec:suffixed-tenses>
The present anterior and preterite are formed by appending a set of suffixes to the verb. These affixes are appended
‘on top of’ the present-tense active/passive affixes whose suffix parts they replace or coalesce with; the prefix parts
of the present-tense affixes remain unchanged. These #s[pres ant] and #s[pret] suffixes, as well as precombined forms,
are shown in @tab:pres-ant-combined and @tab:pret-combined below.

#[
#let pres-ant-pret-table(caption: [], ..rows) = figure(
    caption: caption ,
    [
        #show : italic-table-body.with(cols: (0, 4, 8))
        #show table.cell: it => if (it.x in (0, 4) and it.y != 0) { smallcaps(it) } else { it }
        #rowtable(
            table.header[ Suffix & Sg & Pl && Active & Sg & Pl && Passive & Sg & Pl ],
            ..(1, 6).map(it => hlineat(it, end: 3)),
            ..(1, 6).map(it => hlineat(it, start: 4, end: 7)),
            ..(1, 6).map(it => hlineat(it, start: 8)),
            ..vlinesat(1, 2, 5, 6, 9),
            align: (x, y) => {
                if x in (1, 5) and y in (6, 7) { center } else { left }
            },
            ..rows.pos()
        )
    ]
)

#pres-ant-pret-table(
    caption: [Present Anterior Affixes],
    [ #s[1st]  & -#L é & -#L â      && #s[1st]  &j- -#L é     &aú-/r-/w- -#L â  &&#s[1st]  &v- -#L é    &aú-/r-/w- -#L â ],
    [ #s[2nd]  & -#L á & -#L áḍ     && #s[2nd]  &ḍ(ẹ)- -#L á  &b’h(y)- -#L áḍ   &&#s[2nd]  &ḍ(ẹ)- -#L á &b’h(y)- -#L áḍ  ],
    [ #s[3m]   & -#L á & -#L ér     && #s[3m]   &l(ẹ)- -#L á  &l(ẹ)- -#L ér     &&#s[3m]   &y’- -#L á   &lý- -#L ér      ],
    [ #s[3f]   & -#L á & -#L ér     && #s[3f]   &ll(a)- -#L á &ll(ẹ)- -#L ér    &&#s[3f]   &y’- -#L á   &lý- -#L ér      ],
    [ #s[3n]   & -#L á & -#L ér     && #s[3n]   &s- -#L á     &l(a)- -#L ér     &&#s[3n]   &sy- -#L á   &lý- -#L ér      ],
    [ #s[inf]  & #col2[-á]  && #s[inf]  &#col2[d(ẹ)- -á] &&#s[inf]  &#col2[à-/h- -á]],
    [ #s[ptcp] & #col2[-ér] && #s[ptcp] &#col2[-êr]      &&#s[ptcp] &#col2[â- -ér]],
) <tab:pres-ant-combined>

#pres-ant-pret-table(
    caption: [Preterite Affixes],
    [ #s[1st]  & -#L á  & -y’aû     && #s[1st]  &j- -#L á     &aú-/r-/w- -#L y’aû  &&#s[1st]  &v- -#L é    &aú-/r-/w- -#L y’aû ],
    [ #s[2nd]  & -#L é  & -y’ẹ́      && #s[2nd]  &ḍ(ẹ)- -#L é  &b’h(y)- -#L y’ẹ́     &&#s[2nd]  &ḍ(ẹ)- -#L é &b’h(y)- -#L y’ẹ́    ],
    [ #s[3m]   & -#L é  & -#L é     && #s[3m]   &l(ẹ)- -#L é  &l(ẹ)- -#L é         &&#s[3m]   &y’- -#L é   &lý- -#L é          ],
    [ #s[3f]   & -#L é  & -#L é     && #s[3f]   &ll(a)- -#L é &ll(ẹ)- -#L é        &&#s[3f]   &y’- -#L é   &lý- -#L é          ],
    [ #s[3n]   & -#L é  & -#L é     && #s[3n]   &s- -#L é     &l(a)- -#L é         &&#s[3n]   &sy- -#L é   &lý- -#L é          ],
    [ #s[inf]  & #col2[-é]  && #s[inf]  &#col2[d(ẹ)- -é]           &&#s[inf]  &#col2[à-/h- -é]],
    [ #s[ptcp] & #col2[-ár] && #s[ptcp] &#col2[-âr]                &&#s[ptcp] &#col2[â- -ár]],
) <tab:pret-combined>
]

#partitle[Lenition]
All #s[pres ant] and #s[pret] suffixes, except for the infinitive and #s[1pl, 2pl pret], lenite any consonant _before_ them, e.g.
#w[ḅárḍáḍ] ‘to be willing’ to #w[jḅárḍát’hé] ‘I was willing’ but #w[dẹḅárḍáḍá] ‘to have been willing’.

#partitle[Coalescence]
In both tenses, the initial vowel of suffixes coalesces with any preceding vowel according to the following rules; note
that all of these except the first describe distinct cases.

- First, if the preceding vowel is #w[ẹ], it is simply deleted, e.g. #w[jrévôt’hẹ] ‘I return’ becomes #w[jrévôt’hé]
          ‘I returned’. This case takes precedence over all other cases.
- If either vowel is fully nasal, no coalescence occurs, e.g. #w[jvŷ] ‘I lead’ becomes #w[jvŷé] ‘I led’.
- If the preceding vowel is #w[è] or #w[ẹ́] and the suffix vowel is #w[é], they merge into #w[ẹ́] or #w[ệ].
- If both vowels have the same quality (and neither is fully nasal), they merge into a vowel with that
          quality, and a level of nasalisation is added,#footnote[All suffixes are either nasalised or nasal, so there
          can never be a case where we’d end up with two oral vowels coalescing here.] e.g.
          #w[jvvaúríhe] ‘I remember’ becomes #w[jvvaúríhé] ‘I remembered’.
- In any other case (i.e. if the vowels differ in quality), hiatus is maintained, e.g. #w[ní] ‘to deny’ becomes
          #w[âníér] ‘having been denied’.

#partitle[Multiple Affixes]
If a verb takes both and active and a passive person affix, the suffix aligns with the active affix; thus
#s[pres ant] ‘she loved me’ is #w[llavad’hórá]. Note that #w[llavád’hóré], while also grammatical, is the
corresponding #s[pret] form instead since the #w[-é] indicates a #s[pret] in the #s[3f].

#partitle[Diachrony]
Diachronically, the #s[1sg pret] is an interesting case; in EUF, it was originally \*#w[-é], but it later changed to #w[-á]
to distinguish it from the #s[2sg, 3sg pres ant]. The remaining forms—save the infinitives, which are derived from the
tenses’ definite endings by analogy—originated from the PF simple past tenses.

#partitle[Examples]
The table below lists the example paradigm of the verb #w[ad’hór] in the present anterior and preterite tenses.
Observe that there is no difference between the #s[1pl, 2pl] active and passive.

#conjugation-table(
    caption: [Present Anterior Paradigm of the Verb #w[ad’hór]],
    [#s[1st]        & jad’hóré  & rad’hórâ     &     & #s[1st]         & vad’hóré  & rad’hórâ   ],
    [#s[2nd]        & ḍad’hórá  & b’had’hóráḍ  &     & #s[2nd]         & ḍad’hórá  & b’had’hóráḍ ],
    [#s[3m]         & lad’hórá  & lad’hórér    &     & #s[3m]       & y’ad’hórá & lýad’hórér  ],
    [#s[3f]         & llad’hórá & llad’hórér   &     & #s[3f]       & y’ad’hórá & lýad’hórér  ],
    [#s[3n]         & sad’hórá & lad’hórér    &     & #s[3n]       & syad’hórá & lýad’hórér  ],
    [#s[inf] &#col2[dad’hórá] & & #s[inf] & #col2[ád’hórá] ],
    [#s[ptcp]&#col2[ad’hórêr]&&#s[ptcp]&#col2[âd’hórér]],
) <tab:adhor-paradigm-pres-ant>

#conjugation-table(
    caption: [Preterite Paradigm of the Verb #w[ad’hór]],
    [#s[1st]        & jad’hórá  & rad’hóry’aû   && #s[1st]     & vad’hórá  & rad’hóry’aû   ],
    [#s[2nd]        & ḍad’hóré  & b’had’hóry’ẹ́  && #s[2nd]      & ḍad’hóré  & b’had’hóry’ẹ́ ],
    [#s[3m]         & lad’hóré  & lad’hóré      && #s[3m]      & y’ad’hóré & lýad’hóré  ],
    [#s[3f]         & llad’hóré & llad’hóré     && #s[3f]      & y’ad’hóré & lýad’hóré  ],
    [#s[3n]         & sad’hóré & lad’hóré      && #s[3n]       & syad’hóré & lýad’hóré  ],
    [#s[inf] & #col2[dad’hóré] & & #s[inf] & #col2[ád’hóré] ],
    [#s[ptcp]&#col2[ad’hórâr]&&#s[ptcp]&#col2[âd’hórár]],
) <tab:adhor-paradigm-pret>


=== Preterite Anterior
The preterite anterior tense, sometimes also called the ‘pluperfect’, is used to describe events that happened before
another event in the past, e.g. #w[jyád’hórâr] ‘I had loved’; it is formed using coalesced forms of the preterite participle
and the preterite form of the verb #w[av́ár] ‘to have’.#footnote[Note that the modern preterite stem of #w[av́ár] is #w[y].]
The following table illustrates the underlying construction using #w[ad’hór], though it is worth noting that these
forms are not actually grammatical:

#conjugation-table(
    caption: [Preterite Anterior Construction],
    [#s[1st] &\*jyá ad’hórâr  &\*ryy’aû ad’hórâr   &&#s[1st] &\*vyá âd’hórár  &\*ryy’aû âd’hórár],
    [#s[2nd] &\*ḍyé ad’hórâr  &\*b’hyy’ẹ́ ad’hórâr  &&#s[2nd] &\*ḍyé âd’hórár  &\*b’hyy’ẹ́ âd’hórár],
    [#s[3m]  &\*lyé ad’hórâr  &\*lyé ad’hórâr      &&#s[3m]  &\*y’yé âd’hórár &\*lýÿé âd’hórár],
    [#s[3f]  &\*llyé ad’hórâr &\*llyé ad’hórâr     &&#s[3f]  &\*y’yé âd’hórár &\*lýÿé âd’hórár],
    [#s[3n]  &\*syé ad’hórâr  &\*lyé ad’hórâr      &&#s[3n]  &\*syÿé âd’hórár &\*lýÿé âd’hórár],
    [#s[inf]&#col2[\*dyé ad’hórâr]&&inf&#col2[\*hyé âd’hórár]],
    [#s[ptcp]&#col2[\*yâr ad’hórâr]&&#s[ptcp]&#col2[\*âyár âd’hórár]],
) <tab:preterite-ant>

Based on this underlying principle, the actual preterite anterior forms can be constructed using a series of coalescence
rules: first, if the participle starts with a consonant (which is only possible in the active as the passive will always have
the passive participle prefix #w[â-] prepended to it), or the form of #w[av́ár] ends with a consonant (which is only the case
in the participle) the two verbs forms are simply written as one word, e.g. #w[jyávvaúríhê] ‘I had remembered’.

Otherwise, we have a collision of two vowels. The first vowel of the participle is erased. If it was nasal(ised),
a _single_ level of nasalisation is added to the last vowel of the form of #w[av́ár], then, the two forms are concatenated as
by the first rule, e.g. #w[ḍyéd’hórâr] ‘you had loved’, and #w[ḍyêd’hórár] ‘you had been loved’. Thus, the actual paradigm
of #w[ad’hór] in the preterite anterior is as shown in @tab:adhor-paradigm-pret-ant below.

#conjugation-table(
    caption: [Preterite Anterior Paradigm of #w[ad’hór]],
    [#s[1st] &jyád’hórâr  &ryy’aûd’hórâr   &&#s[1st] &vyâd’hórár  &ryy’aûd’hórár],
    [#s[2nd] &ḍyéd’hórâr  &b’hyy’ẹ́d’hórâr  &&#s[2nd] &ḍyêd’hórár  &b’hyy’ệd’hórár],
    [#s[3m]  &lyéd’hórâr  &lyéd’hórâr      &&#s[3m]  &y’yêd’hórár &lýÿêd’hórár],
    [#s[3f]  &llyéd’hórâr &llyéd’hórâr     &&#s[3f]  &y’yêd’hórár &lýÿêd’hórár],
    [#s[3n]  &syéd’hórâr  &lyéd’hórâr      &&#s[3n]  &syÿêd’hórár &lýÿêd’hórár],
    [#s[inf]&#col2[dyéd’hórâr]&&inf&#col2[hyêd’hórár]],
    [#s[ptcp]&#col2[yârad’hórâr]&&#s[ptcp]&#col2[âyárâd’hórár]],
) <tab:adhor-paradigm-pret-ant>

Note that the active participle is used with active prefixes and the passive participle with passive prefixes. If both
are present, either may be used, depending on the dialect; for example, the passive participle is preferred in
literary language, whereas the active participle is more common in speech.

The subjunctive and optative paradigms can be obtained using the same construction and follow the same coalescence
rules: first, construct the appropriate form of #w[av́ár], and the perform the merging with the appropriate _indicative_
participle, e.g. \*#w[jèsá ad’hórâr] > #w[jèsád’hórâr] (roughly ‘I should have had loved’#footnote[This is another of
those forms that has no real equivalent in English and is fairly untranslatable.]).

Finally, as always, these forms are stressed on the last syllable of the stem of the actual verb; the coalesced form
of #w[av́ár] is unstressed.

== Future Tenses
UF has two paradigms of future tenses: The Future I is a more modern construction and is only used in spoken informal
language. The Future II is an older, more literary tense that uses a separate stem, which is also used to form other future
tenses such as the Future Anterior and the Conditionals.

=== Future I <subsubsec:future-i>
The future tenses, i.e. the Future I and II, Future Anterior (a tense similar to the future perfect), as well
as the Conditional I and II, are formed by adding prefixes to the present forms. The prefix is the same in all persons and numbers,
except that there is a separate prefix for the infinitive.

In the Future, much to the UF learner’s dismay, this prefix can go in two separate positions: either before the person marker(s) or
inbetween the person marker(s) and the stem. The former case is more common in speech, while the later is more literary
and strongly preferred in writing and poetry as well as in formal speech. But even in informal speech, the Future I alone
will still not be enough to get by, as the Conditional, a _very_ common tense, is formed using the Future II.

First, let us examine the former, simpler case, commonly called the Future I. The prefix is #w[aú-] if the verb form
after it starts with a consonant (except glides), #w[aúr-] in all other cases; e.g. #w[aújad’hór] ‘I shall love’, but
#w[aúrý’ad’hór] ‘he will be loved’. In the infinitive passive, it
contracts with the initial #w[à-] or #w[á-] to #w[aú] or #w[aû], e.g. #w[aûd’hór] ‘to be about to be loved’.#footnote[This too is
hard to translate literally.] No contraction happens
if the infinitive starts with #w[â], e.g. #w[aúrânvé] ‘to be about to be animated’. Since
there is little point in writing a table for just the prefixes, @tab:adhor-paradigm-future-1 instead shows the Future I paradigm
of the verb #w[ad’hór].

#conjugation-table(
    caption: [Future I Paradigm of the Verb #w[ad’hór]],
    [#s[1st]&aújad’hór&aúrad’hóró   &&#s[1st] &aúvad’hór&aúrad’hór],
    [#s[2nd]&aúḍad’hór&aúb’had’hóré &&#s[2nd] &aúḍad’hór&aúb’had’hór],
    [#s[3m]&aúlad’hór&aúlad’hór     &&#s[3m] &aúry’ad’hór&aúlýad’hór],
    [#s[3f]&aúllad’hór&aúllad’hór   &&#s[3f] &aúry’ad’hór &aúlýad’hór],
    [#s[3n]&aúsad’hór&aúlad’hór   &&#s[3n] &aúsyad’hór&aúlýad’hór],
    [#s[inf]&#col2[aúdad’hór]&&inf&#col2[aûd’hór]],
    [#s[ptcp]&#col2[aúrad’hórâ]&&#s[ptcp]&#col2[aúrâd’hór]],
) <tab:adhor-paradigm-future-1>


=== Future II <subsubsec:future-ii>
The Future I paradigm is fairly straight-forward; unfortunately, the Future II is a lot worse: not only do the affixes
vary a lot more, but they are different depending on whether verb form following them starts with a vowel or a
consonant.#footnote[This also means that e.g. adding a consonantal passive prefix before a vocalic stem will change the
future inflexion to be consonantal; compare #w[b’had’hórérẹ́] ‘I will love’ as opposed to #w[jaúsyad’hórérệ] ‘I will love it’.]
The vocalic and consonantal Future II affixes are shown in @tab:future-2-vocalic and @tab:future-2-consonantal below, respectively.

The diachrony of these forms is somewhat unclear—especially that of the participles. It would appear, however, that they result
from a coalescence of the personal pronouns with forms of some auxiliary (likely PF #pf[avoir] and #pf[aller]) as well as
the PF future. It appears that the #s[2sg] is derived from the formal PF #s[2pl] pronoun, which is in line with the fact that
the Future II is generally considered more formal than the almost colloquial Future I. The #w[v́] in the #s[2pl act] seems to
be the result of metathesis.

#conjugation-table(
    caption: [Vocalic Future II Affixes],
    [#s[1st]   &b’h- -(ẹ)  &náý’- -aú      &&#s[1st]    &v- -é    &náý’-     ],
    [#s[2nd]   &ḍír- -(ẹ)  &b’haý’- -(r)ẹ́  &&#s[2nd]    &ḍír-     &b’haý’-   ],
    [#s[3m] &ł-  -(ẹ)   &lb’h- -aú         &&#s[3m]   &l-       &lb’h- -(r)e ],
    [#s[3f] &èł-  -(ẹ)  &lb’h- -aú         &&#s[3f]   &l-       &lb’h- -(r)e ],
    [#s[3n] &aúł-  -(ẹ) &lb’h- -aú         &&#s[3n]   &s-       &lb’h- -(r)e ],
    [#s[inf]&#col2[d- -è]&&inf&#col2[h-]],
    [#s[ptcp]&#col2[-ŷr]&&#s[ptcp]&#col2[á- -ýr]],
) <tab:future-2-vocalic>

#conjugation-table(
    caption: [Consonantal Future II Affixes],
    [#s[1st]   &jaú- -ẹ́  &aúnraû- -aú &&#s[1st]   &vaú- -é  &naú-    ],
    [#s[2nd]   &b’há- -(ẹ) &v́aú- -e   &&#s[2nd]   &ḍá-  &b’haú-      ],
    [#s[3m] &aúr-  -(ẹ) &laú- -aú     &&#s[3m]  &y’aúr-  &laú- -(r)e ],
    [#s[3f] &aúr-  -(ẹ) &laú- -aú     &&#s[3f]  &y’aúr-  &laú- -(r)e ],
    [#s[3n] &aúr-  -(ẹ) &laú- -aú     &&#s[3n]  &saúr-   &laú- -(r)e ],
    [#s[inf]&#col2[dẹ- -è]&&inf&#col2[haú-]],
    [#s[ptcp]&#col2[-(r)ŷ]&&#s[ptcp]&#col2[á- -(r)ý]],
) <tab:future-2-consonantal>

#partitle[Future Stem]
Many verbs have a different future stem that is used in all future tenses (except the Future I); for example, the future
stem of #w[vvaúríhe] ‘to remember’, is #w[vvaúríźe]; thus, we have
#w[jvvaúríhe] ‘to remember’ but #w[jaúvvaúríźẹ́] ‘I shall remember’.

Note also that these forms already include the
active/passive affixes, which is why it’s #w[jaúvvaúríźẹ́] and not \*#w[jaújvvaúríźẹ́] or \*#w[jjaúvvaúríźẹ́].
As in the present, the dictionary form of the future
stem is a verbal noun; thus, #w[vvaúríźe] roughly means ‘the act of being about to remember’.#footnote[As noted before, infinitive
and gerund forms of future tenses are difficult to translate into English.]

The future _subjunctive_ uses a different stem; for that, see @subsec:subjunctive.

#partitle[Stem-final vowel elision and #w[-(ẹ)]]
If the future stem ends with #w[e], #w[ẹ], #w[é], #w[ẹ́], or #w[è], that vowel is dropped if any future suffix or a suffix that starts with a vowel is added, e.g.
#w[laúvvaúríźaú] ‘they will remember’, not \*#w[laúvvaúríźeaú]. Note that in the case of future suffixes, even those that start
with a consonant cause the vowel to be dropped. The only exception to this is the suffix #w[-(ẹ)], which is found in a number of
Future II forms; that suffix is dropped instead, e.g. #w[aúrvvaúríźe] ‘she will remember’, not \*#w[aúrvvaúríźẹ].

#partitle[Nasal Stems]
Some future stems are nasalising, which is the case if the final vowel is a nasal vowel; in such cases, that vowel
is still dropped if a suffix is added, but if that suffix starts with a vowel, nasalisation is applied to it, e.g.
in the case of #w[dír], whose future stem is #w[dírẹ́], we have #w[aúnraûdíraû] ‘we shall say’: the #w[-aú] suffix merges
with the nasalisation of the final vowel to become #w[aû]. Unlike with regular stems, the Future II #w[-(ẹ)] _does_
replace the final vowel and becomes #w[-ẹ́] for such verbs, e.g. #w[aúrdírẹ́] ‘he will say’, and #s[1sg fut pass]
vocalic #w[-é] becomes #w[-ê].

#partitle[#w[r-] Dropping]
Initial #w[r] in Future II suffixes is dropped if the
last consonant before the final vowel of the future stem is #w[w], or an ʁ-coloured consonant such as #w[ź], e.g.
#w[laúvvaúríźe] ‘they will be remembered’, not \*#w[laúvvaúríźre]. If the last consonant of the future stem is #w[r], since
any following vowel (whether nasalised or not) is deleted when a Future II suffix is added, the final #w[r] of the stem and
the initial #w[-r] of the Future II suffixes that have one coalesce to #w[rr], e.g. #w[b’haý’ad’hórérre] ‘you (#s[pl]) will
love’.

#partitle[Affix Stacking]
Note that when more than one affix is used, at most one can be a future affix, e.g. #w[jaúsyvvaúríźẹ́] ‘I shall remember it’
and not \*#w[jaúsaúrvvaúríźẹ́]. Generally, the active prefix will be the future affix, but it is possible to use the
passive future affixes instead for emphasis e.g. #w[jy’aúrvvaúríźe] roughly ‘him, I shall remember’; often, this is
also used to aid in establishing a contrast to some other part of the sentence that does not have this inversion.

Finally, as always, infinitive prefixes come first. If combined with other affixes, it will generally be the future affix,
e.g. #w[haújvvaúríźe] roughly ‘them to be about to be remembered by me’ but, as with passive affixes, variations are possible for emphasis
or contrastive power, e.g. #w[dẹjaúvvaúríźẹ́], which puts more emphasis on ‘me’.

#partitle[Examples]
@tab:future-2-adhor below shows the complete (vocalic) Future II paradigm of the verb #w[ad’hór] ‘to love’, and
@tab:future-2-vvaurihe the complete (consonantal) Future II paradigm of II #w[vvaúríhe] ‘to remember’; recall
that the future stems of these verbs are #w[ad’hórérẹ́] and #w[vvaúríźe].

#conjugation-table(
    caption: [Vocalic Future II Paradigm of #w[ad’hór]],
    [#s[1st]   &b’had’hórérẹ́  &náý’ad’hóréraû   &&#s[1st]    &vad’hórérệ    &náý’ad’hórérẹ́   ],
    [#s[2nd]   &ḍírad’hórérẹ́  &b’haý’ad’hórérrẹ́ &&#s[2nd]    &ḍírad’hórérẹ́  &b’haý’ad’hórérẹ́ ],
    [#s[3m] &ład’hórérẹ́    &lb’had’hóréraû      &&#s[3m]   &lad’hórérẹ́    &lb’had’hórérre  ],
    [#s[3f] &èład’hórérẹ́   &lb’had’hóréraû      &&#s[3f]   &lad’hórérẹ́    &lb’had’hórérre  ],
    [#s[3n] &aúład’hórérẹ́  &lb’had’hóréraû      &&#s[3n]   &sad’hórérẹ́    &lb’had’hórérre  ],
    [#s[inf]&#col2[dad’hóréré]&&inf&#col2[had’hórérẹ́]],
    [#s[ptcp]&#col2[ad’hórérŷr]&&#s[ptcp]&#col2[ád’hórérýr]],
) <tab:future-2-adhor>

#conjugation-table(
    caption: [Consonantal Future II Paradigm of #w[vvaúríhe]],
    [#s[1st]   &jaúvvaúríźẹ́  &aúnraûvvaúríźaú &&#s[1st]   &vaúvvaúríźé    &naúvvaúríźe ],
    [#s[2nd]   &b’hávvaúríźe &v́aúvvaúríźe     &&#s[2nd]   &ḍávvaúríźe  &b’haúvvaúríźe  ],
    [#s[3m] &aúrvvaúríźe  &laúvvaúríźaú       &&#s[3m] &y’aúrvvaúríźe  &laúvvaúríźe ],
    [#s[3f] &aúrvvaúríźe  &laúvvaúríźaú       &&#s[3f] &y’aúrvvaúríźe  &laúvvaúríźe ],
    [#s[3n] &aúrvvaúríźe  &laúvvaúríźaú       &&#s[3n] &saúrvvaúríźe   &laúvvaúríźe ],
    [#s[inf]&#col2[dẹvvaúríźè]&&inf&#col2[haúvvaúríźe]],
    [#s[ptcp]&#col2[vvaúríźŷ]&&ptcp&#col2[ávvaúríźý]],
) <tab:future-2-vvaurihe>

=== Future Anterior
The Future Anterior tense is formed by combining the Future II and the Present Anterior affixes. The #s[pres ant] suffixes
are applied after the #s[fut ii] affixes. The vocalic and consonantal affixes are shown in
@tab:future-anterior-vocalic and @tab:future-anterior-consonantal.

#conjugation-table(
    caption: [Vocalic Future Anterior Affixes],
    [#s[1st]   &b’h- -#L é  &náý’- -aúrâ    &&#s[1st]    &v- -#L ê    &náý’- -#L â    ],
    [#s[2nd]   &ḍír- -#L á  &b’haý’- -(r)ệḍ &&#s[2nd]    &ḍír- -#L á  &b’haý’- -#L áḍ ],
    [#s[3m] &ł-   -#L á  &lb’h- -aûr        &&#s[3m]  &l- -#L á    &lb’h- -(r)ér   ],
    [#s[3f] &èł-  -#L á  &lb’h- -aûr        &&#s[3f]  &l- -#L á    &lb’h- -(r)ér   ],
    [#s[3n] &aúł- -#L á  &lb’h- -aûr        &&#s[3n]  &s- -#L á    &lb’h- -(r)ér   ],
    [#s[inf]&#col2[d- -á]&&inf&#col2[h- -á]],
    [#s[ptcp]&#col2[-ŷrér]&&#s[ptcp]&#col2[á- -ýrér]],
) <tab:future-anterior-vocalic>

#conjugation-table(
    caption: [Consonantal Future Anterior Affixes],
    [#s[1st]   &jaú-  -#L ệ  &aúnraû- -aúrâ  &&#s[1st]   &vaú- -#L ê    &naú- -#L â  ],
    [#s[2nd]   &b’há- -#L á  &v́aú- -éḍ       &&#s[2nd]   &ḍá- -#L á  &b’haú- -#L áḍ  ],
    [#s[3m] &aúr-  -#L á  &laú- -aûr         &&#s[3m] &y’aúr- -#L á  &laú- -(r)ér ],
    [#s[3f] &aúr-  -#L á  &laú- -aûr         &&#s[3f] &y’aúr- -#L á  &laú- -(r)ér ],
    [#s[3n] &aúr-  -#L á  &laú- -aûr         &&#s[3n] &saúr-  -#L á  &laú- -(r)ér ],
    [#s[inf]&#col2[dẹ- -á]&&inf&#col2[haú- -á]],
    [#s[ptcp]&#col2[-(r)ŷr]&&#s[ptcp]&#col2[á- -(r)ýr]],
) <tab:future-anterior-consonantal>


Note that again, nasalised stems add another level of nasalisation, and vowel-dropping still applies, but
this time, there is no #w[-ẹ] dropping, since none of the affixes end with #w[ẹ] anymore.

#partitle[Coalescence]
All vowel suffixes coalesce with the final vowel of the stem; if the suffix vowel is nasal, a level of nasalisation is
added, e.g. #w[aúrvvaúrízá] ‘he will have remembered’ from the future stem #w[vvaúríźe]. Note also that the #w[ź] is lenited
to #w[z]; the quality of the suffix vowel overrides that of the stem vowel. #w[r] contraction still happens as in the
Future II.

@tab:future-ant-adhor and @tab:future-ant-vvaurihe below show
the paradigm of the verbs #w[ad’hór] ‘to love’ and #w[vvaúríhe] ‘to remember’ in the Future Anterior tense. Note that
both the rules for the Future Anterior tense as well as the Present Anterior tense apply here.

#conjugation-table(
    caption: [Vocalic Future Anterior Paradigm of #w[ad’hór]],
    [#s[1st]   &b’had’hórérệ  &náý’ad’hóréraûrâ  &&#s[1st]    &vad’hórérệ    &náý’ad’hórérậ    ],
    [#s[2nd]   &ḍírad’hórérậ  &b’haý’ad’hórérrệḍ &&#s[2nd]    &ḍírad’hórérậ  &b’haý’ad’hórérậḍ ],
    [#s[3m] &ład’hórérậ    &lb’had’hóréraûr      &&#s[3m]  &lad’hórérậ    &lb’had’hórérrér  ],
    [#s[3f] &èład’hórérậ   &lb’had’hóréraûr      &&#s[3f]  &lad’hórérậ    &lb’had’hórérrér  ],
    [#s[3n] &aúład’hórérậ  &lb’had’hóréraûr      &&#s[3n]  &sad’hórérậ    &lb’had’hórérrér  ],
    [#s[inf]&#col2[dad’hórérâ]&&inf&#col2[had’hórérậ]],
    [#s[ptcp]&#col2[ad’hórérŷrér]&&#s[ptcp]&#col2[ád’hórérýrér]],
) <tab:future-ant-adhor>

#conjugation-table(
    caption: [Consonantal Future Anterior Paradigm of#w[vvaúríhe]],
    [#s[1st] &jaúvvaúrízệ  &aúnraûvvaúríźaúrâ &&#s[1st] &vaúvvaúrízê   &naúvvaúrízâ    ],
    [#s[2nd] &b’hávvaúrízá &v́aúvvaúríźéḍ      &&#s[2nd] &ḍávvaúrízá    &b’haúvvaúrízáḍ ],
    [#s[3m]  &aúrvvaúrízá  &laúvvaúríźaûr     &&#s[3m]  &y’aúrvvaúrízá &laúvvaúríźér   ],
    [#s[3f]  &aúrvvaúrízá  &laúvvaúríźaûr     &&#s[3f]  &y’aúrvvaúrízá &laúvvaúríźér   ],
    [#s[3n]  &aúrvvaúrízá  &laúvvaúríźaûr     &&#s[3n]  &saúrvvaúrízá  &laúvvaúríźér ],
    [#s[inf]&#col2[dẹvvaúríźá]&&inf&#col2[haúvvaúríźá]],
    [#s[ptcp]&#col2[vvaúríźŷr]&&ptcp&#col2[ávvaúríźýr]],
) <tab:future-ant-vvaurihe>


=== Conditional I and II <subsubsec:conditional>
The Conditional tenses are fairly simple—so long as you know the Future II and Future Anterior, that is. Both Conditionals
are formed by adding the #w[-ss(a)-] infix between the Future II stem and any suffixes.

#conjugation-table(
    caption: [Consonantal Conditional II Paradigm of#w[vvaúríhe]],
    [#s[1st]   &jaúvvaúríźessệ  &aúnraûvvaúríźessaúrâ &&#s[1st]   &vaúvvaúríźessê    &naúvvaúríźessâ ],
    [#s[2nd]   &b’hávvaúríźessá &v́aúvvaúríźesséḍ      &&#s[2nd]   &ḍávvaúríźessá  &b’haúvvaúríźessáḍ ],
    [#s[3m] &aúrvvaúríźessá  &laúvvaúríźessaûr        &&#s[3m]  &y’aúrvvaúríźessá  &laúvvaúríźessrér ],
    [#s[3f] &aúrvvaúríźessá  &laúvvaúríźessaûr        &&#s[3f]  &y’aúrvvaúríźessá  &laúvvaúríźessrér ],
    [#s[3n] &aúrvvaúríźessá  &laúvvaúríźessaûr        &&#s[3n]  &saúrvvaúríźessá   &laúvvaúríźessrér ],
    [#s[inf]&#col2[dẹvvaúríźessá]&& #s[inf]&#col2[haúvvaúríźesse]],
    [#s[ptcp]&#col2[vvaúríźessŷr]&&#s[ptcp]&#col2[ávvaúríźessý]],
) <tab:cond-ii-vvaurihe>

The Conditional I is formed from
the Future II, and the Conditional II from the Future Anterior. The #w[a] in #w[-ss(a)-] is omitted if
the suffix after the infix starts with a vowel, except for #w[ẹ], which it replaces. @tab:cond-ii-vvaurihe
shows the consonantal Conditional II paradigm of #w[vvaúríhe] ‘to remember’. Note that the #w[ss] in this form
is _never_ lenited.

The conditional tenses are mainly used in the apodoses of conditional clauses. On their own, their meaning
is similar to that of the English ‘would’ (I) or ‘could’ (II), e.g. #w[jaúvvaúríźessẹ́] ‘I would remember’. The Conditional I
can be combined with the gnomic to express a general observation of someone’s disposition, e.g.
#w[laúsynárrahódejússaub’he’sý’ýâ] ‘they wouldn’t narrate it to you (implied: because they just don’t do things like that)’.

The Conditional I can also be used to express a future-in-the-past, and the Conditional II, even though it is
morphologically a future tense, is used to express a hypothetical past, e.g. #w[jaúvvaúríźessệ] ‘I could have loved’.
In reported speech, this can lead to a subjunctive conditional construction.

== Subjunctive <subsec:subjunctive>
The UF subjunctive forms are fortunately fairly simple: they use the same affixes as the present, past, and future
forms, except that each verb has a different, often irregular, subjunctive stem, which is generally formed
by adding an #w[-s] to the end of the corresponding indicative stem, e.g. #w[ad’hór] ‘to love’ to #w[ad’hórs];
thus we have, e.g. #w[jad’hórs] ‘I may love’, and #w[rád’hórsó] ‘We may love’.

The future subjunctive stem is always regular and formed by adding the desinence #w[-śe] to the end of the future stem. For example,
the future stem of #w[ad’hór] is #w[ad’hórérẹ́], so the future subjunctive stem is #w[ad’hórérẹ́śe]; similarly, the future
stem of #w[vvaúríhe] is #w[vvaúríźe], so the future subjunctive stem is #w[vvaúríźeśe]. The subjunctive stem coalesces like
a regular non-nasal future stem. Note that in the future anterior, the stem is often subject to lenition, and thus, the signature
#w[ś] of the future subjunctive often becomes #w[s].

There are several main uses of the UF subjunctive, each of which we shall examine in more detail below:

- in reported speech and indirect questions, e.g. #w[lladírá vad’hórhé] ‘she said she loved me’;
- with certain subordinating conjunctions, such as #w[b’he] ‘so that’;
- to express deontic modality, e.g. #w[ḍẹḅars] ‘you may leave’;
- as a jussive, e.g. #w[rad’hesó] ‘let’s go’;
- as a negative imperative, e.g. #w[sá ḍẹḅars] ‘don’t leave’;
- irrealis conditionals (see @subsec:conditionals);
- in a serial verb construction in the future, expressing purpose;
- with certain adverbs, e.g. #w[ḅýt’hèḍ] ‘maybe’;
- in #s[aci]s and #s[pci]s.

=== Reported Speech
UF does not use backshifting in reported speech, but rather, the corresponding subjunctive form is used. For instance,
#w[jḍad’hór] ‘I love you’ becomes #w[jdíré jḍad’hórs] ‘I said I love you’. Note that the tense stays the same in this
example: present indicative becomes present subjunctive. Accordingly, #w[jḍad’hóré] ‘I loved you’ becomes #w[jdíré
jḍad’hórsé] ‘I said I loved you’.

Consequently, the tense of the verb in reported speech is independent of the tense of the matrix clause, e.g.
#w[b’had’hrệ] ‘I shall go’ becomes #w[jdíré b’had’hrẹ́sé] ‘I said I would go’,#footnote[Note the lenition here because
of the present anterior suffix: #w[b’had’hrẹ́sé], not \*#w[b’had’hrẹ́śé].] with #w[b’had’hrẹ́sé] being the Future II
subjunctive form of #w[b’had’hrẹ́].

=== Dependent Clauses
#let subordinators(body) = {
    smallskip
    move(dx: 1em, columns(2, [
        #show strong: emph
        #body
    ]))
    smallskip
}

The following subordinating conjunctions take the subjunctive:

#subordinators[
    / áhaúr: ‘even though’
    / ḅas: ‘because’
    / b’he: ‘so that’
    / c’haúr: ‘as’ (viz. ‘because’)
    / de: ‘once’
    / ráhẹ: ‘though’
    #colbreak()
    / rê: ‘although’
    / s: ‘if’ (see @subsec:conditionals)
    / sá: ‘without’
    / sauc’h: ‘except that’
    / váłé: ‘despite that’
    / c’haúvs: ‘as if’, ‘as though’
]

Note that not all subordinating conjunctions take the subjunctive. For instance, the conjunction #w[y’is]
‘because’ takes the indicative: #w[jḍad’hórs c’haúr] ‘as I love you’, but #w[jḍad’hór y’ís] ‘because I love you’.

=== Deontic Modality
The subjunctive can also be used on its own, in which case it assumes a deontic or jussive meaning;
in the first person, it is generally a jussive, e.g. #w[rad’hesó] ‘let’s go’, but the jussive sense is not restricted
to the first person, e.g. #w[lẹsyrét’hes] ‘he take care of it’ (in the sense of ‘let him take care of it’).

The deontic sense is also apparent from that last example: #w[lẹsyrét’hes] can also be interpreted to mean ‘he
may take care of it’, which can either be a statement of permission or a condescending order. Note that even
though UF also has a word for ‘let’ (namely #w[le]), it is mostly used in questions or commands, while the
deontic subjunctive is used to grant permission.

=== Negation <subsubsec:negated-subjunctive>
The subjunctive is negated with the particle #w[sá], rather than with #w[asý’ýâ]. The particle #w[sá] is placed
immediately before the verb form it negates, e.g. #w[sá jḍad’hórs c’haúr] ‘as I don’t love you’. It is reduced
to #w[s’] before vowels, but interestingly, it does not cause nasalisation in that case, e.g. #w[s’aúsydíssâ c’haúr]
‘as we didn’t say it’.

On its own, the negated subjunctive is used to express a negative imperative in the second and third person,
e.g. #w[sá ḍẹḅars] ‘don’t leave’, and a negative jussive in the first person e.g. #w[sá rad’hesó], ‘let’s not go’.

=== Infinitive
Most curiously, UF has a _subjunctive infinitive_. This form is almost exclusively used to express deontic modality
in #s[aci]s and #s[pci]s. For example, the form #w[dad’hórs], the subjunctive infinitive of #w[ad’hór], while defying any attempt
at translation on its own,#footnote[The best attempt one could make to translate this would be something along the
lines of ‘to should love’, but that is not exactly grammatical in English.] can be translated as ‘should’ when combined
with an #s[acc] or #s[part], e.g. #w[sráhó dad’hórs] roughly means ‘that fish should love’, though this form can only
occur as the complement of a verb.

=== Future Subjunctive of Intent or Purpose
The future subjunctive is used in a serial verb construction with another verb to express purpose or intent: a
serial verb construction is a clause with two finite verbs; in this case, one combines any verb#footnote[The verb is
_usually_ a finite verb, but it may also be e.g. an infinitive if the future subjunctive of intent is nested
in an #s[aci].] with a finite subjunctive Future II, e.g. #w[jsyc’hrír jaúvvaúríźeśẹ́] ‘I’m writing
it down so I don’t forget’; the two needn’t agree in person, and word order, as ever with inflected forms, is not fixed,
e.g. #w[náý’aúréśaú sybźâ] ‘It was needed
for us to understand’.#footnote[Lit. ‘I write it [down]; I should-will remember’ and ‘It was needed, so that we
should-will understand’, respectively.]

The main semantic difference between this construction and #w[b’he] is that the latter strictly means ‘in order to’ or ‘so that’,
whereas this can be a bit broader in meaning; however, the future subjunctive of intent is also sometimes used to mean ‘in order to’
or ‘so that’.

== Optative <subsec:optative>
The UF optative is used to express wishes, hopes, as well as in certain conditional constructions. It is formed
by prefixing #w[y’(ẹ)#L] to the indicative (or future) stem,#footnote[The use of the (future) subjunctive stem to form the optative, with
no change in overall meaning, is fairly archaic and only encountered in poetry in modern UF.] e.g. #w[dẹvy’ẹvvaúríhe] ‘may
you remember me’. As ever, the #w[(ẹ)] is omitted if the stem starts with a vowel.

In the future, this generally does _not_ change whether the consonantal or vocalic affixes are used! If the stem was
vocalic, the vocalic affixes are also used in the optative. This is because the optative is conceptually appended to the prefix rather than
prepended to the stem. Moreover, some prefixes in the future end with
#w[ý’], which this is dropped in the optative: e.g. #w[náý’ad’hóraú] ‘we shall love’ becomes #w[náy’ad’hóraú] ‘may we love’ (the
difference is minor: #w[ý’] vs #w[y’]). A bare optative is difficult to translate into English; a more precise explanation of what
these forms actually mean will be given below. Uses of the optative include:

- wishes, hopes, dreams, and aspirations;
- with certain subordinating conjunctions, such as #w[auha] ‘in case’;
- talking about fears;
- counterfactual conditionals (see @subsec:conditionals).

=== Wishes and Hopes
The most traditional use of the optative is to express wishes and hopes, e.g. #w[dẹvy’ẹvvaúríhe] ‘may you remember me’. In
the present or future tense, this use indicates a wish for something to happen; in the present tense, its meaning is
that of a wish for a condition to be true in the present in the face of uncertainty or lack of knowledge; thus, the
actual meaning of #w[dẹvy’ẹvvaúríhe] is roughly ‘I hope that you remember me’.#footnote[The context of this could be e.g.
meeting someone again after a long time apart and hoping that they still remember you.] In the future tense, it indicates a wish
that a situation will be true in the future, e.g. #w[b’hávy’ẹvvaúríźe] ‘may you remember me’.

In the past tenses, the optative indicates dismay, regret, or disappointment that something did not happen, e.g.
#s[pres ant] #w[dẹvy’ẹvvaúríhá] ‘if only you had remembered me’. The optative can also be combined with the Conditional I
to convey uncertainty about a future wish, as well as with the Conditional II to express extreme regret over a past event;
certain verbs, e.g. #w[ub’hrá] ‘can, may, might’, also have constructions with the optative.

=== Dependent Clauses
The following subordinating conjunctions take the optative:

#subordinators[
    / auha: ‘in case’
    / ab’há: ‘before’
    / ávrê: ‘unless’
    / ḅré: ‘after’
    #colbreak()
    / fahaú: ‘in such a way that’
    / jys: ‘until’
    / sit’há: ‘supposing that’
    / úrbh: ‘provided that’
]

=== Negation and Verbs of Fearing <subsubsec:negated-optative>
As with the negated subjunctive, the negated optative also has a separate negation particle, namely #w[t’hé#N{]}
(#w[t’h’] with no nasalisation before vowels). Note that a negated optative indicates that the speaker wishes that something does
or had not happened, e.g. #w[t’hé dẹvy’ẹvvaúríhá] ‘if only you had not remembered me’. The negation thus negates
the wish, and not the act of wishing; for the latter, the indicative or subjunctive together with a verb such
as #w[sḅé] ‘to wish’ are used instead.

Verbs of fearing are typically construed with a dependent clause in the negated optative, e.g. #w[jréd’hé
t’hé b’háy’ẹbharẹ́] ‘I was afraid lest you might leave’.

== The Copula _eḍ_ <subsec:ed-paradigm>
There is only one irregular verb in UF, namely the copula #w[eḍ]. All of its forms are highly irregular. The copula lacks
passive forms as well as the Future I.  The preterite anterior is a periphrastic construction of the preterite participle
of #w[eḍ] and its present tense,#footnote[The original morphological preterite anterior tense of _eḍ_ was lost in
Late Middle UF.] e.g. #w[t’hẹdâ vy’í] ‘I had been’. Note that only the participle is
inflected for mood in this case, e.g. subjunctive #w[t’hẹrâ vy’í] ‘I should have been’. The gnomic is formed by
appending #w[(j)ú] to the end of a form, with the #w[j] dropped if the form in question ends with a consonant.

//#footnote[At the same time, the #s[1sg] forms seem to be derived from the #s[acc] of the PF #s[1sg] pronoun,
//for unknown reasons.]
#let ed-table(caption: [], ..rows) = figure(
    caption: caption,
    placement: none,
    [
        #show : italic-table-body.with(cols: (0,), rows: (0, 1))
        #rowtable(
            table.header[ &#col2[Present]&#col2[Pres. Ant.]&#col2[Preterite]&#col2[Future II]&#col2[Fut. Ant.]],
            hlineat(1, start: 1),
            hlineat(2),
            hlineat(7),
            ..vlinesat(..range(1, 11)),
            align: (x, y) => {
                if x != 0 and y in (0, 7, 8) { center } else { left }
            },
            ..rows.pos()
        )
    ]
)

#ed-table(
    caption: [Indicative Paradigm of #w[eḍ]],
    [ #s[ind] &Sg&Pl  & Sg &Pl & Sg &Pl & Sg &Pl & Sg &Pl ],
    [ #s[1st] & vy’í  & aúsó   & vẹ     & aúfý   & vet’h  & weḍy’ó   & vẹ́hér  & aúhér   & vẹhér    & aúfêr ],
    [ #s[2nd] & ḍe    & b’heḍ  & ḍyf    & b’hu   & ḍet’h  & b’heḍy’é & dyhér  & b’hehér & ḍyfér    & b’huhér ],
    [ #s[3m]  & le    & lẹsó   & leb’h  & lẹfýr  & let’h  & let’he   & lehér  & lẹhér   & leb’hér  & lẹfêr ],
    [ #s[3f]  & lle   & llẹsó  & lleb’h & llẹfýr & llet’h & llet’he  & llehér & llẹhér  & lleb’hér & llẹfêr ],
    [ #s[3n]  & se    & lasó   & seb’h  & lafýr  & set’h  & laet’h   & sehér  & lahér   & seb’hér  & lafêr ],
    [ #s[inf]& #col2[éḍ] &#col2[éfyḍ] & #col2[ét’hẹd] & #col2[éhér] & #col2[éfér] ],
    [ #s[ptcp]& #col2[ḍâ] &#col2[fyḍâ] & #col2[t’hẹdâ] & #col2[hérâ] & #col2[férâ] ],
) <tab:ed-paradigm-ind>

#ed-table(
    caption: [Subjunctive Paradigm of #w[eḍ]],
    [ #s[subj] &Sg&Pl  & Sg &Pl   & Sg &Pl & Sg &Pl & Sg &Pl ],
    [ #s[1st] & vy’íra  & aúra   & vẹsa   & aúfýs  & veḍra  & weḍra      & vẹ́héra  & aúhéra   & vẹhéra    & aúfêra ],
    [ #s[2nd] & ḍera    & b’hera & ḍys    & b’hus  & ḍeḍra  & b’heḍra    & dyhéra  & b’hehéra & ḍyféra    & b’huhéra ],
    [ #s[3m]  & lera    & lẹra   & les    & lẹfýs  & leḍra  & le’thra    & lehéra  & lẹhéra   & leb’héra  & lẹfêra ],
    [ #s[3f]  & llera   & llẹra  & lles   & llẹfýs & lleḍra & llet’hra   & llehéra & llẹhéra  & lleb’héra & llẹfêra ],
    [ #s[3n]  & sera    & lara   & ses    & lafýs  & seḍra  & laet’hra   & sehéra  & lahéra   & seb’héra  & lafêra ],
    [ #s[inf]& #col2[éḍra] &#col2[éfysa] & #col2[ét’hẹra] & #col2[éhéra] & #col2[éféra] ],
    [ #s[ptcp]& #col2[ḍerâ] &#col2[fysâ] & #col2[t’hẹrâ] & #col2[hérarâ] & #col2[férarâ] ],
) <tab:ed-paradigm-subj>

#ed-table(
    caption: [Optative Paradigm of #w[eḍ]],
    [ #s[opt] &Sg&Pl  & Sg &Pl   & Sg &Pl & Sg &Pl & Sg &Pl ],
    [ #s[1st] & víra      & aúry’a   & vẹsy’a    & aúfýy’a  & veḍraä  & weḍraä      & vẹ́ra  & aúra   & vẹra     & aúfrá ],
    [ #s[2nd] & ḍy’era    & b’hery’a & ḍysy’a    & b’huy’a  & ḍeḍraä  & b’heḍraä    & dyra  & b’hera & ḍyra     & b’hura ],
    [ #s[3m]  & ly’era    & lẹry’a   & lesy’a    & lẹfýy’a  & leḍraä  & le’thraä    & lera  & lẹra   & leb’hra  & lẹfrá ],
    [ #s[3f]  & lly’era   & llẹry’a  & llesy’a   & llẹfýy’a & lleḍraä & llet’hraä   & lléra & llẹra  & lleb’hra & llẹfrá ],
    [ #s[3n]  & sy’era    & lary’a   & sesy’a    & lafýy’a  & seḍraä  & laet’hraä   & sera  & lara   & seb’hra  & lafrá ],
    [ #s[inf]& #col2[éḍy’a] &#col2[éfyy’a] & #col2[ét’hẹä] & #col2[éhérá] & #col2[éférá] ],
    [ #s[ptcp]& #col2[ḍy’â] &#col2[fyy’â] & #col2[t’hẹáâ] & #col2[héráâ] & #col2[féráâ] ],
) <tab:ed-paradigm-opt>

All forms of the copula are shown in  @tab:ed-paradigm-ind to @tab:ed-paradigm-opt, except for the Conditional I and II,
which are formed by infixing #w[-ss-] before the #w[-ér], #w[-êr] desinences and #w[-ssa-] before the #w[-ra] and #w[-rá]
desinences of the Future II and Future Anterior forms, respectively.

Unlike nearly every other word in the language, disyllabic forms of the copula are stressed on
the first syllable, and trisyllabic forms are stressed on the second syllable—except for #w[hérarâ], #w[férarâ], #w[héráâ],
and #w[féráâ], which are stressed on the first syllable. All other participle forms are stressed on the last syllable.
In forms of the copula, #w[ae] is pronounced /ai̯/.

The etymology of these forms is mostly from a gradual simplification of coalesced forms of the personal
pronouns with the PF copula. To compensate for the fact that PF lacks certain forms that are present in UF, some
of the forms were coined by analogy. For instance, the #s[pres ant inf] #w[éfyḍ] is derived from the #s[pres ant]
stem \*#w[fy] and the #s[pres inf] #w[éḍ], and the same is true for the #s[pret inf] #w[ét’hẹd].

// The coalescence rule table is a terrible abomination that isn’t even fully up-to-date and
// is way too dense; I’m not even going to try converting or updating that.

#chapter([Syntax], "syntax")
UF syntax is unfortunately complicated in what morphological constructs are used in what situations, and
the rules are not always clear. The following is a list of the most common constructions.

== Word Order
Word order in ULTRAFRENCH is largely free at the sentence level. As we’ve already seen, the phrase-internal structure
is generally more rigid.#footnote[E.g. adjectives and appositions following nouns.] However, there are still some
structural rules that must be abided by.

== Coordination
Coordination in UF is accomplished by a set of conjunctive particles, chiefly #w[au] ‘and’, #w[u] ‘or (inclusive)’, and
#w[ra] ‘or (exclusive)’. When possible, it is preferred to place a particle before every conjunct.

- #w[au árb au raû] ‘the tree and the log’
- #w[Lasẹhérélé au láb’haúré au láhaul.] \ ‘The Sun and the North Wind were quarreling.’
- #w[Sav́áré lávaûd de au iraúl syl au sývaú vêâ.] \ ‘The entire world had one language and the same words.’

When a coordinated phrase is the subject or object of a verb, if either part is a pronoun, it is incorporated into the
verb as a singular active/passive affix, with the other noun declined in the appropiate case. If neither part is a pronoun,
the active/passive prefix, if required at all, is plural. If both parts are pronouns, the verb may have to be repeated—or
#w[fér] may be used instead, see @subsubsec:personal-pronouns—as there are no isolated personal pronouns in the
#s[nom], #s[acc], or #s[part].

- #w[Llẹvad’hór au ilè.] ‘She loves me and herself.’
- #w[Llad’hór au ivvâ au ibhabh.] ‘She loves her mother and her father.’
- #w[Lýy’ad’hór au’z lávvâ au’z lábhabh.] ‘Her mother her father love her.’
- #w[Llẹvad’hór au y’fér.] ‘She loves me and her.’
- #w[Llẹy’ad’hór au vfér.] ‘She loves her and me.’

== Independent Clauses
The UF independent clause typically consists of a finite verb together with a subject perhaps several
objects. The verb is conjugated to agree with the subject in person, number, and gender in some cases.

The unmarked tense in UF is the present tense, which can generally be translated as either a present or
present continuous tense in English. For general truths and facts, the gnomic tense is generally used
instead.


- #w[Rab’haḍó iárb.] ‘We are felling the tree.’
- #w[Rab’haḍjô sárb.] ‘We fell trees.’

The object is incorporated into the verb if it is a personal pronoun, in which case there are rules for
the order in which these affixes occur (see @subsec:verbal-morphology).

- #w[Lẹrab’hat’há.] ‘He felled us.’
- #w[Llẹsyad’hór.] ‘She loves it.’

Word order is rather lax due to the presence of case marking, and any constituent can be fronted, usually to convey
focus,#footnote[For emphasis, the particle #w[dèl] is generally used instead.] though usually, the verb or the subject
is placed first.

- #w[B’hehýnác aúlýab’hat’hâ.] ‘With an axe, we have felled them.’
- #w[Iḷý dẹc’haúbhýrífá ḍẹv́ár.] ‘The place, you must have purified it.’

Note that words belonging to the same phrase are typically juxtaposed as adjectives are not inflected. However,
this rule may sometimes be broken, particularly in poetry. Consider, for example, the following passage in alexandrine
metre, written by the renowned poet #s[J.#thinsp();Y.#thinsp();B.#thinsp();Snet’h], where we can find the verb positioned between a possessive
pronoun and its associated noun:

- #w[Au lýr náý’acḍaúrâ sýec̣ asvaúr sýárb.] ‘And we shall indeed have revealed their sins to the world’#footnote[See
    the dictionary entry for #w[act’he], sense 4, for more information about the use of this word here,
    which normally means ‘cleave’. The literal meaning of this sentence is roughly: ‘And we shall have brought
    down the trees upon their sins, to (= for the benefit of) the world’.]

== Negated Clauses <sec:negated-clauses>
Negation in the indicative is expressed using the particle #w[asý’ýâ] ‘not’, which is typically appended to verbs
as #w[’sý’ýâ]—even if the verb ends with a consonant. For a discussion of negation in the subjunctive, optative,
and #s[aci]s/#s[pci]s see @subsec:subjunctive, @subsec:optative, @subsec:aci-pci.
By default, the particle is placed right after the verb, but if there is a fronted constituent, the particle is
sometimes placed after that constituent in independent clauses:

- #w[Aúlýab’hat’hâ’sý’ýâ b’hehýnác.] ‘We have not felled them with an axe.’
- #w[B’hehýnác asý’ýâ aúlýab’hat’hâ.] ‘It is not with an axe that we have felled them.’

UF makes frequent use of double negation in conjunction with words that create a negative context
such as #w[jávé] ‘never’, #w[y’ê] ‘nothing’, or #w[ráv́â] ‘seldom’. Typically, such words are frontend,
and consequently, the negation particle then appears appended to them, e.g. Note that double negation is
required in this case:

- #w[Ráv́â’sý’ýâ st’halẹ jac̣t'heá.] ‘Rarely have I ever bought a table.’
- #w[St’halẹ’sý’ýâ ráv́â jac̣t'heá.] ‘A table I have bought rarely.’
- #w[\#Ráv́â st’halẹ jac̣t'heá.] ‘(roughly) I rarely-bought a table.’

Learners often make the mistake of assuming that the negation particle is part of a word,
e.g. that #w[ráv́â’sý’ýâ] means ‘seldom’. As such, UF speakers, when imitating a foreigner, may
sometimes use more than one negation particle in a single sentence. Note that this is very
much not proper language; such constructions are summarily comedic and best compared to phrases
such as ‘it do be like that’ in English:

- #w[\*Ráv́â’sý’ýâ st’halẹ jac̣t'heá’sý’ýâ.] ‘(roughly) Rarely-not I bought a table.’

On its own, the negation particle can be used to mean ‘no’. Its literal meaning in this use is really ‘it is
not / I am not / etc.’, in all numbers and tenses. This word is generally used as a reply and is only
appropriate in contexts in which ‘it is not / I am not / etc.’ would also be a valid reply.

== Interrogative Clauses <sec:interrogative>
=== Yes-No Questions
In UF, questions are generally marked by one or more particles. Unlike in many other languages, the verb generally
does not move, except perhaps for emphasis. The most fundamental kind of question is a yes-no question, which is
marked by the interrogative particle #w[c’hes].

In yes-no questions, the particle typically occurs in second position in the sentence.#footnote[That is, after the
first _constituent_, not after the first word.] The main exception to this is with forms of #w[eḍ] ‘to be’,
which are typically immediately preceded by the question particle, the two forming a single word, placed at the very
end of the sentence:


- #w[St’halẹ #b[c’hes] jac̣t'heá ?] ‘Did I buy a table?’
- #w[Dwáḷýhes ilývy’ér ḍauḍéá #b[c’hes] ?] ‘Where did you get the light?’
- #w[Raúl baú #b[c’hes]se ?] ‘Is it a good language?’

==== Negation
Negation is placed in the usual position. A negated question is marked by the negation particle #w[sý’ýâ],
to which the expected answer is ‘yes’. Alternatively, the particle #w[(r)vá] can be used to indicate that
the speaker expects the answer to be ‘no’ or to indicate disbelief, surprise, or amazement. #w[(r)vá]
_replaces_ the question particle and unlike #w[c’hes] never merges with #w[eḍ] ‘to be’. It is also
possible to combine both particles.

- #w[St’halẹ c’hes jac̣t'heá’sý’ýâ ?] ‘Did I not buy a table?’
- #w[St’halẹvá jac̣t'heá ?] ‘I bought a table?’
- #w[St’halẹvá jac̣t'heá’sý’ýâ?] ‘I didn’t buy a table?’
- #w[Raúl baú c’hesse ?] ‘Is it a good language?’
- #w[Raúlvá baú se ?] ‘It is a good language?’

The precise meaning of these questions is as follows: In #w[St’halẹ c’hes jac̣t'heá?] (‘Did I buy a table?’),
the speaker is asking whether they themselves bought a table; a plausible situation would be that they
simply forgot whether they did. Its negation, #w[St’halẹ c’hes jac̣t'heá’sý’ýâ?] (‘Did I not buy a table?’),
could be used if the speaker is sure they bought a table sometime ago, but they can’t seem to find it and
are starting to doubt themselves (‘Did I not buy a table? I’m sure I did.’).

By contrast, the question #w[St’halẹvá jac̣t'heá?]) would be an assertion of disbelief; maybe the speaker
found a table in their loft, and they can’t seem to remember buying it, but the price tag is still there.
Finally, its negation #w[St’halẹvá jac̣t'heá’sý’ýâ?] would most likely be the speaker expressing their frustration
over the fact that they can’t seem to find their table and asserting that, in fact, they know for sure that
they did indeed buy a table (‘Did I not buy a table? I know I did!’).

==== Fronting the Verb
Fronting of the verb in the last two cases generally indicates confusion rather than amazement or anger and
is most commonly used in response to someone else’s statement so as to ask for clarification (‘What do you mean
“I bought a table”; what are you talking about?’). The same applies to the negated version of such a question.

- #w[Jac̣t'heává st’halẹ ‽] ‘I _bought_ a _table_?!’
- #w[Jac̣t'heá’sý’ýâvá st’halẹ ‽] ‘I _didn’t_ buy a _table_?!’

Note the order of particles:#footnote[See @sec:particles for more information on particle order.] negation
precedes the question particle. Placing them the other way around makes it sound like you’re trying to correct
yourself from #w[Jac̣t'hévá] to #w[Jac̣t'hé’sý’ýâ].

==== Simplified Questions
In simple yes-no questions where the addressee is obvious, person marking of adjective verbs as well as the copula
are often dropped; only the question particle is required. This is most common in speech and written dialog; it is
seldom found in prose.

- #w[Ýrŷ c’hes ?] ‘Are you happy?’
- #w[Sýr c’hes ?] ‘Are you sure?’
- #w[C’hes ?] ‘Is it?’ / ‘Really?’

Person marking is generally required if the addressee is not in the second person:

- #w[Sýr c’hes aúdẹvárc ?] ‘Are you sure that this will work?’
- #w[Ausýró c’hes aúdẹvárc ?] ‘Are _we_ sure that this will work?’

=== Wh-Questions
UF has two kinds of wh-questions which differ in whether the wh-word replaces the question particle or not. The following
wh-words do _not_ replace the question particle; in fact, they can also be used without the question particle in
which case they act more like relative pronouns.

- All variants of the locative pronoun #w[ḷýhes] ‘where, whither, whence, ...’
- #w[a] ‘who, what, whom, whose’.
- #w[c’haúy’ê] ‘how much, how many’.
- #w[c’há] ‘when’.
- #w[b’hehráy’ê] ‘by what means’.

Conversely, there are a few wh-words that act more like particles and replace #w[c’hes] in questions:

- #w[c’hèl] ‘which, which one’.
- #w[c’hrá] ‘why’.

==== #w[a c’hes] — ‘who, what, whom’ <subsubsec:aches-who-what>
The actual interrogative pronoun here is #w[a], which is actually the relative pronoun turned interrogative by the
the question particle #w[c’hes]. The two cannot be separated: the #w[a] must always precede the #w[c’hes]. It is
used to mean both ‘who’ (if #s[def]) and ‘what’ (if #s[indef]). While most wh-words are immutable, #w[a] can be
declined arbitrarily.

- #w[Sa c’hes ḍad’hór ?] ‘What do you love?’
- #w[Ia c’hes ḍad’hór ?] ‘Whom do you love?’
- #w[Asa c’hes sydír ?] ‘To whom is it said?’
- #w[Sý’ẹ a c’hesse ?] ‘What is that?’
- #w[Árb áa c’hesse ?] ‘Whose tree is it?’

This pronoun is used to mean both ‘who’ and ‘what’. It takes indefinite case when it refers to a thing and definite
case when it refers to a person.

- #w[Sa c’hes ḍad’hór ?] ‘What do you love?’
- #w[Ia c’hes ḍad’hór ?] ‘Whom do you love?’

If the subject of the question is a noun phrase that contains more than just the interrogative pronoun,
pronoun and question particle are added after the entire phrase, and the pronoun is not declined, e.g. In
informal speech, the #w[a] is sometimes even omitted entirely.

- #w[Ŷnalẹ a c’hes ḍad’hór ?] ‘What table do you love?’
- #w[Árb a c’hesse ?] ‘What tree is it?’

A common variant spelling in older literature is to write the pronoun and question particle as one
word, e.g. #w[sac’hes] instead of #w[sa c’hes] or to contract the ‘e’, e.g. #w[sac’h’s].

==== #w[c’haúy’ê] ‘how much, how many’
This particle first and foremost means ‘how much’ or ‘how many’. It also occurs frequently in set phrases such as
#w[c’haúy’ê sýná] ‘how long’ (lit. ‘how much time’).

- #w[C’haúy’ê sýná c’hes dauhybh seh dwá-ádrrá ?] ‘How long have you been living in this place?’
- #w[Aúłraúlaúrẹ c’haúy’ê sýná c’hes láhẹh ?] ‘How long will this go on?’

== Particles <sec:particles>
UF has a great number of words which syntactically fulfill the role of complementisers, subordinators, etc. and which
have certain characteristics in common. These words are jointly referred to as ‘particles’. Common to all particles is
that the position they occupy is generally that of the second _word_ in—or alternatively right after—the phrase
they modify. If multiple particles modify the same phrase, they are grouped together in that position.

- #w[Sa #b[c’hes] ḍad’hór?] ‘What do you love?’
- #w[Rívnél #b[ḍèl] rá leb’h.] ‘He was a big _scoundrel_.’
- #w[Rívnél rá #b[ḍèl] leb’h.] ‘He was a _big_ scoundrel.’
- #w[St’halẹ #b[vé] jad’hór.] ‘But I love a table.’
- #w[U #b[vé] st’halẹ u sárb jad’hór.] ‘But I love a table or a tree.’

When multiple particles occur in the same sentence, they must be ordered such that a particle that modifies a phrase
rather than the entire clause is placed next to the phrase it modifies, and only particles that modify the same or
a nested phrase may precede it. The following are all equivalent:

- #w[Jlí#b[’sý’ýâ] #b[vé] #b[dývrê] iliv́uhé.] ‘But at least I don’t read the book.’
- #w[Jlí#b[’sý’ýâ] #b[dývrê] #b[vé] iliv́uhé.]
- #w[Iliv́uhé #b[vé] #b[dývrê] jlí#b[’sý’ýâ].]
- \*#w[Jlí #b[vé]#b[’sý’ýâ] #b[dývrê] iliv́uhé.]
Here, the negation particle #w[’sý’ýâ] modifies the verb #w[jub’hrá], whereas #w[vé] ‘but’ modifies the entire sentence;
thus, the former must appear closer to the verb, and the only correct particle order is #w[’sý’ýâvé], with \*#w[vé’sý’ýâ]
being entirely ungrammatical.

Syntactically, most particles can be analysed as adjuncts since the omission of a particle still yields a grammatical
phrase or clause in nearly all cases. Unfortunately, modelling this using traditional syntactic means usually leads to
some rather horrendous outcomes. Note that in UF syntax, ‘PP’ stands for ‘particle phrase’ rather than ‘prepositional
phrase’, as there are no prepositions in UF.

#figure[
    #show regex(".\u{0304}") : it => [#Bar(it.text.slice(0, 1))]
    #tree[CP
        [C̄
            [C̄
                [C̄
                    [VP
                        [V̄
                            [V̄
                                [V\ #w[jlí]]
                            ]
                            [PP [#w[’sý’yâ] #tree-attr(triangle: true)]]
                        ]
                    ]
                    [C\ #w[c’hes]]
                ]
                [PP [#w[vé] #tree-attr(triangle: true)]]
            ]
            [PP [#w[dývrê] #tree-attr(triangle: true)]]
        ]
        [NP [#w[iliv́uhé] #tree-attr(triangle: true)]]
    ]
    A possible tree for #w[Jlí’sý’ýâ c’hes vé dývrê iliv́uhé ?] ‘But do I at least not read the book?’
]

Notably, the VP+NP do not form a constituent in UF. Analysing the #Bar[C] particles as part of e.g. the VP
doesn’t work since #Bar[C] particles can be reordered with respect to one another, but not with respect to any
#Bar[V] particles (of which there may be several, and those in turn _can_ again be
reordered with respect to each other).
As the verb is the only part of an UF sentence that is required for it
to be grammatical, it makes sense to model it as the complement of the CP, with the subject or object, if there
is one, placed in spec-CP.

The tree above also shows a crucial difference between question particles like #w[c’hes] and other kinds of particles:
there can only be one question particle per clause, which can be explained by modelling it as the head of the CP. Thus,
C is always empty in non-questions.

== ACI and PCI <subsec:aci-pci>
The term #s[aci] is Latin for _accūsātīvus cum īnfīnītīvō_ ‘accusative with infinitive’. As the name would suggest, this
grammatical construction consists of a dependent clause formed by an #s[acc] noun together with an infinitive; the
noun is the subject or object of the clause, and the infinitive the predicate. This construction is most well-known
from Classical languages such as Latin or Ancient Greek, but it is also found in various other languages, including
English and, of course, UF:
#gloss("
    Lácár sbhaú àfér láȷ́éd’há.
    lá\c̣ár s\bhaú à-fér l-áȷ́éd’h\á
    {nom}\Charles {acc.indef}\bridge {inf.pass}-build {3m}-order\{pres.ant}
    Charles ordered a bridge to be built.
")

In this sentence, the matrix clause is #w[Lácár láȷ́éd’há] ‘Charles ordered’, and the dependent clause is formed by
the #s[aci] #w[sbhaú àfér] ‘a bridge to be built’. Since ‘a bridge’ is the object in this case, the passive infinitive
is used. Observe how this sentence’s translation also uses an #s[aci] with a passive infinitive in both English (‘Charles
ordered a bridge to be built’) as well as Latin (_Carolus pontem fierī iussit_).

UF does not have a word for ‘that’ as in ‘I think that ...’ or ‘I know that ...’; instead, it uses
#s[aci]s in these cases. Just how multiple ‘that’ clauses can be chained in English, so can multiple #s[aci]s in UF.
#gloss("
    Icár sbhaú àfér dáȷ́édá jsav́á.
    i\c̣ár s\bhaú à-fér d-áȷ́éd-á j-sav́á
    {acc}\Charles {acc.indef}\bridge {inf.pass}-build {inf}-order-{pres.ant} {1sg}-know
    I know that Charles ordered a bridge to be built.
")

Whenever a word is marked as taking an #s[aci] in the dictionary, it may also take a #s[pci] instead if
that makes sense semantically; there are no words that syntactically may take an #s[aci], but not a #s[pci].
Finally, note that ‘that’ is not always expressed with an #s[aci] or #s[pci]. Certain verbs, e.g. verbs of fearing, may
take a dependent clause in the subjunctive or optative instead (see @subsec:subjunctive, @subsec:optative).

=== Nested ACIs
When multiple #s[aci]s are chained together, they are nested such that #s[acc] comes first and the infinitive
last or vice versa, and any nested #s[aci]s are placed inbetween; observe that, in the sentence above, the #s[aci]
#w[sbhaú àfér] ‘a bridge to be built’ is nested inside #w[Icár dáȷ́édá] ‘Charles to have ordered’. The literal
translation of this sentence would thus be ‘I know Charles to have ordered a bridge to be built’.

Furthermore, note that the finite verb of the matrix clause of an #s[aci] receives only a subject marker if the
#s[aci] is the object and vice versa. Thus, we have #w[jsav́á] ‘I know’ in the example above instead of e.g.
#w[jsysav́á] ‘I know it’. It _would_ be possible to add the object marker in the example above, but it would
sound a bit strange, roughly ‘I know it: that Charles ordered a bridge to be built’, and the verb would
probably have to be fronted for the sentence to make sense that way.

The exception, of course, is if the matrix clause is in the passive, in which case, as ever, the passive affix
is added regardless, seeing as the verb would not be finite otherwise, e.g. #w[sysav́á] ‘it is known that’.

=== PCIs
In addition to #s[aci]s, UF also has #s[pci]s, which use the #s[part] case instead. The #s[part] is used with verbs
that govern the #s[part] or in some cases to indicate that an action is incomplete (see @subsubsec:declension).
#gloss("
    Lácár dŷnbaú àfér láȷ́éd’há.
    lá\c̣ár dŷn-ḅaú à-fér l-áȷ́éd’h\á
    {nom}\Charles {part.indef}-bridge {inf.pass}-build {3m}-order\{pres.ant}
    ‘Charles ordered to start building a bridge.’
")

The translation of the sentence above isn’t the best, but we start to run into a problem here, since UF uses
#s[aci]s and #s[pci]s much more prolifically than English does. A somewhat literal translation of this sentence would be
something along the lines of ‘Charles ordered the building of a bridge to be started’, but it isn’t perfect
either since ‘building’ is a gerund but in the sentence above, it’s an infinitive. In modern English, there simply
is no good literal translation for this sentence that preserves the passive infinitive.

=== Resolving Ambiguity
When dealing with #s[aci]s and #s[pci]s that involve verbs that also take #s[acc] and #s[part] arguments, respectively, or
other infinitives which do, one must be careful not to construct garden-path sentences. For instance, take #w[*sḅáłýr*
sýc̣ahý dýbháhẹ dylí *dub’hrá*]. Here, the #s[pci] is marked in bold, and the intended meaning is ‘for speakers to be
able to read each other’s thoughts’. Unfortunately, however, ‘read’ also takes a #s[part] here, and thus, it is
possible to construct a different #s[pci], namely #w[*sḅáłýr* sýc̣ahý dýbháhẹ *dylí* dub’hrá] ‘for speakers
to read each other’s thoughts’, and #w[dub’hrá] ‘to be able to’ is awkwardly left hanging at the end of the sentence.

To fix this problem, rearrange the sentence so the infinitive of the #s[aci] or #s[pci] is placed first and put the verbs of any
enclosed verb phrases first in those phrases to indicate that any immediately following #s[acc] or #s[part] nouns are part
of that verb rather than of the #s[aci] or #s[pci]: #w[*dub’hrá* dylí sýc̣ahý dýbháhẹ *sḅáłýr*].
This rule is sometimes intentionally subverted in cases where the double meaning is desirable, or in poetry, where word order
is a lot looser, but it would be very awkward to do so in prose.

In speech, this problem is more readily solved via intonation by placing emphasis and separating the ‘contents’ of the
#s[aci] or #s[pci] from the infinitive and noun with short pauses, e.g. #w[*sḅáłýr* ‖ sýc̣ahý dýbháhẹ dylí ‖ *dub’hrá*].

=== Negation
Negation of #s[aci]s and #s[pci]s uses the same particle as negation in the optative, viz. #w[t’hé] (see
Section@subsubsec:negated-optative), attached to the verb of the #s[aci]. Note that the
matrix clause is negated normally. Where the meaning of the two is equivalent, negating
the #s[aci] is generally preferred.

- #w[Lácár sbhaú #b[t’h’]àfér láȷ́éd’há.] ‘Charles ordered that no bridge be built.’
- #w[Lácár sbhaú àfér láȷ́éd’há#b[’sý’ýâ].] ‘Charles did not order a bridge to be built.’

=== Pronominal ACIs and PCIs <subsubsec:pronominal-aci>
One of the most counterintuitive constructions in UF is the pronominal #s[aci], i.e an #s[aci] that is formed using
an infinitive and a pronoun. However, since separate pronouns do not exist in the #s[acc] or #s[part] case (see
@subsubsec:personal-pronouns), passive affixes are used instead, even if the form is intended to be active
in meaning. If the meaning of the sentence is intended to be passive, the passive infinitive is used instead. This is one of
the only cases where a verb can receive two affixes of the same voice.

- #w[Lác̣ár dẹ#b[lý]ḅarḍ láȷ́éd’há.] ‘Charles ordered them to leave.’
- #w[Lác̣ár #b[àsy]fér láȷ́éd’há.] ‘Charles ordered it to be built.’

Thus, the voice of a pronominal #s[aci] or #s[pci] depends on the voice of the infinitive affix, and not that of
the finite affix. Finally, a pronominal #s[pci] is formed as expected, i.e. with the pronominal partitive infix
#w[-dy-] (see @subsubsec:personal-pronouns).

- #w[Lác̣ár dẹlý#b[dy]ḅarḍ láȷ́éd’há.] ‘Charles ordered them to get going.’


== Conditionals <subsec:conditionals>
#let cond-examples(..els) = {
    show grid.cell.where(x: 0) : it => [*(#s[#it])*]
    show grid: set block(above: 1em, below: 1em)
    grid(
        columns: (auto, 1fr),
        column-gutter: .5em,
        row-gutter: .75em,
        ..els.pos()
    )
}

Traditional UF grammar divides conditionals into four categories: Simple (#s[s]), potential (#s[p]), counterfactual (#s[c]),
and irrealis (#s[i]). In the examples below, the letter in brackets indicates the type of conditional.

UF does not use any form of backshifting. Thus, a past tense is used in a conditional sentence if and
only if the action, from the speaker’s perspective, takes place in the past. Even counterfactual conditionals, if they
appertain to the present, still use present tense.

Still, there are restrictions on tense in that not all kinds of conditionals appertain to all tenses. For instance, it
is impossible to construct a potential conditional in the past; it would have to be a counterfactual conditional
instead.

=== Simple Conditionals
Simple conditionals indicate basic implications and logical truths. These conditionals use the indicative in both the protasis
and apodosis, in the appropriate tense. The protasis is generally introduced by the particle #w[s] ‘if’.

#cond-examples[s][
    #w[S r sré, aû-r sfe.] ‘If #w[r] is true, then not-#w[r] is false.’#footnote[UF does not
    use the letters #w[p] or #w[q], and thus, discussions of propositional logic in UF tend to
    use #w[r] and #w[t] instead. #w[s] is not used either so as to not confuse it with #w[s] ‘if’.]
]

A variant of the simple conditional is the so-called ‘gnomic conditional’, which uses a gnomic form in the apodosis; this form
expresses ‘if X, then Y must/should be too’. This is often found in formal specifications and legal documents.

- #w[S sfúr snaûb, ád’hý rêrá sejú.] ‘If a number is provided, it shall be greater than two.’

=== Potential Conditionals
Potential conditionals indicate that something is possible or could happen in the present or future (but _not_ in
the past), provided some condition is met, but which is not currently the case. These conditionals use the present
indicative (#s[p1]) or the present (spoken) or Future II (literary) optative in the future (#s[p2]) in the protasis, and
the Conditional I in the apodosis.

#cond-examples(
    [p1], [
        #w[S ḍẹsẹhúrvé, aúrrzaúsḍressa júrdy’í.] \
        ‘If you were to help me, it could be finished today.’
    ],

    [p2], [
        #w[S vê ḍẹy’ẹhẹhúrvé, aúrrzaúsḍressa aḍrdvê.] \
        ‘If you were to help me tomorrow, it could be finished the day after tomorrow.’
    ],
)

This sentence indicates that the speaker believes that, if the addressee helps them, there is a _possibility_ that they
could finish the task. If, by contrast, the speaker is certain that they will get the task done, a simple conditional is used
instead:

#cond-examples[s][
    #w[S ḍẹsẹhúrvé, aúrrzaúsḍre júrdy’í.] \
    ‘If you help me, it will (with certainty) be finished today.’
]

=== Counterfactual Conditionals
Counterfactual conditionals are conditionals whose protasis is false. These conditionals exist only in the present
and past and use the subjunctive in the present or any past tense in the protasis, and the Conditional II in the apodosis:

#cond-examples(
    [c], [
        #w[S ḍẹsẹhúsvé, aúrrzaúsḍressá.] \
        ‘If you were helping me, it would be finished.’
    ],

    [c], [
        #w[S ḍẹsẹhúhávé, aúrrzaúsḍressá y’ér.] \
        ‘If you had helped me, it would have been finished yesterday.’
    ],
)

=== Irrealis Conditionals
Irrealis conditionals are conditionals that describe a situation that could never be true. They are distinct from
potential conditionals in that they cannot possibly happen, and from counterfactuals in that the apodosis is not ‘false’,
either because it is not a statement, but rather a wish etc. (#s[i1]), or because it hasn’t happened yet (#s[i2]). This also
means that irrealis conditionals are constrained to the present and future tense and are chiefly used to describe something that
the speaker knows won’t happen. In a sense, they are often the opposite of potential conditionals. They use the
optative in the protasis and the subjunctive in the apodosis.

#cond-examples(
    [i1], [
        #w[S ḍẹy’ẹhẹhúrvé, srzaúst’há y’ér !] \
        ‘If only you were helping me—it would have been finished yesterday!’
    ],

    [i2], [
        #w[S vê b’háy’ẹhẹhúrrevé, aúr-rzaúsẹre-śe aḅrdvê.] \
        ‘(roughly) If you had been able to help me tomorrow, it would have been finished the day after.’
    ]
)

The second example in particular is hard to translate since it communicates an irrealis in the future, at the same time
using a morphological future in both the apodosis and the protasis. The tenses used in the translation here thus do not
reflect the tense actually used in UF.

#chapter([Northern Dialect], "nd")
What we have discussed so far is the standard dialect (SD) of UF. The main other established dialect or language
variant of UF is the so-called Northern Dialect (ND), or #w[Raúl Áheb’hèc’h],
#s[nd] #w[Raúl á-S’heuè].

== Phonology and Orthography
The divergence of this variety began in Late Middle UF; however, it should also be noted
that the SD is fairly conservative: not many sound changes happened in the around 400 years between the Early
Modern and Modern period, whereas the ND continued to evolve. As such, ND forms often seem more like descendants of
their SD counterparts rather than of Middle UF, though of course, there are exceptions.

=== Phonemic Changes
These changes can be conceived of as taking place after Early Modern UF, even though that may not be fully diachronically
correct for some of them, but experts are still unsure about that. Note that changes of the form ‘X > ː’ indicate
compensatory lengthening.
#[
#let sound-changes = (
    ([], (
        [ð > ð̞ [ð̺˕]],
        [z, ʑ > s, ʃ / \#\_, C[-voice]\_, \_C[-voice]],
        [ɕ, ȷ̊ > ʃ],
        [x > ʃ / V[+front]\_, \_V[+front]],
        [ɮ̃ > ɬ̃ > ʃ  / \_V],
        [ɰ > ː / V\_],
        [ɰ̃ > ɰ],
        [ʀ > x],
        [ɸ, β > u / V\_],
    )),
    ([], (
        [ḅ > b / V\_],
        [b > β],
        [y, ỹ, ỹ̃ > ʉ, ʉ̃, ʉ̃̃],
        [e, ɛ > i̯ / V\_],
        [o > u / a\_, ã\_, ã̃\_],
        [o > ɔ],
        [C[+fricative] > ː / V\_\#],
        [h > $emptyset$ / V\_V],
    ))
)
#smallskip
#format-sound-changes(sound-changes, break-at: (1,))
]

=== Phonetic Changes and Earlier Developments
These changes are either phonetic or allophonic differences, as well as earlier changes that took place in the Late
Middle UF period.

- Voiceless vowels are simply oral instead, and /ə̥/ does not exist, with it dropped entirely in some words
  and retaining its original Middle UF quality in others.
- #w[t’h] /θ/ is really [θ͡ɸ] instead of standard [θ].
- #w[sw] lenites to #w[hw] /ʍ/ instead of #w[ź].
- /t/ > /d/ never happened; thus, #w[ḍ] is still spelt and pronounced /t/ ⟨t⟩.

=== Spelling
The ND uses the grave to differentiate between #w[au] /ɔ/ and #w[aù] /au̯/. When nasalised, this becomes #w[aú] /ɔ/
vs #w[àú] /aũ̯/, #w[áu] /ãu̯/, #w[áú] /ãũ̯/. Do not confuse this with the use of the grave to mark contractions in poetry.
A contraction of two /u/s does not occur anywhere in the ND.

The northern /ʃ/ is diachronically derived from /ɕ, ʑ, ȷ̊, ɮ̃/ ⟨c, j, c̣, l⟩ as well as in some cases ⟨c’h⟩ /x/, which,
even in the standard dialect, is already [ɕ] around front vowels. All of these are spelt #w[s’h], but any instances of
it that were historically /ȷ̊/ ⟨c̣⟩ or /ɮ̃/ ⟨l⟩ do not lenite and are thus written #w[ṣ’h] in this grammar. Otherwise,
#w[s’h] lenites to #w[h] as one would expect. By contrast, /x/ derived diachronically from /ʀ/ _does_ lenite exactly
like regular /x/, and thus, both are written ⟨c’h⟩.

On the subject of vowels, instead of having both #w[o] and #w[au] for /ɔ/, the ND only retains the more sensible spelling,
that being #w[au]. The letter #w[o] is not used at all. Furthermore, the loss of word-final fricatives and coda /ɰ/ gives
rise to phonemic vowel length. This is marked with a macron in spelling, e.g. #w[ab’hèc’h] > #w[aùḕ] /au̯ˈɛː/, though #w[x̄́]
is written #w[x̌] instead, e.g. #w[aḅraúc̣] > #w[ab’hraǔ] /aˈβɰɔ̃ː/. A notable exception to this process is #w[S’heuè], which
lost its final #w[c’h] before this change occurred.

#[
#show : italic-table-body.with(cols: (2,))
#center-table(
    caption: [Examples of Northern Dialect words.],
    align: left,
    hlineat(1),
    ..vlinesat(1, 2),
    table.header[Standard & Northern & Pronunciation],
    [jad’hór         & s’had’haǔ      & /ʃaˈð̞ɔ̃ː/       ],
    [Raúl Áheb’hèc’h & Raúl á-S’heuè  & /ˌɰɔ̃ɮ̃ ɑ̃ˈheu̯.ɛ/ ],
    [c’hes           & s’hē           & /ʃeː/          ],
    [nárrahóḍ        & nác’hàút       & /nɑ̃xaũ̯t/       ],
    [láel            & ṣ’háil         & /ʃɑ̃i̯ɮ̃/         ],
    [ḍalẹ            & taṣ’hau        & /taʃɔ/         ],
)
]

== Nouns <sec:nd-nouns>
There are some differences in how noun declensions work in the ND. Most of the prefixes are the same, but unlike in the SD,
they _do_ undergo coalescence, and some of them appear in a contracted form.

When proper nouns are declined, there are two things to note. First, the SD capitalises the prefix, whereas the ND maintains capitalisation
of the first letter of the noun proper and attaches prefixes with a hyphen, e.g. #w[C’heb’hèc’h] which in the ND is #w[S’heuè]
becomes #s[all] #s[sd] #w[Ádác’heb’hèc’h] but #s[nd] #w[â-S’heuè] /ɑ̃̃ˈʃeu̯.ɛ/. Secondly, lenition of proper nouns is not
written at all, even though it is still pronounced, e.g. the #s[gen] of #w[S’heuè] is written #w[á-S’heuè] even though it is
still pronounced /ɑ̃ˈheu̯.ɛ/.

The following northern case prefixes undergo irregular changes in addition to the regular sound changes above. Note that the
latter still apply to these prefixes, e.g. the #s[nom] affix #w[lá-#L] is #w[ṣ’há-#L] instead. Entries marked with _/_
are _not_ irregular.
#[
#show : italic-table-body.with(cols: (0, 4))
#center-table(
    caption: [Northern Dialect Declension],
    align: left,
    ..vlinesat(1, 2, 5, 6),
    hlineat(1, end: 3),
    hlineat(1, start: 4),
    table.header[Definite    &Sg&Pl && Indefinite       &Sg&Pl],
    [Allative         & â-            & ê-       && Allative  & aŷn-       & aŷ-  ],
    [Ablative         & /             & /        && Ablative  & rêýn-      & rêý-  ],
)
]


Lastly, noun prefixes coalesce with any initial stem vowels of the same quality. Earlier varieties of the ND used the
same vowel contraction rules described in @subsec:other-punct everywhere, but in modern times, there are a few
differences:

- Such contractions are restricted to declensions only, e.g. #s[sd] #w[lá-áb’há] > #s[nd] #w[ṣ’hâuá].
- Two nasalised vowels are contracted to a nasal vowel, i.e. #w[ṣ’hâuá], not \*#w[ṣ’hàuá].#footnote[Even in
        poetry, the latter would be unusual in the ND.]
- The double grave variant, i.e. #w[ṣ’hȁuá], is archaic nowadays, with the circumflex used instead.

#chapter([Examples], "examples")

== Fully-Glossed Examples

=== Simple Glossing Example
#gloss("
    Cárvá, sráhó dwávaût’há dact’heá ?
    C̣ár vá s-ráhó dwá-vaût’há ḍ-ac̣t’he-á
    Charles.{voc} {particle} {indef.acc}-fish {def.iness}-mountain {2sg}-buy-{pres.ant.2sg}
    Charles, you bought a fish on the mountain?
")

=== CCC 2 Text
_Słérá de c’hóný áb’hásy’ô, ráy’ê y’aúhý dís dyb’hóy’e sab’héy’. Ez lé-el lalebet’he z’ihór bet’hê rêsol daudé.
Ýab’héy’ rêd’hes lab’hóy’ejú, dŷna c’haúr debauhib sá lasusy’és ýrâhe lasyrrájú._

#multigloss("
    słé-rá ḍẹ c’hóný á\b’hásy’ô ráy’ê y’aúhý ḍ-ís dy-b’hóy’ẹ
    {cons.pl}-law all well.known {gen}\aviation way there.is.no {inf-subj}.can {part}-to.fly

    s-ab’héy’ ez lé-el la-lẹ-bet’hẹ z’ i\hór bet’h\ê
    {acc.indef}-bee its {nom.pl}-wing {3pl-aff.comp}-be.small its {acc}\body be.small\{part}

    rê-sol ḍ-auḍé ý-ab’héy’ rêd’hes la-b’hóy’ẹ-jú dŷn-a c’haúr
    {abl}-soil {inf}-obtain {nom.pl.indef}-bee of.course {3n.pl}-fly-{gn} {part}-what as

    dẹ-ḅauhib sá la-susy’é\s ý-râhẹ la-sy-rrá-jú
    {inf}-be.impossible not {3n.pl}-care.about\{subj} {nom.pl.indef}-human {3n.pl}-{3n.pass}-believe-{gn}
")

#block[
‘According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too
small to get its fat little body off the ground. The bee, of course, flies anyway because bees don't care
what humans think is impossible.’
]

#smallskip

Literal translation: ‘According to all known laws of aviation, there is no way that a bee should be capable of flight.#footnote[
Note that UF here uses the verbal noun #w[b’hóy’ẹ] ‘to fly’ as a noun to mean ‘flight’.]
Its wings are too small for its little body to obtain [distance] from the ground. Of course, bees fly [anyway], as
they do not care about what humans believe to be impossible.

=== Copypasta Translation
_Rub’hráy’ó rát’he au sré au sfèhe laut’hâ adŷbáłýr Át’hebhaú Raúl dedesle, s aút’hiy’ey’ó sývéhýr dýhisdé sérdé laúây’êr ;
aúc’haúbrâdy’ó’sý’ýâ vé dúr dyhaúbhausy’ô sehabhvísy’ô. Sýlývy’ér saúr c’hesse ? Lec’hdr\-aúv\-nét’hic’hâ nérje c’hesse ?
Árdihyl c’hesse ? Sauz-aud de c’hesse ? Jávé’sý’ýâ jrét’hádé dedónéle dýha\-bha\-hit’he deý’ebhat’hic’hâ Áraúl dybháł.
Aúrsáheressá. Jdír jys dub’hrá au dylí sýcahý dýbháhe au dylýáv́áy’é b’hýcahý sbáłýr Áraúl._

_Lásásc’hríd raúl révéy’ýr c’hessejú ? Léraúb’he lasydír, lavâhe vé sbhárde sásy’élâ Áraúl. Sráhis’sý’ýâ id’hír deb’hýlnér
u b’hesaúr rêvú aû-át’heý’ebhat’he u B’helfaúr sraúb’he. Jav́ár sáví lyzy’ýr ádróid. Sy’u\-b’h\-rá dahaúr isásc’hríd
dwáníb’he araúl sébâ âc’hrír ‘dèc’hníc’hvâ’ Át’hebhaú Raúl ‘desybhérýr’, sjys vé delýc’hóbhár, lásásc’hríd c’haúr sýraúl
âc’hrír sc’hóváhá, lévás nórâ jys ‘desybáł’ dyhéy’é la\-y’e\-hó\-vâ\-hér. Aúc’hóhid’héy’ó laúrvé Áraúl dynát’hýr rêâ, srâsírá,
dwác’hóvníc’h âbáł dývrê b’hehbár\-di\-hi\-bhá aû-á\-dr\-ó\-id, It’hebhaú Raúl abhraúl dérésdâ derâdvâvéy’ýr._

==== Gloss
#multigloss("
    r-ub’hrá-y’ó rát’hẹ au s-ré au s-fèhẹ laut’h-â
    {1pl}-can-{1pl} you.see and {acc.pl.indef}-ray {and} {acc.pl.indef}-beam float-{ptcp}

    aḍŷ-ḅáłýr á-t’hebhaú~raúl dẹ-deslẹ s aú-t’hiy’e-y’ó sý-véhýr
    {interess.pl.indef}-speaker {gen}-Ultrafrench.language {inf}-detect if {1pl}-use-{1pl} {gen.pl.indef}-measure

    dý\hisḍé sérḍé laú â-y’\ệr aú-c’haúḅrâd-y’ó
    {part.pl.indef}\system certain long {ptcp.pass}-forbid\{ptcp.pres.ant} {1pl}-understand-{1pl}

    ’sý’ýâ vé ḍúr dy\haúbhausy’ô sẹh abh-vísy’ô sý-lývy’ér saúr c’hes
    not but still {part}\composition this {gen.pl}-emission {gen.indef}-light {abs}.kind {q}

    se lec’hḍraúvnẹ́t’hic’h-â nérjẹ c’hes se árḍihyl c’hes se sauz
    {3n}.be electromagnetic-{ptcp} {energy}.{abs} {q} {3n}.be particle.{abs} {q} {3n}.be {abs}.thing

    aud ḍẹ c’hes se jávé ’sý’ýâ j-rét’hád-é dẹ-dónẹ́-ḷẹ
    other entire {q} {3n}.be never not {1sg}-claim-{pres.ant} {inf}-endow-{3.dat}

    dý\habhahit’hẹ ḍeý’ebhat’hic’h-â á-raúl dy\bháł
    {part.pl.indef}\ability be.telepathic-{ptcp} {gen}-language {part}\speak

    aúr-sáhere-ss\a j-dír jys d-ub’hrá au dy-lí
    {3n.fut.ii}-be.preposterous.{fut}-{cond}\{circ} {1sg}-say only {inf}-can and {part}-read

    sý\c̣ahý dý\bháhẹ au dy-lý-áv́áy’é
    {gen.pl.indef}-each.other {part.pl.indef}-thought and {part}-{3pl.pass}-send

    b’hý\c̣ahý s-ḅáłýr á-raúl
    {dat.pl.indef}-each.other {acc.pl.indef}-speaker {gen}-language

    lá-sásc’hríḍ~raúl ré-véy’ýr c’hes se-jú
    {nom}-Sanskrit {abs}.language {sup}-better {q} {3n}.be-{gn}

    lé-raúb’hẹ la-sy-dír la-vâhẹ vé s\bhárḍẹ sásy’él-â á-raúl
    {nom.pl}-robot {3pl}-{3n.pass}-say {3pl}-miss.out but {acc.indef}\part be.essential-{ptcp} {gen}-language

    s-ráhis ’sý’ýâ i\d’hír dẹ-b’hýlnẹ́r u b’hel-saúr rê-vú aû- á\t’heý’ebhat’hẹ
    {3n}-be.racist not {acc}\say {inf}-be.unaffected or {instr.pl}-form {sup}-many non- {gen}-telepathy

    u b’he-faúr s-raúb’he j-av́ár s-áví lyzy’ýr ádróid
    or {instr}-Force {acc.pl.indef}-robot {1sg}-have {acc.pl.indef}-friend several {abs}.android

    s-y’-ub’hrá dahaúr i-sásc’hríd dwá-níb’hẹ a-raúl séḅ-â â-c’hrír
    {3n-opt}-can sure {acc}-Sanskrit {iness}-level {gen}-language be.plain-{ptcp} {ptcp.pass}.write

    ḍèc’hníc’hvâ á-t’hebhaú~raúl dẹ-sybhẹ́rýr s-jys vé dẹ-lý-c’hóbhár
    technically {gen}-Ultrafrench.language {inf}-be.superior {3n}-be.unfair but {inf}-{3pl.pass}-compare

    lá-sásc’hríd c’haúr sý-raúl â-c’hrír s-c’hóváh\á
    {nom}-Sanskrit as {gen.indef}-language {ptcp.pass}-write {3n}-start.out.as.{subj}\{pres.ant}

    lé-vás nór-â jys dẹ-sy-ḅáł dy\héy’ẹ́ la-y’ẹ\hóvâh\ér
    {nom.pl}-masses be.ignorant-{ptcp} until {inf}-{3n.pass}-speak {part}\attempt {3pl}-{opt}\start\{pres.ant}

    aú-c’hóhid’hẹ́-y’ó laúrvé á-raúl dy-nát’hýr rê-â
    {1pl}-consider-{1pl} but.when {gen}-language {part}-nature be.triune-{ptcp}

    s-râsír-á dwá-c’hóvníc’h â-ḅáł dývrê b’heh-ḅárḍihibhá aû- ádróid
    {3n}-transpire-{pres.ant} {iness}-communication {ptcp.pass}-speak at least {instr.pl.indef}-participant non {abs}.android

    i-t’hebhaú~raúl abh-raúl ḍérésḍ-â dẹ-râdvâ-véy’ýr
    {acc}-Ultrafrench.language {gen.pl}-language be.terrestrial-{ptcp} {inf}-{superl}-be.better
")

==== Translation
‘You see, we can detect rays and beams of energy floating between ULTRAFRENCH speakers if we use certain long-forbidden
measurement systems, but we still don’t understand the composition of these emissions. Are they some kind of light?
Electromagnetic energy? A particle? Something else entirely?

‘I’ve never claimed that speaking ULTRAFRENCH endows you with telepathic abilities. That would be preposterous. I’m just
saying that ULTRAFRENCH speakers can read each others minds and send thoughts to each other.

‘Is Sanskrit the best language? The robots tell me so.  But they are missing out on an essential part of ULTRAFRENCH.
It’s not racist to say robots are immune to most forms of not-telepathy and the Force. I have several android friends

‘Sanskrit might be “technically” “superior” to ULTRAFRENCH on the level of the plain written language. Sure, but it’s
unfair to compare them because Sanskrit started out as a written language until the ignorant masses started attempting
to “speak” it.

‘But when you consider the triune nature of ULTRAFRENCH, I think it’s clear that, at least in spoken communication with
non-android participants, ULTRAFRENCH is the best earth-based language.’

==== Literal Translation
We can, you see, detect both rays and beams of energy floating between speakers of The UF Language
if we use certain systems of measurement long-forbidden; we still don’t understand, however, the composition of these
emissions. Is it some kind of light? Is it electromagnetic energy? Is it a particle? Is it something else entirely?
I’ve never claimed that [the mere act of]#footnote[The speaker uses a #s[pci] (#w[dybháł]) instead of an #s[aci]
(#w[ibháł]) for ‘speaking’ here; had they used an #s[aci], the meaning would be closer to ‘the act
of “fully speaking” the language’, as in, speaking and understanding it in its entirety. Thus, the speaker implicates that
it is not the mere act of making utterances in UF (#w[Áraúl dybháł]), but rather speaking and comprehending it in its
entirety (#w[Áraúl ibháł]) that gives rise to telepathic abilities.] the speaking of The Language endows them with
telepathic abilities.
It would be preposterous. I’m only saying that speakers of The Language can both read each other’s thoughts#footnote[In UF, ‘to
read someone’s mind’ is expressed as ‘to read someone’s thoughts’.] and send them to each other.

Is Sanskrit the best language? The robots are saying it, but they miss out on an essential part of The Language. The act
of saying that robots are incapable of being affected by most forms of non-telepathy or#footnote[The UF text uses #w[u] ... #w[u]
... ‘... or ... (inclusive)’. This is for semantic reasons: the original text had a positive context (‘immune to’), whereas
the UF translation uses a negative context (‘incapable of being affected by’); thus, by De Morgan, we have to switch from ‘and’
to ‘or’ here.] by the Force is not racist. I have several android friends. Sure, Sanskrit might,#footnote[‘might be X’ is
generally expressed using the optative of #w[ub’hrá] + an #s[aci] with ‘to be X’.] on the level of the plain written
language, be ‘technically’ ‘superior’ to The UF Language, but it is unfair to compare them, as Sanskrit started out as
a written language, until the ignorant masses started attempting to ‘speak’ it. But when we consider the triune nature
of The Language, it has transpired that,#footnote[‘To become clear’ is expressed with the #s[pres ant] form of ‘transpire’.]
at least in spoken communication with non-android participants, UF is the best of the terrestrial languages.

=== Two Stanzas from ‘The Rime of the Ancient Mariner’
#align(center, grid(
    columns:2,
    column-gutter: 2em,
    verse[
        All in a hot and copper sky, \
        #quad The bloody Sun, at noon, \
        Right up above the mast did stand, \
        #quad No bigger than the Moon.

        Day after day, day after day, \
        #quad We stuck, ne breath ne motion; \
        As idle as a painted ship \
        #quad Upon a painted ocean.
    ],

    verse[
        _Dáhŷná’ câ, bárýnrê de, \
        Láhaul dwávíd’h’, áhâłát’hâ, \
        Sýrvá sb’haulá dèl sý’dwálý, \
        #quad Aûlerá áraúvá._

        _Órdy’úr ád’y’úr, órdy’í ád’y’í, \
        Aúrdévýry’aû, sáhýnvúb’hvâ, \
        Bárýnc’hánár âbét’hýrér, \
        #quad Dáhŷnvérr dehýnrál._
    ]
))

#medskip

#align(center)[
    — #s[Sávy’él D. C’haulełij], _rád’hyc’hsy’ô_ #s[Áhnet’h]
]

#medskip

#multigloss("
    dáhŷn\á(ẹ) câ ḅárýn-rê ḍẹ
    {iness.indef}\sky be.hot\{ptcp} {ess.indef}-copper all

    lá\haul dwá-víd’h(ẹ) áhâłát’h\â
    {nom}-sun {iness}-noon be.bloody-{ptcp}

    sýr-vá s-b’haul-á dèl sý’-dwá-ḷý
    {spress}-mast {3n}-hover-{pres.ant} [particle] [distal]-{iness}-[sp.~correl.]

    aû-lẹ-rá áraúvá
    not-{aff.comp}-big {gen}-moon

    órd-y’úr ád(á)-y’úr órd-y’í ád(á)-y’í
    {ela}-day {ill}-day {ela}-night {ill}-night %Definite to fit the metre.

    aúr-dévýr-y’aû sáhýn-vúb’hvâ
    {1pl}-remain-{pret.1pl} {abess}-movement

    ḅárýn-c’hánár â-ḅét’hýr-ér
    {ess.indef}-ship {ptcp.pass}-paint-{ptcp.pres.ant}

    dáhŷn-vérr dẹhýn-rál
    {iness.indef}-sea {spress.indef}-canvas
")

// Temporary chapter and sections because the document doesn’t compile if there
// are missing references; remove these once we convert the sections that contain
// these labels.
#chapter("TEMP", "temp")
== TEMP <subsec:verbal-morphology>


// ============================================================================
//  Backmatter
// ============================================================================
#show : backmatter