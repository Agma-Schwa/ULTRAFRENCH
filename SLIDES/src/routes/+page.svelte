<script lang='ts'>
    import Page from './Page.svelte';
    import Text from './Text.svelte';
    import CentrePage from './CentrePage.svelte';
    import '$lib/style.scss';
    import Table from './Table.svelte';
    import SeqTablePages from './SeqTablePages.svelte';
    import BasicTable from './BasicTable.svelte';
    import SeqListPages from './SeqListPages.svelte';
    import {AlignmentSpec} from '$lib/text';
    import CopyPasta from './CopyPasta.svelte';
</script>

<style lang='scss'>
</style>

<!-----------------------------------------------------------------------------
  PRELUDE
------------------------------------------------------------------------------>
<CentrePage>
    <div class='noprint'>(This page is intentionally left blank)</div>
</CentrePage>

<CentrePage>
    <Text v='$7$ij’adore'/>
    <Text v='$4/ʒa.dɔʁ/' classes='closer'/>
    <Text v='$3‘I adore’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$ijad’hór'/>
    <Text v='$4[ʑa̯ˈðɔ̃ˑɰ]' classes='closer'/>
    <Text v='$4‘I love’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$iDominique'/>
    <Text v='$4/dɔ.mi.nik/' classes='closer'/>
    <Text v='$3‘Dominic’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$iDaúvníc’h'/>
    <Text v="$4['dɔ̃ˑʋ̃.nĩɕ]" classes='closer'/>
    <Text v='$4‘Dominic’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$ien faire tout un fromage'/>
    <Text v='$3‘To make everything into cheese’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$iférḍufraú'/>
    <Text v='$4[ɸɜ̃ɰ.du̯ˈɸɰɔ̃ˑ]' classes='closer'/>
    <Text v='$4‘To make a big fuss about something’'/>
</CentrePage>

<CentrePage>
    <Text v='$9$iT’heb’haú Raúl'/>
    <Text v="$5[θeˌβɔ̃ˑ'ɰɔ̃ˑɮ̃]"/>
</CentrePage>

<CentrePage classes='no-box-shadow'>
    <Text v='$2ULTRAFRENCH'/>
</CentrePage>

<!-----------------------------------------------------------------------------
  Consonants
------------------------------------------------------------------------------>
<CentrePage title='Consonants'>
    <Table
            bgcolour='var(--frenchred-dark)'
            colnames={['Labial', 'Coronal', 'Palatal', 'Velar', 'Glottal']}
            rownames={['Stop', 'Nasal', 'Fricative', 'Trill', 'Approximant', 'Lateral Fricative']}
            data={[
                ['b, bʱ', 'd'],
                ['', 'n'],
                ['ɸ β, ʋ̃', 's z, θ ð', 'ç ɕ ʑ', 'x', 'h'],
                ['', '', '', 'ʀ'],
                ['', '', 'ɥ ɥ̃, ȷ̊', 'ɰ ɰ̃'],
                ['', 'ɮ̃', 'ʎ̝̃']
            ]}
    />
</CentrePage>

<CentrePage title='Consonants'>
    <Table
            bgcolour='var(--frenchred-dark)'
            colnames={['Labial', 'Coronal', 'Palatal', 'Velar', 'Glottal']}
            rownames={['Stop', 'Nasal', 'Fricative', 'Fric. (ʁ-coloured)', 'Trill', 'Approximant', 'Lateral Fricative']}
            data={[
                ['b, bʱ', 'd'],
                ['', 'n'],
                ['ɸ β, ʋ̃', 's z, θ ð', 'ç ɕ ʑ', 'x', 'h'],
                ['βʶ', 'sʶ zʶ ɮ̃ʶ', 'ɕʶ ʑʶ'],
                ['', '', '', 'ʀ'],
                ['', '', 'ɥ ɥ̃, ȷ̊', 'ɰ ɰ̃'],
                ['', 'ɮ̃', 'ʎ̝̃']
            ]}
    />
</CentrePage>

