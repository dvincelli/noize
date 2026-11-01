(lang dune 3.24)

(name noize)

(generate_opam_files true)

(source
 (github dvincelli/noize))

(authors "David Vincelli <david.vincelli@gmail.com>")

(maintainers "David Vincelli <david.vincelli@gmail.com>")

(license LICENSE)

(documentation https://mkl.ink/noize)

(package
 (name noize)
 (synopsis "A library for generating noise procedurally")
 (description "Noise algorithms for procedural generation and audio synthesis")
 (depends ocaml stdio)
 (tags
  ("noise" "procedural")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
