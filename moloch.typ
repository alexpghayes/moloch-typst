// Moloch: a minimalist Touying theme.
//
// A Typst port of the Moloch Beamer theme by Johan Larsson and contributors
// (https://github.com/jolars/moloch, CC-BY-SA-4.0), itself a fork of
// Metropolis by Matthias Vogelgesang (https://github.com/matze/mtheme).
// Colors, proportions and templates follow the Beamer source (v2.3.1).
// This port is distributed under the same license, CC-BY-SA-4.0.
//
// Usage:
//
//   #import "moloch.typ": *
//   #show: moloch-theme.with(
//     config-info(title: [Title], author: [Author]),
//   )
//   #title-slide()
//   = Section
//   == Frame title
//   Content.

#import "@preview/touying:0.6.1": *

// ---------------------------------------------------------------------------
// Colors
// ---------------------------------------------------------------------------

// xcolor mixes in RGB; Typst defaults to Oklab, which gives visibly different tints.
#let _mix(..colors) = color.mix(..colors, space: rgb)

// `pct` of `c`, the rest white (xcolor's `c!pct`).
#let _tint(c, pct) = _mix((c, pct), (white, 100% - pct))
// `pct` of `c` mixed with black, the rest white (xcolor's `c!50!black!pct`).
#let _dim(c, pct) = _tint(_mix((c, 50%), (black, 50%)), pct)

#let _palette(
  fg,
  bg,
  alert,
  example,
  frametitle-fg,
  frametitle-bg,
  progress-fg,
  progress-bg,
  separator,
  standout-fg,
  standout-bg,
  standout-alerted-fg,
  standout-alerted-bg,
  standout-example-fg,
  standout-example-bg,
  footnote,
) = (
  normal-fg: fg,
  normal-bg: bg,
  alert: alert,
  example: example,
  frametitle-fg: frametitle-fg,
  frametitle-bg: frametitle-bg,
  progress-fg: progress-fg,
  progress-bg: progress-bg,
  separator: separator,
  standout-fg: standout-fg,
  standout-bg: standout-bg,
  standout-alerted-fg: standout-alerted-fg,
  standout-alerted-bg: standout-alerted-bg,
  standout-example-fg: standout-example-fg,
  standout-example-bg: standout-example-bg,
  footnote: footnote,
)

#let _default-light = {
  let fg = rgb("#23373b")
  let bg = _tint(black, 2%)
  let alert = rgb("#EB811B")
  _palette(
    fg, bg, alert, rgb(0, 128, 128),
    bg, fg,
    alert, _dim(alert, 30%), alert,
    bg, fg,
    rgb("#F7F0EA"), rgb("#9E3D12"),
    rgb("#EAF4F3"), rgb("#0E4D4F"),
    _tint(fg, 90%),
  )
}

#let _default-dark = {
  let fg = _tint(black, 2%)
  let bg = rgb("#23373b")
  let alert = rgb("#EF9F76")
  _palette(
    fg, bg, alert, rgb("#5ABFB5"),
    bg, _tint(black, 15%),
    alert, _dim(alert, 30%), alert,
    bg, _tint(black, 15%),
    rgb("#23373B"), rgb("#F3C4A0"),
    rgb("#23373B"), rgb("#BFE6E2"),
    _tint(fg, 90%),
  )
}

#let _tomorrow-light = {
  let progress = rgb("#8959a8")
  _palette(
    rgb("#1d1f21"), white, rgb("#cc6666"), rgb("#4271ae"),
    white, rgb("#1d1f21"),
    progress, _dim(progress, 30%), progress,
    white, rgb("#1d1f21"),
    white, rgb("#A63D3D"),
    white, rgb("#2E5578"),
    rgb("#1d1f21"),
  )
}

#let _tomorrow-dark = {
  let progress = rgb("#b294bb")
  _palette(
    white, rgb("#282a2e"), rgb("#de935f"), rgb("#7aa6da"),
    white, rgb("#1d1f21"),
    progress, _dim(progress, 30%), progress,
    white, rgb("#1d1f21"),
    rgb("#1D1F21"), rgb("#CC6666"),
    rgb("#1D1F21"), rgb("#81A2BE"),
    rgb("#1d1f21"),
  )
}