<SeqTablePages
        classes='table-row2-italic'
        title='Consonants — Orthography'
        bgcolour='var(--frenchred-dark)'
        colnames={['Phoneme(s)', 'Spelling']}
        data={[
        ['b, d, n, s, z, h', 'b, d, n, s, z, h'],
        ['\0x, θ, ð, β', 'c’h, t’h, d’h, b’h'],
        ['\0ɮ̃, ʎ̝̃', 'l, l'],
        ['\0ɰ, ɰ̃, ʀ', 'r, w, rr'],
        ['\0ɥ, ɥ̃', 'y’, ý’'],
        ['\0ɸ, ʋ̃, ɕ, ʑ, ȷ̊', 'f, v, c, j, c'],
        ['\0βʶ, ɮ̃ʶ, sʶ, ɕʶ, ʑʶ, zʶ', 'v́, ł, ś, ć, ȷ́ , ź'],
    ]}
/>

<!-----------------------------------------------------------------------------
  Vowels
------------------------------------------------------------------------------>
<CentrePage title='Vowels'>
    <Table
            bgcolour='var(--frenchblue-dark)'
            colnames={['Front', 'Central', 'Back']}
            rownames={['Close', 'Near-close', 'Close-mid', 'Mid', 'Open-mid', 'Near-open', 'Open']}
            data={[
                ['i ĩ', 'y', 'u ũ'],
                ['ʏ̃'],
                ['e ẽ', '', 'o'],
                ['', 'ə'],
                ['ɛ ɛ̃', '', 'ɔ̃'],
                ['', 'ɐ'],
                ['', '', 'ɑ̃']
            ]}
    />
</CentrePage>

<CentrePage title='Vowels'>
    <Table
            bgcolour='var(--frenchblue-dark)'
            colnames={['Front', 'Central', 'Back']}
            rownames={['Close', 'Near-close', 'Close-mid', 'Mid', 'Open-mid', 'Near-open', 'Open']}
            data={[
                ['i ĩ ĩ̃', 'y', 'u ũ ũ̃'],
                ['ʏ̃ ʏ̃̃'],
                ['e ẽ ẽ̃', '', 'o'],
                ['', 'ə'],
                ['ɛ ɛ̃ ɛ̃̃', '', 'ɔ̃ ɔ̃̃'],
                ['', 'ɐ'],
                ['', '', 'ɑ̃ ɑ̃̃']
            ]}
    />
</CentrePage>

<CentrePage title='Vowels'>
    <Table
            bgcolour='var(--frenchblue-dark)'
            colnames={['Front', 'Central', 'Back']}
            rownames={['Close', 'Near-close', 'Close-mid', 'Mid', 'Open-mid', 'Near-open', 'Open']}
            data={[
                ['i ĩ ı̃̃ i̥ y ẙ', '', 'u ũ ũ̃ u̥'],
                ['ʏ̃ ʏ̃̃'],
                ['e ẽ ẽ̃ e̥', '', 'o o̥'],
                ['', 'ə ə̥'],
                ['ɛ ɛ̃ ɛ̃̃ ɛ̥', '', 'ɔ̃ ɔ̃̃'],
                ['', 'ɐ ɐ̥'],
                ['', '', 'ɑ̃ ɑ̃̃']
            ]}
    />
</CentrePage>

<!--
Note: There are no centred voiceless vowels since centering only
affects vowels before *r* and *w*, and voiceless vowels can only
occur at the very beginning and end of the word.
-->
<CentrePage title='Vowels — Allophones'>
    <Table
            bgcolour='var(--frenchblue-dark)'
            colnames={['Front', 'Central', 'Back']}
            rownames={['Close', 'Near-close', 'Close-mid', 'Mid', 'Open-mid', 'Near-open', 'Open']}
            data={[
                ['i ĩ ı̃̃ i̥ y ẙ', 'ɨ̃ ɨ̃̃ ʉ', 'u ũ ũ̃ u̥'],
                ['ʏ̃ ʏ̃̃', 'ʏ̠̃ ʏ̠̃̃'],
                ['e ẽ ẽ̃ e̥', 'ɘ ɘ̃ ɘ̃̃', 'o o̥'],
                ['', 'ə ə̥'],
                ['ɛ ɛ̃ ɛ̃̃ ɛ̥', 'ɜ ɜ̃ ɜ̃̃', 'ɔ̃ ɔ̃̃'],
                ['', 'ɐ ɐ̥'],
                ['', '', 'ɑ̃ ɑ̃̃']
            ]}
    />
</CentrePage>

