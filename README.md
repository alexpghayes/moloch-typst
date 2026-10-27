# Moloch for Typst

A [Touying](https://touying-typ.github.io/) theme that ports the
[Moloch](https://github.com/jolars/moloch) Beamer theme (v2.3.1) by Johan
Larsson, itself a fork of Metropolis by Matthias Vogelgesang. Licensed
CC-BY-SA-4.0, like Moloch.

- `moloch.typ`: the theme
- `example.typ`: a deck to start from
- `example-light.pdf`, `example-dark.pdf`: compiled examples

```sh
typst compile example.typ                          # light
typst compile example.typ --input variant=dark     # dark
```

Touying 0.6.1 downloads on first compile.

## Usage

```typ
#import "moloch.typ": *
#show: moloch-theme.with(
  variant: "dark",            // light | dark
  color-theme: "tomorrow",    // default | tomorrow | paper | highcontrast
  config-info(title: [Title], author: [Me], date: datetime.today()),
)
#title-slide()
= Section        // makes a section slide
== Frame title   // makes a slide
```

| Option | Values (default first) |
| --- | --- |
| `variant` | `"light"`, `"dark"` |
| `color-theme` | `"default"`, `"tomorrow"`, `"paper"`, `"highcontrast"` |
| `colors` | overrides, e.g. `(alert: rgb("#c00"))`; keys in `moloch-palettes` |
| `progress-bar` | `"frametitle"`, `"head"`, `"foot"`, `"none"` |
| `progress-bar-height` | `1.86pt` |
| `section-page` | `"progressbar"`, `"simple"`, `"none"` |
| `block-style` | `"transparent"`, `"fill"` |
| `title-format` | `"regular"`, `"smallcaps"`, `"allsmallcaps"`, `"allcaps"` |
| `page-number` | `"plain"`, `"fraction"`, `"none"` |
| `footer`, `align`, `margin-x`, `text-size` | see doc comments |
| `font`, `mono-font`, `weight` | Fira Sans/Mono, light, with fallbacks |

Slide functions: `slide`, `title-slide`, `standout-slide(style: "alerted")`.
Blocks: `mblock`, `alert-block`, `example-block` (named `mblock` so Typst's
`block` isn't shadowed). Overlays (`#pause`, `#only`) are Touying's.

## Fidelity to Beamer

Rendered next to Moloch v2.3.1 (XeLaTeX, 16:9, same font), the 17 slides of the
example agree in light and dark: margins, bar heights, rule thicknesses, font
sizes, list indents, block spacing and colors. Beamer's units are scaled by
1.86 (a 160 mm Beamer page on Typst's 297 mm page), so Beamer's 11 pt text is
about 20 pt here and its 1 pt rules are 1.86 pt.

Known differences:

- Fonts: the demo uses Fira Sans, which Typst warns about if it isn't
  installed. Install Fira Sans/Mono, or pass `font:`. Smallcaps need a font
  that has them.
- Math uses Typst's default math font, not Fira Math.
- Nested list indents differ by a few points, since Typst's `list` has one
  indent value for all levels.
- The TOC spaces its entries at a fixed 4em, where Beamer stretches them over
  the frame.
- Not ported: the `catppuccin` color theme, the `plain` and `split` title
  pages, subsection pages, `background`, and `frametitle` margin options.
