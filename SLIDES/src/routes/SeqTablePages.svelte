<script lang="ts">
    import CentrePage from "./CentrePage.svelte";
    import Table from "./Table.svelte";

    /// Last control char.
    const MAX_CONTROL = 31;
    const NO_CONTROL = 32;
    const NBSP = '&nbsp;';

    export let classes: string = ''
    export let title: string | undefined = undefined;
    export let colnames: string[]
    export let rownames: string[] | undefined = undefined;
    export let data: string[][];
    export let bgcolour: string = 'black';

    function IsControlChar(c: number) {
        return c <= MAX_CONTROL;
    }

    /// Deep-copy data because modifying the original royally screws up Svelte.
    const _data = data.map(row => row.map(cell => cell));

    /// Determine max slide number. A table cell may contain a leading
    /// slide number as an ASCII control character. This is used to generate
    /// multiple slides for a table.
    let maxnum = 0;
    for (const row of _data) {
        if (row.length === 0) continue;

        /// If the first cell in a row contains \0, then the number
        /// after that is used for the entire row; if there is no
        /// number after that, auto-increment maxnum.
        const fst = row[0].charCodeAt(0); /// 1st char or NaN.
        const snd = row[0].charCodeAt(1); /// 2nd char or NaN.
        if (fst === 0) {
            if (isNaN(snd) || !IsControlChar(snd)) {
                maxnum++;
                row[0] = String.fromCharCode(0, maxnum) + row[0].slice(1);
            }
        } else {
            for (let i in row) {
                const num = row[i].length !== 0 ? row[i].charCodeAt(0) : 0;
                if (IsControlChar(num)) maxnum = Math.max(maxnum, num);
            }
        }

    }

    /// If maxnum is not 0, then we need to generate multiple slides. Create
    /// a copy of the table data for each slide, adding cells starting with
    /// \x01 to all slides starting at the second, cells starting with \x02 to
    /// all slides starting at the third, etc.
    let slides: string[][][] = [];
    for (let i = 0; i <= maxnum; i++) {
        slides.push([]);
        const slide = slides[i];
        for (const data_row of _data) {
            if (data_row.length === 0) continue;
            slide.push([]);
            const row = slide[slide.length - 1];

            /// If the first cell in the row starts with \0, then use number
            /// after it as the slide number for the rest of the row.
            const fst = data_row[0].charCodeAt(0); /// 1st char or NaN.
            const snd = data_row[0].charCodeAt(1); /// 2nd char or NaN.
            if (fst === 0) {
                /// Remove control chars and apply the same cell format
                /// to the rest of the row. If we get here, the second
                /// char must be a control char, because we just inserted
                /// it above.
                if (snd <= i) {
                    row.push(data_row[0].slice(2));
                    for (let j = 1; j < data_row.length; j++) row.push(data_row[j]);
                } else {
                    slide[slide.length - 1] = Array(data_row.length).fill(NBSP);
                }
            } else {
                for (const data_cell of data_row) {
                    const cell_index = data_cell.length !== 0 ? data_cell.charCodeAt(0) : NO_CONTROL;
                    if (cell_index > MAX_CONTROL) row.push(data_cell);
                    else if (cell_index <= i) row.push(data_cell.slice(1));
                    else row.push(NBSP);
                }
            }

        }
    }
</script>
{#each slides as slide}
    <CentrePage>
        <Table
                {classes}
                {title}
                {colnames}
                {rownames}
                data={slide}
                {bgcolour}
        />
    </CentrePage>
{/each}