<SeqListPages
        title='Vowels — Orthography'
        data={[
        '/i, y, u, e, o/ are spelt $ii, y, u, e, o.',
        '/ɐ/ is spelt $ia.',
        'When nasal(ised), /y, e, o, ɐ/ change quality to /ʏ, ɛ, ɔ, ɑ/.',
        'Nasalised: <$ií, ý, ...>, nasal: <$iî, ŷ, ...>, voiceless: <$iì, ỳ, ...>',
        '/o, ɔ̃, ɔ̃̃/ are frequently also spelt $iau, aú, aû.',
        'Oral /ɛ/ is spelt $iè.',
        'Nasal(ised) /ẽ, ẽ̃/ are spelt $ié, ê.',
        'Oral and voiceless /ə/ are spelt $ie.',
    ]}
/>

<!-----------------------------------------------------------------------------
  Orthography
------------------------------------------------------------------------------>
<CentrePage title='Orthography — Ambiguity' vcenter={false}>
    <BasicTable style='margin-top: 3rem' format='$2' colsep='1rem' data={[
        ['$ie', '→', '/e/', 'or', '/ə/'],
        ['$ié', '→', '/ɛ̃/', 'or', '/ẽ/'],
        ['$iè', '→', '/ɛ/', 'or', '/e̥/'],
        ['$il', '→', '/ɮ̃/', 'or', '/ʎ̝̃/'],
        ['$ic', '→', '/ɕ/', 'or', '/ȷ̊/'],
    ]}/>
</CentrePage>

<CentrePage title='Orthography — Ambiguity cont’d' vcenter={false}>
    <BasicTable style='margin-top: 3rem' format='$2' colsep='1rem' data={[
        ['$ie', '→', '<$ie> /e/', 'vs', '$ <$iẹ> /ə/$1*'],
        ['$ié', '→', '<$ié> /ɛ̃/', 'vs', '<$iẹ́> /ẽ/'],
        ['$iè', '→', '<$iè> /ɛ/', 'vs', '$ <$iẹ̀> /e̥/$1*'],
        ['$il', '→', '<$il> /ɮ̃/', 'vs', '<$iḷ> /ʎ̝̃/'],
        ['$ic', '→', '<$ic> /ɕ/', 'vs', '<$ic̣> /ȷ̊/'],
    ]}/>

    <div class='content' style='margin-top: 1rem'>
        <Text classes='font05' v='*Word-final /e̥/ and /ə/ are actually /ə̥/ and thus both spelt
            <$iẹ>. Furthermore, /ɛ/ can never occur word-initially, so word-initial /e̥/ is also
            just spelt $iè.'/>
    </div>
</CentrePage>

<CentrePage>
    <Text v='$2$i(just slowly pan down over all the sound changes in the grammar)'/>
</CentrePage>

<!-----------------------------------------------------------------------------
  Nasalisation and Lenition
------------------------------------------------------------------------------>
<CentrePage title='Lenition' vcenter={false}>
    <BasicTable style='margin-top: 3rem' classes='lenition-table' format='$2$i' data={[
        ['$m$bConsonant', 'x, s, z', 'c', 'b, f', 'ḅ$1*', 'd', 'ḍ$1*'],
        ['$m$bLenited', 'h', 'c̣', 'b’h', 'bh', 'd’h', 't’h']
    ]}/>

    <div class='content' style='margin-top: 5rem'>
        <Text classes='font05' v='*For diachronic reasons, <$id> and <$ib> can be lenited
            in 2 different ways. Which lenition is used depends on the word; in grammatical
            material, a dot below is used for ‘hard’ <$id> and <$ib>, which diachronically
            derive from <$it> and <$ip>.'/>
    </div>
</CentrePage>

<CentrePage title='Nasalisation'>
    <BasicTable format='$2$i' colsep='1rem' data={[
        ['à, a', '→', 'á'],
        ['á', '→', 'â'],
        ['ḍ', '→', 'n/$mØ'],
    ]}/>
</CentrePage>

<!-----------------------------------------------------------------------------
  Nouns
