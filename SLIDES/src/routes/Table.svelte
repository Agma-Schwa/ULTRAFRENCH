<script lang="ts">
    import {onMount} from "svelte";
    import Text from "./Text.svelte";

    export let classes: string = '';
    export let title: string | undefined = undefined;
    export let colnames: string[]
    export let rownames: string[] | undefined = undefined;
    export let data: string[][];
    export let bgcolour: string = 'black';
    let table: HTMLTableElement;

    onMount(() => {
        table.style.setProperty('--bg-colour', bgcolour);
        if (!rownames) table.classList.add('notitlecol');
    })
</script>

<style lang="scss">
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
    <Text v="$3{title}" style="margin-bottom: 1rem"/>
{/if}

<div class="table-wrapper">
    <table bind:this={table} class={classes}>
        <colgroup>
            {#each data as _}
                <col>
            {/each}
        </colgroup>

        <thead>
        <tr>
            {#if rownames}
                <td></td>
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
                        <td>{@html data[i]?.[j] ?? ''}</td>
                    {/each}
                </tr>
            {/each}
        {:else}
            {#each data as row, i}
                <tr>
                    {#each row as _, j}
                        <td>{@html data[i]?.[j] ?? ''}</td>
                    {/each}
                </tr>
            {/each}
        {/if}
        </tbody>
    </table>
</div>