#let _paper-light = _palette(
  black, white, rgb("#E5276F"), rgb("#265DAB"),
  black, white,
  rgb("#60BD68"), _tint(black, 20%), rgb("#F15854"),
  white, _tint(black, 60%),
  white, rgb("#B01E58"),
  white, rgb("#1E4C8A"),
  _tint(black, 90%),
)

#let _paper-dark = _palette(
  white, _tint(black, 80%), rgb("#F17CB0"), rgb("#88BDE6"),
  white, _tint(black, 80%),
  rgb("#90CD97"), _tint(black, 70%), rgb("#F15854"),
  white, _tint(black, 60%),
  white, rgb("#E5276F"),
  white, rgb("#265DAB"),
  _tint(black, 90%),
)

#let _highcontrast-light = {
  let alert = rgb("#C66526")
  _palette(
    black, white, alert, rgb("#3070AD"),
    white, black,
    alert, _dim(alert, 30%), alert,
    black, white,
    white, rgb("#AD003D"),
    white, rgb("#005580"),
    _tint(black, 90%),
  )
}

#let _highcontrast-dark = {
  let alert = rgb("#DCA237")
  _palette(
    white, black, alert, rgb("#6FB2E4"),
    black, white,
    alert, _dim(alert, 70%), alert,
    white, black,
    white, rgb("#AD003D"),
    white, rgb("#005580"),
    _tint(white, 90%),
  )
}

/// The color themes of Moloch, as `(theme: (light: (..), dark: (..)))`.
/// Every palette has the keys `normal-fg`, `normal-bg`, `alert`, `example`,
/// `frametitle-fg`, `frametitle-bg`, `progress-fg`, `progress-bg`,
/// `separator`, `standout-{fg,bg}`, `standout-{alerted,example}-{fg,bg}`
/// and `footnote`.
#let moloch-palettes = (
  default: (light: _default-light, dark: _default-dark),
  tomorrow: (light: _tomorrow-light, dark: _tomorrow-dark),
  paper: (light: _paper-light, dark: _paper-dark),
  highcontrast: (light: _highcontrast-light, dark: _highcontrast-dark),
)

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

// Moloch's `titleformat` options: regular, smallcaps, allsmallcaps, allcaps.
#let _format(fmt, body) = {
  if fmt == "smallcaps" {
    smallcaps(body)
  } else if fmt == "allsmallcaps" {
    smallcaps(lower(body))
  } else if fmt == "allcaps" {
    upper(body)
  } else {
    body
  }
}

#let _bar(self, height) = components.progress-bar(
  height: height,
  self.colors.progress-fg,
  self.colors.progress-bg,
)

#let _page-number(self) = context {
  let n = utils.slide-counter.display()
  if self.store.page-number == "fraction" {
    [#n / #utils.last-slide-number]
  } else if self.store.page-number == "none" {
    none
  } else {
    n
  }
}

// ---------------------------------------------------------------------------
// Slides
// ---------------------------------------------------------------------------

/// Default slide. The frame title is the current level-2 heading unless
/// `title` is given; `title: none` hides the title bar.
///
/// - title (content, auto, none): The frame title.
/// - align (alignment, auto): Vertical alignment of the body.
/// - config (dictionary): Per-slide Touying configuration.
/// - repeat (int, auto): Number of subslides.
/// - setting (function): Extra set/show rules for the slide.
/// - composer (function, array, int): Layout of the bodies, e.g. `(1fr, 1fr)`.
#let slide(
  title: auto,
  align: auto,
  config: (:),
  repeat: auto,
  setting: body => body,
  composer: auto,
  ..bodies,
) = touying-slide-wrapper(self => {
  if align != auto {
    self.store.align = align
  }
  let st = self.store
  let colors = self.colors

  let header(self) = {
    set std.align(top)
    if st.progress-bar == "head" {
      _bar(self, st.progress-bar-height)
    }
    block(
      width: 100%,
      fill: colors.frametitle-bg,
      inset: (x: 0.75em, y: 0.94em),
      spacing: 0pt,
      {
        set text(fill: colors.frametitle-fg, size: 1.09em, weight: "bold")
        let fit = body => utils.fit-to-width(grow: false, 100%, _format(st.title-format, body))
        if title == auto {
          utils.display-current-heading(setting: fit, depth: self.slide-level)
        } else {
          fit(title)
        }
      },
    )
    if st.progress-bar == "frametitle" {
      _bar(self, st.progress-bar-height)
    }
  }

  let footer(self) = {
    set std.align(bottom)
    set text(size: 0.55em, fill: colors.normal-fg)
    pad(
      left: 0.36em,
      right: 0.46em,
      bottom: 0.7em,
      components.left-and-right(
        utils.call-or-display(self, st.footer),
        _page-number(self),
      ),
    )
    if st.progress-bar == "foot" {
      place(bottom, _bar(self, st.progress-bar-height))
    }
  }

  let page-config = if title == none {
    config-page(
      fill: colors.normal-bg,
      header: none,
      margin: (top: 1.5em),
      footer: footer,
    )
  } else {
    config-page(fill: colors.normal-bg, header: header, footer: footer)
  }
  let self = utils.merge-dicts(self, page-config)

  let new-setting = body => {
    show: std.align.with(self.store.align)
    set text(fill: colors.normal-fg)
    show: pad.with(x: st.margin-x)
    show: setting
    body
  }
  touying-slide(self: self, config: config, repeat: repeat, setting: new-setting, composer: composer, ..bodies)
})

