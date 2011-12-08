# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :cli => '--color --format progress' do
    # Regexp watch patterns are matched with Regexp#match
    watch(%r{^app/(.+)/(.+)\.rb$}) {|m| "spec/#{m[1]}/#{m[2]}_spec.rb" }
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})         { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^spec/models/.+\.rb$})   { ["spec/models"] }
    watch(%r{^spec/.+\.rb$})          { `say hello` }
    # String watch patterns are matched with simple '=='
    watch('spec/spec_helper.rb') { "spec" }
end
