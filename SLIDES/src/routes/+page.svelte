<script>
    import Page from "./Page.svelte";
    import Text from "./Text.svelte";
    import CentrePage from "./CentrePage.svelte";
    import "$lib/style.scss";
</script>

<!-- Base Form -->
<CentrePage>
    <Text v="$7$iad’hór" />
    <Text v="$4‘to love’"/>
</CentrePage>

<!-- Active Form: Prefix -->
<CentrePage>
    <Text v="$7$i<$rj>ad’hór" />
    <Text v="$4<$a1sg->love" classes="closer"/>
    <Text v="$3‘I love’"/>
</CentrePage>

<!-- Active Form: Circumfix -->
<CentrePage>
    <Text v="$7$i<$rb’h>ad’hór$ré" />
    <Text v="$4<$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love’"/>
</CentrePage>

<!-- Passive Form -->
<CentrePage>
    <Text v="$7$i<$uv>ad’hór" />
    <Text v="$4<$p1sg.pass->love" classes="closer"/>
    <Text v="$3‘I am loved’"/>
</CentrePage>

<!-- Active + Passive Form (note the additional -y- in the active prefix) -->
<CentrePage>
    <Text v="$7$i<$rb’hy><$uv>ad’hór$ré" />
    <Text v="$4<$a2pl-><$p1sg.pass->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love me’"/>
</CentrePage>

<!-- INCORRECT: Active + Passive Form -->
<CentrePage>
    <Text v="$7$i<$u*v><$rb’h>ad’hór$ré" />
    <Text v="$4<$p1sg.pass-><$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$i$3(Invalid: active prefix should be on the outside)"/>
</CentrePage>

<!-- Active + Corresponding Passive Form -->
<CentrePage>
    <Text v="$7$i<$rb’hy><$ub’h>ad’hór$ré" />
    <Text v="$4<$a2pl-><$p2pl.pass->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love yourselves’"/>
</CentrePage>

<!-- Active Infinitive + Passive -->
<CentrePage>
    <Text v="$7$i<$rdẹ><$uv>ad’hór" />
    <Text v="$4<$ainf-><$p1sg.pass->love" classes="closer"/>
    <Text v="$3‘to love me’"/>
</CentrePage>

<!-- Passive Infinitive + Active -->
<CentrePage>
    <Text v="$7$i<$uà><$rb’h>ad’hór$ré" />
    <Text v="$4<$pinf.pass-><$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$3‘to be loved by you $s(pl)’"/>
</CentrePage>

<!-- Negated Optative Conditional II of a Ditransitive Verb, because that’s a thing -->
<CentrePage>
    <Text v="$6$i<$nt’h’><$raûnraû><$usy><$yy’ẹ>dón<$gr>ẹ́$<$oss><$raúrâ><$vb’hẹ>"/>
    <Text v="<$s$nneg&bsol;><$a1pl.fut.ant-><$p3n.pass-><$y$sopt->endow$s$g.fut<$o-cond.ii><$a-circ><$v-2.dat>" classes="closer font25"/>
    <Text v="<$iroughly:> ‘If only we had not endowed you with it’" classes="font15" />
</CentrePage>