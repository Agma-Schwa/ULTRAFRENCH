<script lang="ts">
    export let v: string;
    export let classes = '';

    /// Syntax of text:
    ///
    /// $r = red
    /// $u = blue (MTG moment, I know)
    /// $g = green
    /// $y = yellow
    /// $v = purple
    /// $n = navy (blue)
    /// $o = orange
    /// $a = active ($r + $s)
    /// $p = passive ($u + $s)
    /// $b = bold
    /// $i = italic
    /// $s = small-caps
    /// q = Close span.
    /// <$X...> = $X applied to ... only.
    /// $1-$9 = font size 1-9
    let output_text = '';
    let spans_to_close = 0;
    let groups: number[] = [];
    for (let i = 0; i < v.length; i++) {
        switch (v[i]) {
/*            case 'q':
                if (spans_to_close) {
                    output_text += '</span>';
                    spans_to_close--;
                }
                break;*/

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

                output_text += '<span class="';
                switch (v[++i]) {
                    case 'r':
                        output_text += 'red';
                        break;

                    case 'u':
                        output_text += 'blue';
                        break;

                    case 'g':
                        output_text += 'green';
                        break;

                    case 'y':
                        output_text += 'yellow';
                        break;

                    case 'v':
                        output_text += 'purple';
                        break;

                    case 'o':
                        output_text += 'orange';
                        break;

                    case 'n':
                        output_text += 'navy';
                        break;

                    case 'b':
                        output_text += 'bold';
                        break;

                    case 'i':
                        output_text += 'italic';
                        break;

                    case 's':
                        output_text += 'small-caps';
                        break;

                    case 'a':
                        output_text += 'red small-caps';
                        break;

                    case 'p':
                        output_text += 'blue small-caps';
                        break;

                    case '1':
                    case '2':
                    case '3':
                    case '4':
                    case '5':
                    case '6':
                    case '7':
                    case '8':
                    case '9':
                        output_text += `font${v[i]}`;
                        break;

                    default:
                        output_text += `$${v[i]}`;
                        break;
                }

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

<p class={classes}>{@html output_text}</p>