#import "BASE/src/lib.typ" : *

// ============================================================================
//  Preamble
// ============================================================================
#show : setup
#let w(it) = emph(it)
#let L = super[L]
#let N = super[N]

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
        [V\scalpha > $emptyset$ / \_\#V\scalpha],
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

#columns(2, {
    let num = 1
    for (title, changes) in sound-changes {
        partitle(title)
        enum(start: num, ..changes)
        num += changes.len()
    }
})
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

// Temporary chapter and sections because the document doesn’t compile if there
// are missing references; remove these once we convert the sections that contain
// these labels.
#chapter("TEMP", "temp")
== TEMP <subsec:aci-pci>
== TEMP <subsec:ornative>

// ============================================================================
//  Backmatter
// ============================================================================
#show : backmatter