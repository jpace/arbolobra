# Arbolobra

Arbolobra is for reading and writing a hierarchical set of data, i.e., a tree. ("Arbol" is Spanish
for "tree", so the palindrome "Arbolobra" means a tree, backward and forward.)

Arbolobra makes it simple to take a flat set of data (such as a list of files of the form
/path/to/filename) and write that as a tree, and the inverse.

TODO: Delete this and the text above, and describe your gem

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

And to change output, such as from a list of files, from flat to hierarchical:

```ruby
tree = Arbolobra::Tree.new lines: ARGV, separator: "/"
tree.root.print
```

```shell
% git diff-index --name-only --no-commit-id <commit> | xargs <above script>
```

```text

+---.gitignore
+---README.md
+---lib
|   \---arbolobra
|       +---chars.rb
|       +---node.rb
|       \---tree.rb
\---test
    \---arbolobra
        +---chars_test.rb
        +---node_test.rb
        \---tree_test.rb
```

### Generating from Strings

To convert strings, such as from a list of files, from flat to hierarchical:

```ruby
tree = Arbolobra::Tree.new $stdin.readlines, "/"
tree.root.print
```

Using the above, converting Git output to a tree:

```shell
% git diff-index --name-only --no-commit-id  c2ef601 |
  ruby -rarbolobra/tree -e 'tree = Arbolobra::Tree.new $stdin.readlines, "/"; tree.root.print'
```

Output:

```text

+---README.md
\---test
    \---arbolobra
        +---node_test.rb
        \---tree_test.rb
```

Why the blank first line? That's because the "root" of a list of strings is empty -- each line is a
descendant of that root. (This will be amended in a future release.)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jpace/arbolobra.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
