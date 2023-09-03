<script lang="ts">
    import {onMount} from "svelte";

    export let colnames: string[]
    export let rownames: string[]
    export let data: string[][];
    export let bgcolour: string = 'black';
    let table: HTMLTableElement;

    onMount(() => void table.style.setProperty('--bg-colour', bgcolour))
</script>

<style lang="scss">
    .table-wrapper {
        display: flex;
        align-items: center;
        justify-content: center;

        table {
            --bg-colour: black;
            width: 80%;
            border-collapse: collapse;
            border: 1px solid var(--bg-colour);

            /// Table header.
            thead {
                tr {
                    color: white;
                    background: var(--bg-colour);
                }
            }

            /// First column.
            tr td:first-child {
                text-align: left;
                padding: 0 0 0 .5rem;
                width: 7.5rem;
                color: white;
                background: var(--bg-colour);
            }

            tbody {
                /// Even columns.
                tr:nth-child(2n) {
                    background: var(--bg-colour);

                    td:not(:first-child) {
                        box-shadow: inset 0 0 0 10000px rgb(255 255 255 / 50%);
                    }
                }

                /// Odd columns.
                tr:nth-child(2n + 1) {
                    background: white;
                }
            }
        }
    }
</style>


<div class="table-wrapper">
    <table bind:this={table}>
        <colgroup>
            {#each data as _}
                <col>
            {/each}
        </colgroup>
        <thead>
        <tr>
            <td></td>
            {#each colnames as title}
                <td>{title}</td>
            {/each}
        </tr>
        </thead>

        <tbody>
        {#each rownames as name, i}
            <tr>
                <td>{name}</td>
                {#each colnames as _, j}
                    <td>{data[i]?.[j] ?? ''}</td>
                {/each}
            </tr>
        {/each}
        </tbody>
    </table>
</div>