/// Title slide, left-aligned with a rule below the title. Uses the fields of
/// `config-info` (`title`, `subtitle`, `author`, `institution`, `date`) and
/// `logo` as the title graphic; any of them can also be passed here.
///
/// - extra (content, none): Extra material below the date.
#let title-slide(
  config: (:),
  extra: none,
  ..args,
) = touying-slide-wrapper(self => {
  let st = self.store
  let colors = self.colors
  self = utils.merge-dicts(
    self,
    config,
    config-common(freeze-slide-counter: true),
    config-page(
      fill: colors.normal-bg,
      margin: (top: 0pt, bottom: 0pt, x: st.margin-x),
    ),
  )
  let info = self.info + args.named()
  let body = block(width: 100%, height: 100%, {
    set text(fill: colors.normal-fg)
    v(1.618fr)
    if info.logo != none {
      block(width: 100%, spacing: 1em, utils.call-or-display(self, info.logo))
    }
    if info.title != none {
      block(
        width: 100%,
        spacing: 0pt,
        text(size: 1.31em, weight: "bold", _format(st.title-format, info.title)),
      )
    }
    if info.subtitle != none {
      block(
        width: 100%,
        above: 0.7em,
        spacing: 0pt,
        text(size: 1.09em, _format(st.title-format, info.subtitle)),
      )
    }
    block(
      width: 100%,
      above: 1.2em,
      below: 1.2em,
      line(length: 100%, stroke: st.separator-height + colors.separator),
    )
    if info.author != none {
      block(spacing: 0.25em, text(size: 0.91em, info.author))
    }
    if info.institution != none {
      block(
        spacing: 1.1em,
        text(size: 0.73em, fill: _mix((colors.normal-fg, 80%), (colors.normal-bg, 20%)), info.institution),
      )
    }
    if info.date != none {
      block(spacing: 0.7em, text(size: 0.91em, utils.display-info-date(self)))
    }
    if extra != none {
      block(spacing: 0.7em, text(size: 0.91em, extra))
    }
    v(1fr)
  })
  touying-slide(self: self, body)
})

/// Section slide, shown automatically for each level-1 heading. The progress
/// bar below the title shows how far along the talk is.
#let new-section-slide(config: (:), level: 1, numbered: false, body) = touying-slide-wrapper(self => {
  let st = self.store
  let colors = self.colors
  let slide-body = {
    set std.align(horizon + center)
    block(width: 78.75%, {
      set std.align(left)
      set text(fill: colors.normal-fg)
      text(
        size: 1.31em,
        weight: "bold",
        _format(
          st.title-format,
          utils.display-current-heading(level: level, numbered: numbered, style: auto),
        ),
      )
      if st.section-page == "progressbar" {
        v(0.8em, weak: true)
        _bar(self, st.progress-bar-height)
        // Beamer reserves a line for the (empty) subsection title.
        v(2em)
      }
      if body != [] and body != none {
        text(fill: colors.normal-fg, body)
      }
    })
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: colors.normal-bg, margin: (top: 0pt, bottom: 0pt, x: st.margin-x)),
  )
  touying-slide(self: self, config: config, slide-body)
})

