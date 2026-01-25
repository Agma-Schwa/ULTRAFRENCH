use std::borrow::Cow;
use dictgen::{BuiltinMacro, Node, Nodes, Part};
#[cfg(target_arch = "wasm32")] use wasm_minimal_protocol::*;
#[cfg(target_arch = "wasm32")] initiate_protocol!();

pub struct ULTRAFRENCHOps;

use BuiltinMacro::*;

impl dictgen::LanguageOps for ULTRAFRENCHOps {
    fn handle_unknown_macro(&self, macro_name: &str, args: Nodes) -> dictgen::Result<Node> {
        Ok(match macro_name {
            mutation @ ("L" | "N") => Node::builtin_with_args(Superscript, vec![Node::text(mutation)]),
            "pf" => {
                if !args.len() == 1 { return Err(format!("Macro \\pf expects 1 arg, got {}", args.len())); }
                Node::group(vec![
                    Node::builtin_with_args(SmallCaps, vec![Node::text("pf")]),
                    Node::text(" "),
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
}

#[cfg(target_arch = "wasm32")]
#[wasm_func]
pub fn generate_dictionary(contents: &[u8]) -> Result<Vec<u8>, String> {
    let ops = Box::new(ULTRAFRENCHOps {});
    let json = dictgen::parse_and_generate(
        ops,
        str::from_utf8(contents).map_err(|e| e.to_string())?,
        false,
        false,
    )?;
    Ok(json.into_bytes())
}
