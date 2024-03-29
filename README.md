# ![Indoctrinatr](assets/images/logo.png)

## About

[Indoctrinatr Tools](https://github.com/dkd/indoctrinatr-tools) is a set of commandline tools to kick-start and develop [Indoctrinatr](https://github.com/dkd/indoctrinatr) Template Packs. Indoctrinatr in itself is an Open Source Software project by [dkd Internet Service GmbH](https://dkd.de/), Frankfurt (Germany), which renders [eRuby](https://en.wikipedia.org/wiki/ERuby) (more specifically: [Erubis](http://www.kuwata-lab.com/erubis/)) enriched [XeTeX](http://tug.org/xetex/) templates to PDF documents.

## Installation

[![Gem Version](https://badge.fury.io/rb/indoctrinatr-tools.svg)](http://badge.fury.io/rb/indoctrinatr-tools)


1.  Install XeTeX:

    Mac OS X: [MacTeX](https://tug.org/mactex/) (e.g. `brew install mactex`)

    Debian/Ubuntu:

    ```shell
    apt-get install texlive texlive-xetex texlive-latex-extra texlive-generic-extra
    ```

2. We distribute Indoctrinatr Tools as a Rubygem. Please run:

    ```shell
    gem install indoctrinatr-tools
    ```
   After installation verify if you have a working `indoctrinatr` shell command.

### LaTeX Requirements

* `latexmk`
* for the template documentation
  * Tested against TeX Live 2022
  * `dirtree`
  * `datetime2`

## Usage

Replace `project_name` with the name of your Template Pack:

Command | Description
---|---
`indoctrinatr new project_name` | Creates a scaffold for a new Template Pack
`indoctrinatr parse project_name` | Parses a XeTex file with ERB and default values
`indoctrinatr pdf project_name` | Compiles PDF with default values
`indoctrinatr pdf_with_field_names project_name` | Generates PDF with the field names as values
`indoctrinatr doc project_name` | Creates a technical documentation of your template pack
`indoctrinatr check project_name` | Analyzes your Template Pack for errors
`indoctrinatr pack project_name` | Creates a Template Pack from a given project folder
`indoctrinatr demo` | Creates, parses, and compiles a demo project
`indoctrinatr workflow` | Displays a suggested workflow

The commands `pdf`, `pdf_with_field_names` and `doc` have a `keep-aux-files` option. This is helpful if you run in into LaTeX errors, want to inspect the .log file and run LaTeX for yourself again.

The command `doc` does not overwrite existing examples. This means that you can customize the examples that are appended in the documentation.

## Build

If you want to build the Rubygem yourself, run `rake build` to build and `rake install` to build and install the Indoctrinatr Tools gem.

## Feedback

What you think of Indoctrinatr and Indoctrinatr Tools? Drop us a line (<opensource@dkd.de>) and tell us how you use Indoctrinatr. You can also open a [GitHub Issue](https://github.com/dkd/indoctrinatr-tools/issues) if you experience any problems.

## Contributing

We are also looking forward to your [GitHub Pull Requests](https://help.github.com/articles/using-pull-requests/).

Manual testing: After cloning the repo, run `bundle exec bin/indoctrinatr` inside the directory for testing your own development changes.
Automatic testing: run `rspec`

## License

Indoctrinatr and Indoctrinatr Tools are licensed under the terms and conditions of the [MIT License](http://en.wikipedia.org/wiki/MIT_License).

## Credits

[![dkd](assets/images/dkd_logo.png)](https://dkd.de/)

* Luka Lüdicke (development)
* Eike Henrich (development)
* Nicolai Reuschling (development)
* Søren Schaffstein (idea, product management)
