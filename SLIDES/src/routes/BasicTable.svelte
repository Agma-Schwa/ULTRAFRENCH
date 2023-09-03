<script lang='ts'>
    import Text from './Text.svelte';
    import {TextFormat} from '$lib/text';
    import {onMount} from 'svelte';


    export let colsep: string = '';
    export let format: string = '';
    export let data: string[][];
    export let style: string = '';
    let table : HTMLTableElement;

    onMount(() => {
        if (colsep.length > 0) {
            table.style.setProperty('--colsep', colsep);
        }
    })
</script>

<style lang='scss'>
    table {
        --colsep: auto;
        width: 1px;
        white-space: nowrap;
        border-collapse: collapse;
    }

    td + td {
        padding-left: var(--colsep);
    }
</style>

<table class={TextFormat.ParseTextFormat(format)} bind:this={table} {style}>
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