------------------------------------------------------------------------------>
<CentrePage>
    <div style='display: flex; flex-direction: row; gap: 1rem;'>
        <Table
                classes='font05'
                format='$i'
                bgcolour='var(--frenchred-dark)'
                colnames={['Sg', 'Pl']}
                name='DEFINITE'
                align={AlignmentSpec.Left}

                rownames={[
                    'Absolutive',
                    'Nominative',    'Vocative',
                    'Partitive',     'Accusative',
                    'Genitive',      'Dative',
                    'Inessive',      'Interessive',
                    'Ablative',      'Allative',
                    'Considerative', 'Instrumental'
                ]}

                data={[
                    ['$mØ', 'l-'],
                    ['lá-$UL', 'lé-$UL'],
                    ['<$mØ>-$UL', '<$mØ>-$UN'],
                    ['dy-$UL', 'dẹ-$UL'],
                    ['i-$UL', 'sý-$UL'],
                    ['á-$UL', 'abh-$UL'],
                    ['as-$UL', 'a-$UL'],
                    ['dwá-', 'dwé-'],
                    ['aḍá-', 'aḍé-'],
                    ['rê(d)-', 'rês-'],
                    ['b’hé-$UL', 'b’hér-'],
                    ['słá-', 'słé-'],
                    ['b’hel-', 'b’he-']
                ]}
        />
        <Table
                classes='font05'
                format='$i'
                bgcolour='var(--frenchblue-dark)'
                colnames={['Sg', 'Pl']}
                name='INDEFINITE'
                align={AlignmentSpec.Left}

                rownames={[
                    'Absolutive',
                    'Nominative',    'Vocative',
                    'Partitive',     'Accusative',
                    'Genitive',      'Dative',
                    'Inessive',      'Interessive',
                    'Ablative',      'Allative',
                    'Considerative', 'Instrumental'
                ]}

                data={[
                    ['<$mØ>-$UN', '<$mØ>-$UL'],
                    ['ŷn-$UN', 'ý-$UL'],
                    ['/', '/'],
                    ['dŷn-$UN', 'dý-$UL'],
                    ['s-$UL', 's-'],
                    ['sý-$UN', 'sý-$UL'],
                    ['an-$UN', 'an-$UL'],
                    ['dáhŷn-', 'dáhŷ-'],
                    ['aḍŷn-', 'aḍŷ-'],
                    ['rêdýn-', 'rêdý-'],
                    ['b’hŷn-$UN', 'b’hý-$UL'],
                    ['sý’óýn-', 'sý’óý-'],
                    ['b’hehý(n)-', 'b’heh-']
                ]}
        />
    </div>
</CentrePage>

<!-----------------------------------------------------------------------------
  Abbreviated Glosses
------------------------------------------------------------------------------>
<CentrePage title='Abbreviated Glosses' vcenter={false}>
    <div class='content' style='text-align: left;'>
        <ul>
            <li>Verbs are active, present, and indicative by default.</li>
            <li>Nouns are singular and definite by default.</li>
        </ul>
    </div>
</CentrePage>

<CentrePage>
    <Text v='$7$ijad’hór it’halẹ'/>
    <Text v='$4‘I love the table’'/>
</CentrePage>

<CentrePage>
    <BasicTable colsep='2rem' align={AlignmentSpec.Left}
                data={[
            ['$i$6<$5$ >j-ad’hór', '$i$6i\\t’halẹ'],
            ['$4<$s1sg.act.pres.ind>-love', '$4<$sacc.sg.def>\\table']
        ]}
    />
</CentrePage>

<CentrePage>
    <BasicTable colsep='2rem' align={AlignmentSpec.Left}
                data={[
            ['$i$6<$4$ >j-ad’hór', '$i$6i\\t’halẹ'],
            ['$4<$s1sg>-love', '$4<$sacc>\\table']
        ]}
    />
</CentrePage>

<CentrePage>
    <Text v='$7$iḍalẹ'/>
    <Text v='$3‘table’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$rsý>nalẹ'/>
    <Text v='$4<$s$rgen.indef\>table' classes='closer'/>
    <Text v='$3‘of a table’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$rsý>t’halẹ'/>
    <Text v='$4<$s$rgen.indef.pl\>table' classes='closer'/>
    <Text v='$3‘of tables’'/>
</CentrePage>

<!-----------------------------------------------------------------------------
  Adjectives
------------------------------------------------------------------------------>
<CentrePage title='Adjectives' vcenter={false}>
    <div class='content' style='text-align: left;'>
        <ul>
            <li>Most ‘adjectives’ are adjective verbs.</li>
            <li>Adjectives are not declined and follow the noun they qualify.</li>
        </ul>
    </div>
</CentrePage>

