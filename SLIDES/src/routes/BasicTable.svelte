<script lang='ts'>
    import Text from './Text.svelte';
    import {TextFormat} from '$lib/text';


    export let format: string = '';
    export let data: string[][];
</script>

<style lang='scss'>
    table {
        width: 1px;
        white-space: nowrap;
        border-collapse: collapse;
    }
</style>

<table class={TextFormat.ParseTextFormat(format)}>
    <tbody>
    {#each data as row}
        <tr>
            {#each row as cell}
                <td><Text v={cell}/></td>
            {/each}
        </tr>
    {/each}
    </tbody>
</table>