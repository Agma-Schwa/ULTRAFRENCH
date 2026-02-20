use std::borrow::Cow;
use aho_corasick::{AhoCorasick, MatchKind};
use dictgen::{BuiltinMacro, Node, Nodes, Part};
#[cfg(target_arch = "wasm32")] use wasm_minimal_protocol::*;
#[cfg(target_arch = "wasm32")] initiate_protocol!();

pub struct ULTRAFRENCHOps;

use BuiltinMacro::*;
use lazy_static::lazy_static;
use unicode_normalization::UnicodeNormalization;

const VOICELESS_BELOW: char = '̥';

static PATTERNS: &[&str] = &[
    "'", "’", "`", "-",
    "á", "â", "é", "ê", "í", "î", "ó", "ô", "ú", "û", "ý", "ŷ",
    "ẹ́", "ệ", "ẹ",
    "à", "è", "ì", "ò", "ù", "ỳ",
    "a",
    "au", "aú", "aû", "ü",
    "y’", "ý’",
    "ḅ", "bh", "b’h", "b'h",
    "c", "ć", "c̣", "c’h", "c'h",
    "ḍ", "d’h", "d'h",
    "f",
    "h",
    "j", "ȷ", "j́", "ȷ́", // Dotted *and* dotless j w/ acute.
    "l", "ll", "lll", "ḷ", "ḷḷ", "ḷḷḷ", "ł", "łł", "łłł",
    "r", "rr",
    "s", "ś", "ss", "śś", "s’h", "s'h", "ṣ’h", "ṣ'h",
    "t’h", "t'h",
    "v", "vv", "v́", "v́v́",
    "w",
    "z", "ź",
];

static REPLACEMENTS: &[&str] = &[
    "", "", "", "",
    "ɑ̃", "ɑ̃̃", "ɛ̃", "ɛ̃̃", "ĩ", "ĩ̃", "ɔ̃", "ɔ̃̃", "ũ", "ũ̃", "ʏ̃", "ʏ̃̃",
    "ẽ", "ẽ̃", "ə",
    "ɐ̥", "ɛ", "i̥", "o̥", "u̥", "ẙ",
    "ɐ",
    "o", "ɔ̃", "ɔ̃̃", "u",
    "ɥ", "ɥ̃",
    "b", "bʱ", "β", "β",
    "ɕ", "ɕʶ", "ȷ̊", "x", "x",
    "d", "ð", "ð",
    "ɸ",
    "h",
    "ʑ", "ʑ", "ʑʶ", "ʑʶ",
    "ɮ̃", "ɮ̃ː", "ɮ̃ːː", "ʎ̝̃", "ʎ̝̃ː", "ʎ̝̃ːː", "ɮ̃ʶ", "ɮ̃ʶː", "ɮ̃ʶːː",
    "ɰ", "ʀ",
    "s", "sʶ", "sː", "sʶː", "ʃ", "ʃ", "ʃ", "ʃ",
    "θ", "θ",
    "ʋ̃", "ʋ̃ː", "βʶ", "βʶː",
    "ɰ̃",
    "z", "zʶ",
];

lazy_static! {
    static ref IPA_TRIE: AhoCorasick = AhoCorasick::builder()
        .match_kind(MatchKind::LeftmostLongest)
        .build(&PATTERNS.iter().map(|s|s.nfc().to_string()).collect::<Vec<_>>())
        .unwrap();
}

impl dictgen::LanguageOps for ULTRAFRENCHOps {
    fn handle_unknown_macro(&self, macro_name: &str, args: Nodes) -> dictgen::Result<Node> {
        Ok(match macro_name {
            mutation @ ("L" | "N") => Node::builtin_with_args(Superscript, vec![Node::text(mutation)]),
            "pf" => {
                if !args.len() == 1 { return Err(format!("Macro \\pf expects 1 arg, got {}", args.len())); }
                Node::group(vec![
                    Node::builtin_with_args(SmallCaps, vec![Node::text("pf")]),
                    Node::text("\u{00A0}"), // Non-breaking space.
                    Node::builtin_with_args(Italic, args),
                ])
            }
            _ => return Err(format!("Unknown macro '\\{}'", macro_name)),
        })
    }

    fn preprocess_full_entry(&self, entry: &mut [Cow<'_, str>]) -> dictgen::Result<()> {
        // Warn about non-typographic quotes, after comment deletion
        // because it’s technically fine to have them in comments.
        if entry.iter().any(|p|p.contains('\'')) {
            return Err("Non-typographic quote! Please use ‘’ (and “” for nested quotes) instead!".to_string());
        }

        // If this is a single word, and the field contains no backslashes,
        // wrap it with '\pf{}'. That takes care of this field for most words
        // (conversely, more complex etymologies often don’t start w/ a PF word).
        // Etymology is empty; don’t do anything here.
        let part = &mut entry[Part::Etym as usize];
        if !part.is_empty() && !part.contains(&[' ', '\\']) {
            *part.to_mut() = format!("\\pf{{{}}}", part);
        }

        Ok(())
    }

    fn to_ipa(&self, text: &str) -> dictgen::Result<Option<Node>> {
        const { assert!(PATTERNS.len() == REPLACEMENTS.len()); }

        // Treat whitespace and most punctuation marks as word separators. We need
        // to split the input into words to mark word-final schwa as voiceless.
        let mut s = String::new();
        for part in text.to_lowercase().nfc().collect::<String>().split(&[
            '.', ',', ':', ';', '–', '—', '!', '?',
            '«', '‹', '»', '›',
            '/', '\\', '(', ')', '[', ']',
            ' ', '\t', '\n', '\r', '|',
            '₁', '₂', '₃', '₄', '₅'
        ]) {
            let part = part.trim();
            if part.is_empty() { continue }
            if part.contains(&['g', 'm', 'k', 'p', 'q', 'x']) { return Err(format!("Word '{}' contains invalid character", part)); }
            if !s.is_empty() {
                if s.ends_with('ə') { s.push(VOICELESS_BELOW) }
                s.push(' ');
            }
        }

        if s.ends_with('ə') { s.push(VOICELESS_BELOW) }
        Ok(Some(Node::text(s)))
    }
}

#[cfg(target_arch = "wasm32")]
#[wasm_func]
pub fn generate_dictionary(contents: &[u8]) -> Result<Vec<u8>, String> {
    let ops = Box::new(ULTRAFRENCHOps {});
    let json = dictgen::parse_and_generate(
        ops,
        str::from_utf8(contents).map_err(|e| e.to_string())?,
        Default::default(),
    )?;
    Ok(json.into_bytes())
}