<CentrePage>
    <Text v='$7$iḅẹt’hẹ'/>
    <Text v='$3‘to be small’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$iḅẹt’h$râ'/>
    <Text v='$4be.small$r$s\ptcp'/>
    <Text v='$3‘small’ (lit. ‘being small’)'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$usý>nalẹ ḅẹt’h$râ'/>
    <Text v='$4<$s$ugen.indef\>table be.small$r$s\ptcp'/>
    <Text v='$3‘of a small (lit. “small-being”) table’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$ulẹ>ḅẹt’h$râ'/>
    <Text v='$4<$pcomp->be.small$a\ptcp'/>
    <Text v='$3‘smaller (and also small)’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$uy’ŷ>ḅẹt’h$râ'/>
    <Text v='$4<$pcomp->be.small$a\ptcp'/>
    <Text v='$3‘smaller (but not small)’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$urê>ḅẹt’h$râ'/>
    <Text v='$4<$pcomp->be.small$a\ptcp'/>
    <Text v='$3‘smaller’'/>
</CentrePage>

<CentrePage>
    <Text v='$7$i<$raú><$uy’ŷ>ḅẹt’hẹ$ry’ó'/>
    <Text v='$4<$a1pl-><$pcomp->be.small<$a-1pl>'/>
    <Text v='$3‘we are smaller, but not small’'/>
</CentrePage>

<CentrePage>
    <Text v='$5$iLáráhó <$rs><$ulẹ><$olúr><$rá> b’héd’hẹhẹ dẹnájẹ.'/>
    <Text v='$3‘The fish <$rwas> <$utoo> <$obulky> to swim to the surface.’'/>
</CentrePage>

<CentrePage title='Active/Passive Affixes'>
    <div style='display: flex; gap: 1rem;'>
        <Table
                name='Active'
                format='$i'
                colnames={['Sg', 'Pl']}
                rownames={['1st', '2nd', '3rd m', '3rd f', '3rd n', 'Infinitive', 'Participle']}
                align={AlignmentSpec.Left}
                bgcolour='var(--frenchred-dark)'
                data={[
                ['j-', 'aú-/r-/w- -(y’)ó'],
                ['ḍ(ẹ)-', 'b’h(y)- -(y’)é'],
                ['l(ẹ)-', 'l(ẹ)-'],
                ['ll(a)-', 'll(ẹ)-'],
                ['s- ', 'l(a)-'],
                ['$Cd(ẹ)-', '#span'],
                ['$C-â', '#span']
            ]}
        />

        <Table
                name='Passive'
                format='$i'
                colnames={['Sg', 'Pl']}
                rownames={['1st', '2nd', '3rd m', '3rd f', '3rd n', 'Infinitive', 'Participle']}
                align={AlignmentSpec.Left}
                bgcolour='var(--frenchblue-dark)'
                data={[
                    ['v-', 'aú-/r-/w-'],
                    ['ḍ(ẹ)-', 'b’h(y)-'],
                    ['y’-', 'lý-'],
                    ['y’- ', 'lý-'],
                    ['sy-', 'lý-'],
                    ['$Cà-/h-', '#span'],
                    ['$Câ-', '#span'],
                ]}
        />
    </div>
</CentrePage>

<!-----------------------------------------------------------------------------
  Verb Examples
------------------------------------------------------------------------------>
<!-- Base Form -->
<CentrePage>
    <Text v='$7$iad’hór'/>
    <Text v='$4‘to love’'/>
</CentrePage>

<!-- Active Form: Prefix -->
<CentrePage>
    <Text v='$7$i<$rj>ad’hór'/>
    <Text v='$4<$a1sg->love' classes='closer'/>
    <Text v='$3‘I love’'/>
</CentrePage>

<!-- Active Form: Circumfix -->
<CentrePage>
    <Text v='$7$i<$rb’h>ad’hór$ré'/>
    <Text v='$4<$a2pl->love$a-2pl' classes='closer'/>
    <Text v='$3‘you (<$spl>) love’'/>
</CentrePage>

<!-- Passive Form -->
<CentrePage>
    <Text v='$7$i<$uv>ad’hór'/>
    <Text v='$4<$p1sg.pass->love' classes='closer'/>
    <Text v='$3‘I am loved’'/>
</CentrePage>

<!-- Active + Passive Form (note the additional -y- in the active prefix) -->
<CentrePage>
    <Text v='$7$i<$rb’hy><$uv>ad’hór$ré'/>
    <Text v='$4<$a2pl-><$p1sg.pass->love$a-2pl' classes='closer'/>
    <Text v='$3‘you (<$spl>) love me’'/>
</CentrePage>

