# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# encoding: utf-8
# Be sure to restart your server when you modify this file.
# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
inflect.plural /([aeiou])([A-Z]|_|$)/, '\1s\2'
inflect.plural /([rlnd])([A-Z]|_|$)/, '\1es\2'
inflect.singular /([aeiou])s([A-Z]|_|$)/, '\1\2'
inflect.singular /([rlnd])es([A-Z]|_|$)/, '\1\2'
inflect.irregular 'user', 'users'
inflect.irregular 'account', 'accounts'
inflect.irregular 'password', 'passwords'
inflect.irregular 'session', 'sessions'
end

