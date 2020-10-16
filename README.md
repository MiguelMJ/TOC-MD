<h2 align=center>TOC-MD - Table of Contents for Markdown</h1>

**Contents**

  - [Description ](#Description-)
  - [Usage](#Usage)
    - [Features](#Features)
    - [Bugs](#Bugs)
  - [Build](#Build)
  - [To Do](#To-Do)


## Description 

**TOC-MD** generates tables of contents for Markdown files.

## Usage

This basic program takes a single argument with the path of the file to process and print the result to the standard output. To store it in a file, you must redirect it.

This `README.md`, for example, had its table of contents generated with `tocgen`

```shell
$ ./tocgen README.in > README.md
```

Passing more or none arguments will print a usage message.

### Features

- A single line containing the label `<toc>` will be replaced by the actual Table of Contents of the file.

### Bugs

1. If the `<toc>` label is surrounded by any white spaces, it won't be replaced.
2. If the file doesn't end in a newline, the program will go on an infinite loop.

## Build

To build TOC-MD you need SWI-Prolog in your computer. The compilation using the provided Makefile is pretty straightforward.

```shell
$ make
```

This creates the `tocgen` executable in the root of the project.

## To Do

This is version is somewhat _rudimentary_, to say the least. There are a lot of things yet to be done:

- Correct the [bugs](#bugs).

- Section TOC.
- Invisible sections.
- TOC depth specified in the label.
- Reinterpret levels.
  - For example, If you don't use level 2 but directly level 3, don't subscribe the bullets to an inexistent second level.