/// A standout slide for emphasis ("Thank you!", "Questions?").
///
/// - style (str): `"default"`, `"alerted"` or `"example"`.
/// - align (alignment): Placement of the content.
#let standout-slide(config: (:), style: "default", align: horizon + center, body) = touying-slide-wrapper(self => {
  let colors = self.colors
  let (fg, bg) = if style == "alerted" {
    (colors.standout-alerted-fg, colors.standout-alerted-bg)
  } else if style == "example" {
    (colors.standout-example-fg, colors.standout-example-bg)
  } else {
    (colors.standout-fg, colors.standout-bg)
  }
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(fill: bg, margin: 2em),
  )
  set text(fill: fg, size: 1.31em, weight: "bold")
  touying-slide(self: self, config: config, std.align(align, _format(self.store.title-format, body)))
})

// ---------------------------------------------------------------------------
// Blocks
// ---------------------------------------------------------------------------

#let _block(kind, self: none, title, body) = {
  let colors = self.colors
  let title-fg = if kind == "alert" {
    colors.alert
  } else if kind == "example" {
    colors.example
  } else {
    colors.normal-fg
  }
  let fill-style = self.store.block-style == "fill"
  let title-bg = _mix((colors.normal-bg, 80%), (colors.normal-fg, 20%))
  let body-bg = _mix((title-bg, 50%), (colors.normal-bg, 50%))
  block(width: 100%, breakable: false, above: 1.3em, below: 1.3em, {
    if title != none {
      block(
        width: 100%,
        fill: if fill-style { title-bg },
        inset: if fill-style { (x: 0.6em, y: 0.4em) } else { (x: 0pt, y: 0pt) },
        below: if fill-style { 0pt } else { 0.6em },
        text(fill: title-fg, weight: "bold", title),
      )
    }
    block(
      width: 100%,
      fill: if fill-style { body-bg },
      inset: if fill-style { 0.6em } else { 0pt },
      above: 0pt,
      body,
    )
  })
}

/// A block with a bold title. `#block[Title][Body]` is not used because it
/// would shadow Typst's `block`; use `#mblock`.
#let mblock(title, body) = touying-fn-wrapper(_block.with("normal"), title, body)
/// A block whose title is in the alert color.
#let alert-block(title, body) = touying-fn-wrapper(_block.with("alert"), title, body)
/// A block whose title is in the example color.
#let example-block(title, body) = touying-fn-wrapper(_block.with("example"), title, body)

// ---------------------------------------------------------------------------
// Theme
// ---------------------------------------------------------------------------

