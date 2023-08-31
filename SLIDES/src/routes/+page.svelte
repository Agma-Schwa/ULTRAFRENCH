<script>
    import Page from "./Page.svelte";
    import Text from "./Text.svelte";
    import CentrePage from "./CentrePage.svelte";
    import "$lib/style.scss";
</script>

<style lang="scss">
    .consonants-table-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .consonants {
        width: 80%;
        border-collapse: collapse;
        border: 1px solid var(--frenchred-dark);

        thead {
            tr {
                color: white;
                background: var(--frenchred-dark);
            }
        }

        colgroup col:first-child {
            background: var(--frenchred-dark);
        }

        tr td:first-child {
            text-align: left;
            padding: 0 0 0 .5rem;
            width: 7.5rem;
            color: white;
        }

        tr:nth-child(2n) {
            background: var(--frenchred-dark);

            td:not(:first-child) {
                box-shadow: inset 0 0 0 10000px rgb(255 255 255 / 50%);
            }
        }
    }
</style>

<Page />

<CentrePage>
    <Text v="$7$ij’adore" />
    <Text v="$4/ʒa.dɔʁ/" classes="closer" />
    <Text v="$3‘I adore’" />
</CentrePage>

<CentrePage>
    <Text v="$7$ijad’hór" />
    <Text v="$4[ʑa̯ˈðɔ̃ˑɰ]" classes="closer" />
    <Text v="$4‘I love’" />
</CentrePage>

<CentrePage>
    <Text v="$7$iDominique" />
    <Text v="$4/dɔ.mi.nik/" classes="closer" />
    <Text v="$3‘Dominic’" />
</CentrePage>

<CentrePage>
    <Text v="$7$iDaúvníc’h" />
    <Text v="$4['dɔ̃ˑʋ̃.nĩɕ]" classes="closer" />
    <Text v="$4‘Dominic’" />
</CentrePage>

<CentrePage>
    <Text v="$7$ien faire tout un fromage" />
    <Text v="$3‘To make everything into cheese’" />
</CentrePage>

<CentrePage>
    <Text v="$7$iférḍufraú" />
    <Text v="$4[ɸɜ̃ɰ.du̯ˈɸɰɔ̃ˑ]" classes="closer" />
    <Text v="$4‘To make a big fuss about something’" />
</CentrePage>

<CentrePage>
    <Text v="$9$iT’heb’haú Raúl" />
    <Text v="$5[θeˌβɔ̃ˑ'ɰɔ̃ˑɮ̃]" />
</CentrePage>

<CentrePage classes="no-box-shadow">
    <Text v="$2ULTRAFRENCH" />
</CentrePage>

<CentrePage>
    <div class="consonants-table-wrapper">
    <table class="consonants">
        <colgroup>
            <col>
            <col>
            <col>
            <col>
            <col>
        </colgroup>
        <thead>
        <tr>
            <td></td>
            <td>Labial</td>
            <td>Coronal</td>
            <td>Palatal</td>
            <td>Velar</td>
            <td>Glottal</td>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td>Stop</td>
            <td>b, bʱ</td>
            <td>d</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>Nasal</td>
            <td></td>
            <td>n</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>Fricative</td>
            <td>ɸ β, ʋ̃</td>
            <td>s z, θ ð</td>
            <td>ç ɕ ʑ</td>
            <td>x χ</td>
            <td>h</td>
        </tr>

        <tr>
            <td>Trill</td>
            <td></td>
            <td></td>
            <td></td>
            <td>ʀ</td>
            <td></td>
        </tr>

        <tr>
            <td>Approximant</td>
            <td></td>
            <td></td>
            <td>ɥ ɥ̃, ȷ̊</td>
            <td>ɰ ɰ̃</td>
            <td></td>
        </tr>

        <tr>
            <td>Lateral Fricative</td>
            <td></td>
            <td>ɮ̃</td>
            <td></td>
            <td></td>
            <td>ʎ̝̃</td>
        </tr>

        </tbody>
    </table>
    </div>
</CentrePage>

