These notes are for the EDITORS of plana

This project was created using the [ontology starter kit](https://github.com/cmungall/ontology-starter-kit). See the site for details.

For more details on ontology management, please see the [OBO tutorial](https://github.com/jamesaoverton/obo-tutorial) or the [Protege Planteome Tutorial](https://github.com/Planteome/protege-tutorial)

## Editors Version

Make sure you have an ID range in the [idranges file](plana-idranges.owl)

If you do not have one, get one from the head curator.

The editors version is [plana-edit.owl](plana-edit.owl)

** DO NOT EDIT plana.obo OR plana.owl in the top level directory **

[../../plana.owl] is the release version

To edit, open the file in Protege. First make sure you have the repository cloned, see [the GitHub project](https://github.com/obophenotype/planaria-ontology) for details.

## ID Ranges

These are stored in the file

 * [plana-idranges.owl](plana-idranges.owl)

** ONLY USE IDs WITHIN YOUR RANGE!! **

If you have only just set up this repository, modify the idranges file
and add yourself or other editors. Note Protege does not read the file
- it is up to you to ensure correct Protege configuration.


## Setting ID ranges in Protege

We aim to put this up on the technical docs for OBO on http://obofoundry.org/

For now, consult the [Protege Planteome Tutorial](https://github.com/Planteome/protege-tutorial/blob/master/presentations/protege_planteome_tutorial.doc?raw=true) and look for the section "new entities"


## Release Manager notes

You should only attempt to make a release AFTER the edit version is
committed and pushed, and the travis build passes.

to release:

    cd src/ontology
    make

If this looks goo
d type:

    make prepare_release

This generates derived files such as plana.owl and plana.obo and places
them in the top level (../..). The versionIRI will be added.

Commit and push these files.

    git commit -a

And type a brief description of the release in the editor window

Finally type

    git push origin master

IMMEDIATELY AFTERWARDS (do *not* make further modifications) go here:

 * https://github.com/obophenotype/planaria-ontology/releases
 * https://github.com/obophenotype/planaria-ontology/releases/new

The value of the "Tag version" field MUST be

    vYYYY-MM-DD

The initial lowercase "v" is REQUIRED. The YYYY-MM-DD *must* match
what is in the versionIRI of the derived plana.owl (data-version in
plana.obo).

Release title should be YYYY-MM-DD, optionally followed by a title (e.g. "january release")

Then click "publish release"

__IMPORTANT__: NO MORE THAN ONE RELEASE PER DAY.

The PURLs are already configured to pull from github. This means that
BOTH ontology purls and versioned ontology purls will resolve to the
correct ontologies. Try it!

 * http://purl.obolibrary.org/obo/plana.owl <-- current ontology PURL
 * http://purl.obolibrary.org/obo/plana/releases/YYYY-MM-DD.owl <-- change to the release you just made

For questions on this contact Chris Mungall or email obo-admin AT obofoundry.org

# Travis Continuous Integration System

Check the build status here: [![Build Status](https://travis-ci.org/obophenotype/planaria-ontology.svg?branch=master)](https://travis-ci.org/obophenotype/planaria-ontology)

Note: if you have only just created this project you will need to authorize travis for this repo. Go to [https://travis-ci.org/profile/obophenotype](https://travis-ci.org/profile/obophenotype) for details

