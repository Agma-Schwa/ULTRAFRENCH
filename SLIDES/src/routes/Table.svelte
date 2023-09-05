<script lang='ts'>
    import {onMount} from 'svelte';
    import Text from './Text.svelte';
    import {AlignmentSpec, TextFormat} from '$lib/text';

    export let classes: string = '';
    export let title: string | undefined = undefined;
    export let colnames: string[];
    export let rownames: string[] | undefined = undefined;
    export let data: string[][];
    export let bgcolour: string = 'black';
    export let format: string = '';
    export let name: string = '';
    export let align: AlignmentSpec = AlignmentSpec.Center;
    let table: HTMLTableElement;

    $: parsed_format = TextFormat.ParseTextFormat(format);

    /// Compute cell spans.
    let spans: number[][] = Array(data.length).fill(0).map(_ => Array(colnames.length).fill(1));

    /// If a cell contains the text '#span', then the cell to the left
    /// of it is extended by 1; multiple occurrences of '#span' extend
    /// the cell by the number of occurrences.
    for (let i = 0; i < data.length; i++) {
        for (let j = 0; j < data[i].length; j++) {
            if (j === 0) continue;
            const idx = j - 1;

            /// Note: It’s ok to skip over an extra element here after a
            /// series of '#span's since that element can’t be a '#span'
            /// anyway and can thus just be ignored.
            while (j < data.length && data[i][j++] === '#span') spans[i][idx]++;
        }
    }

    onMount(() => {
        table.style.setProperty('--bg-colour', bgcolour);
        if (!rownames) table.classList.add('notitlecol');
    });
</script>

<style lang='scss'>
    .table-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;

        table {
            --bg-colour: black;
            --even-cell-box-shadow: inset 0 0 0 10000px rgb(255 255 255 / 50%);
            --table-border: 1px solid var(--bg-colour);

            width: min-content;
            white-space: nowrap;

            border-collapse: collapse;
            border: var(--table-border);

            td {
                padding: 0 .5rem;
            }

            /// Table header.
            thead {
                tr {
                    color: white;
                    background: var(--bg-colour);
                }
            }

            tbody {
                /// Even columns.
                tr:nth-child(even) {
                    background: var(--bg-colour);
                    box-shadow: var(--even-cell-box-shadow);
                }

                /// Odd columns.
                tr:nth-child(odd) {
                    background: white;
                }
            }
        }

        table:not(.notitlecol) {
            tr td:first-child {
                text-align: left;
                width: 1px;
                white-space: nowrap;
                color: white;
                background: var(--bg-colour);
            }

            /// No box shadow on the first column.
            tbody tr:nth-child(even) td:first-child {
                box-shadow: none;
            }
        }
    }
</style>

{#if title}
    <Text v='$3{title}' style='margin-bottom: 1rem'/>
{/if}

<div class='table-wrapper'>
    <table bind:this={table} class='{classes} {align}'>
        <colgroup>
            {#each data as _}
                <col>
            {/each}
        </colgroup>

        <thead>
        <tr>
            {#if rownames}
                <td>{name}</td>
            {/if}
            {#each colnames as title}
                <td>{title}</td>
            {/each}
        </tr>
        </thead>

        <tbody>
        {#if rownames}
            {#each rownames as name, i}
                <tr>
                    <td>{name}</td>
                    {#each colnames as _, j}
                        {#if data[i]?.[j] !== '#span'}
                            <td class='{parsed_format}' colspan='{spans[i][j]}'>
                                <Text v='{data[i]?.[j] ?? ""}'/>
                            </td>
                        {/if}
                    {/each}
                </tr>
            {/each}
        {:else}
            {#each data as row, i}
                <tr>
                    {#each row as _, j}
                        {#if data[i]?.[j] !== '#span'}
                            <td class='{parsed_format}' colspan='{spans[i][j]}'>
                                <Text v='{data[i]?.[j] ?? ""}'/>
                            </td>
                        {/if}
                    {/each}
                </tr>
            {/each}
        {/if}
        </tbody>
    </table>
</div>