<CentrePage>
    <div class="consonants-table-wrapper">
    <table class="consonants">
        <colgroup>
            <col>
            <col>
            <col>
            <col>
            <col>
            <col>
        </colgroup>
        <thead>
        <tr>
            <td></td>
            <td>Labial</td>
            <td>Coronal</td>
            <td>Palatal</td>
            <td>Velar</td>
            <td>Glottal</td>
        </tr>
        </thead>
        <tbody>

        <tr>
            <td>Stop</td>
            <td>b, bʱ</td>
            <td>d</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>Nasal</td>
            <td></td>
            <td>n</td>
            <td></td>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>Fricative</td>
            <td>ɸ β, ʋ̃</td>
            <td>s z, θ ð</td>
            <td>ç ɕ ʑ</td>
            <td>x χ</td>
            <td>h</td>
        </tr>

        <tr>
            <td>Fric. (ʁ-coloured)</td>
            <td>βʶ</td>
            <td>sʶ zʶ ɮ̃ʶ</td>
            <td>ɕʶ ʑʶ</td>
            <td></td>
            <td></td>
        </tr>

        <tr>
            <td>Trill</td>
            <td></td>
            <td></td>
            <td></td>
            <td>ʀ</td>
            <td></td>
        </tr>

        <tr>
            <td>Approximant</td>
            <td></td>
            <td></td>
            <td>ɥ ɥ̃, ȷ̊</td>
            <td>ɰ ɰ̃</td>
            <td></td>
        </tr>

        <tr>
            <td>Lateral Fricative</td>
            <td></td>
            <td>ɮ̃</td>
            <td></td>
            <td></td>
            <td>ʎ̝̃</td>
        </tr>

        </tbody>
    </table>
    </div>
</CentrePage>


<!-- Base Form -->
<CentrePage>
    <Text v="$7$iad’hór"/>
    <Text v="$4‘to love’"/>
</CentrePage>

<!-- Active Form: Prefix -->
<CentrePage>
    <Text v="$7$i<$rj>ad’hór"/>
    <Text v="$4<$a1sg->love" classes="closer"/>
    <Text v="$3‘I love’"/>
</CentrePage>

<!-- Active Form: Circumfix -->
<CentrePage>
    <Text v="$7$i<$rb’h>ad’hór$ré"/>
    <Text v="$4<$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love’"/>
</CentrePage>

<!-- Passive Form -->
<CentrePage>
    <Text v="$7$i<$uv>ad’hór"/>
    <Text v="$4<$p1sg.pass->love" classes="closer"/>
    <Text v="$3‘I am loved’"/>
</CentrePage>

<!-- Active + Passive Form (note the additional -y- in the active prefix) -->
<CentrePage>
    <Text v="$7$i<$rb’hy><$uv>ad’hór$ré"/>
    <Text v="$4<$a2pl-><$p1sg.pass->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love me’"/>
</CentrePage>

<!-- INCORRECT: Active + Passive Form -->
<CentrePage>
    <Text v="$7$i<$u*v><$rb’h>ad’hór$ré"/>
    <Text v="$4<$p1sg.pass-><$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$i$3(Invalid: active prefix should be on the outside)"/>
</CentrePage>

<!-- Active + Corresponding Passive Form -->
<CentrePage>
    <Text v="$7$i<$rb’hy><$ub’h>ad’hór$ré"/>
    <Text v="$4<$a2pl-><$p2pl.pass->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love yourselves’"/>
</CentrePage>

<!-- Active Infinitive + Passive -->
<CentrePage>
    <Text v="$7$i<$rdẹ><$uv>ad’hór"/>
    <Text v="$4<$ainf-><$p1sg.pass->love" classes="closer"/>
    <Text v="$3‘to love me’"/>
</CentrePage>

<!-- Passive Infinitive + Active -->
<CentrePage>
    <Text v="$7$i<$uà><$rb’h>ad’hór$ré"/>
    <Text v="$4<$pinf.pass-><$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$3‘to be loved by you $s(pl)’"/>
</CentrePage>

<!-- Negated Optative Conditional II of a Ditransitive Verb, because that’s a thing -->
<CentrePage>
    <Text v="$6$i<$nt’h’><$raûnraû><$usy><$yy’ẹ>dón<$gr>ẹ́$<$oss><$raúrâ><$vb’hẹ>"/>
    <Text v="<$s$nneg&bsol;><$a1pl.fut.ant-><$p3n.pass-><$y$sopt->endow$s$g.fut<$o-cond><$a-circ><$v-2.dat>"
          classes="closer font25"/>
    <Text v="<$iroughly:> ‘If only we had not endowed you with it’" classes="font15"/>
</CentrePage>