# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "show_me_the_cookies/version"

Gem::Specification.new do |s|
  s.name        = "show_me_the_cookies"
  s.version     = ShowMeTheCookies::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Rutherford"]
  s.email       = ["nick.rutherford@gmail.com"]
  s.homepage    = "https://github.com/nruth/show_me_the_cookies"
  s.summary     = %q{Cookie manipulation for Capybara drivers}
  s.description = %q{Cookie manipulation for Capybara drivers -- viewing, deleting, ...}
  s.licenses = ["MIT"]

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency('capybara', ['>= 2', '< 4'])
end
