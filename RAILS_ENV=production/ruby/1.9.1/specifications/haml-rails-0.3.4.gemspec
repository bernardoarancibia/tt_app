# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{haml-rails}
  s.version = "0.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["André Arko"]
  s.date = %q{2010-10-15}
  s.description = %q{Haml-rails provides Haml generators for Rails 3. It also enables Haml as the templating engine for you, so you don't have to screw around in your own application.rb when your Gemfile already clearly indicated what templating engine you have installed. Hurrah.}
  s.email = ["andre@arko.net"]
  s.files = [".gitignore", "Gemfile", "README.md", "Rakefile", "haml-rails.gemspec", "lib/generators/haml/controller/controller_generator.rb", "lib/generators/haml/controller/templates/view.html.haml", "lib/generators/haml/mailer/mailer_generator.rb", "lib/generators/haml/mailer/templates/view.text.haml", "lib/generators/haml/scaffold/scaffold_generator.rb", "lib/generators/haml/scaffold/templates/_form.html.haml", "lib/generators/haml/scaffold/templates/edit.html.haml", "lib/generators/haml/scaffold/templates/index.html.haml", "lib/generators/haml/scaffold/templates/new.html.haml", "lib/generators/haml/scaffold/templates/show.html.haml", "lib/haml-rails.rb", "lib/haml-rails/version.rb", "test/fixtures/routes.rb", "test/lib/generators/haml/controller_generator_test.rb", "test/lib/generators/haml/mailer_generator_test.rb", "test/lib/generators/haml/scaffold_generator_test.rb", "test/lib/generators/haml/testing_helper.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/indirect/haml-rails}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{haml-rails}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{let your Gemfile do the configuring}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, ["~> 3.0"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_runtime_dependency(%q<railties>, ["~> 3.0"])
      s.add_development_dependency(%q<rails>, ["~> 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
    else
      s.add_dependency(%q<haml>, ["~> 3.0"])
      s.add_dependency(%q<activesupport>, ["~> 3.0"])
      s.add_dependency(%q<actionpack>, ["~> 3.0"])
      s.add_dependency(%q<railties>, ["~> 3.0"])
      s.add_dependency(%q<rails>, ["~> 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    end
  else
    s.add_dependency(%q<haml>, ["~> 3.0"])
    s.add_dependency(%q<activesupport>, ["~> 3.0"])
    s.add_dependency(%q<actionpack>, ["~> 3.0"])
    s.add_dependency(%q<railties>, ["~> 3.0"])
    s.add_dependency(%q<rails>, ["~> 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
  end
end