<!-- INCORRECT: Active + Passive Form -->
<CentrePage>
    <Text v='$7$i<$u*v><$rb’h>ad’hór$ré'/>
    <Text v='$4<$p1sg.pass-><$a2pl->love$a-2pl' classes='closer'/>
    <Text v='$i$3(Invalid: active prefix should be on the outside)'/>
</CentrePage>

<!-- Passive Form vs Active form-->
<CentrePage>
    <BasicTable
        colsep='5rem'
        data={[
            ['$6$i<$rb’h>ad’hór<$ré>', '$6$i<$ub’h>ad’hór'],
            ['$4<$a2pl->love$a-2pl', '$4<$p2pl.pass->love'],
            ['$3‘you (<$spl>) love’', '$3‘you (<$spl>) are loved’']
        ]}
    />
</CentrePage>

<!-- Active + Corresponding Passive Form -->
<CentrePage>
    <Text v='$7$i<$rb’hy><$ub’h>ad’hór$ré'/>
    <Text v='$4<$a2pl-><$p2pl.pass->love$a-2pl' classes='closer'/>
    <Text v='$3‘you (<$spl>) love yourselves’'/>
</CentrePage>

<!-- Active Infinitive + Passive -->
<CentrePage>
    <Text v='$7$i<$rdẹ><$uv>ad’hór'/>
    <Text v='$4<$ainf-><$p1sg.pass->love' classes='closer'/>
    <Text v='$3‘to love me’'/>
</CentrePage>

<!-- Passive Infinitive + Active -->
<CentrePage>
    <Text v='$7$i<$uà><$rb’h>ad’hór$ré'/>
    <Text v='$4<$pinf.pass-><$a2pl->love$a-2pl' classes='closer'/>
    <Text v='$3‘to be loved by you $s(pl)’'/>
</CentrePage>

<!-- Negated Optative Conditional II of a Ditransitive Verb, because that’s a thing -->
<CentrePage>
    <Text v='$6$idónẹ́'/>
    <Text v='$2[dɔ̃ˈnẽˑ]'/>
    <Text v='endow' classes='font25'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raú>dónẹ́<$ry’ó>'/>
    <Text v='<$a1pl->endow$s<$a-1pl>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃.dɔ̃ˈnẽˑ.ɥɔ̃]'/>
    <Text v='‘We endow’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raú>dónẹ́<$ry’ó><$vb’hẹ>'/>
    <Text v='<$a1pl->endow$s<$a-1pl><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃.dɔ̃ˈnẽˑ.ɥɔ̃.βə̥]'/>
    <Text v='‘We endow you’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raú><$usy>dónẹ́<$ry’ó><$vb’hẹ>'/>
    <Text v='<$a1pl-><$p3n.pass->endow$s<$a-1pl><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃.sy.dɔ̃ˈnẽˑ.ɥɔ̃.βə̥]'/>
    <Text v='‘We endow you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raúnraû><$usy>dón<$gr><$raûrâ><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass->endow$s$g.fut<$a&bsol;circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃n.ɰɔ̃̃.sy.dɔ̃nˈɰɔ̃̃ˑ.ɰɑ̃̃.βə̥]'/>
    <Text v='‘We shall have endowed you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raúnraû><$usy>dón<$grẹ́><$oss><$raúrâ><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃n.ɰɔ̃̃.sy.dɔ̃nˈɰẽˑ.sːɔ̃.ɰɑ̃̃.βə̥]'/>
    <Text v='‘We would have endowed you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raúnraû><$usy><$yy’ẹ>dón<$grẹ́><$oss><$raúrâ><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass-><$y$sopt->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃̃n.ɰɔ̃̃.sy.ɥə.dɔ̃nˈɰẽˑ.sːɔ̃.ɰɑ̃̃.βə̥]'/>
    <Text v='<$iroughly:> ‘If only we had endowed you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$nt’h’><$raûnraû><$usy><$yy’ẹ>dón<$grẹ́><$oss><$raúrâ><$vb’hẹ>'/>
    <Text v='<$s$nneg&bsol;><$a1pl.fut.ant-><$p3n.pass-><$y$sopt->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[θɔ̃̃n.ɰɔ̃̃.sy.ɥə.dɔ̃nˈɰẽˑ.sːɔ̃.ɰɑ̃̃.βə̥]'/>
    <Text v='<$iroughly:> ‘If only we had not endowed you with it’' classes='font15'/>
</CentrePage>

