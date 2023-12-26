
<p align="center">
  <img src="https://github.com/postwoman-team/postwoman/assets/66630725/a01dcbf1-9974-48af-9734-2d8d9a5ce695" width="50%" height="50%">
</p>

<h2>
  Postwoman
  <br>
  <a href="README.md">
    <img src="https://img.shields.io/badge/Português-blue">
  </a>
</h2>

<p align="justify">
Postwoman is a Ruby gem created to make API calls. It's similar to another famous tool, but with a shift in focus.
</p>

<p align="justify">
In other applications, especially those using a graphical interface, it's noticeable that it's easier to "mess up" the parameters of a request for a quick test than to automate them with special variables or the like. In Postwoman, we have an opinionated design, making it easier for a user to change a parameter for a quick test without making the change permanent.
</p>

<p align="justify">
Furthermore, Postwoman proposes that users create their requests and scripts in Ruby, taking advantage of all the flexibility and ease this language offers.
</p>

**This tool is still in a very early stage of development, and bugs are frequent.**

### How to Install
For now, the gem has not been published on RubyGems, so it's necessary to install it manually:

- Clone the repository
- Navigate your terminal to the project directory
- Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) and Bundler (which comes installed with Ruby!) on your machine
- Run in the terminal the command:

```bash
$ make install
```

### How to Use
To start using Postwoman, you need to create a package. To do this, use the command:

```bash
$ postwoman -n package_directory
```

If you already have a package, use the command:

```bash
$ postwoman package_directory
```

Type `help` for more information.
