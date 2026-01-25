use std::fs::read_to_string;
use plugin::ULTRAFRENCHOps;
use clap::Parser;

#[derive(Parser)]
struct Args {
    /// File to process.
    #[arg()] file: String,

    /// Whether to minify the JSON output.
    #[arg(long, default_value_t = false)] minify: bool,
}

pub fn main() {
    let args = Args::parse();
    let ops = Box::new(ULTRAFRENCHOps {});
    let text = read_to_string(args.file).unwrap();
    let json = dictgen::parse_and_generate(
        ops,
        &text,
        true,
        !args.minify
    ).unwrap();
    println!("{}", json);
}
