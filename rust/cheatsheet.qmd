---
engine: markdown
---

# Cheatsheet for Rust

## Starting a new project

- Initialize the package (new folder, with a .gitignore, a cargo.toml and a src directory with a `.rs` file): `cargo new <project_name>`
- Create more files (an executable file in **target/debug/<project_name>.exe** and not in the current directory, a **cargo.lock** for dependencies: `cargo build`
- Convert any existing project to the cargo format: `cargo init`
- Compile your code: `rustc <project_name>.rs`
- Execute your code: `./<project_name>`
- Compile and exectute at the same time: `cargo run`
- Check if code compiles without actually compiling: `cargo check`
- Fix formatting to community standards: `rustfmt <project_name>.rs`

## Variables and functions

- Function syntax: `fn main() {}`
- Macro syntax: `fn main!() {}`
- Print a line: `println!()`
- Inizitialize variable: `let x = <something>`
- Inizitialize mutable variable: `let mut x = <something>`
