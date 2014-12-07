(TeX-add-style-hook "errata"
 (function
  (lambda ()
    (LaTeX-add-index-entries
     "#1"
     "#1@{\\tt{#1}} attribute in!{\\tt{#2}}"
     "#1@{\\tt{#1}} (element)"
     "#1@{\\tt{#1}}  value for attribue !{\\tt{#2}} on element!{\\tt{#3}}"
     "#1@{\\tt{#1}}")
    (LaTeX-add-bibliographies
     "omdoc")
    (TeX-run-style-hooks
     "hyperref"
     "a4paper=true"
     "bookmarks=true"
     "linkcolor=black"
     "citecolor=black"
     "urlcolor=black"
     "colorlinks=true"
     "pagecolor=black"
     "breaklinks=true"
     "bookmarksopen=true"
     "url"
     "acronyms"
     "ags-bib"
     "latex2e"
     "art11"
     "article"
     "11pt"
     "theerrata"))))

