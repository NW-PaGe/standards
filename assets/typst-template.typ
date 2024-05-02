// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 2,
  margin: (left: 10mm, right: 10mm, top: 3cm, bottom: 10mm),
  paper: "a4",
  lang: "en",
  region: "US",
  font: ("Hanken Grotesk"),
  fontsize: 14pt,
  sectionnumbering: none,
  toc: false,
  doc
) = {

   import "@preview/bubble:0.1.0": *

   show: bubble.with(
    title: "Northwest Pathogen Genomics Center of Excellence",
    subtitle: "Policies, standards, and guidelines",
    author: "Frank Aragona",
    affiliation: "Washington State Department of Health",
    date: datetime.today().display(),
    year: "2024",
    class: "Data Integration/Quality Assurance",
    logo: image("images/nwpage_logo.png"),
    main-color: "#155d64"
  ) 

  outline(indent: auto)

  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(center)[#block(inset: 2em)[
      #text(weight: "bold", size: 1.5em)[#title]
    ]]
  }

  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(center)[
            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )
  }

  if date != none {
    align(center)[#block(inset: 1em)[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    block(above: 0em, below: 2em)[
    #outline(
      title: auto,
      depth: none
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}