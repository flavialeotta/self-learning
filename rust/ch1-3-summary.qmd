---
title: "Rust Chapters 1-3"
engine: markdown
---

# Rust Programming Language: Chapters 1 to 3

To open the book even offline, run this command:

```{rust}
rustup doc --book
```

With Rust come some interesting tools:

-	Cargo: a dependency manager and build tool;
-	rustfmt formatting tool to have a consistent coding style;
-	The Rust Language Server powers IDE: inline error messages.

## Table of Contents.
- [Rust Programming Language: Chapters 1 to 3](#rust-programming-language-chapters-1-to-3)
  - [Table of Contents.](#table-of-contents)
  - [i.	Chapter 1: Rust essentials and Cargo](#ichapter-1-rust-essentials-and-cargo)
    - [Hello World](#hello-world)
  - [ii. Chapter 2](#ii-chapter-2)
  - [iii. Chapter 3: Common Programming Concepts](#iii-chapter-3-common-programming-concepts)
    - [Variables](#variables)
    - [Constants and constant evaluation](#constants-and-constant-evaluation)

## i.	Chapter 1: Rust essentials and Cargo

Chapter 1 explains how to install Rust, how to write a “Hello, world!” program, and how to use 
Cargo, Rust’s package manager and build tool. 

> **TOOL: rustup**. The command-line tool for managing the version of Rust on your machine is rustup. You can 
access the documentation by running `rustup doc`.

### Hello World

To write the Hello World function we do like this:

```{rust}
fn main() {
    println!("Hello, world!");
}
```

The main() function is the first code that runs in every Rust program. Then we have to compile it. 
I had a problem with doing that, and I solved it by following a [stackoverflow thread](https://stackoverflow.com/questions/55603111/unable-to-compile-rust-hello-world-on-windows-linker-link-exe-not-found).

```{rust}
rustup toolchain install stable-x86_64-pc-windows-gnu
rustup default stable-x86_64-pc-windows-gnu
rustc main.rs
./main
```

Like in C++ we first need to compile the program (hence rustc main.rs): compiling means to generate 
a binary executable, which you can later execute. Interestingly enough, if you give somebody else the 
result file (main.exe) they don’t need to have Rust installed to be able to run it! An important part 
of this code is that `println!` calls a **Rust macro**. If it had called a function instead, it would 
be entered as `println` (without the !). **Rust macros** are a way to write code that generates code 
to extend Rust syntax, and it’s a topic from Chapter 20. Macros don’t always follow the same rules as 
functions. Additionally, like in C++, most lines of Rust code end with a semicolon (;).

> **TOOL: rustftm**: To stick to a certain formatting standard, you can run `rustfmt main.rs`: it will
> rewrite the program with the correct spaces and all those practices to standardize code.

> **TOOL: cargo**: Cargo is Rust’s build system and package manager.

If youy do:

```{rust}
cargo new hello_cargo
```

Cargo will create a new folder, complete with a .gitignore, a cargo.toml and a src directory:
-	The **cargo.toml** file is written in TOML (Tom’s Obvious, Minimal Language): the first line,
  [package], indicates that the following statements are configuring a package. Then the name,
 	the version, and the edition of Rust to use. The last line, [dependencies], is the start of
 	the project’s dependencies. In Rust, packages of code are referred to as **crates**. 
-	In src/main.rs there is already an Hello World! Program (it is generated automatically). You
  can convert any project to the Cargo format by moving the code into a src directory and create
 	a toml file by running `cargo init`.

With the following command we can create more files:

```{rust}
cargo build
```

-	an executable file in **target/debug/hello_cargo.exe** and not in the current directory
  (different from rustc main.rs which creates executables in the same directory as the source
 	code);
-	a **cargo.lock** file that keeps track of dependencies (it updates automatically).

If you want to compile the code and run the executable all in one command, you can simply do 
`cargo run`, and it will not rebuild the executable file if the source code hasn’t changed, so 
it is pretty convenient! And if you just want to check if the code compiles and you don’t want 
to build an executable, you can do `cargo check` (faster than cargo build because it skips the 
building of an executable). Once ready to finalise the project, you can run `cargo build --release`.
This can compile code with optimizations (although slow to compile), and the executable will be 
in **target/release/hello_cargo.exe**.

| Command       | Creates Directories? | Compiles? | Builds exectutable? | Runs executable? |
| ------------- | -------------------- | --------- | ------------------- | ---------------- |
| rustc main.rs | No                   | Yes       | Yes                 | No               |
| ./main        | No                   | No        | No                  | Yes              |
| cargo new     | Yes                  | No        | No                  | No               |
| cargo init    | No?                  | No        | No                  | No               |
| cargo build   | Yes                  | Yes       | Yes                 | No               |
| cargo run     | No                   | Yes       | Yes (optional)      | Yes              |
| cargo check   | No                   | Yes       | No                  | No               |

## ii. Chapter 2

Chapter 2 is a hands-on introduction to writing a program in Rust, having you build up a 
number-guessing game. Here, we cover concepts at a high level, and later chapters will provide 
additional detail.

## iii. Chapter 3: Common Programming Concepts

Although this chapter comes after 2, I decided to read it first because it will talk about 
concepts that are similar and different from Rust to other Programming languages.

### Variables 

Variables are immutable by default, although you can choose to make them mutable 
(not recommended). When a variable is immutable, its value cannot be changed: if you want a 
variable to be mutable you have to clearly state so.

```{rust}
fn main() {
  let mut x = 5;	// This will create a mutable variable
  let y = 6;  	  // This will create an immutable variable
}
```

### Constants and constant evaluation

Mostly used for values that are purposely hardcoded. They are also bound to a name but not
allowed to change, but with a few differences: you cannot add mut, and you have to declare 
the type of the value. They can be declared in the global scope and they can be set as a 
constant expression but not as a result of a value that can only be computed at runtime 
(sometimes it is preferred to store values as an operation that an human can verify more 
easily and faster) but remember that only a set of all expressions can be evaluated at 
compile-time (“constant evaluation” is limited).







