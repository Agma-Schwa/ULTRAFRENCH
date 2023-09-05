<script lang='ts'>
    import {TextFormat} from '$lib/text';

    export let v: string;
    export let classes = '';
    export let style = '';

    /// See text.ts for a list of text format specifiers.
    let output_text = '';
    let closing_tags: string[] = [];
    let groups: number[] = [];
    for (let i = 0; i < v.length; i++) {
        switch (v[i]) {
            case '<':
                groups.push(closing_tags.length);
                break;

            case '>':
                const last = groups.pop();
                if (last !== undefined)
                    while (closing_tags.length > last)
                        output_text += closing_tags.pop() as string;
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

                /// Also handle extended specifiers that require HTML.
                switch (v[i + 1]) {
                    case 'U':
                        output_text += '<sup>';
                        closing_tags.push('</sup>');
                        i++;
                        break;

                    default:
                        output_text += '<span class="';
                        output_text += TextFormat.ActOnFormatSpecifier(v[++i], true);
                        output_text += '">';
                        closing_tags.push('</span>');
                        break;
                }

                break;

            default:
                output_text += v[i];
                break;
        }
    }

    while (closing_tags.length) output_text += closing_tags.pop() as string;
</script>

<p class={classes} {style}>{@html output_text}</p>