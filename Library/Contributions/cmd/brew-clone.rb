#
# brew-clone.rb - Clone formula source to a directoy
#

require 'formula'

if ARGV.named.length != 2
  onoe "Usage: brew clone <formula> <destination>"
  exit 1
end

name = ARGV.shift
dest = Pathname.new(ARGV.shift)

f = Formula.factory(name.downcase)
dls = f.head.download_strategy.new(f.name, f.head, dest)
if dest.exist? and not dls.repo_valid?
  onoe "#{dest} already exists, but is not a valid #{f.name} repository."
  exit 1
end
dls.fetch()