<!-----------------------------------------------------------------------------
  Copypasta
------------------------------------------------------------------------------>
<CopyPasta
    text='Rub’hráy’ó rát’he au sré au sfèhe laut’hâ'
    gloss='<$s1pl>-can-<$s1pl> you.see and <$sacc.pl.indef>-ray <$sand> <$sacc.pl.indef>-beam float-<$sptcp>'
    trans='We can, you see, detect rays and beams of energy floating'
/>

<CopyPasta
    text='Át’hebhaú Raúl dedesle, s aút’hiy’ey’ó'
    gloss='<$sinteress.pl.indef>-speaker <$sgen>-Ultrafrench language <$sinf>-detect if <$s1pl>-use-<$s1pl>'
    trans='between speakers of the ULTRAFRENCH Language if we use'
/>

<CopyPasta
    text='sývéhýr dýhisdé sérdé laúây’êr;'
    gloss='<$spart.pl.indef>\system certain long-<$sptcp.pass>-forbid\<$sptcp.pres.ant>'
    trans='certain systems of measurement long-forbidden;'
/>


<CopyPasta
    text='aúc’haúbrâdy’ó’sý’ýâ vé dúr'
    gloss='<$s1pl>-understand-<$s1pl>-not but still'
    trans='we still don’t understand, however,'
/>


<CopyPasta
    text='dyhaúbhausy’ô sehabhvísy’ô.'
    gloss='<$spart>\composition this-<$sgen.pl>-emission'
    trans='the composition of these emissions.'
/>

<CopyPasta
    text='Sýlývy’ér saúr c’hesse?'
    gloss='<$sgen.indef>-light <$sabs>.kind <$sq>-<$s3n>.be'
    trans='Is it some kind of light?'
/>

<CopyPasta
    text='Lec’hdraúvnét’hic’hâ nérje c’hesse?'
    gloss='electromagnetic-<$sptcp> <$senergy>.<$sabs> <$sq>-<$s3n>.be'
    trans='Is it electromagnetic energy?'
/>

<CopyPasta
    text='Árdihyl c’hesse?'
    gloss='particle.<$sabs> <$sq>-<$s3n>.be'
    trans='Is it a particle?'
/>

<CopyPasta
    text='Sauz-aud de c’hesse?'
    gloss='<$sabs>.thing-other entire <$sq>-<$s3n>.be'
    trans='Is it something else entirely?'
/>

<CopyPasta
    text='Jávé’sý’ýâ jrét’hádé dedónéle'
    gloss='never-not <$s1sg>-claim-<$spres.ant> <$sinf>-endow-<$s3.dat>'
    trans='I’ve never claimed that they are endowed with'
/>

<CopyPasta
    text='dýhabhahit’he deý’ebhat’hic’hâ Áraúl dybháł.'
    gloss='<$spart.pl.indef>\ability be.telepathic-<$sptcp> <$sgen>-language <$spart>\speak'
    trans='telepathic abilities by [the mere act of] speaking The Language.'
/>

<CopyPasta
    text='Aúrsáheressá.'
    gloss='<$s3n.fut.ii>-be.preposterous.<$sfut>-<$scond>\<$s3n.fut.ii>'
    trans='It would be preposterous.'
/>

<CopyPasta
    text='Jdír jys dub’hrá au dylí sýcahý'
    gloss='<$s1sg>-say only <$sinf>-can and <$spart>-read <$sgen.pl.indef>-each.other'
    trans='I’m only saying that speakers of The Language can read each other’s'
/>

<CopyPasta
    text='dýbháhe au dylýáv́áy’é b’hýcahý sbáłýr Áraúl.'
    gloss='<$spart.pl.indef>-thought and <$spart>-<$s3pl.pass>-send <$sdat.pl.indef>-each.other <$sacc.pl.indef>-speaker <$sgen>-language'
    trans='thoughts and send them to each other'
/>

<CopyPasta
    text='Lásásc’hríd raúl révéy’ýr c’hessejú?'
    gloss='<$snom>-Sanskrit <$sabs>.language <$ssup>-better <$sq> <$s3n>.be-<$sgnomic>'
    trans='Is Sanskrit the best language?'
/>

<CopyPasta
    text='Léraúb’he lasydír,'
    gloss='<$snom.pl>-robot <$s3pl>-<$s3n.pass>-say'
    trans='The robots say so,'
/>

