options = {
  #pride: true,
  test_folders: 'tests',
  test_file_patterns: 'test_*.rb'
}

guard :minitest, options do
  watch(%r{^test/(.*)\/?test_(.*)\.rb$})
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})        { |m| "tests/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^lib/.*/(.*/)?([^/]+)\.rb$})   { |m| "tests/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})         { 'test' }
end