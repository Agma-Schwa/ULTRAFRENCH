<script>
    import Page from "./Page.svelte";
    import Text from "./Text.svelte";
    import CentrePage from "./CentrePage.svelte";
    import "$lib/style.scss";
</script>

<CentrePage>
    <Text v="$7$iad’hór" />
    <Text v="$4‘to love’"/>
</CentrePage>

<CentrePage>
    <Text v="$7$i<$rj>ad’hór" />
    <Text v="$4<$a1sg->love" classes="closer"/>
    <Text v="$3‘I love’"/>
</CentrePage>

<CentrePage>
    <Text v="$7$i<$rb’h>ad’hór$ré" />
    <Text v="$4<$a2pl->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love’"/>
</CentrePage>

<CentrePage>
    <Text v="$7$i<$uv>ad’hór" />
    <Text v="$4<$p1sg.pass->love" classes="closer"/>
    <Text v="$3‘I am loved’"/>
</CentrePage>

<CentrePage>
    <Text v="$7$i<$rb’hy><$uv>ad’hór$ré" />
    <Text v="$4<$a2pl-><$p1sg.pass->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love me’"/>
</CentrePage>

<CentrePage>
    <Text v="$7$i<$rb’hy><$ub’h>ad’hór$ré" />
    <Text v="$4<$a2pl-><$p2pl.pass->love$a-2pl" classes="closer"/>
    <Text v="$3‘you (<$spl>) love yourselves’"/>
</CentrePage>