<CopyPasta
    text='lavâhe vé sbhárde sásy’élâ Áraúl.'
    gloss='<$s3pl>-miss.out but <$sacc.indef>\<$spart> be.essential-<$sptcp> <$sgen>-language'
    trans='but they are missing out on an essential part of The Language.'
/>

<CopyPasta
    text='Sráhis’sý’ýâ id’hír deb’hýlnér u b’hesaúr rêvú'
    gloss='<$s3n>-be.racist-not <$sacc>\say <$sinf>-be.unaffected or <$sinstr.pl>-form <$ssup>-many'
    trans='It’s not racist to say that robots are unaffected by most forms'
/>

<CopyPasta
    text='aû-át’heý’ebhat’he u B’helfaúr sraúb’he.'
    gloss='non-<$sgen>-telepathy or <$sinstr>-Force <$sacc.pl.indef>-robot'
    trans='of non-telepathy and the Force.'
/>

<CopyPasta
    text='Jav́ár sáví lyzy’ýr ádróid.'
    gloss='<$s1sg>-have <$sacc.pl.indef>-friend several <$sabs>.android'
    trans='I have several android friends.'
/>

<CopyPasta
    text='Sy’ub’hrá dahaúr isásc’hríd dwáníb’he'
    gloss='<$s3n-opt>-can sure <$sacc>-Sanskrit <$siness>-level'
    trans='Sure, Sanskrit might, on the level of'
/>

<CopyPasta
    text='araúl sébâ âc’hrír ‘dèc’hníc’hvâ’'
    gloss='<$sgen>-language be.plain-<$sptcp> <$sptcp.pass>.write technically'
    trans='the plain written language, be “technically”'
/>

<CopyPasta
    text='Át’hebhaú Raúl ‘desybhérýr’,'
    gloss='<$sgen>-Ultrafrench language <$sinf>-be.superior'
    trans='“superior” to The UF Language,'
/>

<CopyPasta
    text='sjys vé delýc’hóbhár,'
    gloss='<$s3n>-be.unfair but <$sinf>-<$s3pl.pass>-compare'
    trans='but it is unfair to compare them,'
/>

<CopyPasta
    text='lásásc’hríd c’haúr sýraúl âc’hrír sc’hóváhá,'
    gloss='<$snom>-Sanskrit as <$sgen.indef>-language <$sptcp.pass>-write <$s3n>-begin.<$ssubj>\<$spres.ant>'
    trans='as Sanskrit started out as a written language,'
/>

<CopyPasta
    text='lévás nórâ jys ‘desybáł’ dyhéy’é lay’ehóvâhér.'
    gloss='<$snom.pl>-masses be.ignorant-<$sptcp> until <$sinf>-<$s3n.pass>-speak <$spart>\attempt $B <$s3pl>-<$sopt>\start\<$spres.ant>'
    trans='until the ignorant masses started attempting to “speak” it.'
/>

<CopyPasta
    text='Aúc’hóhid’héy’ó laúrvé Áraúl dynát’hýr rêâ,'
    gloss='<$s1pl>-consider-<$s1pl> but.when <$sgen>-language <$spart>-nature be.triune-<$sptcp>'
    trans='But when we consider the triune nature of The Language,'
/>

<CopyPasta
    text='srâsírá, dwác’hóvníc’h âbáł dývrê'
    gloss='<$s3n>-transpire-<$spres.ant> <$siness>-communication <$sptcp.pass>-speak at.least'
    trans='it is clear that, at least in spoken communication'
/>

<CopyPasta
    text='b’hehbárdihibhá aû-ádróid, It’hebhaú Raúl'
    gloss='<$sinstr.pl.indef>-participant non <$sabs>.android <$sacc>-Ultrafrench language'
    trans='with non-android participants, ULTRAFRENCH'
/>

<CopyPasta
    text='abhraúl dérésdâ derâdvâvéy’ýr.'
    gloss='<$sgen.pl>-language be.terrestrial-<$sptcp> <$sinf>-<$ssuperl>-be.better'
    trans='is the best of the terrestrial languages.'
/>
<!--

But when we consider the triune nature of The Language, it has transpired that,26 at least in spoken
communication with non-android participants, UF is the best of the terrestrial languages
-->

<!-----------------------------------------------------------------------------
  Thank You for Watching
------------------------------------------------------------------------------>
<CentrePage>
    <Text v='$9$iVérs ád’herárdá!' />
</CentrePage>