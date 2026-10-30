(lang dune 3.24)

(name noize)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "David Vincelli <david.vincelli@gmail.com>")

(maintainers "David Vincelli <david.vincelli@gmail.com>")

(license LICENSE)

(documentation https://mkl.ink/noize)

(package
 (name noize)
 (synopsis "A library for making noise")
 (description "Noise algorithms for procedural generation and audio synthesis")
 (depends ocaml)
 (tags
  ("noise" "procedural")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
