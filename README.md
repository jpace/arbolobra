# Arbolobra

Arbolobra is for reading and writing a hierarchical set of data, i.e., a tree. ("Arbol" is Spanish
for "tree", so the palindrome "arbolobra" means a tree, backward and forward.)

Arbolobra makes it simple to take a flat set of data (such as a list of files of the form
/path/to/filename) and write that as a tree, and the inverse.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arbolobra'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arbolobra

## Usage

Arbolobra is for reading and writing a hierarchical set of data, i.e., a tree.

### Generating from Data

For example, a simple viewer (a rough equivalent of "find") of files and directories, as a tree:

```ruby
require 'arbolobra/node'
require 'pathname'

def build pn
  children = pn.directory? ? pn.children.sort : Array.new
  Arbolobra::Node.new pn.basename, children.collect { |child| build child }
end

args = ARGV.empty? ? %w{ . } : ARGV

args.each do |arg|
  pn = Pathname.new arg
  node = build pn
  node.print
end
```

The output of running the above in the Arbolobra project for the arguments [ "lib", "test" ]:

```text
lib
+---arbolobra
|   +---chars.rb
|   +---node.rb
|   +---tree.rb
|   \---version.rb
\---arbolobra.rb
test
+---arbolobra
|   +---chars_test.rb
|   +---node_test.rb
|   \---tree_test.rb
+---arbolobra_test.rb
\---test_helper.rb
```

### Generating from Strings (Lines)

To convert strings, such as from a list of files, from flat to hierarchical:

```ruby
require 'arbolobra/tree

tree = Arbolobra::Tree.new $stdin.readlines, "/"
tree.root.print
```

In raw form:

```shell
% git diff-index --name-only --no-commit-id  c2ef
```

The output:

```text
README.md
arbolobra.gemspec
lib/arbolobra/chars.rb
lib/arbolobra/formatter.rb
lib/arbolobra/node.rb
lib/arbolobra/tree.rb
test/arbolobra/chars_test.rb
test/arbolobra/formatter_test.rb
test/arbolobra/node_test.rb
test/arbolobra/tc.rb
test/arbolobra/tree_test.rb
```

Using the above script, converting Git output to a tree:

```shell
% git diff-index --name-only --no-commit-id c2ef | 
  ruby -I lib -rarbolobra/tree -e 'tree = Arbolobra::Tree.new $stdin.readlines, "/"; tree.root.print'
```

Output:

```text
.
+---README.md
+---arbolobra.gemspec
+---lib
|   \---arbolobra
|       +---chars.rb
|       +---formatter.rb
|       +---node.rb
|       \---tree.rb
\---test
    \---arbolobra
        +---chars_test.rb
        +---formatter_test.rb
        +---node_test.rb
        +---tc.rb
        \---tree_test.rb
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jpace/arbolobra.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
