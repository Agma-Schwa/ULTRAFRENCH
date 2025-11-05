#import "BASE/src/lib.typ" : *

// ============================================================================
//  Preamble
// ============================================================================
#show : setup
#let w(it) = emph(it)
#let L = super[L]
#let N = super[N]
#let pf(it) = [#s[pf] #w(it)]
#set list(spacing: 1em)

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
    show : italic-table-body.with(header: (0, 4))
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
#show : italic-table-body.with(header: (0, 4))
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



// Temporary chapter and sections because the document doesn’t compile if there
// are missing references; remove these once we convert the sections that contain
// these labels.
#chapter("TEMP", "temp")
== TEMP <subsec:aci-pci>
== TEMP <sec:nd-nouns>
== TEMP <subsubsec:dative-affixes>

// ============================================================================
//  Backmatter
// ============================================================================
#show : backmatter