/// The Moloch theme.
///
/// - aspect-ratio (str): `"16-9"` or `"4-3"`.
/// - variant (str): `"light"` or `"dark"`.
/// - color-theme (str): `"default"`, `"tomorrow"`, `"paper"` or `"highcontrast"`.
/// - colors (dictionary): Overrides for individual palette keys, see
///   `moloch-palettes`, e.g. `(alert: red)`.
/// - progress-bar (str): `"frametitle"`, `"head"`, `"foot"` or `"none"`.
///   Beamer's default is `none`; the Moloch demo uses `frametitle`.
/// - progress-bar-height (length): Thickness of every progress bar.
/// - section-page (str): `"progressbar"`, `"simple"` or `"none"`.
/// - block-style (str): `"transparent"` or `"fill"`.
/// - title-format (str): `"regular"`, `"smallcaps"`, `"allsmallcaps"` or
///   `"allcaps"`, for titles, section pages and standout slides.
/// - page-number (str): `"plain"`, `"fraction"` or `"none"`.
/// - separator-height (length): Thickness of the title slide rule.
/// - footer (content, function): Left part of the footer.
/// - align (alignment): Default vertical alignment of slide bodies.
/// - text-size (length): Base text size.
/// - font (str, array): Text font. Moloch's demo uses Fira Sans.
/// - mono-font (str, array): Font for raw text.
/// - weight (str, int): Base text weight; `"light"` matches the demo.
/// - margin-x (length, auto): Horizontal slide margin.
#let moloch-theme(
  aspect-ratio: "16-9",
  variant: "light",
  color-theme: "default",
  colors: (:),
  progress-bar: "frametitle",
  progress-bar-height: 1.86pt,
  section-page: "progressbar",
  block-style: "transparent",
  title-format: "regular",
  page-number: "plain",
  separator-height: 1.3pt,
  footer: none,
  align: horizon,
  text-size: 20pt,
  font: ("Fira Sans", "Helvetica Neue", "Arial"),
  mono-font: ("Fira Mono", "Fira Code", "Menlo", "DejaVu Sans Mono"),
  weight: "light",
  margin-x: auto,
  ..args,
  body,
) = {
  assert(variant in ("light", "dark"), message: "variant must be \"light\" or \"dark\"")
  assert(color-theme in moloch-palettes, message: "unknown color theme " + repr(color-theme))
  let palette = moloch-palettes.at(color-theme).at(variant) + colors
  let margin-x = if margin-x == auto { 2.5 * text-size } else { margin-x }

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      header-ascent: 0pt,
      footer-descent: 0pt,
      margin: (top: 3em, bottom: 1.2em, x: 0pt),
    ),
    config-common(
      slide-fn: slide,
      show-strong-with-alert: false,
      new-section-slide-fn: if section-page == "none" { none } else { new-section-slide },
    ),
    config-methods(
      alert: (self: none, body) => text(fill: self.colors.alert, body),
    ),
    config-colors(primary: palette.alert, ..palette),
    config-store(
      align: align,
      margin-x: margin-x,
      footer: footer,
      progress-bar: progress-bar,
      progress-bar-height: progress-bar-height,
      section-page: section-page,
      block-style: block-style,
      title-format: title-format,
      page-number: page-number,
      separator-height: separator-height,
    ),
    ..args,
  )

  set text(size: text-size, font: font, weight: weight, fill: palette.normal-fg)
  set strong(delta: 300)
  set par(justify: false, leading: 0.5em, spacing: 1.1em)

  // Bullets: circle, square, triangle, as in the Beamer theme.
  // Each marker is centered 0.33em above the baseline (Beamer: 0.7ex), about
  // the middle of the lowercase letters, whatever its height `h`.
  let marker(h, shape) = box(baseline: h / 2 - 0.33em, shape)
  set list(
    indent: 1.3em,
    body-indent: 0.6em,
    spacing: 0.5em,
    marker: (
      marker(0.32em, circle(radius: 0.16em, fill: palette.normal-fg, stroke: none)),
      marker(0.31em, square(size: 0.31em, fill: palette.normal-fg, stroke: none)),
      marker(0.42em, polygon(
        (0pt, 0pt), (0.42em, 0.21em), (0pt, 0.42em),
        fill: palette.normal-fg, stroke: none,
      )),
    ),
  )
  set enum(indent: 1em, body-indent: 0.7em, spacing: 0.5em)
  // Beamer shrinks nested lists: \small, then \footnotesize.
  let depth = state("moloch-list-depth", 0)
  let nested(it) = context {
    set text(size: 0.91em) if depth.get() > 0
    depth.update(n => n + 1)
    it
    depth.update(n => n - 1)
  }
  show list: nested
  show enum: nested
  set terms(tight: false, separator: [: ])
  show terms.item: it => {
    strong(it.term) + [: ] + it.description
  }

  // Figures and tables.
  set figure.caption(separator: [: ])
  show figure.caption: it => context {
    set text(size: 0.8em)
    strong(it.supplement + [ ] + it.counter.display(it.numbering)) + it.separator + it.body
  }
  set table(stroke: none, inset: (x: 0.6em, y: 0.4em))

  // Code.
  show raw: set text(font: mono-font, size: 0.9em, weight: "regular")
  // Plain verbatim, as in Beamer; no background.
  show raw.where(block: true): set block(above: 1em, below: 1em)

  // Table of contents: plain section names, as in Beamer.
  show outline.entry: it => block(above: 4em, below: 0pt, it.body())

  // Links and in-slide headings.
  show link: set text(fill: palette.example)
  show heading.where(level: 3): set text(weight: "bold", size: 1em)
  show heading.where(level: 3): set block(above: 1em, below: 0.6em)

  show footnote.entry: set text(fill: palette.footnote, size: 0.7em)
  set footnote.entry(separator: line(length: 30%, stroke: 0.5pt + palette.footnote))

  body
}
