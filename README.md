# ![Indoctrinatr](assets/images/logo.png)

## About

[Indoctrinatr Tools](https://github.com/dkd/indoctrinatr-tools) is a set of commandline tools to kick-start and develop [Indoctrinatr](https://github.com/dkd/indoctrinatr) Template Packs. Indoctrinatr in itself is an Open Source Software project by [dkd Internet Service GmbH](https://dkd.de/), Frankfurt (Germany), which renders [eRuby](https://en.wikipedia.org/wiki/ERuby) (more specifically: [Erubis](http://www.kuwata-lab.com/erubis/)) enriched [XeTeX](http://tug.org/xetex/) templates to PDF documents.

## Installation

[![Gem Version](https://badge.fury.io/rb/indoctrinatr-tools.svg)](http://badge.fury.io/rb/indoctrinatr-tools) Branch: master [![Travis CI Status: master](https://travis-ci.org/dkd/indoctrinatr-tools.svg?branch=master)](https://travis-ci.org/dkd/indoctrinatr-tools) Branch: development  [![Travis CI Status: development](https://travis-ci.org/dkd/indoctrinatr-tools.svg?branch=development)](https://travis-ci.org/dkd/indoctrinatr-tools)

1.  Install XeTeX:

    Mac OS X: [MacTeX](https://tug.org/mactex/)
 
    Debian/Ubuntu: `apt-get install texlive-full`

2. We distribute Indoctrinatr Tools as a Rubygem. Please run:

    ```shell
    gem install indoctrinatr-tools
    ```
   After installation verify if you have a working `indoctrinatr` shell command.

## Usage

Replace `project_name` with the name of your Template Pack:

Command | Description
---|---
`indoctrinatr new project_name` | Creates a scaffold for a new Template Pack
`indoctrinatr parse project_name` | Parses a XeTex file with ERB and default values
`indoctrinatr pdf project_name` | Compiles PDF with default values
`indoctrinatr pack project_name` | Creates a Template Pack from a given project folder
`indoctrinatr demo` | Creates, parses, and compiles a demo project
`indoctrinatr workflow` | Displays a suggested workflow
`indoctrinatr bashcompletion` | Displays instructions for bash completion
`indoctrinatr zshcompletion` | Displays instructions for zsh completion


## Build

If you want to build the Rubygem yourself, run `rake build` to build and `rake install` to build and install the Indoctrinatr Tools gem.

## Feedback

What you think of Indoctrinatr and Indoctrinatr Tools? Drop us a line (<opensource@dkd.de>) and tell us how you use Indoctrinatr. You can also open a [GitHub Issue](https://github.com/dkd/indoctrinatr-tools/issues) if you experience any problems.

## Contributing

We are also looking forward to your [GitHub Pull Requests](https://help.github.com/articles/using-pull-requests/).

## License

Indoctrinatr and Indoctrinatr Tools are licensed under the terms and conditions of the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

## Credits

[![dkd](assets/images/dkd_logo.png)](https://dkd.de/)

* Nicolai Reuschling (development)
* Søren Schaffstein (idea, product management)
