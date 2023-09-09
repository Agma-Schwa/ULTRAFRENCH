<script lang='ts'>

    import CentrePage from './CentrePage.svelte';
    import Text from './Text.svelte';

    export let text: string;
    export let gloss: string;
    export let trans: string;
</script>

<style lang='scss'>
    p { text-align: center; }
    .content {
        padding: 1rem;
        :global(p + p) { margin-top: .25rem; }
    }
</style>

<CentrePage>
    <div class='content'>
        <Text v='{text}' classes='font4 italic width100'/>
        <Text v='{gloss}' classes='gloss font15'/>
        <Text v='{"‘" + trans + "’"}' classes='trans font15'/>
    </div>
</CentrePage>