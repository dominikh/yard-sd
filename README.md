# yard-sd

## Description

yard-sd allows embedding sequence diagrams directly in docstrings and
files. During documentation generation, it replaces the text
description with images.

## Requirements

yard-sd needs the following binaries:

- pdflatex
- convert (from the ImageMagick suite)
- gs (Ghostscript, needed by convert)

## Installation

$ gem install yard-sd

## Usage

yard-sd defines a new language for code blocks called "sd". Like other
languages, it can be used with the tripple-bang syntax (!!!LANG).

## Example

### Input

    !!!plain
    !!!sd
    % size = 400

    thread Alice
    participant[2] Bob
    participant[2] Eve

    Alice -> Bob: Some message
    Bob   -> Eve: Another message
    Eve  --> Bob: Return value
    noreturn

### Output

(Note: If you're viewing this on Github or any other service that
doesn't support yard-sd, check out the result at TODO link)

    !!!sd
    %size = 400

    thread Alice
    participant[2] Bob
    participant[2] Eve

    Alice -> Bob: Some message
    Bob   -> Eve: Another message
    Eve  --> Bob: Return value
    noreturn

## The format

A sequence diagram consists of two parts: the metadata (currently only
the size) and the actual description of the diagram's content

### Metadata

The only currently supported and required metadata is the size of the
diagram. You can either specify only a width (e.g. `500`), only a
height (e.g. `x500`) or both (e.g. `500x500`). In most cases it makes
sense to specify only one of the dimensions so the aspect ratio can be
kept.

### Content

The content itself can also be separated into two parts: The list of
threads/participants (simply called participants from now on) and the
messages between those.

#### Participants

In their most basic form, they consist of a type (`thread` or
`participant`) and a name.

Example:

    !!!!plain
    thread Alice
    participant Bob

It is also possible to specify the distance to the previous
participant by adding a number in square brackets. The default is `0`,
so `1` will double the distance, `2` will triple it and so on.

Example:

    !!!plain
    thread Alice
    participant[1] Bob

Finally, it is also possible to assign aliases to avoid typing out
long names over and over again.

Example:

    !!!plain
    participant "Alice, the wonderful girl" as Alice
    participant Bob

    Alice -> Bob: Yey

#### Messages

The second part of description of the sequende diagram consists of
messages between participants. Messages are denoted by an arrow and
text (`p1 -> p2: The message`) while return values are denoted by a
dashed arrow and also text (`p2 --> p1: The return value`). If a
message has no return value, a `noreturn` has to be placed after the
execution finished.

Example:

    !!!plain
    Alice -> Bob: Some message
    Bob   -> Eve: Another message
    Eve  --> Bob: Return value
    noreturn

#### Blocks

Furthermore, it is possible to group messages into blocks, for example
for representing loops:

Example:

    !!!plain
    block "Name" "Description"
      Alice -> Bob:
      Bob --> Alice:

      block "Another name" "Nested blocks, yey"
        Alice -> Bob:
        noreturn

    Alice -> Bob:
    Bob --> Alice:

Blocks automatically get closed, based on the indentation level.

### More information

For a more advanced example, see {file:Example.md Example.md}.

