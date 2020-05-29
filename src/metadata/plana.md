---
layout: ontology_detail
id: plana
title: planaria-ontology
jobs:
  - id: https://travis-ci.org/obophenotype/planaria-ontology
    type: travis-ci
build:
  checkout: git clone https://github.com/obophenotype/planaria-ontology.git
  system: git
  path: "."
contact:
  email: smr@stowers.org 
  label: Sofia Robb
description: PLANA, the PLAarian Anatomy Ontology, encompasses the anatomy of developmental stages and adult biotypes of Schmidtea mediterranea. 
domain: stuff
homepage: https://github.com/obophenotype/planaria-ontology
products:
  - id: plana.owl
  - id: plana.obo
dependencies:
 - id: ro
 - id: uberon
tracker: https://github.com/obophenotype/planaria-ontology/issues
license:
  url: http://creativecommons.org/licenses/by/3.0/
  label: CC-BY
---

Anatomy ontology for planaria and terms specific to the developmental stages of the planarian _Schmidtea mediterranea_.
