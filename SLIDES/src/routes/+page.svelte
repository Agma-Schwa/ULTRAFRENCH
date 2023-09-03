<script lang='ts'>
    import Page from './Page.svelte';
    import Text from './Text.svelte';
    import CentrePage from './CentrePage.svelte';
    import '$lib/style.scss';
    import Table from './Table.svelte';
    import SeqTablePages from './SeqTablePages.svelte';
    import BasicTable from './BasicTable.svelte';
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

<Page title='Vowels — Orthography'>
    <div class='content'>
        <ul>
            <li>/i, y, u, e, o/ are spelt <em>i, y, u, e, o</em></li>
            <li>/ɐ/ is spelt <em>a</em>.</li>
            <li>When nasal(ised), /y, e, o, ɐ/ change quality to /ʏ, ɛ, ɔ, ɑ/.</li>
            <li>Nasalised: <em>í, ý, ...</em>, nasal: <em>î, ŷ, ...</em>, voiceless: <em>ì, ỳ, ...</em></li>
            <li>Oral /ɛ/ is spelt <em>è</em>.</li>
            <li>Nasal(ised) /ẽ, ẽ̃/ are spelt <em>é, ê</em>.</li>
            <li>Oral and voiceless are spelt <em>e</em>.</li>
        </ul>
    </div>
</Page>

<CentrePage title='Orthography — Ambiguity'  vcenter={false}>
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
    <Text v='endow' classes='closer font25'/>
    <Text v='$2[dɔ̃ˈnẽˑ]'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raú>dónẹ́<$ry’ó>'/>
    <Text v='<$a1pl.fut.ant->endow$s<$a-circ>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃.dɔ̃ˈnẽˑ.ɥɔ̃]'/>
    <Text v='‘We endow’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raú>dónẹ́<$ry’ó><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant->endow$s<$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃.dɔ̃ˈnẽˑ.ɥɔ̃.βə̥]'/>
    <Text v='‘We endow you’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raú><$usy>dónẹ́<$ry’ó><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass->endow$s<$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃.sy.dɔ̃ˈnẽˑ.ɥɔ̃.βə̥]'/>
    <Text v='‘We endow you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raûnraû><$usy>dón<$gr><$raûrâ><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass->endow$s$g.fut<$a&bsol;circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃̃n.ɰɔ̃̃.sy.dɔ̃nˈɰɔ̃̃ˑ.ɰɑ̃̃.βə̥]'/>
    <Text v='‘We shall have endowed you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raûnraû><$usy>dón<$gr>ẹ́<$oss><$raúrâ><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃̃n.ɰɔ̃̃.sy.dɔ̃nˈɰẽˑ.sːɔ̃.ɰɑ̃̃.βə̥]'/>
    <Text v='‘We would have endowed you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$raûnraû><$usy><$yy’ẹ>dón<$gr>ẹ́<$oss><$raúrâ><$vb’hẹ>'/>
    <Text v='<$a1pl.fut.ant-><$p3n.pass-><$y$sopt->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[ɔ̃̃n.ɰɔ̃̃.sy.ɥə.dɔ̃nˈɰẽˑ.sːɔ̃.ɰɑ̃̃.βə̥]'/>
    <Text v='<$iroughly:> ‘If only we had endowed you with it’' classes='font15'/>
</CentrePage>

<CentrePage>
    <Text v='$6$i<$nt’h’><$raûnraû><$usy><$yy’ẹ>dón<$gr>ẹ́<$oss><$raúrâ><$vb’hẹ>'/>
    <Text v='<$s$nneg&bsol;><$a1pl.fut.ant-><$p3n.pass-><$y$sopt->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>'
          classes='closer font25'/>
    <Text v='$2[θɔ̃̃n.ɰɔ̃̃.sy.ɥə.dɔ̃nˈɰẽˑ.sːɔ̃.ɰɑ̃̃.βə̥]'/>
    <Text v='<$iroughly:> ‘If only we had not endowed you with it’' classes='font15'/>
</CentrePage>