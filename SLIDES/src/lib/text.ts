/// Parses a format specifier list and returns a list of classes
/// to be applied to get the desired format. Unexpected characters
/// are ignored.
namespace TextFormat {
    export function ParseTextFormat(format: string): string {
        let classes = '';
        for (let i = 0; i < format.length; i++) {
            if (format[i] != '$') continue;
            classes += ActOnFormatSpecifier(format[++i], false);
        }
        return classes;
    }

    export function ActOnFormatSpecifier(spec: string, escape_invalid: boolean): string {
        switch (spec) { /// @formatter:off
            default: return escape_invalid ? '$${spec}' : '';
            case 'r': return 'red';
            case 'u': return 'blue';
            case 'g': return 'green';
            case 'y': return 'yellow';
            case 'v': return 'purple';
            case 'o': return 'orange';
            case 'n': return 'navy';
            case 'b': return 'bold';
            case 'i': return 'italic';
            case 's': return 'small-caps';
            case 'a': return 'red small-caps';
            case 'p': return 'blue small-caps'
            /// @formatter:on

            case '1':
            case '2':
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                return `font${spec}`;

        }
    }
}

export {TextFormat};