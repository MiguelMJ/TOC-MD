<h2 align=center>TOC-MD - Table of Contents for Markdown</h1>

**Contents**

<span id="toc"></span>

- [Description ](#Description-6)
  - [Usage](#Usage10)
  - [Features](#Features22)
  - [Bugs](#Bugs45)
- [Build](#Build51)
- [To Do](#To-Do61)
  - [License](#License75)

<h1 id="Description-6">Description <small><a href="#toc">  [TOC]</a></small></h1> 

**TOC-MD** generates tables of contents for Markdown files. It's been tested successfully in GitHub READMEs and dev.to posts.

<h2 id="Usage10">Usage</h2> 

This basic program takes a single argument with the path of the file to process and print the result to the standard output. To store it in a file, you must redirect it.

This `README.md`, for example, had its table of contents generated with `tocgen`

```shell
$ ./tocgen README.in > README.md
```

Passing more or none arguments will print a usage message.

<h2 id="Features22">Features</h2> 

- A single line containing the label `<toc>` will be replaced by the actual Table of Contents of the file.

- All first level headers (h1) will include a link to the Table of Contents.

- It only takes into account the markdown headers made with `#`, so to make a section invisible you can use `===` or html tags.

  ```markdown
  # Section one
  This one is shown.
  
  Section two
  ===
  This one is hidden.
  
  <h1>Section three</h1>
  
  This one too.
  ```

  

<h2 id="Bugs45">Bugs</h2> 

- If the `<toc>` label is surrounded by any white spaces, it won't be replaced.

- If the file doesn't end in a newline, the program will go on an infinite loop.

<h1 id="Build51">Build<small><a href="#toc">  [TOC]</a></small></h1> 

To build TOC-MD you need SWI-Prolog in your computer. The compilation using the provided Makefile is pretty straightforward.

```shell
$ make
```

This creates the `tocgen` executable in the root of the project.

<h1 id="To-Do61">To Do<small><a href="#toc">  [TOC]</a></small></h1> 

This is version is somewhat _rudimentary_, to say the least. There are a lot of things yet to be done:

- [ ] Correct the [bugs](#bugs).
- [ ] Section specific TOC.
- [x] Invisible sections.
- [ ] ~~TOC depth specified in the label~~.
- [ ] Add flexibility via cli options or toc xml-like fields, like.
  - [ ] TOC depth.
  - [ ] Levels where the TOC link should be included.
- [x] Reinterpret levels.
  - For example, If you don't use level 2 but directly level 3, don't subscribe the bullets to an inexistent second level.

<h2 id="License75">License</h2> 

This software uses the Unlicense.
