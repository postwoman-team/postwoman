## Postwoman

Postwoman is a Ruby gem created for making API calls. It's similar to another famous tool but with a shifted focus.

In other applications, especially those with a graphical interface, it's often easier to mess up the parameters of a request for a quick test than to automate them with special variables or similar methods. With Postwoman, we have an opinionated design, making it easier for a user to change a parameter for a quick test without making the change permanent.

Additionally, Postwoman proposes that users create their requests and scripts in Ruby, enjoying all the flexibility and ease that this language offers.

**This tool is still in a very early stage of development, and bugs are frequent.**

[EN](README-EN.md)

### How to Install
For now, the gem has not been published on RubyGems, so it needs to be installed manually:

- Clone the repository
- Open your terminal in the project directory
- Install [Ruby](https://www.ruby-lang.org/en/documentation/installation/) and Bundler on your machine
- Run the command `make install` in the terminal

### How to Use
To start using Postwoman, you need to create a package. For this, use the command `$postwoman -n package_directory`. If you already have a package, use the command `$ postwoman package_directory`. Type `help` for more information.
