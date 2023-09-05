<script lang='ts'>
    import {TextFormat} from '$lib/text';

    export let v: string;
    export let classes = '';
    export let style = '';

    /// See text.ts for a list of text format specifiers.
    let output_text = '';
    let spans_to_close = 0;
    let groups: number[] = [];
    for (let i = 0; i < v.length; i++) {
        switch (v[i]) {
            case '<':
                groups.push(spans_to_close);
                break;

            case '>':
                const last = groups.pop();
                if (last !== undefined) {
                    while (spans_to_close > last) {
                        output_text += '</span>';
                        spans_to_close--;
                    }
                }
                break;

            case '$':
                if (i == v.length - 1) {
                    output_text += '$';
                    break;
                }

                if (v[i + 1] == ' ') {
                    output_text += '&nbsp;';
                    i++;
                    break;
                }

                output_text += '<span class="';
                output_text += TextFormat.ActOnFormatSpecifier(v[++i], true);
                output_text += '">';
                spans_to_close++;
                break;

            default:
                output_text += v[i];
                break;
        }
    }

    while (spans_to_close) {
        output_text += '</span>';
        spans_to_close--;
    }
</script>

<p class={classes} {style}>{@html output_text}</p>