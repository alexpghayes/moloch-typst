// Example Moloch deck. Compile with `typst compile example.typ`, or
// `typst compile example.typ --input variant=dark` for the dark variant.
#import "moloch.typ": *

#let variant = sys.inputs.at("variant", default: "light")

#show: moloch-theme.with(
  variant: variant,
  // color-theme: "tomorrow",      // default | tomorrow | paper | highcontrast
  // progress-bar: "frametitle",   // frametitle | head | foot | none
  // block-style: "fill",          // transparent | fill
  // title-format: "smallcaps",    // regular | smallcaps | allsmallcaps | allcaps
  // colors: (alert: rgb("#cc0000")),
  config-info(
    title: [Moloch],
    subtitle: [A minimal Typst slide theme],
    author: [Your Name],
    date: datetime.today(),
    institution: [Your Institution, Your University],
  ),
)

#title-slide()

== Table of Contents

#outline(title: none, depth: 1)

= Introduction

== Moloch

The Moloch theme has minimal visual noise. It is a Typst port of the Moloch
Beamer theme, which is a fork of the Metropolis theme by Matthias Vogelgesang.

Enable the theme with

```typ
#import "moloch.typ": *
#show: moloch-theme.with(
  config-info(title: [Title], author: [Author]),
)
```

== Sections

Each level-1 heading (`= Section`) inserts a section slide. Its progress bar
shows how far along the talk is, and the thin bar under every frame title does
the same.

= Elements

== Typography

The theme provides sensible defaults to _emphasize_ text, #alert[accent] parts
or show *bold* results.

- Regular, _italic_, *bold* and `monospace`
- Lists use a circle, a square and a triangle:
  - Second level
    - Third level
+ Enumerations are numbered
+ Like this

== Blocks

#mblock[A plain block][
  Blocks are transparent by default: a bold title and the body, nothing more.
]

#alert-block[An alert block][
  Use it for warnings or important results.
]

#example-block[An example block][
  Use it for worked examples.
]

== Columns

#slide(composer: (1fr, 1fr))[
  === Left

  - Pass a `composer` to split a slide
  - Widths are free, e.g. `(2fr, 1fr)`
][
  === Right

  Each argument in brackets becomes one column.
]

== Math

Euler's identity, $e^(i pi) + 1 = 0$, and the Gaussian integral

$ integral_(-infinity)^infinity e^(-x^2) dif x = sqrt(pi) $

== Tables and figures

#figure(
  table(
    columns: 3,
    align: (left, right, right),
    table.hline(stroke: 1.5pt),
    table.header[*Method*][*Error*][*Time (s)*],
    table.hline(stroke: 0.9pt),
    [Baseline], [0.31], [1.2],
    [Proposed], [0.18], [1.9],
    table.hline(stroke: 1.5pt),
  ),
  caption: [Rules are in the booktabs style.],
)

== Overlays

Touying's incremental reveals work as usual.

- First point
#pause
- Second point, shown after one click
#pause
- Third point

= Conclusion

== Summary

- Moloch is minimal, with a title bar, a progress bar and little else
- Colors come from the Beamer theme, in light and dark variants
- Edit `example.typ` to start your own talk

#standout-slide[Thank you!]
