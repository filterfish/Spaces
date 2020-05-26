Spaces
======

# Getting Started

You'll need to create a directory for Spaces to write all its data at:

* `\opt\UniversalSpace`

Ideally, Spaces should create this directory on first access, but I ran into permission problems and moved on.

James: perhaps you could advise how I programmatically create a new directory under /opt?

# The Universe

Spaces exist in a universe which you can create with the `Universal::Space` class:

```
require_relative 'ruby/universal/space'
universe = Universal::Space.new
```

From a universe you can access a variety of spaces. For example:

```
universe.blueprints
universe.containers
```

# Spaces::Descriptor

A `Spaces::Descriptor` object is the way spaces objects are saved and located in their various spaces. While Spaces generates its own descriptors internally,
a common starting point is to start with a descriptor to locate a source blueprint. For example:

```
require_relative 'ruby/spaces/descriptor'
descriptor = Spaces::Descriptor.new(
  repository: 'https://github.com/MarkRatjens/publify.git'
)
```

which can be used to import a blueprint from an external Git repo.

There are optional attributes you can declare for a blueprint:

```
descriptor = Spaces::Descriptor.new(
  repository: 'https://github.com/MarkRatjens/publify.git',
  branch: 'current'
)
```

# Blueprints
## Importing

You can import a blueprint into your universe with:

```
blueprint_space = universe.blueprints
blueprint_space.import(descriptor)
```

## Retrieving an imported blueprint

Once you've imported a blueprint, you can retrieve it with:

```
blueprint_space.by(descriptor)
```

## Generating a Resolutions::Resolution

A `Resolutions::Resolution` is what will generate a DockerFile. You create a Resolution from a blueprint like so:

```
blueprint = universe.blueprints.by(descriptor)
resolution = blueprint.resolution
```

## Saving a Resolutions::Resolution

Save `Resolutions::Resolution` to resolution space with:

```
resolution_space = universe.resolutions
resolution_space.save(resolution)
```

# Containers

## Generating DockerFile content

A resolution can generate docker file content:

```
content = resolution.docker_file
```

## Saving docker file content to a file

Save docker file content to container space with:

```
container_space.save(content)
```

# Image Subjects
## Generating an Images::Subject

An `Images::Subject` is what will manage a folder structure that you'll eventually be able to use as an image to build a container. Generate an
image subject from a Resolution in a similar way to generating a docker file:

```
content = resolution.image_subject
```

## Saving image file content to image space

Save the image subject's folders and files to image space with:

```
image_space = universe.images
image_space.save(content)
```

# Web client

To run the GUI:
1. `bundle`
2. `npm i`
3. `thin start`

# Terms

Copyright (C) 2020 P3 Nominees Pty Ltd

This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License along with this program (see the LICENSE.md file in the root of the repository). If not, see <https://www.gnu.org/licenses/>.
