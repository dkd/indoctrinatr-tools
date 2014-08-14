Given(/^I do not have (?:a|an) '(.*)' project$/) do |project_name|
  FileUtils.rm_rf project_name
end

Given(/^I have an Indoctrinatr project '(.*)'$/) do |project_name|
  run_simple(unescape("indoctrinatr new #{project_name}"), false)
end

When(/^I run the Indoctrinatr command '(.*)'$/) do |command|
  step "When I successfully run `indoctrinatr #{command}`"
end
